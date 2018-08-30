require("utils.lua")

function mainMenu()
    if comms_target.comms_data == nil then
        comms_target.comms_data = {}
    end
    mergeTables(comms_target.comms_data, {
        friendlyness = random(0.0, 100.0),
        weapons = {
            Homing = "neutral",
            HVLI = "neutral",
            Mine = "neutral",
            Nuke = "friend",
            EMP = "friend"
        },
        weapon_cost = {
            Homing = 2,
            HVLI = 2,
            Mine = 2,
            Nuke = 15,
            EMP = 10
        },
        services = {
            supplydrop = "friend",
            reinforcements = "friend",
        },
        service_cost = {
            supplydrop = 100,
            reinforcements = 150,
        },
        reputation_cost_multipliers = {
            friend = 1.0,
            neutral = 2.5
        },
        max_weapon_refill_amount = {
            friend = 1.0,
            neutral = 0.5
        }
    })
    comms_data = comms_target.comms_data

    if player:isEnemy(comms_target) then
        return false
    end

    if comms_target:areEnemiesInRange(5000) then
        setCommsMessage("Nous sommes attaqués! Pas le temps de parler!");
        return true
    end
    if not player:isDocked(comms_target) then
        handleUndockedState()
    else
        handleDockedState()
    end
    return true
end

function handleDockedState()
    -- Handle communications while docked with this station.
    if player:isFriendly(comms_target) then
        setCommsMessage("Bonjour, officier!\nQue pouvons-nous pour vous?")
    else
        setCommsMessage("Bienvenue dans notre charmante station.")
    end

    if player:getWeaponStorageMax("Homing") > 0 then
        addCommsReply("Avez-vous des missiles à guidage en stock pour nous? ("..getWeaponCost("Homing").."rep each)", function()
            handleWeaponRestock("Homing")
        end)
    end
    if player:getWeaponStorageMax("HVLI") > 0 then
        addCommsReply("Pouvez-vous nous fournir en missiles Rafale? ("..getWeaponCost("HVLI").."rep each)", function()
            handleWeaponRestock("HVLI")
        end)
    end
    if player:getWeaponStorageMax("Mine") > 0 then
        addCommsReply("Fournissez-nous en mines SVP. ("..getWeaponCost("Mine").."rep each)", function()
            handleWeaponRestock("Mine")
        end)
    end
    if player:getWeaponStorageMax("Nuke") > 0 then
        addCommsReply("Pouvez-vous nous fournir en Nano? ("..getWeaponCost("Nuke").."rep each)", function()
            handleWeaponRestock("Nuke")
        end)
    end
    if player:getWeaponStorageMax("EMP") > 0 then
        addCommsReply("Fournissez-nous en Axo-IEM SVP. ("..getWeaponCost("EMP").."rep each)", function()
            handleWeaponRestock("EMP")
        end)
    end
end

function handleWeaponRestock(weapon)
    if not player:isDocked(comms_target) then setCommsMessage("Vous devez rester arrimés pour cette action."); return end
    if not isAllowedTo(comms_data.weapons[weapon]) then
        if weapon == "Nuke" then setCommsMessage("Nous ne marchandons pas d'armes de destruction massive.")
        elseif weapon == "EMP" then setCommsMessage("Nous ne marchandons pas d'armes de disruption massive.")
        else setCommsMessage("Nous ne marchandons pas ce type d'armes.") end
        return
    end
    local points_per_item = getWeaponCost(weapon)
    local item_amount = math.floor(player:getWeaponStorageMax(weapon) * comms_data.max_weapon_refill_amount[getFriendStatus()]) - player:getWeaponStorage(weapon)
    if item_amount <= 0 then
        if weapon == "Nuke" then
            setCommsMessage("Toutes les Nanos sont chargées et amorcées en mode annihilation.");
        else
            setCommsMessage("Désolé, mais vous êtes chargés au maximum de ce que je peux vous fournir.");
        end
        addCommsReply("Retour", mainMenu)
    else
        if not player:takeReputationPoints(points_per_item * item_amount) then
            setCommsMessage("Pas assez de trans-crébits.")
            return
        end
        player:setWeaponStorage(weapon, player:getWeaponStorage(weapon) + item_amount)
        if player:getWeaponStorage(weapon) == player:getWeaponStorageMax(weapon) then
            setCommsMessage("Vous êtes chargés au maximum et prêts à faire exploser des choses.")
        else
            setCommsMessage("Nous vous avons généreusement fournis avec quelques charges.\nFaites-en bon usage.")
        end
        addCommsReply("Retour", mainMenu)
    end
end

function handleUndockedState()
    --Handle communications when we are not docked with the station.
    if player:isFriendly(comms_target) then
        setCommsMessage("Bonjour, officier.\nSi vous avez besoin de fournitures, arrimez-vous à nous au préalable SVP.")
    else
        setCommsMessage("Bienvenue.\nSi vous voulez négocier, arrimez-vous à nous au préalable SVP.")
    end
    if isAllowedTo(comms_target.comms_data.services.supplydrop) then
        addCommsReply("Pouvez-vous nous envoyer un largage de fournitures? ("..getServiceCost("supplydrop").."rep)", function()
            if player:getWaypointCount() < 1 then
                setCommsMessage("Vous devez déployer une balise avant de demander du support.");
            else
                setCommsMessage("Sur quelle balise devons nous larger les fournitures?");
                for n=1,player:getWaypointCount() do
                    addCommsReply("Balise " .. n, function()
                        if player:takeReputationPoints(getServiceCost("supplydrop")) then
                            local position_x, position_y = comms_target:getPosition()
                            local target_x, target_y = player:getWaypoint(n)
                            local script = Script()
                            script:setVariable("position_x", position_x):setVariable("position_y", position_y)
                            script:setVariable("target_x", target_x):setVariable("target_y", target_y)
                            script:setVariable("faction_id", comms_target:getFactionId()):run("supply_drop.lua")
                            setCommsMessage("Nous avons dépêché une navette de fournitures vers la balise " .. n);
                        else
                            setCommsMessage("Pas assez de trans-crébits!");
                        end
                        addCommsReply("Retour", mainMenu)
                    end)
                end
            end
            addCommsReply("Retour", mainMenu)
        end)
    end
    if isAllowedTo(comms_target.comms_data.services.reinforcements) then
        addCommsReply("Envoyez des renforts SVP! ("..getServiceCost("reinforcements").."rep)", function()
            if player:getWaypointCount() < 1 then
                setCommsMessage("Vous devez déployer une balise avant de demander des renforts.");
            else
                setCommsMessage("Sur quelle balise devons nous déployer les renforts?");
                for n=1,player:getWaypointCount() do
                    addCommsReply("Balise " .. n, function()
                        if player:takeReputationPoints(getServiceCost("reinforcements")) then
                            ship = CpuShip():setFactionId(comms_target:getFactionId()):setPosition(comms_target:getPosition()):setTemplate("Adder MK5"):setScanned(true):orderDefendLocation(player:getWaypoint(n))
                            setCommsMessage("Nous avons déployé " .. ship:getCallSign() .. " pour vous aider à la balise " .. n);
                        else
                            setCommsMessage("Pas assez de trans-crébits!");
                        end
                        addCommsReply("Retour", mainMenu)
                    end)
                end
            end
            addCommsReply("Retour", mainMenu)
        end)
    end
end

function isAllowedTo(state)
    if state == "friend" and player:isFriendly(comms_target) then
        return true
    end
    if state == "neutral" and not player:isEnemy(comms_target) then
        return true
    end
    return false
end

-- Return the number of reputation points that a specified weapon costs for the
-- current player.
function getWeaponCost(weapon)
    return math.ceil(comms_data.weapon_cost[weapon] * comms_data.reputation_cost_multipliers[getFriendStatus()])
end

-- Return the number of reputation points that a specified service costs for
-- the current player.
function getServiceCost(service)
    return math.ceil(comms_data.service_cost[service])
end

function getFriendStatus()
    if player:isFriendly(comms_target) then
        return "friend"
    else
        return "neutral"
    end
end

mainMenu()

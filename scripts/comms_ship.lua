-- Name: Basic ship comms
-- Description: Simple ship comms that allows setting orders if friendly. Default script for any cpuShip.

function mainMenu()
	if comms_target.comms_data == nil then
		comms_target.comms_data = {friendlyness = random(0.0, 100.0)}
	end
	comms_data = comms_target.comms_data
	
	if player:isFriendly(comms_target) then
		return friendlyComms(comms_data)
	end
	if player:isEnemy(comms_target) and comms_target:isFriendOrFoeIdentifiedBy(player) then
		return enemyComms(comms_data)
	end
	return neutralComms(comms_data)
end

function friendlyComms(comms_data)
	if comms_data.friendlyness < 20 then
		setCommsMessage("Que voulez-vous?");
	else
		setCommsMessage("Comment pouvons-nous vous aider?");
	end
	addCommsReply("Defendre un point balise", function()
		if player:getWaypointCount() == 0 then
			setCommsMessage("Pas de balise. Placez d'abord une balise.");
			addCommsReply("Retour", mainMenu)
		else
			setCommsMessage("Quelle balise devons nous défendre ?");
			for n=1,player:getWaypointCount() do
				addCommsReply("Défendre balise " .. n, function()
					comms_target:orderDefendLocation(player:getWaypoint(n))
					setCommsMessage("Nous venons porter notre assistance à la balise " .. n ..".");
					addCommsReply("Retour", mainMenu)
				end)
			end
		end
	end)
	if comms_data.friendlyness > 0.2 then
		addCommsReply("Me soutenir", function()
			setCommsMessage("Nous venons vous aider.");
			comms_target:orderDefendTarget(player)
			addCommsReply("Retour", mainMenu)
		end)
	end
	addCommsReply("Rapport d'état", function()
		msg = "Coque: " .. math.floor(comms_target:getHull() / comms_target:getHullMax() * 100) .. "%\n"
		shields = comms_target:getShieldCount()
		if shields == 1 then
			msg = msg .. "Bouclier: " .. math.floor(comms_target:getShieldLevel(0) / comms_target:getShieldMax(0) * 100) .. "%\n"
		elseif shields == 2 then
			msg = msg .. "Bouclier avant: " .. math.floor(comms_target:getShieldLevel(0) / comms_target:getShieldMax(0) * 100) .. "%\n"
			msg = msg .. "Bouclier arrière: " .. math.floor(comms_target:getShieldLevel(1) / comms_target:getShieldMax(1) * 100) .. "%\n"
		else
			for n=0,shields-1 do
				msg = msg .. "Bouclier " .. n .. ": " .. math.floor(comms_target:getShieldLevel(n) / comms_target:getShieldMax(n) * 100) .. "%\n"
			end
		end

		missile_types = {'Homing', 'Nuke', 'Mine', 'EMP', 'HVLI'}
		for i, missile_type in ipairs(missile_types) do
			if comms_target:getWeaponStorageMax(missile_type) > 0 then
					msg = msg .. missile_type .. " Missiles: " .. math.floor(comms_target:getWeaponStorage(missile_type)) .. "/" .. math.floor(comms_target:getWeaponStorageMax(missile_type)) .. "\n"
			end
		end

		setCommsMessage(msg);
		addCommsReply("Retour", mainMenu)
	end)
	for _, obj in ipairs(comms_target:getObjectsInRange(5000)) do
		if obj.typeName == "SpaceStation" and not comms_target:isEnemy(obj) then
			addCommsReply("Arrimage à " .. obj:getCallSign(), function()
				setCommsMessage("Arrimage à " .. obj:getCallSign() .. ".");
				comms_target:orderDock(obj)
				addCommsReply("Retour", mainMenu)
			end)
		end
	end
	return true
end

function enemyComms(comms_data)
	if comms_data.friendlyness > 50 then
		faction = comms_target:getFaction()
		taunt_option = "Nous allons assister à votre destruction!"
		taunt_success_reply = "Votre espérance de vie s'arrête ici!"
		taunt_failed_reply = "Vos faibles menaces sont sans effet."
		if faction == "Insurgés" then
			setCommsMessage("Vous allez mourir! Sachez-le!");
		elseif faction == "La Menace" then
			setCommsMessage("Restez en-dehors de notre route, ou nous allons devoir tester nos nouveaux missiles.");
		else
			setCommsMessage("Occupez-vous de vos affaires!");
		end
		comms_data.friendlyness = comms_data.friendlyness - random(0, 10)
		addCommsReply(taunt_option, function()
			if random(0, 100) < 30 then
				comms_target:orderAttack(player)
				setCommsMessage(taunt_success_reply);
			else
				setCommsMessage(taunt_failed_reply);
			end
		end)
		return true
	end
	return false
end

function neutralComms(comms_data)
	if comms_data.friendlyness > 50 then
		setCommsMessage("Désolé, nous n'avons pas le temps de discuter avec vous.\nNous sommes sur une mission importante.");
	else
		setCommsMessage("Nous n'avons rien pour vous.\nBonne journée.");
	end
	return true
end

mainMenu()

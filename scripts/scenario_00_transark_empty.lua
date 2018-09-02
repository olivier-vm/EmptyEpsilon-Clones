-- Name: Simulation Transark - mission vide
-- Description: Scenario vide.
-- Type: Basic

function init()
	--CpuShip():setPosition(5000, 5000):setTemplate('Aerodock Trigone - Petit'):setFaction("Trigone"):setRotation(random(0, 360)):orderDefendLocation(5000, 5000)
	--CpuShip():setPosition(-5000, 5000):setTemplate('Aerodock Trigone - Petit'):setFaction("Trigone"):setRotation(random(0, 360)):orderDefendLocation(-5000, 5000)
	--CpuShip():setPosition(5000, -5000):setTemplate('Aerodock Trigone - Petit'):setFaction("Trigone"):setRotation(random(0, 360)):orderDefendLocation(5000, -5000)
	--CpuShip():setPosition(-5000, -5000):setTemplate('Aerodock Trigone - Petit'):setFaction("Trigone"):setRotation(random(0, 360)):orderDefendLocation(-5000, -5000)
	player1 = PlayerSpaceship():setFaction("Transark"):setTemplate("Cargo Materiel RLS"):setRotation(200)
    --player2 = PlayerSpaceship():setFaction("Transark"):setTemplate("Enhydra"):setRotation(0)
	--Nebula():setPosition(-5000, 0)
    --Artifact():setPosition(1000, 9000):setModel("small_frigate_1"):setDescription("An old space derelict.")
    --Artifact():setPosition(9000, 2000):setModel("small_frigate_1"):setDescription("A wrecked ship.")
    --Artifact():setPosition(3000, 4000):setModel("small_frigate_1"):setDescription("Tons of rotting plasteel.")
    --addGMFunction("move 1 to 2", function() player1:transferPlayersToShip(player2) end)
    --addGMFunction("move 2 to 1", function() player2:transferPlayersToShip(player1) end)
    --CpuShip():setTemplate("Adder MK5"):setPosition(0, 0):setRotation(0):setFaction("Transark")
    --CpuShip():setTemplate("Piranha F12"):setPosition(2000, 0):setRotation(-90):setFaction("Insurges")


    addGMFunction("Random champ d'asteroides", function()
        cleanup()
        for n=1,1000 do
			Asteroid():setPosition(random(-50000, 50000), random(-100000, 100000)):setSize(random(100, 500))
			VisualAsteroid():setPosition(random(-55000, 55000), random(-100000, 100000)):setSize(random(100, 500))
        end
    end)
    addGMFunction("Random champ de micro-nebuleuses", function()
        cleanup()
        for n=1,50 do
			Nebula():setPosition(random(-50000, 50000), random(-50000, 50000))
        end
    end)
    addGMFunction("Effacer non-selectionnes", function()
        local gm_selection = getGMSelection()
        for _, obj in ipairs(getAllObjects()) do
            local found = false
            for _, obj2 in ipairs(gm_selection) do
                if obj == obj2 then
                    found = true
                end
            end
            if not found then
                obj:destroy()
            end
        end
    end)
end

function cleanup()
    --Clean up the current play field. Find all objects and destroy everything that is not a player.
    -- If it is a player, position him in the center of the scenario.
    for _, obj in ipairs(getAllObjects()) do
        if obj.typeName == "PlayerSpaceship" then
            obj:setPosition(random(-100, 100), random(-100, 100))
        else
            obj:destroy()
        end
    end
end

function update(delta)
	--No victory condition
end

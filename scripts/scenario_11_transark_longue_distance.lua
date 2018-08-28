-- Name: Simulation Transark - Longue distance
-- Description: Mission de pilotage sur longue distance avec cargo. Nécessite de la dextérité pour le pilote. Un dosage des moteurs, et de l'ingénieur pour le refroiddement moteur. 
-- Type: Mission

require("utils.lua")

function init()
	-- Vaisseau joueur
	player = PlayerSpaceship():setCallSign("Sigma 7"):setFaction("Transark"):setTemplate("Cargo Extracteur RLS"):setPosition(0, 0):setRotation(-90):commandTargetRotation(-90)

	x, y = player:getPosition()
	asteroidList = {}
	-- Création d'une aura d'asteroïdes
	-- La répartition de fait "carrée" pour une bonne répartition géométrique
	-- Si la répartition se faisait concentrique, il y a une plus forte concentration d'élément près du centre que de l'extérieur
	
	for n=1,500 do
		table.insert(asteroidList, Asteroid():setPosition(x + random(-30000, 30000), y + random(-30000, 30000)):setSize(random(10, 500)))
	end

	-- GM buttons
	addGMFunction("phase 1", function()
		mission_state = phase1
	end)
	
	Script():run("scenar_minerai.lua")
	
	-- Etat initial de la mission
	mission_state = phase1
end

function asteroidUpdate()
	for _, system in ipairs({"reactor", "LASERweapons", "maneuver", "missilesystem", "frontshield", "rearshield", "RLS", "impulse", "WARPdrive"}) do
		player:setSystemPower(system, 1.0)
		player:commandSetSystemPowerRequest(system, 1.0)
		player:setSystemHealth(system, 1.0)
	end
	player:setHullMax(1000)
	player:setHull(1000)
	-- Il faut repérer dans quel quadrant (et quel coin éventuel) un astéroid est supprimé, pour en rajouter un dans le côté opposé, afin de garantir une répartition régulière
	local x, y = player:getPosition()
	for n = 1,500 do
		distanceTooFar = 0
		local i, j = asteroidList[n]:getPosition()
		local xxx = x - i
		local yyy = y - j
		if xxx > 30200 then distanceTooFar = distanceTooFar + 1 end -- West
		if xxx < -30200 then distanceTooFar = distanceTooFar + 2 end -- East
		if yyy > 30200 then distanceTooFar = distanceTooFar + 4 end -- North
		if yyy < -30200 then distanceTooFar = distanceTooFar + 8 end -- South
		if distanceTooFar > 0 then
			-- On change la position de l'astéroïde qui est trop loin, et on le place dans le quadrant opposé à une distance supérieur au champ de vision 30000 < ... < 30200
			if distanceTooFar == 1 then
				asteroidList[n]:setPosition(x + random(30000, 30200), y + random(-30000, 30000)):setSize(random(10, 500))
			elseif distanceTooFar == 2 then
				asteroidList[n]:setPosition(x + random(-30000, -30200), y + random(-30000, 30000)):setSize(random(10, 500))
			elseif distanceTooFar == 4 then
				asteroidList[n]:setPosition(x + random(-30000, 30000), y + random(30000, 30200)):setSize(random(10, 500))
			elseif distanceTooFar == 8 then
				asteroidList[n]:setPosition(x + random(-30000, 30000), y + random(-30000, -30200)):setSize(random(10, 500))
			elseif distanceTooFar == 5 then
				asteroidList[n]:setPosition(x + random(30000, 30200), y + random(30000, 30200)):setSize(random(10, 500))
			elseif distanceTooFar == 6 then
				asteroidList[n]:setPosition(x + random(-30000, -30200), y + random(30000, 30200)):setSize(random(10, 500))
			elseif distanceTooFar == 9 then
				asteroidList[n]:setPosition(x + random(30000, 30200), y + random(-30000, -30200)):setSize(random(10, 500))
			elseif distanceTooFar == 10 then
				asteroidList[n]:setPosition(x + random(-30000, -30200), y + random(-30000, -30200)):setSize(random(10, 500))
			end
		end
	end
	

end

------------------------------------
-- Gestion des phases de missions
------------------------------------

-- Première phase de la mission
function phase1(delta)
--	if delta > 0 then
--		mission_state = phase2
--	end
	asteroidUpdate()
end

function phase4End(delta)
    --Nothing to do
end
--------------------
-- Communications
--------------------

function shipComms()
	if mission_state == phase1 then
		setCommsMessage([[blablabla]])
		return
	end

    setCommsMessage([[blablabla]])
end

----------------------------------
-- Update
----------------------------------

function update(delta)
	if mission_state ~= nil then
		mission_state(delta)
    end
end
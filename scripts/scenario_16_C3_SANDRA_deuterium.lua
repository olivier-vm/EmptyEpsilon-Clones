-- Name: C3 - Real Transark - S.A.N.D.R.A. Deuterium
-- Description: Mission de pilotage sans ennemis. Un cargo mineur Transark doit recolter du Deuterium pur. Pour faire fonctionner le S.A.N.D.R.A., du Deuterium est necessaire, ce dont DNG-72 ne dispose pas. Le secteur ne possede pas encore non plus les moyens pour raffiner ce Deuterium. DNG-72 a donc recu la permission exceptionnelle d'effectuer une mission de collecte de Deuterium sur un asteroide en orbite autour de Maatrah et qui appartient au secteur Premier. Il faudra ensuite livrer ce Deuterium a BNA-108 qui le raffinera pour DNG-72.
-- Type: Mission

require("utils.lua")

function init()
	-- Vaisseau joueur
	player = PlayerSpaceship():setCallSign("Sigma 7"):setFaction("Transark"):setTemplate("Cargo Extracteur RLS"):setPosition(0, 0):setRotation(-90):commandTargetRotation(-90)

	x, y = player:getPosition()

  -- Asteroides
	asteroidList = {}
	-- Creation d'une aura d'asteroides
	-- La repartition de fait "carree" pour une bonne repartition geometrique
	-- Si la repartition se faisait concentrique, il y a une plus forte concentration d'element pres du centre que de l'exterieur
	-- Les deplacement dans les asteroides, sont soumis a la fonction asteroidUpdate qui garanti en permanence la présence d'asteroide ou qu'on soit.
	-- Si on s'éloignent trop, les asteroides qui disparaissent contenant eventuellement des minerais ne reapparaitront plus avec ces minerais. Au gamemaster de garantir la présence de minerai en fonction de la position des joueurs
	for n=1,3000 do
		table.insert(asteroidList, Asteroid():setPosition(x + random(-300000, 300000), y + random(-300000, 300000)):setSize(random(10, 500)))
	end

	-- Nebuleuses
	nebulaList = {}
	for n=1,150 do
		table.insert(nebulaList, Nebula():setPosition(x + random(-300000, 300000), y + random(-300000, 300000)))
	end

	-- Station
	SpaceStation():setTemplate("Small Station"):setFaction("Transark"):setCallSign("DS-DNG-72"):setPosition(-68203, 28889)
	SpaceStation():setTemplate("Small Station"):setFaction("Transark"):setCallSign("DS-BNA-108"):setPosition(121549, -88683)

	--Moving ships (defend location)
	shipList = {}
	for n=1,20 do
		table.insert(shipList, CpuShip():setPosition(x + random(-300000, 300000), y + random(-300000, 300000)):setFaction("Technocorp"):setTemplate('Cargo Extracteur RLS'):orderDefendLocation(x + random(-300000, 300000), y + random(-300000, 300000)))
		table.insert(shipList, CpuShip():setPosition(x + random(-300000, 300000), y + random(-300000, 300000)):setFaction("Transark"):setTemplate('Cargo Extracteur RLS'):orderDefendLocation(x + random(-300000, 300000), y + random(-300000, 300000)))
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
	-- Il faut reperer dans quel quadrant (et quel coin eventuel) un asteroid est supprime, pour en rajouter un dans le cote oppose, afin de garantir une repartition reguliere
	local x, y = player:getPosition()
	for _, astero in ipairs(getAllObjects()) do
		if astero.typeName == "Asteroid" then
			distanceTooFar = 0
			local i, j = astero:getPosition()
			local xxx = x - i
			local yyy = y - j
			if xxx > 302000 then distanceTooFar = distanceTooFar + 1 end -- West
			if xxx < -302000 then distanceTooFar = distanceTooFar + 2 end -- East
			if yyy > 302000 then distanceTooFar = distanceTooFar + 4 end -- North
			if yyy < -302000 then distanceTooFar = distanceTooFar + 8 end -- South
			if distanceTooFar > 0 then
				-- On change la position de l'asteroide qui est trop loin, et on le place dans le quadrant oppose a une distance superieur au champ de vision 300000 < ... < 302000
				if distanceTooFar == 1 then
					asteroidList[n]:setPosition(x + random(30000, 302000), y + random(-300000, 300000)):setSize(random(10, 500))
				elseif distanceTooFar == 2 then
					asteroidList[n]:setPosition(x + random(-300000, -302000), y + random(-300000, 300000)):setSize(random(10, 500))
				elseif distanceTooFar == 4 then
					asteroidList[n]:setPosition(x + random(-300000, 300000), y + random(300000, 302000)):setSize(random(10, 500))
				elseif distanceTooFar == 8 then
					asteroidList[n]:setPosition(x + random(-300000, 300000), y + random(-300000, -302000)):setSize(random(10, 500))
				elseif distanceTooFar == 5 then
					asteroidList[n]:setPosition(x + random(300000, 302000), y + random(300000, 302000)):setSize(random(10, 500))
				elseif distanceTooFar == 6 then
					asteroidList[n]:setPosition(x + random(-300000, -302000), y + random(300000, 302000)):setSize(random(10, 500))
				elseif distanceTooFar == 9 then
					asteroidList[n]:setPosition(x + random(300000, 302000), y + random(-300000, -302000)):setSize(random(10, 500))
				elseif distanceTooFar == 10 then
					asteroidList[n]:setPosition(x + random(-300000, -302000), y + random(-300000, -302000)):setSize(random(10, 500))
				end
			end
		end
	end
end

------------------------------------
-- Gestion des phases de missions
------------------------------------

-- Premiere phase de la mission
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

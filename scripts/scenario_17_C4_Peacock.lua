-- Name: C4 - Real Transark - Peacock
-- Description: Mission d'exploration. Peacock est a bord et part investiguer la zone de la singularite. 1ere partie: Sigma-7 est en renfort pilotant un vaisseau voisin.
-- Type: Mission

function init()

	-- Vaisseau Sigma 7
	player = PlayerSpaceship():setFaction("Transark"):setTemplate("Cargo Materiel RLS"):setWARPDrive(false)
	player:setPosition(58700, 11500):setCallSign("LL-AMS 30"):setRotation(180):commandTargetRotation(180)
	player:setWeaponStorage("Mine", 8)

	-- Vaisseau Teorun
	x, y = player:getPosition()
	teorun = CpuShip():setFaction("Transark"):setTemplate("Transport personnes RLS"):setWARPDrive(false)
	teorun:setCallSign("PEACOCK LL-AMS 36"):setPosition(59160, 11755):setRotation(0):setRLSDrive(true)
	teorun:orderDefendLocation(x, y)

	-- Space stations
	station_tc = SpaceStation():setTemplate("Large Station"):setFaction("Technocorp"):setCallSign("TC-DS7"):setPosition(5529, 0)
	station_tr = SpaceStation():setTemplate("Large Station"):setFaction("Transark"):setCallSign("TR-DS69"):setPosition(-295000, -266000)

	-- Creation d'une aura d'asteroides et nebuleuses
	for n=1,1000 do
		Asteroid():setPosition(x + random(-300000, 300000), y + random(-300000, 300000)):setSize(random(10, 500))
	end
	for n=1,150 do
		Nebula():setPosition(x + random(-300000, 300000), y + random(-300000, 300000))
	end

	-- Vaisseau pas loin des joueurs
	CpuShip():setFaction("Technocorp"):setTemplate("Cargo Marchandise RLS Dock"):setCallSign("EG-ARL-X58"):setPosition(57673, 17221):setRotation(180):setRLSDrive(true):setWARPDrive(false)

	-- Vaisseaux en standby
	shipA = CpuShip():setFaction("Transark"):setTemplate("Cargo Marchandise RLS Dock"):setCallSign("SF-QRN 18"):setPosition(-95009, -106262):setRLSDrive(true):setShields(0.00, 0.00):setWARPDrive(false)
	shipB = CpuShip():setFaction("Transark"):setTemplate("Cargo Marchandise 4"):setCallSign("EG-RAL 42"):setPosition(-84050, -83562):setRLSDrive(true):setShields(0.00, 0.00):setWARPDrive(false)
	shipC = CpuShip():setFaction("Transark"):setTemplate("Cargo Marchandise 4"):setCallSign("EG-RAL 48"):setPosition(-64481, -83953):setRLSDrive(true):setShields(0.00, 0.00):setWARPDrive(false)

	-- Vaisseaux roaming a la station Transark
	CpuShip():setFaction("Technocorp"):setTemplate("Cargo Marchandise 2"):setCallSign("VK6"):setPosition(-290000, -269000):setRLSDrive(true):orderDefendLocation(-290000, -269000):setWARPDrive(false)
	CpuShip():setFaction("Technocorp"):setTemplate("Cargo Marchandise 2"):setCallSign("CV5"):setPosition(-300000, -260000):setRLSDrive(true):orderDefendLocation(-300000, -260000):setWARPDrive(false)
	CpuShip():setFaction("Technocorp"):setTemplate("Cargo Marchandise RLS Dock"):setCallSign("EG-ARL-X58"):setPosition(-91877, -82596):setWARPDrive(false)

	-- GM buttons
	addGMFunction("Teorun with Player", function()
		x, y = player:getPosition()
		teorun:orderFlyTowards(x, y)
	end)
	addGMFunction("Teorun Standby", function()
		teorun:orderIdle()
	end)
	addGMFunction("Add Singu", function()
		addSingu()
	end)
	addGMFunction("Remove Singu", function()
		removeSingu()
	end)
	addGMFunction("Add Fences", function()
		addFences()
	end)
	addGMFunction("Play Teorun", function()
		shipTeorunPlayable()
	end)
	addGMFunction("Moteurs Defect", function()
		mission_state = shipDisabled
	end)
	addGMFunction("Moteurs OFF", function()
		moteursOFF()
		mission_state = phaseExplore
	end)
	addGMFunction("Moteurs ON", function()
		moteursON()
		mission_state = phaseExplore
	end)
	addGMFunction("Warp Ship", function()
		shipWarp()
	end)
	addGMFunction("Teorun RIP", function()
		teorunIsDead()
	end)
	addGMFunction("Zone Ship to Singu", function()
		player:setPosition(101333, -321662):setRotation(315)
	end)
	mission_state = phase1init
end

--
-- Fonctions
--

function addFences()

    CpuShip():setFaction("Transark"):setTemplate("Cargo Equipement 5"):setCallSign("CV13"):setPosition(111497, -366781):orderFlyTowards(77641, -344499):setWARPDrive(false):setRLSDrive(false)
    CpuShip():setFaction("Transark"):setTemplate("Cargo Equipement 5"):setCallSign("VK12"):setPosition(146108, -339526):orderFlyTowards(116582, -363487):setWARPDrive(false):setRLSDrive(false)
    CpuShip():setFaction("Transark"):setTemplate("Cargo Equipement 5"):setCallSign("BR11"):setPosition(121732, -299764):orderFlyTowards(146516, -337037):setWARPDrive(false):setRLSDrive(fasle)
    CpuShip():setFaction("Transark"):setTemplate("Cargo Equipement 5"):setCallSign("S10"):setPosition(74510, -336726):orderFlyTowards(95019, -294293):setWARPDrive(false):setRLSDrive(false)

	-- Barière de sondes à balayage quantique
	RLSJammer():setFaction("Transark"):setPosition(102977, -326298)
	RLSJammer():setFaction("Transark"):setPosition(127042, -326448)
	RLSJammer():setFaction("Transark"):setPosition(127267, -333420)
	RLSJammer():setFaction("Transark"):setPosition(109125, -329821)
	RLSJammer():setFaction("Transark"):setPosition(115122, -333345)
	RLSJammer():setFaction("Transark"):setPosition(102902, -333345)
	RLSJammer():setFaction("Transark"):setPosition(121045, -329971)
	RLSJammer():setFaction("Transark"):setPosition(115197, -326298)
	RLSJammer():setFaction("Transark"):setPosition(121269, -343990)
	RLSJammer():setFaction("Transark"):setPosition(121344, -337018)
	RLSJammer():setFaction("Transark"):setPosition(127492, -340692)
	RLSJammer():setFaction("Transark"):setPosition(109050, -336943)
	RLSJammer():setFaction("Transark"):setPosition(109125, -343990)
	RLSJammer():setFaction("Transark"):setPosition(115197, -340467)
	RLSJammer():setFaction("Transark"):setPosition(115347, -347589)
	RLSJammer():setFaction("Transark"):setPosition(109200, -351187)
	RLSJammer():setFaction("Transark"):setPosition(102827, -340467)
	RLSJammer():setFaction("Transark"):setPosition(102977, -347589)
	RLSJammer():setFaction("Transark"):setPosition(90532, -340692)
	RLSJammer():setFaction("Transark"):setPosition(90532, -333195)
	RLSJammer():setFaction("Transark"):setPosition(96605, -336943)
	RLSJammer():setFaction("Transark"):setPosition(96755, -344065)
	RLSJammer():setFaction("Transark"):setPosition(96755, -329671)
	RLSJammer():setFaction("Transark"):setPosition(90607, -326073)
	RLSJammer():setFaction("Transark"):setPosition(108975, -322699)
	RLSJammer():setFaction("Transark"):setPosition(115122, -319251)
	RLSJammer():setFaction("Transark"):setPosition(121269, -322774)
	RLSJammer():setFaction("Transark"):setPosition(121269, -315727)
	RLSJammer():setFaction("Transark"):setPosition(102827, -319176)
	RLSJammer():setFaction("Transark"):setPosition(108750, -315577)
	RLSJammer():setFaction("Transark"):setPosition(108675, -308680)
	RLSJammer():setFaction("Transark"):setPosition(114972, -312204)
	RLSJammer():setFaction("Transark"):setPosition(102602, -312279)
	RLSJammer():setFaction("Transark"):setPosition(127492, -319551)
	RLSJammer():setFaction("Transark"):setPosition(96455, -315577)
	RLSJammer():setFaction("Transark"):setPosition(96905, -322624)
	RLSJammer():setFaction("Transark"):setPosition(90757, -319101)
end

function addSingu()
	-- Singularite a l'oree du champ d'asteroide et de nebuleuses
	-- Ce sont des wormhole qui s'absorbent les uns les autres en croisement. Fluctuations de position permanente
	wh1 = WormHole():setPosition(111449, -328347):setTargetPosition(106643, -331358)
	wh2 = WormHole():setPosition(107234, -327317):setTargetPosition(111449, -328347)
	wh3 = WormHole():setPosition(110404, -332004):setTargetPosition(107234, -327317)
	wh4 = WormHole():setPosition(106643, -331358):setTargetPosition(110404, -332004)
end

function removeSingu()
	wh1:destroy()
	wh2:destroy()
	wh3:destroy()
	wh4:destroy()
end

function shipTeorunPlayable()
	k, l = teorun:getPosition()
	
	-- Cannot detsroy ship or ship selector in GM crash the server
	--if player:isValid() then player:destroy() end
	--if teorun:isValid() then teorun:destroy() end
	
	-- Old player offline
	player:setCallSign("OFFLINE LL-AMS 30"):setRotation(180):commandTargetRotation(180):setRLSDrive(false)
	player:setEnergy(0.02)
	player:setEnergy(0.01)
	for _, system in ipairs({"reactor", "LASERweapons", "maneuver", "missilesystem", "frontshield", "rearshield", "RLS", "impulse"}) do
		player:setSystemPower(system, 0.01)
		player:commandSetSystemPowerRequest(system, 0.01)
		player:setSystemHealth(system, 0.01)
	end
	player:setImpulseMaxSpeed(0.01)
	player:setRotationMaxSpeed(0.01)
	player:setCombatManeuver(0.01, 0.01)
	
	-- Rename old Peacock to SKF
	-- Holding the humans leaving the ship
	x, y = station_tr:getPosition()
	teorun:setCallSign("Escaping crew"):orderDefendLocation(x, y)
	
	-- Create new player to replace Teorun ship
	player = PlayerSpaceship():setFaction("Transark"):setTemplate("Transport personnes RLS")
	player:setCallSign("PEACOCK LL-AMS 36"):setPosition(k, l):setRotation(180):setRLSDrive(true):setWARPDrive(false)
end

function moteursOFF()
	for _, system in ipairs({"reactor", "LASERweapons", "maneuver", "missilesystem", "frontshield", "rearshield","RLS", "impulse", "WARPdrive"}) do
		player:setSystemPower(system, 0.0):commandSetSystemPowerRequest(system, 0.0):setSystemHealth(system, 1.0):setShields(50.00, 50.00)
	end
end

function moteursON()
	for _, system in ipairs({"reactor", "LASERweapons", "maneuver", "missilesystem", "frontshield", "rearshield","RLS", "impulse", "WARPdrive"}) do
		player:setSystemPower(system, 1.0):commandSetSystemPowerRequest(system, 1.0):setSystemHealth(system, 1.0):setShields(50.00, 50.00)
	end
end

function moteursEnRade()
	for _, system in ipairs({"reactor", "LASERweapons", "maneuver", "missilesystem", "frontshield", "rearshield"}) do
		player:setSystemPower(system, random(0.0, 0.5))
		player:commandSetSystemPowerRequest(system, 0.2)
		player:setSystemHealth(system, random(0.0, 0.5))
	end
	for _, system in ipairs({"RLS", "impulse", "WARPdrive"}) do
		player:setSystemPower(system, random(0.0, 0.1))
		player:commandSetSystemPowerRequest(system, 0.05)
		player:setSystemHealth(system, random(0.0, 0.1))
	end
end

function shipWarp()
	m, n = player:getPosition()

	-- Cannot detsroy ship or ship selector in GM crash the server
	--if player:isValid() then player:destroy() end

	-- player offline
	player:setCallSign("COMM ERROR"):setRLSDrive(false)
--	player:setEnergy(0.02)
--	player:setEnergy(0.01)
--	for _, system in ipairs({"reactor", "LASERweapons", "maneuver", "missilesystem", "frontshield", "rearshield", "RLS", "impulse"}) do
--		player:setSystemPower(system, 0.01)
--		player:commandSetSystemPowerRequest(system, 0.01)
--		player:setSystemHealth(system, 0.01)
--	end
--	player:setImpulseMaxSpeed(0.01)
--	player:setRotationMaxSpeed(0.01)
--	player:setCombatManeuver(0.01, 0.01)

	player:setPosition(m + random(-1000, 1000), n + random(-1000, 1000))
end

function teorunIsDead()
	if player:isValid() then player:destroy() end
end

function moteurRLSJammed()
	player:setSystemPower("RLS", random (0.0, 0.3))
	player:commandSetSystemPowerRequest("RLS", 0.05)
	player:setSystemHealth("RLS", random(0.0, 0.3))
	player:setSystemPower("WARPdrive", random (0.0, 0.3))
	player:commandSetSystemPowerRequest("WARPdrive", 0.05)
	player:setSystemHealth("WARPdrive", random(0.0, 0.3))
end


--
-- Phases
--

-- Demarrage, premier contact
function phase1init(delta)
	if delta > 0 then
		station_tr:sendCommsMessage(player, [[Sigma-7,
		
ici Phi 10, nous vous donnons a present les commandes du LL-AMS 30.
Pour rappel c'est le commandant Peacock qui est en charge de cette mission d'exploration.

Il est a bord de l'autre vaisseau LL-AMS 36 dans vos traces avec ses occupants humains.
Vous devez jouer le role d'eclaireur en suivant ses instructions.

Pour rappel son vaisseau est bride en acceleration pour le transport d'humains donc ne
prenez pas de distance en vous eloigant de trop.

Bonne chance !]])
		mission_state = phaseExplore
	end
end

function shipsZoned(delta)
	player:setPosition(101333, -321662):setRotation(315)
end

function shipDisabled(delta)
	moteursEnRade()
end

function phaseExplore(delta)

end

--
-- update
--

function update(delta)
	if mission_state ~= nil then
		mission_state(delta)
	end
end

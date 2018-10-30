-- Name: C3 - Real Transark - Bermudes
-- Description: LL-AMS 36 a secourir.
-- Type: Mission

function init()
	station_tc = SpaceStation():setTemplate("Large Station"):setFaction("Technocorp"):setCallSign("TC-DS7"):setPosition(5529, 0)
  station_tr = SpaceStation():setTemplate("Large Station"):setFaction("Transark"):setCallSign("TR-DS69"):setPosition(-295000, -266000)
	-- Vaisseau en Transit sur lequel est arrime le vaisseau des joueurs SKF
	-- Ne pourra partir qu'une fois remplis du materiel necessaire
	eg_arl = CpuShip():setFaction("Technocorp"):setTemplate("Cargo Marchandise RLS Dock"):setCallSign("EG-ARL-X58"):setPosition(59149, 11742):setRotation(180):setRLSDrive(true)

	player = PlayerSpaceship():setFaction("Transark"):setTemplate("Cargo Materiel RLS")
	player:setPosition(58700, 11500):setCallSign("SKF"):setRotation(180):commandTargetRotation(180)
--	player:setPosition(59149, 11742):setCallSign("SKF"):setRotation(90):commandTargetRotation(90)
	player:setWeaponStorage("Mine", 8)

	x, y = player:getPosition()

	-- Asteroides
	asteroidList = {}
	-- Creation d'une aura d'asteroides
	for n=1,1000 do
		table.insert(asteroidList, Asteroid():setPosition(x + random(-300000, 300000), y + random(-300000, 300000)):setSize(random(10, 500)))
	end

	-- Nebuleuses
	nebulaList = {}
	for n=1,150 do
		table.insert(nebulaList, Nebula():setPosition(x + random(-300000, 300000), y + random(-300000, 300000)))
	end

	-- Vaisseaux a secourir
	shipA = CpuShip():setFaction("Transark"):setTemplate("Cargo Marchandise RLS Dock"):setCallSign("LL-AMS 36"):setPosition(-95009, -106262):setRLSDrive(true):setShields(0.00, 0.00)
	shipB = CpuShip():setFaction("Transark"):setTemplate("Cargo Marchandise 4"):setCallSign("EG-RAL 42"):setPosition(-84050, -83562):setRLSDrive(true):setShields(0.00, 0.00)
	shipC = CpuShip():setFaction("Transark"):setTemplate("Cargo Marchandise 4"):setCallSign("EG-RAL 48"):setPosition(-64481, -83953):setRLSDrive(true):setShields(0.00, 0.00)

	-- Vaisseaux roeming à la station Transark
	CpuShip():setFaction("Technocorp"):setTemplate("Cargo Marchandise 2"):setCallSign("VK6"):setPosition(-290000, -269000):setRLSDrive(true):orderDefendLocation(-290000, -269000)
	CpuShip():setFaction("Technocorp"):setTemplate("Cargo Marchandise 2"):setCallSign("CV5"):setPosition(-300000, -260000):setRLSDrive(true):orderDefendLocation(-300000, -260000)

	-- GM buttons
	addGMFunction("Materiel OK", function()
		mission_state = phase1WaitForStart
	end)
	addGMFunction("A rescued", function()
		mission_state = phase3rescued
	end)

	mission_state = phase1init
end

--
-- Fonctions
--

function SKFDocking()
	for _, system in ipairs({"maneuver", "impulse"}) do
		player:setSystemPower(system, 1.0):commandSetSystemPowerRequest(system, 1.0)
	end
	for _, system in ipairs({"reactor", "LASERweapons", "missilesystem", "RLS", "WARPdrive", "frontshield", "rearshield"}) do
		player:setSystemPower(system, 0.0):commandSetSystemPowerRequest(system, 0.0)
	end
	player:commandDock(eg_arl)
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

function rescuedOFF()
	for _, system in ipairs({"reactor", "LASERweapons", "maneuver", "missilesystem", "frontshield", "rearshield","RLS", "impulse", "WARPdrive"}) do
		shipA:setSystemPower(system, 0.0):setSystemHealth(system, random(0.0, 0.2)):setShields(0.00, 0.00)
		shipB:setSystemPower(system, 0.0):setSystemHealth(system, random(0.0, 0.2)):setShields(0.00, 0.00)
		shipC:setSystemPower(system, 0.0):setSystemHealth(system, random(0.0, 0.2)):setShields(0.00, 0.00)
	end
end

function rescuedA_OK()
	for _, system in ipairs({"reactor", "LASERweapons", "maneuver", "missilesystem", "frontshield", "rearshield","RLS", "impulse", "WARPdrive"}) do
		shipA:setSystemPower(system, 1.0):setSystemHealth(system, 1.0):setShields(50.00, 50.00)
		shipB:setSystemPower(system, 0.0):setSystemHealth(system, random(0.0, 0.2)):setShields(0.00, 0.00)
		shipC:setSystemPower(system, 0.0):setSystemHealth(system, random(0.0, 0.2)):setShields(0.00, 0.00)
	end
end


--
-- Phases
--

-- Demarrage, premier contact
function phase1init(delta)
	if delta > 0 then
		rescuedOFF()
		station_tc:sendCommsMessage(player, [[Bonjour Sigma-7,
EG-ARL-X58 est en cours d'approche et d'arrimage a la station. Etablissez un contact avec eux, ils doivent savoir comment et quoi charger dans la barge de secours pour votre mission de sauvetage.

Veuilliez ensuite attendre leur feu vert, qu'ils aient fini le chargement, pour pouvoir partir.]])
		mission_state = phase1SKFDocking
	end
end

-- Le SKF doit etre docked
function phase1SKFDocking(delta)
	rescuedOFF()
	SKFDocking()
	if player:isDocked(eg_arl) then
		mission_state = phase1WaitArriving
	end
end

-- eg_arl doit etre a la station
--function phase1WaitArriving(delta)
--	rescuedOFF()
--	moteursOFF()
--	eg_arl:orderFlyTowards(7000, 1500)
--	if distance(eg_arl, 7000, 1500) < 100 then
--		eg_arl:orderDock(station_tc)
--		mission_state = phase1WaitForLoad
--	end
--end

-- eg_arl doit etre a la station
function phase1WaitArriving(delta)
	rescuedOFF()
	moteursOFF()
	eg_arl:orderDock(station_tc)
	if distance(eg_arl, 7000, 1500) < 1000 then
		mission_state = phase1WaitForLoad
	end
end

-- Le materiel doit etre charge
function phase1WaitForLoad(delta)
	rescuedOFF()
	moteursOFF()
end

function phase1WaitForStart(delta)
	rescuedOFF()
	moteursON()
	--Chargement effectue, go go go!.
	eg_arl:sendCommsMessage(player, [[SKF,
Nous avons charge le materiels necessaire a la mission de sauvetage. Vous pouvez vous decrocher sans risque.

Foncez au secteur ZZ0. Vous devrez y trouver LL-AMS 36. ne vous occupez pas des autres vaisseaux, d'autres equipes vont s'en occuper.]])
	mission_state = phase2Start
end

function phase2Start(delta)
	rescuedOFF()
end

function phase3rescued(delta)
	rescuedA_OK()
	shipA:orderDock(station_tr)
end


--
-- update
--

function update(delta)
	if mission_state ~= nil then
		mission_state(delta)
	end
end

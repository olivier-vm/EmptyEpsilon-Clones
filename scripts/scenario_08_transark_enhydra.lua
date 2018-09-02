-- Name: Simulation Enhydra
-- Description: Vous etes le premier equipage d'une nouvelle version amelioree d'un explorateur spatial Enhydra.
--- Votre mission sera de lui faire subir sa premiere serie de tests et son bapteme spatial.
--- En cours de mission l'equipage tombe sur d'etranges phenomenes... (il s'agit d'une fiction de combat pour entrainer les hommes a toutes sortes de situations imprevisibles).
-- Type: Mission

require("utils.lua")

--[[
Rundown of the mission:
==Phase 1: Test ship systems.
* Ship starts docked to the station, with 0 power in all systems.
* Engineering has to power up all systems to 100%.
* After that, undocking is possible.
* After undocking, flying to the supply package to pick up missiles.
* Then test the WARP drive to WARP towards the weapons testing area.
* At the weapons testing area, science needs to scan two dummy ships before they can be destroyed.
* Destroy the two dummy ships, one can only be destroyed with missile weapons.
* Have relay open communications to the station for the next objective.
==Phase 2: Discovery
* You first mission will be to investigate a strange signal from a nebula.
* As the nebula is in the outer space regions, you'll have you use a WARP carrier.
* The WARP carrier delivers you to the edge of a nebulea cloud. There are a few Insurges ships here for you to fight.
* The objective is to find an artifact within the nebulea, and scan it. This is a tough scan (lvl3)
* In these nebulea, you can also encounter ghost ships. Which are just lost single ships. As well as two "dud" artefacts that are not the source of the signal.
* When you scan the proper artifact, it gives you 4 readings in the description. Relay needs to pass these readings to the JC-88 or Shipyard before the mission continues.
* When this is done, the artifact becomes unstable, and becomes a wormhole that sucks in the player.
==Phase 3: Lost in enemy space...
* After the wormhole, the player finds himself in Insurges space.
* There are RLS jammers blocking you from WARPing away. And these jammers are well defended. You'll need to navigate or fight you way out of this.
* I highly recommend navigating. Really. There is some code in place that makes all enemies attack if you engage the jammers.
* JC88 will be waiting for you outside of the defense line. He will take you back to the shipyard.
* At the shipyard you will hand in your data, and get your new objective.
==Phase 4: Nice transport you have there, would be bad if something would happen to it...
* At this point a transport will be created and flying around the forwards stations of the Insurges defense line.
* Your task is to destroy this transport and secure it's cargo.
* Engaging it at one of the stations will call the whole Insurges fleet on your ass. So engage the transport between stations.
* Attacking it between stations will still call a taskforce on your ass, so you need to make haste to secure the cargo and get out of there.
==Phase 5:...
--]]

-- Init is run when the scenario is started. Create your initial world
function init()
	-- Create the main ship for the players.
	player = PlayerSpaceship():setFaction("Transark"):setTemplate("Enhydra")
	player:setPosition(25276, 133850):setCallSign("Enhydra-1"):setRotation(-90):commandTargetRotation(-90)
	for _, system in ipairs({"reactor", "LASERweapons", "missilesystem", "maneuver", "impulse", "RLS", "WARPdrive", "frontshield", "rearshield"}) do
		player:setSystemPower(system, 0.0)
		player:commandSetSystemPowerRequest(system, 0.0)
	end
	player:setWeaponStorage("Homing", 0)
	player:setWeaponStorage("Nuke", 0)
	player:setWeaponStorage("EMP", 0)
	player:setWeaponStorage("Mine", 0)
	player:setWeaponStorage("HVLI", 0)

	--Starting area
	shipyard_gamma = SpaceStation():setTemplate("Medium Station"):setFaction("Transark"):setCallSign("Spatiodock Gamma"):setPosition(25276, 134550)
	shipyard_gamma:setCommsFunction(shipyardGammaComms)
	player:commandDock(shipyard_gamma)
	supply_station_6 = SpaceStation():setTemplate("Small Station"):setFaction("Transark"):setCallSign("Supply-6"):setPosition(14491, 126412)
	supply_station_6.comms_data = { --Do not allow supply drops or reinforcements from the supply station.
		services = {
			supplydrop = "none",
			reinforcements = "none",
		}
	}
	Nebula():setPosition(32953, 146374)
	Nebula():setPosition(4211, 129108)
	createObjectsOnLine(37351, 125310, 39870, 137224, 1000, Mine, 2, 90)
	CpuShip():setFaction("Transark"):setTemplate("Phobos T3"):setCallSign("D-2"):setScanned(true):setPosition(12419, 124184):orderDefendTarget(supply_station_6):setCommsScript("")
	CpuShip():setFaction("Transark"):setTemplate("Phobos T3"):setCallSign("D-3"):setScanned(true):setPosition(16104, 127943):orderDefendTarget(supply_station_6):setCommsScript("")

	createObjectsOnLine(6333, 135054, 12390, 148498, 700, Asteroid, 5, 100, 2000)
	createObjectsOnLine(12390, 148498, 27607, 149902, 700, Asteroid, 5, 100, 2000)
	createObjectsOnLine(6333, 135054, 12390, 148498, 700, VisualAsteroid, 5, 100, 2000)
	createObjectsOnLine(12390, 148498, 27607, 149902, 700, VisualAsteroid, 5, 100, 2000)

	Nebula():setPosition(13314, 108306)
	Nebula():setPosition(30851, 94744)
	Nebula():setPosition(37574, 112457)
	transport_f1 = CpuShip():setFaction("Transark"):setTemplate("Flavia"):setCallSign("F-1"):setScanned(true):setPosition(28521, 114945):orderIdle()
	transport_f1:setCommsScript("")

	target_dummy_1 = CpuShip():setFaction("Insurges"):setTemplate("MT52 Hornet"):setCallSign("Factice-1"):setPosition(29269, 109499):orderIdle():setRotation(random(0, 360))
	target_dummy_2 = CpuShip():setFaction("Insurges"):setTemplate("MT52 Hornet"):setCallSign("Factice-2"):setPosition(31032, 109822):orderIdle():setRotation(random(0, 360))
	target_dummy_1:setHullMax(1):setHull(1):setShieldsMax(300):setScanningParameters(1, 1):setCommsScript("")
	target_dummy_2:setHullMax(1):setHull(1):setShieldsMax(300):setScanningParameters(1, 1):setCommsScript("")

	jc88 = CpuShip():setFaction("Transark"):setTemplate("Transporteur WARP"):setCallSign("JC-88"):setScanned(true):setPosition(18972, 135882):orderIdle()
	jc88:setCommsFunction(jc88Comms)

	--Sector B20
	insurge_b20_1 = CpuShip():setFaction("Insurges"):setTemplate("WX-Lindworm"):setCallSign("S11"):setPosition(304666, -75558):orderDefendLocation(304666, -75558):setWeaponStorage("Homing", 0):setWeaponStorage("HVLI", 4)
	insurge_b20_2 = CpuShip():setFaction("Insurges"):setTemplate("MU52 Hornet"):setCallSign("S10"):setPosition(306010, -74718):orderDefendLocation(306010, -74718)
	insurge_b20_3 = CpuShip():setFaction("Insurges"):setTemplate("Adder MK5"):setCallSign("CCN8"):setPosition(304364, -74222):orderDefendLocation(304364, -74222):setWeaponStorage("HVLI", 3)
	b20_nebula_list = {}
	table.insert(b20_nebula_list, Nebula():setPosition(319259, -78069))
	table.insert(b20_nebula_list, Nebula():setPosition(321469, -70621))
	table.insert(b20_nebula_list, Nebula():setPosition(324743, -62928))
	table.insert(b20_nebula_list, Nebula():setPosition(335382, -61946))
	table.insert(b20_nebula_list, Nebula():setPosition(334809, -72258))
	table.insert(b20_nebula_list, Nebula():setPosition(325643, -88627))
	table.insert(b20_nebula_list, Nebula():setPosition(328671, -79788))
	table.insert(b20_nebula_list, Nebula():setPosition(315655, -85367))

	nebula = table.remove(b20_nebula_list, math.random(#b20_nebula_list))
	x, y = nebula:getPosition()
	b20_artifact = Artifact():setPosition(x + random(-1000, 1000), y + random(-1000, 1000))
	b20_artifact:setScanningParameters(3, 1)
	b20_artifact.nebula = nebula
	b20_artifact.beta_radiation = irandom(1, 10)
	b20_artifact.gravity_disruption = irandom(1, 10)
	b20_artifact.ionic_phase_shift = irandom(1, 10)
	b20_artifact.doppler_instability = irandom(1, 10)
	b20_artifact:setDescriptions("Un dechet flottant dans l'espace.", string.format([[Trouve! Nous obtenons des mesures etranges sur cet objet.
Nos capteurs observent:
Radiation beta: %i
Deplacement de phase ionic: %i
Perturbation gravitationnelle: %i
Instabilite Doppler: %i]], b20_artifact.beta_radiation, b20_artifact.ionic_phase_shift, b20_artifact.gravity_disruption, b20_artifact.doppler_instability))

	x, y = table.remove(b20_nebula_list, math.random(#b20_nebula_list)):getPosition()
	b20_dummy_artifact_1 = Artifact():setPosition(x + random(-1000, 1000), y + random(-1000, 1000)):setDescriptions("Un dechet flottant dans l'espace.", "Cela semble inerte, et nos capteurs ne detectent rien. L'objet doit se trouver ailleurs.")
	b20_dummy_artifact_1:setScanningParameters(3, 1)

	x, y = table.remove(b20_nebula_list, math.random(#b20_nebula_list)):getPosition()
	b20_dummy_artifact_2 = Artifact():setPosition(x + random(-1000, 1000), y + random(-1000, 1000)):setDescriptions("Un dechet flottant dans l'espace.", "Cela semble inerte, et nos capteurs ne detectent rien. L'objet doit se trouver ailleurs.")
	b20_dummy_artifact_2:setScanningParameters(3, 1)

	x, y = table.remove(b20_nebula_list, math.random(#b20_nebula_list)):getPosition()
	CpuShip():setFaction("Ghosts"):setPosition(x + random(-1000, 1000), y + random(-1000, 1000)):setTemplate("Phobos T3"):orderDefendLocation(x, y)

	x, y = table.remove(b20_nebula_list, math.random(#b20_nebula_list)):getPosition()
	CpuShip():setFaction("Ghosts"):setPosition(x + random(-1000, 1000), y + random(-1000, 1000)):setTemplate("Piranha F12"):orderDefendLocation(x, y)

	x, y = table.remove(b20_nebula_list, math.random(#b20_nebula_list)):getPosition()
	CpuShip():setFaction("Ghosts"):setPosition(x + random(-1000, 1000), y + random(-1000, 1000)):setTemplate("Starhammer II"):orderDefendLocation(x, y)

	--Insurges defense line.
	insurges_defense_line = {
		RLSJammer():setFaction("Insurges"):setPosition(7657, -264940),
		RLSJammer():setFaction("Insurges"):setPosition(9915, -289620),
		RLSJammer():setFaction("Insurges"):setPosition(1822, -287037),
		RLSJammer():setFaction("Insurges"):setPosition(-6615, -285401),
		RLSJammer():setFaction("Insurges"):setPosition(-18324, -283593),
		RLSJammer():setFaction("Insurges"):setPosition(-24522, -276878),
		RLSJammer():setFaction("Insurges"):setPosition(-28138, -268613),
		RLSJammer():setFaction("Insurges"):setPosition(-23403, -256302),
		RLSJammer():setFaction("Insurges"):setPosition(-11608, -254149),
		RLSJammer():setFaction("Insurges"):setPosition(46849, -260262),
		RLSJammer():setFaction("Insurges"):setPosition(35571, -254924),
		RLSJammer():setFaction("Insurges"):setPosition(22312, -254063),
		RLSJammer():setFaction("Insurges"):setPosition(10842, -255239),
		RLSJammer():setFaction("Insurges"):setPosition(65015, -272745),
		RLSJammer():setFaction("Insurges"):setPosition(60452, -263189),
		RLSJammer():setFaction("Insurges"):setPosition(56664, -280494),
		RLSJammer():setFaction("Insurges"):setPosition(48829, -284454),
		RLSJammer():setFaction("Insurges"):setPosition(22915, -287381),
		RLSJammer():setFaction("Insurges"):setPosition(36690, -287554),
		RLSJammer():setFaction("Insurges"):setPosition(-34202, -259093),
		RLSJammer():setFaction("Insurges"):setPosition(29547, -294816),
		RLSJammer():setFaction("Insurges"):setPosition(54372, -255958)
	}
	insurges_defense_line_ships = {}
	insurges_defense_line_engaged = false
	for _, RLS_jammer in ipairs(insurges_defense_line) do
		x, y = RLS_jammer:getPosition()
		ship = CpuShip():setFaction("Insurges"):setPosition(x + random(-1000, 1000), y + random(-1000, 1000)):orderDefendLocation(x, y)
		if random(0, 100) < 20 then
			ship:setTemplate("Defense platform")
		elseif random(0, 100) < 50 then
			ship:setTemplate("Enhydra X23")
		else
			ship:setTemplate("Starhammer II")
		end
		table.insert(insurges_defense_line_ships, ship)
		for n=1,3 do
			ship2 = CpuShip():setFaction("Insurges"):setPosition(x + random(-1000, 1000), y + random(-1000, 1000)):orderDefendTarget(ship)
			if random(0, 100) < 50 then
				ship2:setTemplate("Phobos T3")
			elseif random(0, 100) < 20 then
				ship2:setTemplate("Piranha F12.M")
			else
				ship2:setTemplate("Piranha F12")
			end
			table.insert(insurges_defense_line_ships, ship2)
		end
	end

	SpaceStation():setTemplate("Huge Station"):setFaction("Insurges"):setPosition(32099, -291152)
	SpaceStation():setTemplate("Huge Station"):setFaction("Insurges"):setPosition(-4252, -297462)
	SpaceStation():setTemplate("Huge Station"):setFaction("Insurges"):setPosition(-27984, -262071)

	insurges_forward_line = {
		SpaceStation():setTemplate("Small Station"):setFaction("Insurges"):setPosition(-7278, -197898),
		SpaceStation():setTemplate("Large Station"):setFaction("Insurges"):setPosition(-13839, -233328),
		SpaceStation():setTemplate("Large Station"):setFaction("Insurges"):setPosition(29333, -240151),
		SpaceStation():setTemplate("Small Station"):setFaction("Insurges"):setPosition(36681, -200260)
	}
	insurges_transport = nil
	for _, station in ipairs(insurges_forward_line) do
		x, y = station:getPosition()
		ship = CpuShip():setFaction("Insurges"):setPosition(x + random(-1000, 1000), y + random(-1000, 1000)):orderDefendLocation(x, y)
		if random(0, 100) < 20 then
			ship:setTemplate("Defense platform")
		elseif random(0, 100) < 50 then
			ship:setTemplate("Enhydra X23")
		else
			ship:setTemplate("Starhammer II")
		end
		table.insert(insurges_defense_line_ships, ship)
		for n=1,3 do
			ship2 = CpuShip():setFaction("Insurges"):setPosition(x + random(-1000, 1000), y + random(-1000, 1000)):orderDefendTarget(ship)
			if random(0, 100) < 50 then
				ship2:setTemplate("Phobos T3")
			elseif random(0, 100) < 20 then
				ship2:setTemplate("Piranha F12.M")
			else
				ship2:setTemplate("Piranha F12")
			end
			table.insert(insurges_defense_line_ships, ship2)
		end
	end

	Nebula():setPosition(-21914, -272098)
	Nebula():setPosition(44037, -290617)
	Nebula():setPosition(28814, -261708)
	Nebula():setPosition(-13477, -290103)
	Nebula():setPosition(4322, -257282)
	createObjectsOnLine(48975, -270452, 40024, -267982, 1000, Mine, 3, 90)
	createObjectsOnLine(20887, -271892, 22225, -282695, 1000, Mine, 3, 90)
	createObjectsOnLine(-12037, -278682, 55663, -258414, 1000, Asteroid, 4, 90, 10000)

	-- GM buttons
	addGMFunction("Phase 1", function()
		for _, system in ipairs({"reactor", "LASERweapons", "missilesystem", "maneuver", "impulse", "RLS", "WARPdrive", "frontshield", "rearshield"}) do
			player:setSystemPower(system, 1.0)
			player:commandSetSystemPowerRequest(system, 1.0)
		end
		supply_drop = SupplyDrop():setFaction("Transark"):setPosition(29021, 114945):setEnergy(500):setWeaponStorage("Homing", 12):setWeaponStorage("Nuke", 4):setWeaponStorage("Mine", 8):setWeaponStorage("EMP", 6):setWeaponStorage("HVLI", 20)
		player:commandUndock(shipyard_gamma)
		player:commandAbortDock(shipyard_gamma)
		player:setPosition(29000, 114900)
		transport_f1:orderDock(supply_station_6)
		mission_state = phase1WaitForSupplyPickup
	end)
	addGMFunction("Phase 2", function()
		if target_dummy_1:isValid() then target_dummy_1:destroy() end
		if target_dummy_2:isValid() then target_dummy_2:destroy() end
		jc88:setPosition(310000, -71000):orderIdle()
		player:setPosition(310050, -71050):setWeaponStorage("Homing", 12):setWeaponStorage("Nuke", 4):setWeaponStorage("Mine", 8):setWeaponStorage("EMP", 6):setWeaponStorage("HVLI", 20)
		if insurge_b20_1:isValid() then insurge_b20_1:destroy() end
		if insurge_b20_2:isValid() then insurge_b20_2:destroy() end
		if insurge_b20_3:isValid() then insurge_b20_3:destroy() end
		mission_state = phase2SeekArtifact
	end)
	addGMFunction("Artifact Scanned", function()
		b20_artifact:setScannedByFaction("Transark", true)
	end)
	addGMFunction("->Objet", function()
		mission_state = phase2WaitTillNearObject
	end)
	addGMFunction("Objet->", function()
		mission_state = phase2WaitTillAwayFromObject
	end)
	addGMFunction("Moteurs OFF", function()
		moteursEnRade()
	end)
	addGMFunction("Phase 3", function()
		player:commandUndock(shipyard_gamma)
		player:commandAbortDock(shipyard_gamma)
		player:setPosition(30036, -270545)
		mission_state = phase2WaitTillWormholeRLSedPlayer
	end)
	addGMFunction("Phase 4", function()
		player:commandUndock(shipyard_gamma)
		player:commandAbortDock(shipyard_gamma)
		player:setPosition(24000, 125000)
		mission_state = phase3ReportBackToShipyard
	end)
	addGMFunction("Phase 5", function()
		--Remove all the Insurges ships from the game that where attacking the player. We no longer need them, and they could mess things up if they get the time to fly all the way to the shipyard.
		for _, ship in ipairs(insurges_defense_line_ships) do
			if ship:isValid() then ship:destroy() end
		end
		player:commandUndock(shipyard_gamma)
		player:commandAbortDock(shipyard_gamma)
		player:setPosition(25276, 133850)
		mission_state = phase5DockWithShipyard
	end)

	--Set the initial mission state
	puitGravitationnelActive = false
	mission_state = phase1MessagePowerup


	defeat_timeout = 2.0 --The defeat timeout means it takes 2 seconds before a defeat is actually done. This gives some missiles and explosions time to impact.
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

function moteurRLSJammed()
	player:setSystemPower("RLS", random (0.0, 0.3))
	player:commandSetSystemPowerRequest("RLS", 0.05)
	player:setSystemHealth("RLS", random(0.0, 0.3))
	player:setSystemPower("WARPdrive", random (0.0, 0.3))
	player:commandSetSystemPowerRequest("WARPdrive", 0.05)
	player:setSystemHealth("WARPdrive", random(0.0, 0.3))
end

function phase1MessagePowerup(delta)
	if delta > 0 then
		shipyard_gamma:sendCommsMessage(player, [[Bien Enhydra-1.
Votre systeme de communication semble fonctionner.
Comme vous le savez, vous etes a bord de la nouvelle version de l'explorateur spatial Enhydra.
Nous allons vous guider au travers de quelques tests de simulation pour voir si le vaisseau fonctionne convenablement.

Premierement, assurez-vous que votre operateur "ingenieur" monte la puissance de tous les systemes a 100%, car actuellement ils sont tous eteints.]])
		mission_state = phase1WaitForPowerup
	end
end

function phase1WaitForPowerup(delta)
	for _, system in ipairs({"reactor", "LASERweapons", "missilesystem", "maneuver", "impulse", "frontshield", "rearshield"}) do
		if player:getSystemPower(system) < 1.0 then
			return
		end
	end
	--All system powered, give the next objective.
	shipyard_gamma:sendCommsMessage(player, [[Enhydra-1,
Bien, nous voyons que tous vos sytemes sont operationnels. Vous pouvez vous decrocher sans risque.

Foncez au secteur K6, il y a un largage provenant du transporteur F-1. Ramassez-le pour faire le plein de missiles.]])
	supply_drop = SupplyDrop():setFaction("Transark"):setPosition(29021, 114945):setEnergy(500):setWeaponStorage("Homing", 12):setWeaponStorage("Nuke", 4):setWeaponStorage("Mine", 8):setWeaponStorage("EMP", 6):setWeaponStorage("HVLI", 20)
	transport_f1:orderDock(supply_station_6)
	mission_state = phase1WaitForSupplyPickup
end

function phase1WaitForSupplyPickup(delta)
	--Keep the shields of the dummies charged.
	target_dummy_1:setShields(300)
	target_dummy_2:setShields(300)

	if not supply_drop:isValid() then
		shipyard_gamma:sendCommsMessage(player, [[Bien Enhydra-1,
Je vois que vous etes a present equippes en missiles.

Il y a deux vaisseaux factices dans vos environs proches.

Avant de tester votre systeme d'armement, nous allons d'abord identifier les vaisseaux pour etre certains de ne pas detruire un vaisseau allie.
Demandez a votre operateur "Sciences/Radar" de scanner les vaisseaux Factice-1 et Factice-2 pour les identifier correctement.]])
		mission_state = phase1ScanDummyShips
	end
end

function phase1ScanDummyShips(delta)
	--Keep the shields of the dummies charged. (Note, at this point, you could destroy them with nukes, which is why we keep the shields at 300)
	target_dummy_1:setShields(300)
	target_dummy_2:setShields(300)

	if target_dummy_1:isScannedBy(player) and target_dummy_2:isScannedBy(player) then
		shipyard_gamma:sendCommsMessage(player, [[Parfait Enhydra-1,
Ils sont identifies comme vaisseaux "Insurges" (nous les avons maquilles electroniquement).
Maintenant, detruisez "Factice-1" avec vos lasers.
Et utilisez un missile a autoguidage pour aneantir "Factice-2" (ses boucliers sont configures pour resister a vos lasers).]])
		mission_state = phase1DestroyDummyShips
		target_dummy_1:setShieldsMax(30)
		target_dummy_2:setShieldsMax(30)
	end
end

function phase1DestroyDummyShips(delta)
	if target_dummy_2:isValid() then
		--Keep the shield of Factice-2 charged to 30, which means it can be taken out with a single blast from a homing missile or nuke, but not by LASER weapons.
		target_dummy_2:setShields(30)
	end

	if not target_dummy_1:isValid() and not target_dummy_2:isValid() then
		shipyard_gamma:sendCommsMessage(player, [[Bien, toutes les armes sont operationnelles.
Votre vaisseau semble en parfait etat de marche.

Maintenant, lorsque vous etes prets pour une premiere mission d'essai, contactez-nous.

(Arrimez-vous a au Spatiodock Supply-6 quand vous en avez besoin pour refaire le plein)]])
		mission_state = phase1WaitForContact
	end
end

function phase1WaitForContact(delta)
	--Wait for the shipyardGammaComms to handle this state.
end

--[[*********************************************************************--]]

function phase2WaitForWARP(delta)
	if handleWARPCarrier(jc88, 24000, 125000, 310000, -71000, [[Nous partons. Direction secteur B20.]]) then
		--Good, continue.
		jc88:sendCommsMessage(player, [[Enhydra-1,
Nous y sommes. Secteur B20.

On dirait qu'il y a quelques Insurges qui se sont incrustes chez nous.
Ils n'ont rien a faire ici, et ne veulent pas se rendre.
Vous avez l'autorisation de les eliminer.

Revenez au rapport lorsque vous aurez trouve ce qui provoque des anomalies sur nos capteurs.]])
		mission_state = phase2SeekArtifact
	end
end

function phase2SeekArtifact(delta)
	if b20_artifact:isScannedBy(player) then
		mission_state = phase2ReportArtifactReadings
	end
end

function phase2ReportArtifactReadings(delta)
	--Readings will be reported in comms functions, so do nothing here.
end

function phase2WaitTillNearObject(delta)
	if distance(player, b20_artifact) < 2000 then
		mission_state = phase2SpawnWormhole
	end
end

function phase2WaitTillAwayFromObject(delta)
	if distance(player, b20_artifact) > 2000 and distance(player, b20_artifact) < 2200 then
		mission_state = phase2SpawnWormhole
	end
end

function phase2SpawnWormhole(delta)
	if not puitGravitationnelActive then
		puitGravitationnelActive = true
		jc88:sendCommsMessage(player, [[Enhydra-1? Que se passe-t-il?
	Nous detectons un enorme afflux gravitationnel allant dans votre direction. Fichez-le camps d'ici.]])
		x, y = b20_artifact:getPosition()
		b20_artifact:explode()
		b20_artifact.nebula:destroy() --Remove the nebula, else it will get sucked into the wormhole. Now it just looks the wormhole replaces the nebula.
		WormHole():setPosition(x, y):setTargetPosition(30036, -270545) --Wormhole to to ZR6
	end
	--The explosion damages all systems, but makes sure the impulse, RLS and WARPdrive are none-functional. This prevents the player from escaping the grasp of the wormhole.
	--We made sure we are around 2U of the wormhole before this function is called.
	if puitGravitationnelActive then
		moteursEnRade()
		mission_state = phase2WaitTillWormholeRLSedPlayer
	end
end

function phase2WaitTillWormholeRLSedPlayer(delta)
	if distance(player, 30036, -270545) < 2000 then
		shipyard_gamma:sendCommsMessage(player, scrambleMessage([[Enhydra-1,
A vous ! A vous !
Nous lisons sur nos ecrans radar que vous etes a present derriere des lignes de defenses d'Insurges.
Ne les provoquez pas. Je repete: NE LES ATTAQUEZ PAS!]]))
		mission_state = phase3FindHoleInTheInsurgesDefenseLine
	end
end

--[[*********************************************************************--]]

function phase3FindHoleInTheInsurgesDefenseLine(delta)
	if distance(player, -5000, -260000) < 10000 then
		shipyard_gamma:sendCommsMessage(player, [[Enfin Enhydra-1,
nous pensions vous avoir perdu. Vous n'etes pas encore sorti de la melasse.
Cherchez apres une faille au-travers des defenses des Insurges.
Essayez d'atteindre le secteur ZU5. Nous vous envoyons "JC-88" pour vous sortir de la.

Les insurges semblent utiliser des brouilleurs RLS. Il est possible que vos moteurs RLS restent en rade dans cette zone.
]])
		jc88:orderFlyTowardsBlind(10000, -210000)
		mission_state = phase3EscapeTheInsurgesDefenseLine
	end
	--RLS jammer: RLS en permanence sans puissance et a niveau de sante proche de 0, mais le moteur a impulsion fonctionne
	moteurRLSJammed()
end

function phase3EscapeTheInsurgesDefenseLine(delta)
	if handleWARPCarrier(jc88, 10000, -210000, 24000, 125000, [[Tenez-vous bien, direction Spatiodock Gamma!]]) then
		--Good, continue.
		jc88:sendCommsMessage(player, [[Bon retour parmi nous Enhydra-1.
Le mieux est de vous accrocher a "Supply-6" pour refaire le plein.
Ensuite, faites un rapport de mission aupres du Spatiodock Gamma.]])
		mission_state = phase3ReportBackToShipyard
	end
end

function phase3ReportBackToShipyard(delta)
	--The shipyardGammaComms function will handle this state.
end

function phase3AnalizingData(delta)
	phase3AnalizingData_timeout = phase3AnalizingData_timeout - delta
	if phase3AnalizingData_timeout < 0.0 then
		shipyard_gamma:sendCommsMessage(player, [[Enhydra-1,
nous avons analyse les donnees recoltees sur l'anomalie qui s'est desintegree.
Il y a des traces de technologies oubliees la-dedans. Ce qui est plutot inquietant.

Cela pourrait signifier que des insurges possedent des technologies oubliees, potentiellement dangereuses.

Tout recemment nous avons pu observer des va-et-vients importants de transports spatiaux Insurges avec la mise en place de ces lignes de defenses que vous avez rencontrees.
Nous avons des raisons de penser que ces transports vont nous donner des indices sur ce que serait ces technologies oubliees.

Nous vous affectons une mission eclair: retournez aux lignes de defense de ces Insurges et detruisez l'un de leurs transports. Prenez une des cargaisons qui traine. Cela pourra nous etre utile.

Arrimez-vous a "JC88" qui vous emmenera sur place directement.

Attention. N'attaquez PAS les bases d'Insurges directement. Vous n'etes pas equippes pour un tel assaut.]])
		insurges_transport = CpuShip():setFaction("Insurges"):setTemplate("Flavia"):setCallSign("KHVT"):orderIdle()
		insurges_transport:setCommsScript(""):setImpulseMaxSpeed(60)
		insurges_transport.current_station = insurges_forward_line[irandom(1, #insurges_forward_line)]
		local x, y = insurges_transport.current_station:getPosition()
		insurges_transport:setPosition(x + random(-1000, 1000), y + random(-1000, 1000))
		insurges_transport:orderDock(insurges_transport.current_station)
		insurges_transport.drop = nil
		mission_state = phase4WARPBackToInsurgesLine
	end
end

--[[*********************************************************************--]]

function phase4WARPBackToInsurgesLine(delta)
	if handleWARPCarrier(jc88, 24000, 125000, 10000, -210000, [[C'est parti! Direction lignes de defenses Insurges.]]) then
		--Good, continue.
		jc88:sendCommsMessage(player, [[Nous y sommes. Attendez le bon moment pour eliminer ce transporteur, et prendre sa cargaison. Ensuite arrimez-vous a moi.
Vous pouvez vous attendre a de vives represailles une fois que vous aurez entamme l'attaque du transporteur.]])
		mission_state = phase4DestroyTheTransport
	end
end

function phase4DestroyTheTransport(delta)
	if insurges_transport:isValid() then
		if insurges_transport:isDocked(insurges_transport.current_station) then
			insurges_transport.current_station = insurges_forward_line[irandom(1, #insurges_forward_line)]
			insurges_transport:orderDock(insurges_transport.current_station)
		end

		insurges_transport.x, insurges_transport.y = insurges_transport:getPosition()
		if insurges_transport:getShieldLevel(0) < insurges_transport:getShieldMax(0) or insurges_transport:getShieldLevel(1) < insurges_transport:getShieldMax(1) then
			--Transport is damaged, go on the full offense.
			putInsurgesDefenseLineOnFullOffense()
		end

	elseif insurges_transport.drop == nil then
		--Transport is destroyed, go on the full offense. (could be destroyed in 1 hit, so we do not see shield damage then)
		putInsurgesDefenseLineOnFullOffense()
		insurges_transport.drop = SupplyDrop():setFaction("Transark"):setPosition(insurges_transport.x, insurges_transport.y)
	elseif not insurges_transport.drop:isValid() then
		jc88:sendCommsMessage(player, [[Revenez ici MAINTENANT. Toute la flotte d'Insurges colle a vos basques. Quoique vous ayez, cela nous sera utile.]])
		mission_state = phase4WARPBackToShipyard
	end
end

function phase4WARPBackToShipyard(delta)
	if handleWARPCarrier(jc88, 10000, -210000, 24000, 125000, [[Tenez-vous bien, direction Spatiodock Gamma.]]) then
		--Good, continue.
		shipyard_gamma:sendCommsMessage(player, [[Enhydra-1,
Remis de vos emotions? On dirait que ces transporteurs contenaient des documents hautement encryptes
Appontez sur notre station. Nous allons mettre nos specialistes d'Intricomm et de Moebius sur le coup.]])
		--Remove all the Insurges ships from the game that where attacking the player. We no longer need them, and they could mess things up if they get the time to fly all the way to the shipyard.
		for _, ship in ipairs(insurges_defense_line_ships) do
			if ship:isValid() then ship:destroy() end
		end

		mission_state = phase5DockWithShipyard
	end
end

--[[*********************************************************************--]]
function phase5DockWithShipyard(delta)
	if player:isDocked(shipyard_gamma) then
		shipyard_gamma:sendCommsMessage(player, [[Merci. Nous allons tout de suite analyser ces documents.
Le cryptage a l'air particulierement evoluee pour des Insurges. Mais bon... les Insurges ne sont pas tous des as du chiffrement non plus.
Cela va prendre un tout petit peu de temps pour craquer ces codes. Mais ca ne posera aucun probleme a nos analyseur algorithmique quantique. Ca doit etre l'affaire de quelques minutes.]])
		cracking_delay = 30
		mission_state = phase5Cracking1
	end
end

function phase5Cracking1(delta)
	if player:isCommsInactive() then
		cracking_delay = cracking_delay - delta
		if cracking_delay < 0.0 then
			shipyard_gamma:sendCommsMessage(player, [[Nous avons craque la premiere partie des documents.


On dirait que les insurges ont trouve une Technologie Oubliee, un equipement capable de provoquer une nano-singularites gravitationnelles. Cela signifierait la creation de particules de masse negative!
Mais il semble aussi qu'il ne maitrise pas la technologie.]])
			cracking_delay = 30
			mission_state = phase5Cracking2
		end
	end
end

function phase5Cracking2(delta)
	if player:isCommsInactive() then
		cracking_delay = cracking_delay - delta
		if cracking_delay < 0.0 then
			shipyard_gamma:sendCommsMessage(player, [[Voila plus de resultat de l'equipe de decryptage.

La technologie des Premiers, que vous avez mis en evidence, provoque la creation de nano particules a masse negative, comme nous le soupconnions.
Mais cela semble incontrolable et instable, jusqu'a l'effondrement en une sorte de micro trou noir en l'espace de quelque secondes.
Une enorme quantite energetique serait necessaire pour ariver a generer un champ de retention magnetique necessaire au confinement de ces particules dans un etat stable.

Il se pourrait que cela permette un jour la creation de faille ou trou de ver dans l'espace, pour permettre des voyages a l'aide de vehicule adapte.
Polaris sera tres content de ces trouvailles. Cela pourrait faire avancer les recherches sur l'evolution des moteurs RLS, comme ces prototypes a acceleration WARP dont on parle tant.]])
			cracking_delay = 30
			mission_state = phase5Cracking3
		end
	end
end

function phase5Cracking3(delta)
	if player:isCommsInactive() then
		cracking_delay = cracking_delay - delta
		if cracking_delay < 0.0 then
			shipyard_gamma:sendCommsMessage(player, [[Il semble que les insurges faisaient des experiences un peu hasardeuses avec cette technologie.

Selon les document voles, les Insurges ont perdu le controle sur certains essais dans le secteur D20. Ce qui explique probablement le phenomene que vous avez observe.

Le document n'est pas encore suffisemment decrypte actuellement, mais il semble que les Insurges ont experimente le passage d'objet et de vaisseaux-epaves non habites au travers de ce qu'ils appellent des failles inter-spatiales.
Ils tenteraient l'expedition d'armement lourd, missile ou bombes par ce moyen. Sans doute pour provoquer des attaques chirugicales instantannees dans nos installations sans qu'on ne puisse les voir arriver.

Les documents mentionnent des tailles de 2000 Unite de distance de vol spatiale qui auraient ete parcourues grâce a ses nano singularites. Sans aucune precision, et avec des resulats fort hasardeux... Biensûr...]])
			cracking_delay = 30
			mission_state = phase5Cracking4
		end
	end
end

function phase5Cracking4(delta)
	if player:isCommsInactive() then
		cracking_delay = cracking_delay - delta
		if cracking_delay < 0.0 then
			shipyard_gamma:sendCommsMessage(player, [[La derniere piece du puzzle est enfin decryptee.

C'est incroyable. C'est enorme ! On a trouve les plans d'une sorte d'enorme station spatiale de combat. Il y aurait un moteur de transfert au centre de cette station utilisant ces generateurs de nano particules anti-gravitationnelles.
On dirait que les Insurges construisent (mais avec quelles moyens??) une station de combat avec une puissance de feu incroyable, qui puisse se deplacer sur de tres grandes distances... instantanement!

Bienque la technologie decouverte ne soient pas stable, ils sont assez fous pour tenter le coup, et nous attaquer par surprise.
Cela leur donnerait une avance strategique insouconnable!]])
			mission_state = phase5CrackingDone
		end
	end
end

function phase5CrackingDone(delta)
	if player:isCommsInactive() then
		shipyard_gamma:sendCommsMessage(player, [[Nous detectons un afflux de puissance... C'EST LA STATION DE COMBAT !

Stoppez vos activites! Retraite! A toutes les statiosn, evacuez au plus vite! Sauvez ce que vous pouvez!]])
		odin = CpuShip():setFaction("Insurges"):setTemplate("Odin"):setCallSign("Odin"):setScanned(true):setPosition(26900, 132872):orderAttack(shipyard_gamma)
		odin.target = shipyard_gamma
		WormHole():setPosition(23984, 126258):setTargetPosition(0, 0)
		mission_state = phase5OdinAttack
	end
end

function phase5OdinAttack(delta)
	-- Soit Odin est mort (mais bon j'y crois pas trop)
	if not odin:isValid() then	--WTF man, you get bonus points for this.
		victory("Transark")
		return
	end
	-- Soit on s'est barre a temps comme des lâches... mais on est vivant.
	if distance(player, odin) > 30000 then
		victory("Transark")
	end

	-- Odin attaque ce qu'il peut dans l'ordre: Spatiodock Gamma, Supply-6, JC-88, Enhydra-1
	if not odin.target:isValid() then
		if shipyard_gamma:isValid() then
			odin.target = shipyard_gamma
		elseif supply_station_6:isValid() then
			odin.target = supply_station_6
		elseif jc88:isValid() then
			odin.target = jc88
		elseif player:isValid() then
			odin.target = player
		end
	-- Tant qu'a faire, autant se teleporter pres de sa victime, qui ne sait pas encore qu'elle va mourir
		if odin.target:isValid() then
			odin:orderAttack(odin.target)
			local x, y = odin.target:getPosition()
			odin:setPosition(x + random(2000, 2000), y + random(2000, 2000))
		end
	end
end

--[[*********************************************************************--]]
function shipyardGammaComms()
	if mission_state == phase3FindHoleInTheInsurgesDefenseLine then
		return false
	end
	--comms_source
	--comms_target
	if mission_state == phase1WaitForContact then
		setCommsMessage([[Enhydra-1, vous etes prets pour votre premiere mission?]])
		addCommsReply("Oui", function()
			setCommsMessage([[Bien.
Votre premiere mission sera de chercher apres une source qui emet d'etranges donnees. Cette source est perdue dans le nuage de nebuleuse dans le secteur B20.
Votre vaisseau n'est pas equipe pour parcourir une telle distance. Nous avons donc prepare le transporteur JC-88 pour vous y mener.
Aponter avec JC-88 et il s'occupera du reste.]])
			mission_state = phase2WaitForWARP
		end)
		addCommsReply("Non", function()
			setCommsMessage([[Alors, contactez-nous lorsque vous etes prets.]])
		end)
		return
	end
	if mission_state == phase2SeekArtifact or mission_state == phase2ReportArtifactReadings then
		artifactReportComms()
		return
	end
	if mission_state == phase3ReportBackToShipyard then
		setCommsMessage([[Enhydra-1,
Nous avons telecharge toutes les donnees que vous avez collectees grâce au radar quantique de capture de donnee a courte portee.
Nous analysons les donnees en ce moment. Nous vous contacterons lorsque nous aurons plus de detail.]])
		mission_state = phase3AnalizingData
		phase3AnalizingData_timeout = 60.0
		return
	end
	if mission_state == phase4WARPBackToInsurgesLine then
		setCommsMessage([[Allez vous arrimer a "JC-88". Ils vont vous emmener sur place pres des Insurges.]])
		return
	end
	setCommsMessage([[Bonjour Enhydra-1.
Veuillez continuer avec votre ordre de mission.]])
end

function jc88Comms()
	if mission_state == phase3FindHoleInTheInsurgesDefenseLine then
		return false
	end
	if mission_state == phase2SeekArtifact or mission_state == phase2ReportArtifactReadings then
		artifactReportComms()
		return
	end
	if mission_state == phase4WARPBackToInsurgesLine then
		setCommsMessage([[Venez vous arrimer a nous. Nous allons vous emmener sur place pres des Insurges.]])
		return
	end
	setCommsMessage([[Transporteur JC-88 au rapport!
Tous les sytemes sont a leurs valeurs nominales.]])
end

function artifactReportComms()
	setCommsMessage([[Enhydra-1,
Avez-vous trouve la source bizarre d'emission que nos capteurs observent?]])
	addCommsReply("Oui", function()
		setCommsMessage([[Super, comme nos mesures sont incoherentes, pouvez-vous nous donner vos lectures avec vos capteurs?

D'abord, que lisez-vous comme radiation beta??]])
		for beta=1,10 do
			addCommsReply(beta, function()
				setCommsMessage([[Ensuite, qu'observez-vous comme deplacement de phase ionic?]])
				for ionic=1,10 do
					addCommsReply(ionic, function()
						setCommsMessage([[Puis, que lisez-vous comme perturbation gravitationnelle?]])
						for gravity=1,10 do
							addCommsReply(gravity, function()
								setCommsMessage([[Finalement, quelle instabilite Doppler est observee?]])
								for doppler=1,10 do
									addCommsReply(doppler, function()
										if b20_artifact.beta_radiation == beta and b20_artifact.gravity_disruption == gravity and b20_artifact.ionic_phase_shift == ionic and b20_artifact.doppler_instability == doppler then
											if distance(player, b20_artifact) < 2000 then
												setCommsMessage([[etes-vous surs? Ces valeurs sont vraiment hors norme.
Eloignez-vous de l'objet, ces valeurs montrent une grande instabilite!]])
												mission_state = phase2WaitTillAwayFromObject
											else
												setCommsMessage([[etes-vous surs? Ces valeurs sont vraiment hors norme.
Pouvez-vous vous rapprocher de l'objet pour voir si vous pouvez ameliorer vos lectures. La micro-nebuleuse peut interferer avec vos capteurs.]])
												mission_state = phase2WaitTillNearObject
											end
										else
											setCommsMessage([[etes-vous surs? Pouvez-vous faire une deuxieme verification et nous recontacter. Ceci ne s'aligne pas avec nos mesures.]])
										end
									end)
								end
							end)
						end
					end)
				end
			end)
		end
	end)
	addCommsReply("Non", function()
		setCommsMessage([[Alors continuez a la chercher.]])
	end)
end

function scrambleMessage(message)
	for n=1,7 do
		local pos = irandom(1, #message - 3)
		message = message:sub(0, pos) .. "---" .. message:sub(pos + 3)
	end
	for n=1,5 do
		local pos = irandom(1, #message - 1)
		message = message:sub(0, pos) .. "." .. message:sub(pos + 1)
	end
	for n=1,3 do
		local pos = irandom(1, #message - 1)
		message = message:sub(0, pos) .. "*" .. message:sub(pos + 1)
	end
	for n=1,3 do
		local pos = irandom(1, #message - 1)
		message = message:sub(0, pos) .. "$" .. message:sub(pos + 1)
	end
	message = [[(La transmission est fort bruitee)
]] .. message
	return message
end

--[[ Assistance function to help with the details of the player using a WARP carrier. --]]
WARPing_state = 'wait_for_dock'
function handleWARPCarrier(jc, source_x, source_y, dest_x, dest_y, WARPing_message)
	if WARPing_state == 'wait_for_dock' then
		if player:isDocked(jc) then
			jc:orderFlyTowardsBlind(dest_x, dest_y)
			jc:sendCommsMessage(player, WARPing_message)
			WARPing_state = 'wait_for_WARP'
		end
	elseif WARPing_state == 'wait_for_WARP' then
		if distance(jc, dest_x, dest_y) < 10000 then
			--We check for the player 1 tick later, as it can take a game tick for the player position to update as well.
			WARPing_state = 'check_for_player'
		end
	elseif WARPing_state == 'check_for_player' then
		WARPing_state = 'wait_for_dock'
		if distance(player, dest_x, dest_y) < 10000 then
			--Good, continue.
			return true
		else
			--You idiot. JC-88 will fly back.
			jc88:orderFlyTowardsBlind(source_x, source_y)
			jc88:sendCommsMessage(player, [[On dirait que le systeme de couplage des structures s'est detache prematurement...
Cela arrive parfois. Je reviens pour que l'on puisse reessayer.]])
		end
	end
	return false
end

function putInsurgesDefenseLineOnFullOffense()
	if not insurges_defense_line_engaged then
		for _, ship in ipairs(insurges_defense_line_ships) do
			if ship:isValid() then
				ship:orderAttack(player)
			end
		end
		insurges_defense_line_ships[1]:sendCommsMessage(player, [[Intrus de la patrie Transark... Rendez-vous!]])
		insurges_defense_line_engaged = true
	end
end

function update(delta)
	if not player:isValid() or (not jc88:isValid() and mission_state ~= phase5OdinAttack) then
		defeat_timeout = defeat_timeout - delta
		if defeat_timeout < 0.0 then
			victory("Insurges")
			return
		end
	end

	--If the player enters the Insurges defense line, or engages a forward station, attack him full force.
	for _, RLS_jammer in ipairs(insurges_defense_line) do
		if distance(player, RLS_jammer) < 6000 then
			putInsurgesDefenseLineOnFullOffense()
		end
	end
	for _, station in ipairs(insurges_forward_line) do
		if distance(player, station) < 3000 then
			putInsurgesDefenseLineOnFullOffense()
		end
	end

	if mission_state ~= nil then
		mission_state(delta)
	end
end

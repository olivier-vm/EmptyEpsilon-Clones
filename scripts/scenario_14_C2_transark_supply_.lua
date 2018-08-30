-- Name: C2 - Real Transark - Supply
-- Description: Clones 2 - Mission de pilotage, approvisionnement avec passager à bord. Un cargo transport Transark doit rejoindre une station éloignée afin de livrer une commande. Un passager important est à bord et doit y être aussi déposé sains et sauf. Le pilotage doit être exemplaire et sans prise de risque. Remarque: du fait de la présence de passager, les accélérations sont fortement bridées.
-- Type: Mission

require("utils.lua")

function init()
	-- Vaisseau joueur
	player = PlayerSpaceship():setCallSign("Sigma 7"):setFaction("Transark"):setTemplate("Transport personnes RLS"):setPosition(-40000, 0):setRotation(-90):commandTargetRotation(-90)

	-- Station relais
	transark_tr_18 = SpaceStation():setCallSign("TR-18"):setTemplate("Medium Station"):setFaction("Transark"):setPosition(-40000, 100)
	transark_tr_18:setCommsFunction(tr_18_Comms)
	CpuShip():setCallSign("US-57"):setFaction("Utanscale"):setTemplate("Cargo Marchandise 1"):setPosition(-41000, -1000):setRotation(random(0, 360)):orderDock(transark_tr_18)
	CpuShip():setCallSign("TC-31"):setFaction("Technocorp"):setTemplate("Cargo Marchandise 1"):setPosition(-38000, 3000):setRotation(random(0, 360)):orderDefendTarget(transark_tr_18)
	CpuShip():setCallSign("TC-82"):setFaction("Technocorp"):setTemplate("Cargo Marchandise 2"):setPosition(-50000, 3000):setRotation(random(0, 360)):orderDefendTarget(transark_tr_18)
	CpuShip():setCallSign("TC-26"):setFaction("Technocorp"):setTemplate("Cargo Marchandise 3"):setPosition(-47000, -5000):setRotation(random(0, 360)):orderDefendTarget(transark_tr_18)
	player:commandDock(transark_tr_18)

	-- Space Deck de Transark
	transark_spacedeck = SpaceStation():setTemplate("Large Station"):setFaction("Transark"):setCallSign("TR-83"):setPosition(-15073, 73863):setRotation(random(0, 360))
	transark_spacedeck:setCommsFunction(usSupplyComms)
	CpuShip():setFaction("Utanscale"):setTemplate("Cargo Marchandise 5"):setCallSign("US-23"):setPosition(-13978, 72943):setRotation(0):orderDock(transark_spacedeck)
	CpuShip():setFaction("Transark"):setTemplate("Transport personnes 5"):setCallSign("TR-47"):setPosition(3798, 73534):orderDefendTarget(transark_spacedeck)
	CpuShip():setFaction("Transark"):setTemplate("Transport personnes 2"):setCallSign("TR-54"):setPosition(-25878, 76266):orderDefendTarget(transark_spacedeck)
	CpuShip():setFaction("Transark"):setTemplate("Transport personnes 1"):setCallSign("TR-63"):setPosition(-26126, 73410):orderDefendTarget(transark_spacedeck)

	-- Insurgés chargés avec missiles Axo-IEM
	insurge_1 = CpuShip():setFaction("Insurgés"):setTemplate("Stalker Q7"):setCallSign("VK13"):setPosition(507654, 164085):orderIdle()
	insurge_2 = CpuShip():setFaction("Insurgés"):setTemplate("Stalker Q7"):setCallSign("JQ19"):setPosition(507655, 164086):orderDefendTarget(insurge_1)
	insurge_3 = CpuShip():setFaction("Insurgés"):setTemplate("Stalker Q7"):setCallSign("LZ37"):setPosition(507656, 164088):orderDefendTarget(insurge_1)
	insurge_4 = CpuShip():setFaction("Insurgés"):setTemplate("Stalker Q7"):setCallSign("CP66"):setPosition(507657, 164088):orderDefendTarget(insurge_1)
	insurge_5 = CpuShip():setFaction("Insurgés"):setTemplate("Stalker Q7"):setCallSign("AW94"):setPosition(507658, 164090):orderDefendTarget(insurge_1)

	insurge_1:setLASERWeapon(0, 40, 355, 0, 0, 0):setLASERWeaponTurret(0, 0, 0, 0):setLASERWeapon(1, 40, 5, 0, 0, 0):setLASERWeaponTurret(1, 0, 0, 0)
	insurge_2:setLASERWeapon(0, 40, 355, 0, 0, 0):setLASERWeaponTurret(0, 0, 0, 0):setLASERWeapon(1, 40, 5, 0, 0, 0):setLASERWeaponTurret(1, 0, 0, 0)
	insurge_3:setLASERWeapon(0, 40, 355, 0, 0, 0):setLASERWeaponTurret(0, 0, 0, 0):setLASERWeapon(1, 40, 5, 0, 0, 0):setLASERWeaponTurret(1, 0, 0, 0)
	insurge_4:setLASERWeapon(0, 40, 355, 0, 0, 0):setLASERWeaponTurret(0, 0, 0, 0):setLASERWeapon(1, 40, 5, 0, 0, 0):setLASERWeaponTurret(1, 0, 0, 0)
	insurge_5:setLASERWeapon(0, 40, 355, 0, 0, 0):setLASERWeaponTurret(0, 0, 0, 0):setLASERWeapon(1, 40, 5, 0, 0, 0):setLASERWeaponTurret(1, 0, 0, 0)

	insurge_2:weaponTubeAllowMissle(0, "EMP"):setWeaponTubeExclusiveFor(0, "EMP"):setWeaponTubeCount(1):setWeaponTubeDirection(0, 0):setWeaponStorageMax("EMP", 2):setWeaponStorage("EMP", 2)
	insurge_3:weaponTubeAllowMissle(0, "EMP"):setWeaponTubeExclusiveFor(0, "EMP"):setWeaponTubeCount(1):setWeaponTubeDirection(0, 0):setWeaponStorageMax("EMP", 2):setWeaponStorage("EMP", 2)
	insurge_4:weaponTubeAllowMissle(0, "EMP"):setWeaponTubeExclusiveFor(0, "EMP"):setWeaponTubeCount(1):setWeaponTubeDirection(0, 0):setWeaponStorageMax("EMP", 2):setWeaponStorage("EMP", 2)
	insurge_5:weaponTubeAllowMissle(0, "EMP"):setWeaponTubeExclusiveFor(0, "EMP"):setWeaponTubeCount(1):setWeaponTubeDirection(0, 0):setWeaponStorageMax("EMP", 2):setWeaponStorage("EMP", 2)

	-- Nébuleuses`qui cachent les insurgés
	Nebula():setPosition(505436, 152917)
	Nebula():setPosition(511383, 149858)
	Nebula():setPosition(518520, 147819)
	Nebula():setPosition(525827, 150198)
	Nebula():setPosition(528036, 156655)
	Nebula():setPosition(530924, 164301)
	Nebula():setPosition(495411, 164301)
	Nebula():setPosition(499489, 157165)
	Nebula():setPosition(489293, 153936)
	Nebula():setPosition(480967, 161413)
	Nebula():setPosition(504926, 139493)


	-- Supply drop à proximité de la station
	SupplyDrop():setFaction("Transark"):setPosition(-13213, 80177):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-10792, 78936):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-12220, 77570):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-11040, 75769):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-13213, 82536):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-11164, 81481):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-14889, 76825):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-22650, 78253):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-16628, 80426):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-16814, 78253):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-14579, 79122):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-17559, 83840):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-16193, 82412):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-18738, 82102):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-19359, 79619):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-17249, 75086):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-18801, 77135):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-21470, 81667):setEnergy(500)
	SupplyDrop():setFaction("Transark"):setPosition(-20663, 76639):setEnergy(500)

	-- Débris et vaisseaux looser pour occuper le radar
	Artifact():setPosition(-10293, -24888):setModel("Cargo Dechets 1"):setFaction("Technocorp"):setDescription("Un vieux débris spatial")
	Artifact():setPosition(-6505, 27406):setModel("Cargo Dechets 2"):setFaction("Technocorp"):setDescription("Un vieux cargo spatial")
	looser = CpuShip():setCallSign("TR-41"):setFaction("Transark"):setTemplate("Cargo Equipement 1"):setPosition(5899, -21563):setRotation(0):orderDefendLocation(5899, -21563)
	looser:setCommsFunction(transarkLooserComms)

	-- Station Technocorp
	tcShip1 = CpuShip():setFaction("Technocorp"):setTemplate("Enhydra X23"):setCallSign("TC-EN-8"):setPosition(1144369, 5528):orderDefendLocation(1144369, 5528)
	tcShip2 = CpuShip():setFaction("Technocorp"):setTemplate("Cargo Equipement 1"):setCallSign("TC-61"):setPosition(1144345, 7044):orderIdle()
	tcStation = SpaceStation():setTemplate("Medium Station"):setFaction("Technocorp"):setCallSign("TC-04"):setPosition(1142784, 7490)
	tcStation:setCommsFunction(tcStationComms)

	-- Astéroides autours de la station tcStation
	Asteroid():setPosition(1140305, 1665)
	Asteroid():setPosition(1142426, 3398)
	Asteroid():setPosition(1139810, 4070)
	Asteroid():setPosition(1137440, 5661)
	Asteroid():setPosition(1138254, 7677)
	Asteroid():setPosition(1144195, 1488)
	Asteroid():setPosition(1140588, 5661)
	Asteroid():setPosition(1140588, 7182)
	Asteroid():setPosition(1142356, 10294)
	Asteroid():setPosition(1141047, 9127)
	Asteroid():setPosition(1144124, 9445)
	Asteroid():setPosition(1144725, 10753)
	Asteroid():setPosition(1147236, 8702)
	Asteroid():setPosition(1146316, 7253)
	Asteroid():setPosition(1139527, 9799)

	-- Mines de défense de la station tcStation
	Mine():setPosition(1151762, 1135)
	Mine():setPosition(1153530, 4176)
	Mine():setPosition(1152363, 5909)
	Mine():setPosition(1150878, 2585)
	Mine():setPosition(1149428, 3433)
	Mine():setPosition(1148438, 923)
	Mine():setPosition(1154450, 7924)
	Mine():setPosition(1150242, 12345)
	Mine():setPosition(1153813, 15315)
	Mine():setPosition(1149110, 14325)
	Mine():setPosition(1151585, 16412)
	Mine():setPosition(1152010, 13583)
	Mine():setPosition(1147908, 16765)
	Mine():setPosition(1149534, 17720)
	Mine():setPosition(1153813, 11920)
	Mine():setPosition(1151444, 10400)
	Mine():setPosition(1152858, 9445)
	Mine():setPosition(1150914, 7642)
	Mine():setPosition(1149923, 5484)
	Mine():setPosition(1149676, -244)
	Mine():setPosition(1147943, -775)

	-- Nébuleuses
	Nebula():setPosition(1061652, 25702)
	Nebula():setPosition(71964, 33469)
	Nebula():setPosition(1142078, 12214)
	Nebula():setPosition(1049685, -6955)
	Nebula():setPosition(1042889, -5636)
	Nebula():setPosition(1050192, 1970)
	Nebula():setPosition(1098163, -9896)
	Nebula():setPosition(1116926, 15560)
	Nebula():setPosition(1044512, -13547)
	Nebula():setPosition(1033762, -26123)
	Nebula():setPosition(-24111, -7667)
	Nebula():setPosition(33333, -36444)
	Nebula():setPosition(45889, -11444)
	Nebula():setPosition(25889, 5222)
	Nebula():setPosition(-51333, -28333)
	Nebula():setPosition(-59333, 8444)
	Nebula():setPosition(-32000, 24889)
	Nebula():setPosition(55111, 9556)
	Nebula():setPosition(43556, 33444)

	-- Quelque astéroides près de la station de départ (ancienne ceinture)
	Asteroid():setPosition(-338, -18347)
	Asteroid():setPosition(5601, -22084)
	Asteroid():setPosition(5691, -22854)
	Asteroid():setPosition(6955, -23456)
	Asteroid():setPosition(349, -16885)
	Asteroid():setPosition(-9798, -24478)
	Asteroid():setPosition(487, -21618)
	Asteroid():setPosition(2970, -21437)
	Asteroid():setPosition(2437, -21199)
	Asteroid():setPosition(-9283, -25491)
	Asteroid():setPosition(8289, -23718)
	Asteroid():setPosition(374, -19918)
	Asteroid():setPosition(1448, -19999)
	Asteroid():setPosition(-9936, -25452)
	Asteroid():setPosition(-10461, -22452)
	Asteroid():setPosition(-7861, -22299)
	Asteroid():setPosition(1527, -18380)

	-- Nuage de nébuleuse à mi-chemin
	Nebula():setPosition(501329, -7379)
	Nebula():setPosition(513261, 14170)
	Nebula():setPosition(518070, 25390)
	Nebula():setPosition(508631, 38213)
	Nebula():setPosition(486191, 52817)
	Nebula():setPosition(482985, 11677)
	Nebula():setPosition(498836, -34806)
	Nebula():setPosition(498479, -53684)
	Nebula():setPosition(476218, -70068)
	Nebula():setPosition(519673, 60475)
	Nebula():setPosition(493315, 33405)
	Nebula():setPosition(487438, -9160)
	Nebula():setPosition(505247, 25390)
	Nebula():setPosition(499192, 13636)
	Nebula():setPosition(492780, 56913)
	Nebula():setPosition(505425, 47652)
	Nebula():setPosition(510768, 73654)
	Nebula():setPosition(508987, 90573)
	Nebula():setPosition(516111, -23229)
	Nebula():setPosition(513974, -8804)
	Nebula():setPosition(461614, -26969)
	Nebula():setPosition(434543, 17198)
	Nebula():setPosition(397678, -3817)
	Nebula():setPosition(391088, 33583)
	Nebula():setPosition(432941, 54420)
	Nebula():setPosition(563662, 46049)
	Nebula():setPosition(604980, 35364)
	Nebula():setPosition(567580, 2060)
	Nebula():setPosition(565799, -44066)
	Nebula():setPosition(623145, -44601)
	Nebula():setPosition(647544, -16996)
	Nebula():setPosition(610144, -20380)
	Nebula():setPosition(610323, 76682)
	Nebula():setPosition(497589, 67599)
	Nebula():setPosition(501685, 35364)
	Nebula():setPosition(494027, 20048)
	Nebula():setPosition(505781, 16308)
	Nebula():setPosition(506672, 2950)
	Nebula():setPosition(497767, 2772)
	Nebula():setPosition(497411, -15749)
	Nebula():setPosition(504000, -25901)
	Nebula():setPosition(504891, -18065)
	Nebula():setPosition(360456, 7937)
	Nebula():setPosition(698479, 38213)

	-- GM buttons
	addGMFunction("Vaisseau hacké", function()
		vaisseauHacked = true
		-- Gestion automatique des réparations et du refroidissement
		player:commandSetAutoRepair(true)
		player:setAutoCoolant(true)
	end)
	addGMFunction("Vaisseau libre", function()
		vaisseauHacked = false
		-- Gestion automatique des réparations et du refroidissement
		player:commandSetAutoRepair(false)
		player:setAutoCoolant(false)
	end)
	addGMFunction("Passager OK", function()
		passager_ok = true
		passager_away = false
		passager_ko = false
	end)
	addGMFunction("Passager KO", function()
		passager_ok = false
		passager_away = false
		passager_ko = true
	end)
	addGMFunction("Passager Parti", function()
		passager_ok = false
		passager_away = true
		passager_ko = false
	end)

	-- Gestion du passager
	passager_ok = true
	passager_away = false
	passager_ko = false

	player:addCustomButton("relay", "VERIF_PASSAGER", "Vérifier Passager", function()
		if passager_ok then player:addToShipLog("Passager à bord. Sain et sauf.","green") end
		if passager_ko then player:addToShipLog("Le passager est inconscient. Il a besoin de soin urgent !","yellow") end
		if passager_away then player:addToShipLog("Le passager n'est plus à bord !","red") end
	end)

	-- Gestion des distances (pilote)
	player:addCustomButton("helms", "RESET_DIST", "RAZ Distances", function()
		player:removeCustom("INFO_DIST_TR")
		player:removeCustom("INFO_DIST_TC")
	end)
	player:addCustomButton("helms", "DIST_TR83", "Distance TR-83", function()
		player:addCustomInfo("helms","INFO_DIST_TR","TR-83: " .. distance(player,transark_spacedeck))
		player:addToShipLog("Distance de TR-83: " .. distance(player,transark_spacedeck),"white")
	end)
	player:addCustomButton("helms", "DIST_TC04", "Distance TC-04", function()
		player:addCustomInfo("helms","INFO_DIST_TC","TC-04: " .. distance(player,tcStation))
		player:addToShipLog("Distance de TC-04: " .. distance(player,tcStation),"white")
	end)

	-- Etat initial de la mission
	mission_state = phase1
	vaisseauHacked = false
end

-- Give the angle to target between 2 objects (a towards b)
-- Angle heading is North, and positive direction is clockwise, so some conversion need to be done to get correct angle
function angle(a, b)
	x1, y1 = a:getPosition()
	x2, y2 = b:getPosition()
	local delta_x = x1-x2
	local delta_y = y2-y1
	return math.deg(math.atan(delta_x, delta_y))+90
end

-- Auto pilot the player ship targetting another object
function autoPilot()
	-- désactive les laser, bouclier et moteur RLS
	for _, system in ipairs({"LASERweapons", "missilesystem", "frontshield", "rearshield", "RLS"}) do
		player:setSystemPower(system, player:getSystemPower(system)-0.001)
		player:commandSetSystemPowerRequest(system, random(0.1, 0.2))
		--health = player:getSystemHealth(system)
		--if health > 0.5 then
		--	player:setSystemHealth(system, health-0.0005)
		--end
	end
	-- Diminue la puissance des moteurs à impulsion
	for _, system in ipairs({"impulse"}) do
		player:setSystemPower(system, player:getSystemPower(system)-0.001)
		player:commandSetSystemPowerRequest(system, random(0.4, 0.5))
		--health = player:getSystemHealth(system)
		--if health > 0.5 then
		--	player:setSystemHealth(system, health-0.0005)
		--end
	end
	--energy_level = player:getEnergyLevel()
	--if energy_level > 10 then
	--		player:setEnergyLevel(energy_level-1)
	--end

	-- Donne l'ordre au vaisseau insurgé de se diriger vers le vaisseau joueur sans attaquer
	-- Change la direction du vaisseau joueur pour aller vers le vaissseau insurgé
	local player_x, player_y = player:getPosition()
	local insurge_x, insurge_y = insurge_1:getPosition()
	insurge_1:orderFlyTowardsBlind(player_x, player_y)
	insurge_2:orderDefendTarget(insurge_1)
	insurge_3:orderDefendTarget(insurge_1)
	insurge_4:orderDefendTarget(insurge_1)
	insurge_5:orderDefendTarget(insurge_1)
	player:commandTargetRotation(angle(player, insurge_1))
	--player:commandDock(insurge_1)

	--player:setEnergyLevel(0)
	player:commandImpulse(0)
	player:commandRLS(0)
	--player:commandSetAlertLevel("RED ALERT")
end


-- Première phase de la mission
function phase1(delta)
	if vaisseauHacked then
		autoPilot()
	end
	if delta > 0 then
		transark_tr_18:sendCommsMessage(player, [[Bonjour Sigma-7, ici la station relais "Transark TR-18".
Nous vous attendions pour votre ordre de mission.
Le relais des commandes du cargo vous est à présent attribué.

Le space deck de Transark ("TR-83") se trouve dans le secteur I4.
Consultez la zone, et une fois avoir repéré "TR-83", placez-y un marqueur pour indiquer la route à votre navigateur.
Vous pourrez entrer en communication avec la station pour connaître la suite de votre ordre de mission.

N'oubliez pas que votre véhicule est prévu pour le transport de personnel. Donc l'usage des moteurs RLS est fort restreint.
Utilisez vos moteurs à impulsion qui vous permettront d'atteindre de beaucoup plus grandes vitesses.
N'oubliez pas de décélérer bien à temps (à mi-parcours).]])
		mission_state = phase2
	end
end

-- Phase 2
function phase2(delta)
	if vaisseauHacked then
		autoPilot()
	end
	--Nothing to do
end

function update(delta)
	if mission_state ~= nil then
		mission_state(delta)
	end
end

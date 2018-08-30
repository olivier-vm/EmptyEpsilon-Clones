-- Name: C1 - Real Transark - Food supply astéroïdes
-- Description: Mission de pilotage sans ennemis. Un cargo Transark doit traverser une petite ceinture d'asteroides afin d'atteindre la station de provisionnement en nourriture, et le ramener à la station de transit.
-- Type: Mission

require("utils.lua")

function init()
	-- Vaisseau joueur
	player = PlayerSpaceship():setCallSign("Sigma 7"):setFaction("Transark"):setTemplate("Cargo Matériel RLS"):setPosition(-40000, 0):setRotation(-90):commandTargetRotation(-90)

	-- Station relais en bordure d'astéroïdes
	transarkast = SpaceStation():setCallSign("Transark AST"):setTemplate("Medium Station"):setFaction("Transark"):setPosition(-40000, 100)
	transarkast:setCommsFunction(transarkASTComms)
	CpuShip():setCallSign("US-57"):setFaction("Utanscale"):setTemplate("Cargo Marchandise 1"):setPosition(-41000, -1000):setRotation(0):orderDock(transarkast)
	CpuShip():setCallSign("TC-31"):setFaction("Technocorp"):setTemplate("Cargo Marchandise 1"):setPosition(-38000, 3000):setRotation(0):orderDefendTarget(transarkast)
	CpuShip():setCallSign("TC-82"):setFaction("Technocorp"):setTemplate("Cargo Marchandise 2"):setPosition(-50000, 3000):setRotation(0):orderDefendTarget(transarkast)
	CpuShip():setCallSign("TC-26"):setFaction("Technocorp"):setTemplate("Cargo Marchandise 3"):setPosition(-47000, -5000):setRotation(0):orderDefendTarget(transarkast)
	player:commandDock(transarkast)

	-- Station d'approvisionnement de l'Utanscale
	utanscale_supply = SpaceStation():setCallSign("US-17"):setPosition(44905, -31080):setTemplate('Medium Station'):setFaction("Utanscale"):setRotation(random(0, 360))
	utanscale_supply:setCommsFunction(usSupplyComms)
	CpuShip():setCallSign("US-96"):setFaction("Utanscale"):setTemplate("Cargo Marchandise 1"):setPosition(46000, -32000):setRotation(0):orderDock(utanscale_supply)

	-- Débris et vaisseaux looser pour occuper le radar
	Artifact():setPosition(-142, -8147):setModel("Cargo Dechets 1"):setFaction("Technocorp"):setDescription("Un vieux débris spatial")
	Artifact():setPosition(-6505, 27406):setModel("Cargo Dechets 2"):setFaction("Technocorp"):setDescription("Un vieux débris spatial")
	looser = CpuShip():setCallSign("TR-41"):setFaction("Transark"):setTemplate("Cargo Equipement 1"):setPosition(5899, -21563):setRotation(0):orderDefendLocation(5899, -21563)
	looser:setCommsFunction(transarkLooserComms)

	-- Station Polaris
    polShip1 = CpuShip():setFaction("Polaris"):setTemplate("Enhydra X23"):setCallSign("PO-EN-8"):setPosition(216141, 29927):orderDefendLocation(216141, 29927)
	polShip2 = CpuShip():setFaction("Polaris"):setTemplate("Cargo Equipement 1"):setCallSign("PO-61"):setPosition(216117, 31443):orderIdle()
	polaris = SpaceStation():setTemplate("Medium Station"):setFaction("Polaris"):setCallSign("POL Zéro G"):setPosition(214556, 31889)
	polaris:setCommsFunction(polarisComms)

	-- Astéroides autours de la station Polaris
    Asteroid():setPosition(212077, 26064)
    Asteroid():setPosition(214198, 27797)
    Asteroid():setPosition(211582, 28469)
    Asteroid():setPosition(209212, 30060)
    Asteroid():setPosition(210026, 32076)
    Asteroid():setPosition(215967, 25887)
    Asteroid():setPosition(212360, 30060)
    Asteroid():setPosition(212360, 31581)
    Asteroid():setPosition(214128, 34693)
    Asteroid():setPosition(212819, 33526)
    Asteroid():setPosition(215896, 33844)
    Asteroid():setPosition(216497, 35152)
    Asteroid():setPosition(219008, 33101)
    Asteroid():setPosition(218088, 31652)
    Asteroid():setPosition(211299, 34198)

	-- Mines de défense de la station Polaris
    Mine():setPosition(223534, 25534)
    Mine():setPosition(225302, 28575)
    Mine():setPosition(224135, 30308)
    Mine():setPosition(222650, 26984)
    Mine():setPosition(221200, 27832)
    Mine():setPosition(220210, 25322)
    Mine():setPosition(226222, 32323)
    Mine():setPosition(222014, 36744)
    Mine():setPosition(225585, 39714)
    Mine():setPosition(220882, 38724)
    Mine():setPosition(223357, 40811)
    Mine():setPosition(223782, 37982)
    Mine():setPosition(219680, 41164)
    Mine():setPosition(221306, 42119)
    Mine():setPosition(225585, 36319)
    Mine():setPosition(223216, 34799)
    Mine():setPosition(224630, 33844)
    Mine():setPosition(222686, 32041)
    Mine():setPosition(221695, 29883)
    Mine():setPosition(221448, 24155)
    Mine():setPosition(219715, 23624)

	-- Nébuleuses
    Nebula():setPosition(133424, 50101)
    Nebula():setPosition(71964, 33469)
    Nebula():setPosition(213850, 36613)
    Nebula():setPosition(121457, 17444)
    Nebula():setPosition(114661, 18763)
    Nebula():setPosition(121964, 26369)
    Nebula():setPosition(169935, 14503)
    Nebula():setPosition(188698, 39959)
    Nebula():setPosition(116284, 10852)
    Nebula():setPosition(105534, -1724)
	Nebula():setPosition(-24111, -7667)
	Nebula():setPosition(33333, -36444)
	Nebula():setPosition(45889, -11444)
	Nebula():setPosition(25889, 5222)
	Nebula():setPosition(-51333, -28333)
	Nebula():setPosition(-59333, 8444)
	Nebula():setPosition(-32000, 24889)
	Nebula():setPosition(55111, 9556)
	Nebula():setPosition(43556, 33444)

	-- Placement de la ceinture d'asteroides
	for n=1,2000 do
		Asteroid():setPosition(random(-15000, 15000), random(-100000, 100000)):setSize(random(100, 1000))
		--VisualAsteroid():setPosition(random(-20000, 20000), random(-100000, 100000)):setSize(random(100, 300))
	end

	-- GM buttons
	addGMFunction("US-17 - wait", function()
		mission_state = phase2WaitForDocked
	end)
	addGMFunction("Transark AST - Return", function()
		mission_state = phase3Return
	end)
	addGMFunction("Polaris livraison", function()
		phase3ContainerTaken()
	end)

	-- Etat initial de la mission
	mission_state = phase1MessagePosition
end

-- Première phase de la mission
function phase1MessagePosition(delta)
    if delta > 0 then
        transarkast:sendCommsMessage(player, [[Bonjour Sigma-7, ici la station relais "Transark AST".
Nous vous attendions pour votre ordre de mission.
Le relais des commandes du cargo vous est à présent attribué.

La station de réapprovisionnement de l'Utanscale ("US Supply 17") se trouve dans le Secteur D7.
Sondez la zone, et une fois avoir repéré "US Supply 17", placer un marqueur pour indiquer la route à votre navigateur.
Vous pourrez entrer en communication avec la station pour connaître la suite de votre ordre de mission.

Attention, vous êtes en bordure de la ceinture d'astéroïdes.
La zone ne présente aucun vaisseau d'insurgés mais soyez très prudents, le passage est très délicat.]])
        mission_state = phase1WaitForContactSupply
    end
end

function phase1WaitForContactSupply(delta)
	if distance(player, utanscale_supply) < 30000 then
		utanscale_supply:sendCommsMessage(player, [[Sigma 7, rapprochez-vous de la station, et entammez un arrimage.
Vos fournitures sont préparées pour le chargement]])
		mission_state = phase2WaitForDocked
	end
end

-- Phase 2 - La station de l'Utanscale attend que le vaisseau fasse un arrimage
function phase2WaitCloser(delta)
	if distance(player, utanscale_supply) < 5000 then
		utanscale_supply:sendCommsMessage(player, [[Sigma 7, une fois à côté de la station, votre navigateur peut entammer l'arrimage.]])
		mission_state = phase2WaitForDocked
	end
end

-- Phase 2 - La station de l'Utanscale attend que le vaisseau fasse un arrimage
function phase2WaitForDocked(delta)
	if player:isDocked(utanscale_supply) then
		mission_state = phase3Return
		utanscale_supply:sendCommsMessage(player, [[Très bien Sigma 7, nous avons électro-cramponné les containers de nourriture.
Vous pouvez vous détacher et retourner à l'aérogare "Transark AST".

Au revoir !
Bonne route !
Soyez prudents !]])
	end
end

-- Phase 3 - La station de Transark attend que le vaisseau fasse un arrimage avec la marchandise. Possibilité de mission d'entraide avec looser
function phase3Return(delta)
	if distance(player, looser) < 5000 then
		mission_state = phase3ReturnSOS
		looser:sendCommsMessage(player, [[Euh.... Sigma 7...

Dites, en fait, on a un léger petit problème. Vous pourriez tout de même pas nous aider?
Si vous avez du temps recontactez-nous SVP.

Merci.]])
	end
	if player:isDocked(transarkast) then
		mission_state = phase4End
		transarkast:sendCommsMessage(player, [[Très bien Sigma 7, nous déchargeons les containers de nourriture.
Ils vont êtres acheminés sur Khayyam.

A bientôt!]])
	end
end

-- Phase 3 - Vaisseau en rade (looser) attend que les joueurs les recontactent pour les aider

function phase3ReturnSOS(delta)
	if player:isDocked(transarkast) then
		mission_state = phase4End
		transarkast:sendCommsMessage(player, [[Très bien Sigma 7, nous déchargeons les containers de nourriture.
Ils vont êtres acheminés sur Khayyam.

A bientôt!]])
	end
end

-- Phase 3 - Les loosers donnent la destination une fois le container ramassé

function phase3TakeContainer(delta)
	if not supply_drop:isValid() then
        looser:sendCommsMessage(player, [[Parfait !

On vous a transféré leurs coordonnées. La station "POL Zéro G" se trouve dans le secteur G15

On vous a aussi mis des cellules de charges d'hyper-deuterium pour vous faire le plein d'énergie pour le trajet.
Dépéchez-vous SVP c'est très urgent. Il va falloir foncer pour être à l'heure prévue! Mais c'est encore possible.

A charge de revanche...]])
		phase3ContainerTaken()
	end
	if player:isDocked(transarkast) then
		mission_state = phase4End
		transarkast:sendCommsMessage(player, [[Très bien Sigma 7, nous déchargeons les containers de nourriture.
Ils vont êtres acheminés sur Khayyam.

A bientôt!]])
	end
end

function phase3ContainerTaken()
		-- On donne les coordonnées aux joueurs via un waypoint
		player:commandAddWaypoint(214556, 31889)
		-- On rend la station visible à Transark en changeant la faction de l'un des vaisseaux aux abords
		polShip2:setFaction("Transark")
		polaris:setScannedByFaction("Transark", true)
		polShip1:setScannedByFaction("Transark", true)
		polShip2:setScannedByFaction("Transark", true)
		mission_state = phase3Polaris
end

-- Phase 3 - La station Polaris attend les joueurs

function phase3Polaris(delta)
	if player:isDocked(polaris) then
		polaris:sendCommsMessage(player, [[Merci Transark, nous attendions ce container impatiemment.

Comme d'habitude vous êtes dans les temps ! Félicitations !

Encore merci!]])
		mission_state = phase4Retour
	end
	if player:isDocked(transarkast) then
		mission_state = phase4End
		transarkast:sendCommsMessage(player, [[Très bien Sigma 7, nous déchargeons les containers de nourriture.
Ils vont êtres acheminés sur Khayyam.

A bientôt!]])
	end
end

-- Phase 4 - 2eme essai, la station de Transark attend que le vaisseau fasse un arrimage avec la marchandise
function phase4Retour(delta)
	if player:isDocked(transarkast) then
		mission_state = phase4End
		transarkast:sendCommsMessage(player, [[Très bien Sigma 7, nous déchargeons les containers de nourriture.
Ils vont êtres acheminés sur Khayyam.

Merci Sigma 7, nous reprenons les commandes.
A bientôt!]])
--	victory("Transark");
	end
end

function phase4End(delta)
    --Nothing to do
end
--------------------
-- Communications
--------------------

function transarkASTComms()
	if mission_state == phase1WaitForContactSupply then
		setCommsMessage([[La station de réapprovisionnement de l'Utanscale ("US Supply 17") se trouve dans le Secteur D7.
Une fois proche de la station, vous pourrez la contacter pour connaître la suite de votre ordre de mission.]])
		return
	end
	if mission_state == phase3Return then
		setCommsMessage([[Sigma 7, nous attendons votre livraison.]])
		return
	end
	if mission_state == phase4End then
		setCommsMessage([[Tous nos opérateurs sont occupés pour l'instant.
Veuillez patientez, nous vous recontacterons.]])
		return
	end
    setCommsMessage([[Sigma 7,
Veuillez continuer sur les objectifs de votre ordre de mission. Maintenez votre plan de vol SVP.]])
end

function usSupplyComms()
	if mission_state == phase1WaitForContactSupply then
		setCommsMessage([[Sigma 7, avez-vous déjà traversé la ceinture d'astéroïdes?]])
		addCommsReply("Oui", function()
			setCommsMessage([[Bien, approchez-vous de la station et entammez un arrimage.
Vos fournitures sont préparées pour le chargement.]])
			mission_state = phase2WaitCloser
			end)
		addCommsReply("Non", function()
			setCommsMessage([[Recontactez-nous lorsque vous êtes proches de la station.]])
			end)
		return
	end
	if mission_state == phase2WaitForDocked then
		setCommsMessage([[Sigma 7, votre navigateur peut entammer l'arrimage.]])
		return
	end
	if mission_state == phase3Return then
		setCommsMessage([[Sigma 7, "Transark AST" attend votre livraison.]])
		return
	end
	if mission_state == phase3ReturnSOS then
		setCommsMessage([[Sigma 7, "Transark AST" attend votre livraison.]])
		return
	end
	if mission_state == phase3TakeContainer then
		setCommsMessage([[Sigma 7, "Transark AST" attend votre livraison.]])
		return
	end
	if mission_state == phase3Polaris then
		setCommsMessage([[Sigma 7, "Transark AST" attend toujours votre livraison. Vous en êtes où ?]])
		return
	end
	if mission_state == phase4Retour then
		setCommsMessage([[Sigma 7, "Transark AST" attend toujours votre livraison. Vous en êtes où ?]])
		return
	end
	if mission_state == phase4End then
		setCommsMessage([[Tous nos opérateurs sont occupés pour l'instant.
Veuillez patientez, nous vous recontacterons.]])
		return
	end
	setCommsMessage([[Sigma 7,
Veuillez continuer sur les objectifs de votre ordre de mission. Maintenez votre plan de vol SVP.]])
end

function transarkLooserComms()
	if mission_state == phase3ReturnSOS then
		setCommsMessage([[On a quelques ennuis moteurs, rien de grave, nos nakas travaillent dessus.

Mais on risque d'encore être bloqué ici un petit temps, et on a une livraison urgente pour la station "POL Zéro G".

Si on vous largue un container, vous pouvez venir le prendre et le livrer à notre place?]])
		addCommsReply("Oui bien sûr on vient le chercher.", function()
			setCommsMessage([[Merci les gars! Vous nous sauvez les miches.

Venez chercher le container que l'on vient de larguer.]])
			x, y = looser:getPosition()
			supply_drop = SupplyDrop():setFaction("Transark"):setPosition(x, y):setEnergy(1000)
			mission_state = phase3TakeContainer
			end)
		addCommsReply("Désolé, nos cales sont remplies au maximum.", function()
			setCommsMessage([[Tant pis, merci tout de même. On se débrouillera.

A bientôt.]])
			end)
		return
	end
	if mission_state == phase3TakeContainer then
		setCommsMessage([[Venez prendre le container proche de nous.
Dépéchez-vous SVP c'est très urgent.]])
		return
	end
	if mission_state == phase3Polaris then
		setCommsMessage([[La station "POL Zéro G" dans le secteur G15 attend la livraison.
Dépêchez-vous !]])
		return
	end
	if mission_state == phase4Retour then
		setCommsMessage([[Encore merci les gars !
Vous avez assuré.]])
		return
	end
	if mission_state == phase4End then
		setCommsMessage([[Encore merci les gars !
Vous avez assuré.]])
		return
	end
    setCommsMessage([[Merci de vous inquiétez pour nous, Sigma 7, mais nous sommes occupés avec des stagiaires pilotes.

Vous pouvez continuer votre ordre de mission. Nous gérons la situation.]])
end

function polarisComms()
	if mission_state == phase3Polaris then
		setCommsMessage([[Nous attendons la livraison... Arrimez-vous à nous une fois à portée de la station.

Faites attention aux astéroïdes et au champs de mines aux abords de la station.]])
		return
	end
    setCommsMessage([[... Canaux de communication non autorisés ...]])
end


function update(delta)
	if mission_state ~= nil then
		mission_state(delta)
    end
end

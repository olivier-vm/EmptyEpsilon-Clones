--[[				  Corvette
Corvettes are the common large ships. Larger then a frigate, smaller then a dreadnaught.
They generally have 4 or more shield sections. Run with a crew of 20 to 250.
This class generally has WARPdrives or RLSdrives. But lack the manouverbility that is seen in frigates.

They come in 3 different subclasses:
* Destroyer: Combat oriented ships. No science, no transport. Just death in a large package.
* Support: Large scale support roles. Drone carriers fall in this category. As well as mobile repair centers.
* Freighter: Large scale transport ships. Most common here are the WARP freighters, using specialized WARPdrives to cross large distances with large amounts of cargo.
----------------------------------------------------------]]

--[[----------------------Destroyers----------------------]]

template = ShipTemplate():setName("Enhydra X23"):setClass("Corvette", "Destroyer"):setModel("battleship_destroyer_1_upgraded")

template:setDescription([[L'Enhydra X23 est le plus petit modèle de vaisseau destroyer, et sa combinaison "taille de frégate" et "puissance de corvette" en fait un excellent vaisseau d'escorte pour défendre de plus gros vaisseaux contre de multiple petits ennemis.

L'Enhydra X23 est équippé d'un puissant moteur RLS, il peut donc aussi servir de navire de patrouille sur longues distances.]])
template:setRadarTrace("radar_dread.png")
template:setHull(100)
template:setShields(200, 200, 200, 200)
template:setSpeed(30, 3.5, 5)
template:setWARPDrive(true)
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0,100, -20, 1500.0, 6.0, 8)
template:setLASER(1,100,  20, 1500.0, 6.0, 8)
template:setLASER(2,100, 180, 1500.0, 6.0, 8)
template:setTubes(4, 10.0)
template:setWeaponStorage("HVLI", 20)
template:setWeaponStorage("Homing", 4)
template:setTubeDirection(0, -90)
template:setTubeDirection(1, -90)
template:setTubeDirection(2,  90)
template:setTubeDirection(3,  90)

variation = template:copy("Enhydra"):setType("playership")

variation:setDescription([[Un navire Enhydra X23 remanié pour plus de tâches générales. Très polycalent. Le grand système de bouclier a été remplacé par des sytèmes avancés de manoeuvre de combat. Le moteur RLS est de toute dernière génération.

Ses lanceurs de missiles sont aussi adaptés à des types variés de munitions. Confondre un Enhydra avec un Enhydra X23 serait une erreur qui pourrait vous coûter la vie.]])
variation:setShields(200, 200)
variation:setHull(250)
variation:setSpeed(90, 10, 20)
variation:setRLSSpeed(900)
variation:setWARPDrive(false)
variation:setCombatManeuver(400, 250)
variation:setLASER(2, 0, 0, 0, 0, 0)
variation:setWeaponStorage("Homing", 12)
variation:setWeaponStorage("Nuke", 4)
variation:setWeaponStorage("Mine", 8)
variation:setWeaponStorage("EMP", 6)
variation:setTubes(5, 8.0) -- Amount of torpedo tubes, and loading time of the tubes.
variation:weaponTubeDisallowMissle(0, "Mine"):weaponTubeDisallowMissle(1, "Mine")
variation:weaponTubeDisallowMissle(2, "Mine"):weaponTubeDisallowMissle(3, "Mine")
variation:setTubeDirection(4, 180):setWeaponTubeExclusiveFor(4, "Mine")

variation:addRoomSystem(1, 0, 2, 1, "Maneuver");
variation:addRoomSystem(1, 1, 2, 1, "LASERWeapons");
variation:addRoom(2, 2, 2, 1);

variation:addRoomSystem(0, 3, 1, 2, "RearShield");
variation:addRoomSystem(1, 3, 2, 2, "Reactor");
variation:addRoomSystem(3, 3, 2, 2, "RLS");
variation:addRoomSystem(5, 3, 1, 2, "WARPDrive");
variation:addRoom(6, 3, 2, 1);
variation:addRoom(6, 4, 2, 1);
variation:addRoomSystem(8, 3, 1, 2, "FrontShield");

variation:addRoom(2, 5, 2, 1);
variation:addRoomSystem(1, 6, 2, 1, "MissileSystem");
variation:addRoomSystem(1, 7, 2, 1, "Impulse");

variation:addDoor(1, 1, true);
variation:addDoor(2, 2, true);
variation:addDoor(3, 3, true);
variation:addDoor(1, 3, false);
variation:addDoor(3, 4, false);
variation:addDoor(3, 5, true);
variation:addDoor(2, 6, true);
variation:addDoor(1, 7, true);
variation:addDoor(5, 3, false);
variation:addDoor(6, 3, false);
variation:addDoor(6, 4, false);
variation:addDoor(8, 3, false);
variation:addDoor(8, 4, false);

--Airlock doors
--variation:addDoor(2, 2, false);
--variation:addDoor(2, 5, false);

-- Duplicate pour apparition dans la database
variation = template:copy("Enhydra*")
variation:setDescription([[Un navire Enhydra X23 remanié pour plus de tâches générales. Très polycalent. Le grand système de bouclier a été remplacé par des sytèmes avancés de manoeuvre de combat. Le moteur RLS est de toute dernière génération.

Ses lanceurs de missiles sont aussi adaptés à des types variés de munitions. Confondre un Enhydra avec un Enhydra X23 serait une erreur qui pourrait vous coûter la vie.]])
variation:setShields(200, 200)
variation:setHull(250)
variation:setSpeed(90, 10, 20)
variation:setRLSSpeed(900)
variation:setWARPDrive(false)
variation:setCombatManeuver(400, 250)
variation:setLASER(2, 0, 0, 0, 0, 0)
variation:setWeaponStorage("Homing", 12)
variation:setWeaponStorage("Nuke", 4)
variation:setWeaponStorage("Mine", 8)
variation:setWeaponStorage("EMP", 6)
variation:setTubes(5, 8.0) -- Amount of torpedo tubes, and loading time of the tubes.
variation:weaponTubeDisallowMissle(0, "Mine"):weaponTubeDisallowMissle(1, "Mine")
variation:weaponTubeDisallowMissle(2, "Mine"):weaponTubeDisallowMissle(3, "Mine")
variation:setTubeDirection(4, 180):setWeaponTubeExclusiveFor(4, "Mine")

--

template = ShipTemplate():setName("Starhammer II"):setClass("Corvette", "Destroyer"):setModel("battleship_destroyer_4_upgraded")
template:setDescription([[Contrary to its predecessor, the Starhammer II lives up to its name. By resolving the original Starhammer's power and heat management issues, the updated model makes for a phenomenal frontal assault ship. Its low speed makes it difficult to position, but when in the right place at the right time, even the strongest shields can't withstand a Starhammer's assault for long.]])
template:setRadarTrace("radar_dread.png")
template:setHull(200)
template:setShields(450, 350, 150, 150, 350)
template:setSpeed(35, 6, 10)
template:setWARPDrive(true)
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0, 60, -10, 2000.0, 8.0, 11)
template:setLASER(1, 60,  10, 2000.0, 8.0, 11)
template:setLASER(2, 60, -20, 1500.0, 8.0, 11)
template:setLASER(3, 60,  20, 1500.0, 8.0, 11)
template:setTubes(2, 10.0)
template:setWeaponStorage("HVLI", 20)
template:setWeaponStorage("Homing", 4)
template:setWeaponStorage("EMP", 2)
template:weaponTubeDisallowMissle(1, "EMP")

--[[-----------------------Support-----------------------]]

-- The weapons-platform is a stationary platform with LASER-weapons. It's extremely slow to turn, but it's LASER weapons do a huge amount of damage.
-- Smaller ships can dock to this platform to re-supply.
template = ShipTemplate():setName("Defense platform"):setClass("Corvette", "Support"):setModel("space_station_4")
template:setDescription([[This stationary defense platform operates like a station, with docking and resupply functions, but is armed with powerful LASER weapons and can slowly rotate. Larger systems often use these platforms to resupply patrol ships.]])
template:setRadarTrace("radartrace_smallstation.png")
template:setHull(150)
template:setShields(120, 120, 120, 120, 120, 120)
template:setSpeed(0, 0.5, 0)
template:setDockClasses("Starfighter", "Frigate")
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0, 30,   0, 4000.0, 1.5, 20)
template:setLASER(1, 30,  60, 4000.0, 1.5, 20)
template:setLASER(2, 30, 120, 4000.0, 1.5, 20)
template:setLASER(3, 30, 180, 4000.0, 1.5, 20)
template:setLASER(4, 30, 240, 4000.0, 1.5, 20)
template:setLASER(5, 30, 300, 4000.0, 1.5, 20)

-- Aérodock Trigone 1 - Triton (Petit)

template = ShipTemplate():setName("Aérodock Trigone 1 - Phoque"):setClass("Corvette", "Support"):setModel("space_station_4")
template:setDescription([[Station spatiale de classe "Phoque". Aérogare du Trigone Armé. Possède de très bons systèmes de défense à rayons, un blindage moyen, et 2 niveaux de boucliers.

Peut accueillir des chasseurs stellaires et des frégates.]])
template:setRadarTrace("radartrace_smallstation.png")
template:setHull(400)
template:setShields(1200, 1200)
template:setSpeed(0, 0.5, 0)
template:setDockClasses("Starfighter", "Frigate")
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0, 30,   0, 2000.0, 1.5, 10)
template:setLASER(1, 30,  60, 2000.0, 1.5, 10)
template:setLASER(2, 30, 120, 2000.0, 1.5, 10)
template:setLASER(3, 30, 180, 2000.0, 1.5, 10)
template:setLASER(4, 30, 240, 2000.0, 1.5, 10)
template:setLASER(5, 30, 300, 2000.0, 1.5, 10)

-- Aérodock Trigone 2 - Dauphin (Moyen)

template = ShipTemplate():setName("Aérodock Trigone 2 - Dauphin"):setClass("Corvette", "Support"):setModel("space_station_3")
template:setDescription([[Station spatiale de classe "Dauphin". Aérogare du Trigone Armé. Possède de très bons systèmes de défense à rayons, un gros blindage, et 3 niveaux de boucliers.

Peut accueillir des chasseurs stellaires et des frégates.]])
template:setRadarTrace("radartrace_mediumstation.png")
template:setHull(600)
template:setShields(1200, 1200, 1200)
template:setSpeed(0, 1, 0)
template:setDockClasses("Starfighter", "Frigate")
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0, 30,   0, 3000.0, 1.5, 15)
template:setLASER(1, 30,  60, 3000.0, 1.5, 15)
template:setLASER(2, 30, 120, 3000.0, 1.5, 15)
template:setLASER(3, 30, 180, 3000.0, 1.5, 15)
template:setLASER(4, 30, 240, 3000.0, 1.5, 15)
template:setLASER(5, 30, 300, 3000.0, 1.5, 15)

-- Aérodock Trigone 3 - Requin (Grand)

template = ShipTemplate():setName("Aérodock Trigone 3 - Epaulard"):setClass("Corvette", "Support"):setModel("space_station_2")
template:setDescription([[Station spatiale de classe "Epaulard". Aérogare du Trigone Armé. Possède de très bons systèmes de défense à rayons, un gros blindage, et 4 niveaux de boucliers.

Peut accueillir des chasseurs stellaires et des frégates.]])
template:setRadarTrace("radartrace_largestation.png")
template:setHull(800)
template:setShields(1200, 1200, 1200, 1200)
template:setSpeed(0, 1, 0)
template:setDockClasses("Starfighter", "Frigate")
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0, 30,   0, 4000.0, 1.5, 20)
template:setLASER(1, 30,  60, 4000.0, 1.5, 20)
template:setLASER(2, 30, 120, 4000.0, 1.5, 20)
template:setLASER(3, 30, 180, 4000.0, 1.5, 20)
template:setLASER(4, 30, 240, 4000.0, 1.5, 20)
template:setLASER(5, 30, 300, 4000.0, 1.5, 20)

-- Aérodock Trigone 4 - Rorqual (Enorme)
-- voir shipTemplates_Dreadnaught.lua

--[[----------------------Freighters----------------------]]

-- Démarrage boucle globale
for cnt=1,5 do

	template = ShipTemplate():setName("Transport personnes " .. cnt):setClass("Corvette", "Freighter"):setModel("transport_1_" .. cnt)
	template:setDescription([[Ces cargos sont concus pour le transport des personnes. Leur version militaire peut transporter des troupes du Trigone Armée, le personnel du Trigone Secours, et le matériel de combat.]])
	template:setHull(100)
	template:setShields(50, 50)
	template:setSpeed(60 - 5 * cnt, 6, 10)
	template:setRadarTrace("radar_transport.png")

-- Pas de saut jump/warp dans clones
--	  if cnt > 2 then
--		  variation = template:copy("Personnel WARP Freighter " .. cnt)
--		  variation:setWARPDrive(true)
--	  end

	--[[ Cargo joueur
	--]]
	if cnt == 2 then
		variation = template:copy("Transport personnes RLS"):setType("playership")
		variation:setDescription([[Transport personne de catégorie 2. Ce type de cargo est concu pour le transport des personnes. Leur version militaire peut transporter des troupes du Trigone Armée, le personnel du Trigone Secours, et le matériel de combat. Le cargo contient aussi de petites soute ayant tout un environnement de stabilisation afin de transporter du matériel, des machineries délicates, et des instrumentations complexes. En plus petite quantité qu'un cargo de fret classique.

Le cargo est équippé en plus d'un moteur à impulsion RLS 4000/100P afin de pouvoir parcourir de très longues longues distances (inter-planétaires) rapidement. C'est une version hybride impulsion/RLS. L'accélération du moteur est bridée afin de rendre les transport de passager agréable. Le moteur à impulsion utilise une dérivation du moteur RLS pour atteindre des vitesses importantes. L'utilisation unique du moteur RLS permet une accélération rapide mais la vitesse est fortment limitée (moins importante qu'avec le moteur à impulsion). Les version militaires sont moins bridées mais reste dans un spectre d'accélération humainement supportable.

Les compartiments arrières du cargo contiennent 8 mines spatio-sismiques, nécessaires en cas d'urgence dans les zones spatiolithique.]])
		--variation:setShields(200, 200)
		--variation:setHull(250)
		variation:setSpeed(4000, 10, 10)
		variation:setRLSSpeed(200)
		variation:setCombatManeuver(200, 100)
		variation:setLASER(2, 0, 0, 0, 0, 0)
		--variation:setWeaponStorage("Homing", 12)
		--variation:setWeaponStorage("Nuke", 4)
		--variation:setWeaponStorage("Mine", 8)
		--variation:setWeaponStorage("EMP", 6)
		--variation:setTubes(5, 8.0) -- Amount of torpedo tubes, and loading time of the tubes.
		--variation:weaponTubeDisallowMissle(0, "Mine"):weaponTubeDisallowMissle(1, "Mine")
		--variation:weaponTubeDisallowMissle(2, "Mine"):weaponTubeDisallowMissle(3, "Mine")
		--variation:setTubeDirection(4, 180):setWeaponTubeExclusiveFor(4, "Mine")
		variation:addRoomSystem(1, 1, 7, 1, "MissileSystem");
		variation:addRoomSystem(0, 3, 1, 2, "RearShield");
		variation:addRoomSystem(1, 3, 2, 2, "Reactor");
		variation:addRoomSystem(3, 3, 1, 2, "RLS");
		variation:addRoomSystem(4, 3, 1, 2, "WARPDrive");
		variation:addRoomSystem(5, 3, 2, 2, "Impulse");
		variation:addRoomSystem(9, 3, 2, 2, "Maneuver");
		variation:addRoomSystem(11, 3, 1, 2, "FrontShield");
		variation:addRoomSystem(1, 6, 7, 1, "LASERWeapons");
		variation:addRoom(2, 2, 2, 1);
		variation:addRoom(2, 5, 2, 1);
		variation:addRoom(7, 3, 2, 2);
		variation:addRoom(5, 2, 2, 1);
		variation:addRoom(5, 5, 2, 1);
		--variation:addDoor(1, 1, true);
		variation:addDoor(2, 2, true);
		variation:addDoor(5, 2, true);
		variation:addDoor(1, 3, false);
		variation:addDoor(2, 3, true);
		variation:addDoor(3, 3, true);
		variation:addDoor(4, 3, false);
		variation:addDoor(5, 3, false);
		variation:addDoor(6, 3, true);
		variation:addDoor(7, 3, false);
		variation:addDoor(9, 3, false);
		variation:addDoor(11, 3, false);
		variation:addDoor(2, 5, true);
		variation:addDoor(3, 5, true);
		variation:addDoor(5, 5, true);
		variation:addDoor(3, 6, true);
		variation:addDoor(5, 6, true);

		-- Duplicate pour apparition dans la database
		variation = template:copy("Transport personnes RLS*")
		variation:setDescription([[Transport personne de catégorie 2. Ce type de cargo est concu pour le transport des personnes. Leur version militaire peut transporter des troupes du Trigone Armée, le personnel du Trigone Secours, et le matériel de combat. Le cargo contient aussi de petites soute ayant tout un environnement de stabilisation afin de transporter du matériel, des machineries délicates, et des instrumentations complexes. En plus petite quantité qu'un cargo de fret classique.

Le cargo est équippé en plus d'un moteur à impulsion RLS 900 afin de pouvoir parcourir de très longues longues distances (inter-planétaires) rapidement. Toutefois l'accélération du moteur est bridée afin de rendre les transport de passager agréable. Les version militaires sont moins bridées mais reste dans un spectre d'accélération humainement supportable.

Les compartiments arrières du cargo contiennent 8 mines spatio-sismiques, nécessaires en cas d'urgence dans les zones spatiolithique.]])
		variation:setSpeed(4000, 10, 10)
		variation:setRLSSpeed(200)
		variation:setCombatManeuver(200, 100)
		variation:setLASER(2, 0, 0, 0, 0, 0)
		variation:setWeaponStorage("Mine", 8)
		variation:weaponTubeDisallowMissle(0, "Mine"):weaponTubeDisallowMissle(1, "Mine")
		variation:weaponTubeDisallowMissle(2, "Mine"):weaponTubeDisallowMissle(3, "Mine")
		variation:setTubeDirection(4, 180):setWeaponTubeExclusiveFor(4, "Mine")
	end

	template = ShipTemplate():setName("Cargo Marchandise " .. cnt):setClass("Corvette", "Freighter"):setModel("transport_2_" .. cnt)
	template:setDescription([[Ces cargos transportent de grosses quantités de marchandises sur de longues distances. Ils sont généralement affretés pour l'Utanscale et Technocorp.

Leurs baies de chargement possèdent des controles de climatisation, et des systèmes de stabilisation, ainsi que certaines structures en permatech qui maintiennent le cargo en bon état.]])
	template:setHull(100)
	template:setShields(50, 50)
	template:setSpeed(60 - 5 * cnt, 6, 10)
	template:setRadarTrace("radar_transport.png")

-- Pas de saut jump/warp dans clones
--	  if cnt > 2 then
--		  variation = template:copy("Goods WARP Freighter " .. cnt)
--		  variation:setWARPDrive(true)
--	  end

	template = ShipTemplate():setName("Cargo Dechets " .. cnt):setClass("Corvette", "Freighter"):setModel("transport_3_" .. cnt)
	template:setDescription([[Ces cargos sont spécialement conçus pour contenir les déchets, et des matière premières à ressources.

Ils sont équipés de chaines automatisée de tri, et de compacteurs à déchets. Ils possèdent moins de système de stabilisation que les autres cargos.

Ces cargos sont utilisés par Technocorp afin d'acheminer les déchets dans les grandes stations de recyclage présentes dans l'espace, ou pour transporter les ressources primaires provenant des énormes carrières de certaines. On les rencontre donc en grand nombres aux alentours des planètes "ressources" (ex: Videsh dans l'arche Khayyam).]])
	template:setHull(100)
	template:setShields(50, 50)
	template:setSpeed(60 - 5 * cnt, 6, 10)
	template:setRadarTrace("radar_transport.png")

-- Pas de saut jump/warp dans clones
--	  if cnt > 2 then
--		  variation = template:copy("Garbage WARP Freighter " .. cnt)
--		  variation:setWARPDrive(true)
--	  end

	template = ShipTemplate():setName("Cargo Equipement " .. cnt):setClass("Corvette", "Freighter"):setModel("transport_4_" .. cnt)
	template:setDescription([[Les cargos équipement ont des système de stabilisations et de climatisations spécialisés afin de pouvoir transporter de manière sécurisées les machineries délicates et de l'instrumentation scientifique.

Ils sont largement utilisés par Technocorp et Möbius, ainsi que l'Utanscale quand ils s'occupent de certains projets spécifiques.]])
	template:setHull(100)
	template:setShields(50, 50)
	template:setSpeed(60 - 5 * cnt, 6, 10)
	template:setRadarTrace("radar_transport.png")

-- Pas de saut jump/warp dans clones
--	  if cnt > 2 then
--		  variation = template:copy("Equipment WARP Freighter " .. cnt)
--		  variation:setWARPDrive(true)
--	  end

	--[[ Cargo joueur
	--]]
	if cnt == 2 then
		variation = template:copy("Cargo Matériel RLS"):setType("playership")
		variation:setDescription([[Cargo transark Equipement de catégorie 2. Possède tout un environnement de stabilisation afin de transporter du matériel, des machineries délicates, et des instrumentations complexes.

Le cargo est équippé en plus d'un moteur à impulsion RLS 900 afin de pouvoir parcourir de très longues longues distances (inter-planétaires) rapidement.

Les compartiments arrières du cargo contiennent 8 mines spatio-sismiques, nécessaires en cas d'urgence dans les zones spatiolithique.]])
		--variation:setShields(200, 200)
		--variation:setHull(250)
		variation:setSpeed(90, 10, 20)
		variation:setRLSSpeed(900)
		variation:setCombatManeuver(200, 100)
		variation:setLASER(2, 0, 0, 0, 0, 0)
		--variation:setWeaponStorage("Homing", 12)
		--variation:setWeaponStorage("Nuke", 4)
		variation:setWeaponStorage("Mine", 8)
		--variation:setWeaponStorage("EMP", 6)
		--variation:setTubes(5, 8.0) -- Amount of torpedo tubes, and loading time of the tubes.
		variation:weaponTubeDisallowMissle(0, "Mine"):weaponTubeDisallowMissle(1, "Mine")
		variation:weaponTubeDisallowMissle(2, "Mine"):weaponTubeDisallowMissle(3, "Mine")
		variation:setTubeDirection(4, 180):setWeaponTubeExclusiveFor(4, "Mine")
		variation:addRoomSystem(1, 1, 7, 1, "MissileSystem");
		variation:addRoomSystem(0, 3, 1, 2, "RearShield");
		variation:addRoomSystem(1, 3, 2, 2, "Reactor");
		variation:addRoomSystem(3, 3, 1, 2, "RLS");
		variation:addRoomSystem(4, 3, 1, 2, "WARPDrive");
		variation:addRoomSystem(5, 3, 2, 2, "Impulse");
		variation:addRoomSystem(9, 3, 2, 2, "Maneuver");
		variation:addRoomSystem(11, 3, 1, 2, "FrontShield");
		variation:addRoomSystem(1, 6, 7, 1, "LASERWeapons");
		variation:addRoom(2, 2, 2, 1);
		variation:addRoom(2, 5, 2, 1);
		variation:addRoom(7, 3, 2, 2);
		variation:addRoom(5, 2, 2, 1);
		variation:addRoom(5, 5, 2, 1);
		--variation:addDoor(1, 1, true);
		variation:addDoor(2, 2, true);
		variation:addDoor(5, 2, true);
		variation:addDoor(1, 3, false);
		variation:addDoor(2, 3, true);
		variation:addDoor(3, 3, true);
		variation:addDoor(4, 3, false);
		variation:addDoor(5, 3, false);
		variation:addDoor(6, 3, true);
		variation:addDoor(7, 3, false);
		variation:addDoor(9, 3, false);
		variation:addDoor(11, 3, false);
		variation:addDoor(2, 5, true);
		variation:addDoor(3, 5, true);
		variation:addDoor(5, 5, true);
		variation:addDoor(3, 6, true);
		variation:addDoor(5, 6, true);

		-- Duplicate pour apparition dans la database
		variation = template:copy("Cargo Matériel RLS*")
		variation:setDescription([[Cargo transark Equipement de catégorie 2. Possède tout un environnement de stabilisation afin de transporter du matériel, des machineries délicates, et des instrumentations complexes.

Le cargo est équippé en plus d'un moteur à impulsion RLS 900 afin de pouvoir parcourir de très longues longues distances (inter-planétaires) rapidement.

Les compartiments arrières du cargo contiennent 8 mines spatio-sismiques, nécessaires en cas d'urgence dans les zones spatiolithique.]])
		variation:setSpeed(90, 10, 20)
		variation:setRLSSpeed(900)
		variation:setCombatManeuver(200, 100)
		variation:setLASER(2, 0, 0, 0, 0, 0)
		variation:setWeaponStorage("Mine", 8)
		variation:weaponTubeDisallowMissle(0, "Mine"):weaponTubeDisallowMissle(1, "Mine")
		variation:weaponTubeDisallowMissle(2, "Mine"):weaponTubeDisallowMissle(3, "Mine")
		variation:setTubeDirection(4, 180):setWeaponTubeExclusiveFor(4, "Mine")
	end

	template = ShipTemplate():setName("Cargo Carburant " .. cnt):setClass("Corvette", "Freighter"):setModel("transport_5_" .. cnt)
	template:setDescription([[Les cargos de carburants transportent principalement de l'hyperdeutérium, sous différentes formes. Leurs cuves sont prévues principalement pour les matériaux en phase liquide, gazeuse, en gel, voir plasmatique dans des champs de rétention magnétique puissants.

Ils sont équipés de capteurs internes asservis à des systèmes de sécurités spécifique au transport de ce type de matériel.

Ils peuvent biensûr aussi être adaptés pour transporter d'autres matériaux que l'hyperdeutérium.]])
	template:setHull(100)
	template:setShields(50, 50)
	template:setSpeed(60 - 5 * cnt, 6, 10)
	template:setRadarTrace("radar_transport.png")

-- Pas de saut jump/warp dans clones
--	  if cnt > 2 then
--		  variation = template:copy("Fuel WARP Freighter " .. cnt)
--		  variation:setWARPDrive(true)
--	  end

	--[[ Cargo joueur extracteur de minerai
	--]]
	if cnt == 2 then
		variation = template:copy("Cargo Extracteur RLS"):setType("playership")
		variation:setDescription([[Cargo transark extracteur de minerai de catégorie 2. En plus des sytème d'extraction de gaz et de minerai, le cargo possède un système de destruction d'astéroïde via des tirs "rafale".

Les cale du vaisseau sont adpatées pour le transport du minerai et du gaz (hyperdeuterium, etc...).

Le cargo est équippé en plus d'un moteur à impulsion RLS 300, pour lui permettre certains déplacement plus rapide.

Les compartiments arrières du cargo contiennent aussi 8 mines spatio-sismiques, nécessaires en cas d'urgence dans les zones spatiolithique.]])
		--variation:setShields(200, 200)
		--variation:setHull(250)
		variation:setSpeed(90, 10, 20)
		variation:setRLSSpeed(300)
		variation:setCombatManeuver(200, 100)
		variation:setLASER(2, 0, 0, 0, 0, 0)
		--variation:setWeaponStorage("Homing", 12)
		--variation:setWeaponStorage("Nuke", 4)
		variation:setWeaponStorage("Mine", 8)
		--variation:setWeaponStorage("EMP", 6)
		variation:setWeaponStorage("HVLI", 20)
		--variation:setTubes(5, 8.0) -- Amount of torpedo tubes, and loading time of the tubes.
		variation:weaponTubeDisallowMissle(0, "Mine"):weaponTubeDisallowMissle(1, "Mine")
		variation:weaponTubeDisallowMissle(2, "Mine"):weaponTubeDisallowMissle(3, "Mine")
		variation:setTubeDirection(4, 180):setWeaponTubeExclusiveFor(4, "Mine")
		variation:addRoomSystem(1, 1, 7, 1, "MissileSystem");
		variation:addRoomSystem(0, 3, 1, 2, "RearShield");
		variation:addRoomSystem(1, 3, 2, 2, "Reactor");
		variation:addRoomSystem(3, 3, 1, 2, "RLS");
		variation:addRoomSystem(4, 3, 1, 2, "WARPDrive");
		variation:addRoomSystem(5, 3, 2, 2, "Impulse");
		variation:addRoomSystem(9, 3, 2, 2, "Maneuver");
		variation:addRoomSystem(11, 3, 1, 2, "FrontShield");
		variation:addRoomSystem(1, 6, 7, 1, "LASERWeapons");
		variation:addRoom(2, 2, 2, 1);
		variation:addRoom(2, 5, 2, 1);
		variation:addRoom(7, 3, 2, 2);
		variation:addRoom(5, 2, 2, 1);
		variation:addRoom(5, 5, 2, 1);
		--variation:addDoor(1, 1, true);
		variation:addDoor(2, 2, true);
		variation:addDoor(5, 2, true);
		variation:addDoor(1, 3, false);
		variation:addDoor(2, 3, true);
		variation:addDoor(3, 3, true);
		variation:addDoor(4, 3, false);
		variation:addDoor(5, 3, false);
		variation:addDoor(6, 3, true);
		variation:addDoor(7, 3, false);
		variation:addDoor(9, 3, false);
		variation:addDoor(11, 3, false);
		variation:addDoor(2, 5, true);
		variation:addDoor(3, 5, true);
		variation:addDoor(5, 5, true);
		variation:addDoor(3, 6, true);
		variation:addDoor(5, 6, true);

		-- Duplicate pour apparition dans la database
		variation = template:copy("Cargo Extracteur RLS*")
		variation:setDescription([[Cargo transark extracteur de minerai/gaz de catégorie 2. En plus des sytème d'extraction de gaz et de minerai, le cargo possède un système de destruction d'astéroïde via des tirs "rafale".

Les cales du vaisseau sont adpatées pour le transport du minerai et du gaz (hyperdeuterium, etc...).

Le cargo est équippé en plus d'un moteur à impulsion RLS 300, pour lui permettre certains déplacement plus rapide.

Les compartiments arrières du cargo contiennent aussi 8 mines spatio-sismiques, nécessaires en cas d'urgence dans les zones spatiolithique.]])
		variation:setSpeed(90, 10, 20)
		variation:setRLSSpeed(300)
		variation:setCombatManeuver(200, 100)
		variation:setLASER(2, 0, 0, 0, 0, 0)
		variation:setWeaponStorage("Mine", 8)
		variation:setWeaponStorage("HVLI", 20)
		variation:weaponTubeDisallowMissle(0, "Mine"):weaponTubeDisallowMissle(1, "Mine")
		variation:weaponTubeDisallowMissle(2, "Mine"):weaponTubeDisallowMissle(3, "Mine")
		variation:setTubeDirection(4, 180):setWeaponTubeExclusiveFor(4, "Mine")
	end

-- Fin de la boucle globale
end

--[[ WARP Carrier
--]]

template = ShipTemplate():setName("Transporteur WARP"):setClass("Corvette", "Freighter"):setModel("transport_4_2")
template:setDescription([[Vaisseau expérimental - Concept (non encore fonctionnel)

Le transporteur WARP est un cargo spécialisé. Il possède un énorme moteur à distorsion WARP expérimental ainsi que les gigantesques cellules énergétiques nécessaire pour le faire fonctionner.

Il est concu pour pouvoir accrocher (arrimage) un autre vaisseau afin de le transporter au plus profond de l'espace.]])
template:setHull(100)
template:setShields(50, 50)
template:setSpeed(50, 6, 10)
template:setRadarTrace("radar_transport.png")
template:setWARPDrive(true)
template:setWARPDriveRange(5000, 100 * 50000) --The WARP carrier can WARP a 100x longer distance then normal WARP drives.
template:setDockClasses("Starfighter", "Frigates", "Corvette")

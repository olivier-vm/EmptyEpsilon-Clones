--[[				  Corvette
Corvettes are the common large ships. Larger then a frigate, smaller then a dreadnaught.
They generally have 4 or more shield sections. Run with a crew of 20 to 250.
This class generally has WARPdrives or RLSdrives. But lack the maneuverability that is seen in frigates.

They come in 3 different subclasses:
* Destroyer: Combat oriented ships. No science, no transport. Just death in a large package.
* Support: Large scale support roles. Drone carriers fall in this category. As well as mobile repair centers.
* Freighter: Large scale transport ships. Most common here are the WARP freighters, using specialized WARPdrives to cross large distances with large amounts of cargo.
----------------------------------------------------------]]

--[[----------------------Destroyers----------------------]]

template = ShipTemplate():setName("Enhydra X23"):setClass("Corvette", "Destroyer"):setModel("battleship_destroyer_1_upgraded")
template:setDescription(_([[The Atlantis X23 is the smallest model of destroyer, and its combination of frigate-like size and corvette-like power makes it an excellent escort ship when defending larger ships against multiple smaller enemies. Because the Atlantis X23 is fitted with a jump drive, it can also serve as an intersystem patrol craft.]]))
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
variation:setDescription(_([[A refitted Atlantis X23 for more general tasks. The large shield system has been replaced with an advanced combat maneuvering systems and improved impulse engines. Its missile loadout is also more diverse. Mistaking the modified Atlantis for an Atlantis X23 would be a deadly mistake.]]))
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
variation:setDescription(_([[A refitted Atlantis X23 for more general tasks. The large shield system has been replaced with an advanced combat maneuvering systems and improved impulse engines. Its missile loadout is also more diverse. Mistaking the modified Atlantis for an Atlantis X23 would be a deadly mistake.]]))
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
template:setDescription(_([[Contrary to its predecessor, the Starhammer II lives up to its name. By resolving the original Starhammer's power and heat management issues, the updated model makes for a phenomenal frontal assault ship. Its low speed makes it difficult to position, but when in the right place at the right time, even the strongest shields can't withstand a Starhammer's assault for long.]]))
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

--

template = ShipTemplate():setName("Crucible"):setClass("Corvette","Popper"):setModel("LaserCorvetteRed"):setType("playership")
template:setDescription(_("A number of missile tubes range around this ship. Beams were deemed lower priority, though they are still present. Stronger defenses than a frigate, but not as strong as the Atlantis"))
template:setRadarTrace("radar_laser.png")
template:setHull(160)
template:setShields(160,160)
template:setSpeed(80,15,40)
template:setCombatManeuver(400, 250)
template:setWARPDrive(false)
template:setRLSSpeed(750)
--                  Arc, Dir,  Range, CycleTime, Dmg
template:setLASER(0, 70, -30, 1000.0, 6.0, 5)
template:setLASER(1, 70,  30, 1000.0, 6.0, 5)
template:setTubes(6, 8.0)
template:setWeaponStorage("HVLI", 24)
template:setWeaponStorage("Homing", 8)
template:setWeaponStorage("EMP", 6)
template:setWeaponStorage("Nuke", 4)
template:setWeaponStorage("Mine", 6)
template:setTubeDirection(0, 0)
template:setTubeSize(0, "small")
template:setTubeDirection(1, 0)
template:setTubeDirection(2, 0)
template:setTubeSize(2, "large")
template:setTubeDirection(3, -90)
template:setTubeDirection(4,  90)
template:setTubeDirection(5, 180)
template:setWeaponTubeExclusiveFor(0, "HVLI")
template:setWeaponTubeExclusiveFor(1, "HVLI")
template:setWeaponTubeExclusiveFor(2, "HVLI")
template:weaponTubeDisallowMissle(3, "Mine")
template:weaponTubeDisallowMissle(4, "Mine")
template:setWeaponTubeExclusiveFor(5, "Mine")

template:setRepairCrewCount(4)

template:addRoomSystem(2, 0, 2, 1, "Maneuver");
template:addRoomSystem(1, 1, 2, 1, "LASERWeapons");
template:addRoomSystem(0, 2, 3, 2, "RearShield");
template:addRoomSystem(1, 4, 2, 1, "Reactor");
template:addRoomSystem(2, 5, 2, 1, "RLS");
template:addRoomSystem(3, 1, 3, 2, "WARPDrive");
template:addRoomSystem(3, 3, 3, 2, "FrontShield");
template:addRoom(6, 2, 6, 2);
template:addRoomSystem(9, 1, 2, 1, "MissileSystem");
template:addRoomSystem(9, 4, 2, 1, "Impulse");

template:addDoor(2, 1, true)
template:addDoor(1, 2, true)
template:addDoor(1, 4, true)
template:addDoor(2, 5, true)
template:addDoor(3, 2, false)
template:addDoor(4, 3, true)
template:addDoor(6, 3, false)
template:addDoor(9, 2, true)
template:addDoor(10,4, true)

template = ShipTemplate():setName("Maverick"):setLocaleName(_("Maverick")):setClass(_("Corvette"),_("Gunner")):setModel("LaserCorvetteGreen"):setType("playership")
template:setDescription(_("A number of beams bristle from various points on this gunner. Missiles were deemed lower priority, though they are still present. Stronger defenses than a frigate, but not as strong as the Atlantis"))
template:setRadarTrace("radar_laser.png")
template:setHull(160)
template:setShields(160,160)
template:setSpeed(80,15,40)
template:setCombatManeuver(400, 250)
template:setWARPDrive(false)
template:setRLSSpeed(800)
--                 Arc, Dir,  Range, CycleTime, Dmg
template:setLASER(0, 10,   0, 2000.0, 6.0, 6)
template:setLASER(1, 90, -20, 1500.0, 6.0, 8)
template:setLASER(2, 90,  20, 1500.0, 6.0, 8)
template:setLASER(3, 40, -70, 1000.0, 4.0, 6)
template:setLASER(4, 40,  70, 1000.0, 4.0, 6)
template:setLASER(5, 10, 180,  800.0, 6.0, 4)
--								Arc, Dir, Rotate speed
template:setLASERWeaponTurret(5, 180, 180, .5)
template:setTubes(3, 8.0)
template:setWeaponStorage("HVLI", 10)
template:setWeaponStorage("Homing", 6)
template:setWeaponStorage("EMP", 4)
template:setWeaponStorage("Nuke", 2)
template:setWeaponStorage("Mine", 2)
template:setTubeDirection(0, -90)
template:setTubeDirection(1,  90)
template:setTubeDirection(2, 180)
template:weaponTubeDisallowMissle(0, "Mine")
template:weaponTubeDisallowMissle(1, "Mine")
template:setWeaponTubeExclusiveFor(2, "Mine")

template:setRepairCrewCount(4)

template:addRoomSystem(2, 0, 2, 1, "Maneuver");
template:addRoomSystem(1, 1, 2, 1, "LASERWeapons");
template:addRoomSystem(0, 2, 3, 2, "RearShield");
template:addRoomSystem(1, 4, 2, 1, "Reactor");
template:addRoomSystem(2, 5, 2, 1, "RLS");
template:addRoomSystem(3, 1, 3, 2, "WARPDrive");
template:addRoomSystem(3, 3, 3, 2, "FrontShield");
template:addRoom(6, 2, 6, 2);
template:addRoomSystem(9, 1, 2, 1, "MissileSystem");
template:addRoomSystem(9, 4, 2, 1, "Impulse");

template:addDoor(2, 1, true)
template:addDoor(1, 2, true)
template:addDoor(1, 4, true)
template:addDoor(2, 5, true)
template:addDoor(3, 2, false)
template:addDoor(4, 3, true)
template:addDoor(6, 3, false)
template:addDoor(9, 2, true)
template:addDoor(10,4, true)

--[[-----------------------Support-----------------------]]

-- The weapons-platform is a stationary platform with LASER-weapons. It's extremely slow to turn, but it's LASER weapons do a huge amount of damage.
-- Smaller ships can dock to this platform to re-supply.
template = ShipTemplate():setName("Defense platform"):setLocaleName(_("Defense platform")):setClass(_("Corvette"), _("Support")):setModel("space_station_4")
template:setDescription(_([[This stationary defense platform operates like a station, with docking and resupply functions, but is armed with powerful beam weapons and can slowly rotate. Larger systems often use these platforms to resupply patrol ships.]]))
template:setRadarTrace("radartrace_smallstation.png")
template:setHull(150)
template:setShields(120, 120, 120, 120, 120, 120)
template:setSpeed(0, 0.5, 0)
template:setDockClasses("Starfighter", "Frigate", "Corvette")
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0, 30,   0, 4000.0, 1.5, 20)
template:setLASER(1, 30,  60, 4000.0, 1.5, 20)
template:setLASER(2, 30, 120, 4000.0, 1.5, 20)
template:setLASER(3, 30, 180, 4000.0, 1.5, 20)
template:setLASER(4, 30, 240, 4000.0, 1.5, 20)
template:setLASER(5, 30, 300, 4000.0, 1.5, 20)

-- Aerodock Trigone 1 - Triton (Petit)

template = ShipTemplate():setName("Aerodock Trigone 1 - Phoque"):setClass("Corvette", "Support"):setModel("space_station_4")
template:setDescription([[Station spatiale de classe "Phoque". Aerogare du Trigone Arme. Possede de tres bons systemes de defense a rayons, un blindage moyen, et 2 niveaux de boucliers.

Peut accueillir des chasseurs stellaires et des fregates.]])
template:setRadarTrace("radartrace_smallstation.png")
template:setHull(400)
template:setShields(1200, 1200)
template:setSpeed(0, 0.5, 0)
template:setDockClasses("Starfighter", "Frigate", "Corvette")
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0, 30,   0, 2000.0, 1.5, 10)
template:setLASER(1, 30,  60, 2000.0, 1.5, 10)
template:setLASER(2, 30, 120, 2000.0, 1.5, 10)
template:setLASER(3, 30, 180, 2000.0, 1.5, 10)
template:setLASER(4, 30, 240, 2000.0, 1.5, 10)
template:setLASER(5, 30, 300, 2000.0, 1.5, 10)

-- Aerodock Trigone 2 - Dauphin (Moyen)

template = ShipTemplate():setName("Aerodock Trigone 2 - Dauphin"):setClass("Corvette", "Support"):setModel("space_station_3")
template:setDescription([[Station spatiale de classe "Dauphin". Aerogare du Trigone Arme. Possede de tres bons systemes de defense a rayons, un gros blindage, et 3 niveaux de boucliers.

Peut accueillir des chasseurs stellaires et des fregates.]])
template:setRadarTrace("radartrace_mediumstation.png")
template:setHull(600)
template:setShields(1200, 1200, 1200)
template:setSpeed(0, 1, 0)
template:setDockClasses("Starfighter", "Frigate", "Corvette")
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0, 30,   0, 3000.0, 1.5, 15)
template:setLASER(1, 30,  60, 3000.0, 1.5, 15)
template:setLASER(2, 30, 120, 3000.0, 1.5, 15)
template:setLASER(3, 30, 180, 3000.0, 1.5, 15)
template:setLASER(4, 30, 240, 3000.0, 1.5, 15)
template:setLASER(5, 30, 300, 3000.0, 1.5, 15)

-- Aerodock Trigone 3 - Requin (Grand)

template = ShipTemplate():setName("Aerodock Trigone 3 - Epaulard"):setClass("Corvette", "Support"):setModel("space_station_2")
template:setDescription([[Station spatiale de classe "Epaulard". Aerogare du Trigone Arme. Possede de tres bons systemes de defense a rayons, un gros blindage, et 4 niveaux de boucliers.

Peut accueillir des chasseurs stellaires et des fregates.]])
template:setRadarTrace("radartrace_largestation.png")
template:setHull(800)
template:setShields(1200, 1200, 1200, 1200)
template:setSpeed(0, 1, 0)
template:setDockClasses("Starfighter", "Frigate", "Corvette")
--					Arc, Dir, Range, CycleTime, Dmg
template:setLASER(0, 30,   0, 4000.0, 1.5, 20)
template:setLASER(1, 30,  60, 4000.0, 1.5, 20)
template:setLASER(2, 30, 120, 4000.0, 1.5, 20)
template:setLASER(3, 30, 180, 4000.0, 1.5, 20)
template:setLASER(4, 30, 240, 4000.0, 1.5, 20)
template:setLASER(5, 30, 300, 4000.0, 1.5, 20)

-- Aerodock Trigone 4 - Rorqual (Enorme)
-- voir shipTemplates_Dreadnaught.lua

--[[----------------------Freighters----------------------]]

-- Demarrage boucle globale
for cnt=1,5 do

	template = ShipTemplate():setName("Transport personnes " .. cnt):setClass("Corvette", "Freighter"):setModel("transport_1_" .. cnt)
	template:setDescription(_([[These freighters are designed to transport armed troops, military support personnel, and combat gear.]]))
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
		variation:setDescription([[Transport personne de categorie 2. Ce type de cargo est concu pour le transport des personnes. Leur version militaire peut transporter des troupes du Trigone Armee, le personnel du Trigone Secours, et le materiel de combat. Le cargo contient aussi de petites soute ayant tout un environnement de stabilisation afin de transporter du materiel, des machineries delicates, et des instrumentations complexes. En plus petite quantite qu'un cargo de fret classique.

Le cargo est equippe en plus d'un moteur a impulsion RLS 4000/100P afin de pouvoir parcourir de tres longues longues distances (inter-planetaires) rapidement. C'est une version hybride impulsion/RLS. L'acceleration du moteur est bridee afin de rendre les transport de passager agreable. Le moteur a impulsion utilise une derivation du moteur RLS pour atteindre des vitesses importantes. L'utilisation unique du moteur RLS permet une acceleration rapide mais la vitesse est fortment limitee (moins importante qu'avec le moteur a impulsion). Les version militaires sont moins bridees mais reste dans un spectre d'acceleration humainement supportable.

Les compartiments arrieres du cargo contiennent 8 mines spatio-sismiques, necessaires en cas d'urgence dans les zones spatiolithique.]])
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
		variation:setDescription([[Transport personne de categorie 2. Ce type de cargo est concu pour le transport des personnes. Leur version militaire peut transporter des troupes du Trigone Armee, le personnel du Trigone Secours, et le materiel de combat. Le cargo contient aussi de petites soute ayant tout un environnement de stabilisation afin de transporter du materiel, des machineries delicates, et des instrumentations complexes. En plus petite quantite qu'un cargo de fret classique.

Le cargo est equippe en plus d'un moteur a impulsion RLS 900 afin de pouvoir parcourir de tres longues longues distances (inter-planetaires) rapidement. Toutefois l'acceleration du moteur est bridee afin de rendre les transport de passager agreable. Les version militaires sont moins bridees mais reste dans un spectre d'acceleration humainement supportable.

Les compartiments arrieres du cargo contiennent 8 mines spatio-sismiques, necessaires en cas d'urgence dans les zones spatiolithique.]])
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
	template:setDescription(_([[Cargo freighters haul large loads of cargo across long distances on impulse power. Their cargo bays include climate control and stabilization systems that keep the cargo in good condition.]]))
	template:setHull(100)
	template:setShields(50, 50)
	template:setSpeed(60 - 5 * cnt, 6, 10)
	template:setRadarTrace("radar_transport.png")

-- Pas de saut jump/warp dans clones
--	  if cnt > 2 then
--		  variation = template:copy("Goods WARP Freighter " .. cnt)
--		  variation:setWARPDrive(true)
--	  end

	--[[ Cargo joueur
	--]]
	if cnt == 5 then
		variation = template:copy("Cargo Marchandise RLS Dock"):setType("playership")
		variation:setDescription([[Cargo transark Marchandise de categorie 5. Possede tout un environnement de stabilisation afin de transporter du materiel, des machineries delicates, et des instrumentations complexes.

	Le cargo est equippe en plus d'un moteur a impulsion RLS 800 afin de pouvoir parcourir de tres longues longues distances (inter-planetaires) rapidement.

	Les compartiments arrieres du cargo contiennent 8 mines spatio-sismiques, necessaires en cas d'urgence dans les zones spatiolithique.

	Le cargo est capable de transporter d'autres vaisseaux (type corvette) qui peuvent donc s'y amarrer.]])
		--variation:setShields(200, 200)
		--variation:setHull(250)
		variation:setDockClasses("Starfighter", "Frigate", "Corvette")
		variation:setSpeed(90, 10, 20)
		variation:setRLSSpeed(800)
		variation:setCombatManeuver(200, 100)
		variation:setLASER(2, 0, 0, 0, 0, 0)
		variation:setWeaponStorage("Mine", 8)
		variation:setTubes(1, 8.0) -- Amount of torpedo tubes, and loading time of the tubes.
		variation:setTubeDirection(0, 180):setWeaponTubeExclusiveFor(0, "Mine")
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
		variation = template:copy("Cargo Marchandise RLS Dock*")
		variation:setDescription([[Cargo transark Marchandise de categorie 5. Possede tout un environnement de stabilisation afin de transporter du materiel, des machineries delicates, et des instrumentations complexes.

	Le cargo est equippe en plus d'un moteur a impulsion RLS 800 afin de pouvoir parcourir de tres longues longues distances (inter-planetaires) rapidement.

	Les compartiments arrieres du cargo contiennent 8 mines spatio-sismiques, necessaires en cas d'urgence dans les zones spatiolithique.

	Le cargo est capable de transporter d'autres vaisseaux (type corvette) qui peuvent donc s'y amarrer.]])
		variation:setSpeed(90, 10, 20)
		variation:setRLSSpeed(800)
		variation:setCombatManeuver(200, 100)
		variation:setLASER(2, 0, 0, 0, 0, 0)
		variation:setWeaponStorage("Mine", 8)
		variation:setTubes(1, 8.0) -- Amount of torpedo tubes, and loading time of the tubes.
		variation:setTubeDirection(0, 180):setWeaponTubeExclusiveFor(0, "Mine")
	end

	template = ShipTemplate():setName("Cargo Dechets " .. cnt):setClass("Corvette", "Freighter"):setModel("transport_3_" .. cnt)
	template:setDescription(_([[These freighters are specially designed to haul garbage and waste. They are fitted with a trash compactor and fewer stabilzation systems than cargo freighters.]]))
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
	template:setDescription(_([[Equipment freighters have specialized environmental and stabilization systems to safely carry delicate machinery and complex instruments.]]))
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
		variation = template:copy("Cargo Materiel RLS"):setType("playership")
		variation:setDescription([[Cargo transark Equipement de categorie 2. Possede tout un environnement de stabilisation afin de transporter du materiel, des machineries delicates, et des instrumentations complexes.

Le cargo est equippe en plus d'un moteur a impulsion RLS 900 afin de pouvoir parcourir de tres longues longues distances (inter-planetaires) rapidement.

Les compartiments arrieres du cargo contiennent 8 mines spatio-sismiques, necessaires en cas d'urgence dans les zones spatiolithique.]])
		--variation:setShields(200, 200)
		--variation:setHull(250)
		variation:setSpeed(90, 10, 20)
		variation:setRLSSpeed(900)
		variation:setCombatManeuver(200, 100)
		variation:setLASER(2, 0, 0, 0, 0, 0)
		variation:setWeaponStorage("Mine", 8)
		variation:setTubes(1, 8.0) -- Amount of torpedo tubes, and loading time of the tubes.
		variation:setTubeDirection(0, 180):setWeaponTubeExclusiveFor(0, "Mine")
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
		variation = template:copy("Cargo Materiel RLS*")
		variation:setDescription([[Cargo transark Equipement de categorie 2. Possede tout un environnement de stabilisation afin de transporter du materiel, des machineries delicates, et des instrumentations complexes.

Le cargo est equippe en plus d'un moteur a impulsion RLS 900 afin de pouvoir parcourir de tres longues longues distances (inter-planetaires) rapidement.

Les compartiments arrieres du cargo contiennent 8 mines spatio-sismiques, necessaires en cas d'urgence dans les zones spatiolithique.]])
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
	template:setDescription(_([[Fuel freighters have massive tanks for hauling fuel, and delicate internal sensors that watch for any changes to their cargo's potentially volatile state.]]))
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
		variation:setDescription([[Cargo transark extracteur de minerai de categorie 2. En plus des syteme d'extraction de gaz et de minerai, le cargo possede un systeme de destruction d'asteroide via des tirs "rafale".

Les cale du vaisseau sont adpatees pour le transport du minerai et du gaz (hyperdeuterium, etc...).

Le cargo est equippe en plus d'un moteur a impulsion RLS 300, pour lui permettre certains deplacement plus rapide.

Les compartiments arrieres du cargo contiennent aussi 8 mines spatio-sismiques, necessaires en cas d'urgence dans les zones spatiolithique.]])
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
		variation:setDescription([[Cargo transark extracteur de minerai/gaz de categorie 2. En plus des syteme d'extraction de gaz et de minerai, le cargo possede un systeme de destruction d'asteroide via des tirs "rafale".

Les cales du vaisseau sont adpatees pour le transport du minerai et du gaz (hyperdeuterium, etc...).

Le cargo est equippe en plus d'un moteur a impulsion RLS 300, pour lui permettre certains deplacement plus rapide.

Les compartiments arrieres du cargo contiennent aussi 8 mines spatio-sismiques, necessaires en cas d'urgence dans les zones spatiolithique.]])
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
template:setDescription(_([[The Jump Carrier is a specialized Freighter. It does not carry any cargo, as it's cargo bay is taken up by a specialized jump drive and the energy storage required to run this jump drive.
It is designed to carry other ships deep into space. So it has special docking parameters, allowing other ships to attach themselves to this ship.]]))
template:setHull(100)
template:setShields(50, 50)
template:setSpeed(50, 6, 10)
template:setRadarTrace("radar_transport.png")
template:setWARPDrive(true)
template:setWARPDriveRange(5000, 100 * 50000) -- The WARP carrier can WARP a 100x longer distance then normal WARP drives.
template:setDockClasses("Starfighter", "Frigate", "Corvette")

 variation = template:copy("Benedict"):setType("playership"):setClass("Corvette","Freighter/Carrier")
 variation:setDescription(_("Benedict is an improved version of the Jump Carrier"))
 variation:setShields(70, 70)
 variation:setHull(200)
 variation:setSpeed(60, 6, 8)
 --                  Arc, Dir, Range, CycleTime, Dmg
 variation:setLASER(0, 10,   0, 1500.0, 6.0, 4)
 variation:setLASER(1, 10, 180, 1500.0, 6.0, 4)
 --								 Arc, Dir, Rotate speed
 variation:setLASERWeaponTurret( 0, 90,   0, 6)
 variation:setLASERWeaponTurret( 1, 90, 180, 6)
 variation:setCombatManeuver(400, 250)
 variation:setWARPDriveRange(5000, 90000)

 variation:setRepairCrewCount(6)
 variation:addRoomSystem(3,0,2,3, "Reactor")
 variation:addRoomSystem(3,3,2,3, "RLS")
 variation:addRoomSystem(6,0,2,3, "WARPDrive")
 variation:addRoomSystem(6,3,2,3, "MissileSystem")
 variation:addRoomSystem(5,2,1,2, "Maneuver")
 variation:addRoomSystem(2,2,1,2, "RearShield")
 variation:addRoomSystem(0,1,2,4, "LASERweapons")
 variation:addRoomSystem(8,2,1,2, "FrontShield")
 variation:addRoomSystem(9,1,2,4, "Impulse")

 variation:addDoor(3, 3, true)
 variation:addDoor(6, 3, true)
 variation:addDoor(5, 2, false)
 variation:addDoor(6, 3, false)
 variation:addDoor(3, 2, false)
 variation:addDoor(2, 3, false)
 variation:addDoor(8, 2, false)
 variation:addDoor(9, 3, false)

 var2 = variation:copy("Kiriya")
 var2:setDescription(_("Kiriya is an improved warp drive version of the Jump Carrier"))
 --                  Arc, Dir, Range, CycleTime, Dmg
 var2:setLASER(0, 10,   0, 1500.0, 6.0, 4)
 var2:setLASER(1, 10, 180, 1500.0, 6.0, 4)
 --								 Arc, Dir, Rotate speed
 var2:setLASERWeaponTurret( 0, 90,   0, 6)
 var2:setLASERWeaponTurret( 1, 90, 180, 6)
 var2:setWARPDrive(false)
 var2:setRLSSpeed(750)

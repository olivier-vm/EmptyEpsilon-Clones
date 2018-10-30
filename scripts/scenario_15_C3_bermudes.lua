-- Name: C3 - Real Transark - Bermudes Log
-- Description: log rejouable de mission du vaisseau à secourir.
-- Type: Mission

function init()
	station_tc = SpaceStation():setTemplate("Large Station"):setFaction("Technocorp"):setCallSign("TC-DS7"):setPosition(5529, 0)

	-- Vaisseau en Transit sur lequel est arrime le vaisseau des joueurs SKF
	-- Ne pourra partir qu'une fois remplis du materiel necessaire
	eg_arl = CpuShip():setFaction("Technocorp"):setTemplate("Cargo Marchandise 5"):setCallSign("EG-ARL-X58"):setPosition(9149, 11742):orderFlyTowards(5529, 0):setRLSDrive(true):setDockClasses("Corvette")
--	eg_arl = CpuShip():setFaction("Technocorp"):setTemplate("Cargo Marchandise 5"):setCallSign("EG-ARL-X58"):setPosition(9149, 11742):orderDock(TC-DS7):setRLSDrive(true):setDockClasses("Corvette")

	player = PlayerSpaceship():setFaction("Transark"):setTemplate("Cargo Materiel RLS")
	player:setPosition(9150, 11742):setCallSign("SKF"):setRotation(90):commandTargetRotation(90)
	for _, system in ipairs({"reactor", "LASERweapons", "missilesystem", "maneuver", "impulse", "RLS", "WARPdrive", "frontshield", "rearshield"}) do
		player:setSystemPower(system, 0.0)
		player:commandSetSystemPowerRequest(system, 0.0)
	end
	player:setWeaponStorage("Mine", 0)
	player:commandDock(eg_arl)

  --Vaisseaux a secourir
	CpuShip():setFaction("Transark"):setTemplate("Cargo Equipement 2"):setCallSign("LL-AMS 36"):setPosition(-95009, -106262):setRLSDrive(true):setShields(0.00, 0.00)
	CpuShip():setFaction("Transark"):setTemplate("Cargo Marchandise 4"):setCallSign("EG-RAL 42"):setPosition(-84050, -83562):setRLSDrive(true):setShields(0.00, 0.00)
	CpuShip():setFaction("Transark"):setTemplate("Cargo Marchandise 4"):setCallSign("EG-RAL 48"):setPosition(-64481, -83953):setRLSDrive(true):setShields(0.00, 0.00)

end


function update(delta)
	--No victory condition
end

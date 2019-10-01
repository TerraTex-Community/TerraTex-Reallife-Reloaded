frakselfcars[10] = {}

local function onEnterMedicVehicle(player,seat)
	if (vioGetElementData(player, "fraktion") ~= 10) and (seat == 0) then
		cancelEvent()
	end
end

local function handlerCreateMedicVehicle()
	----- Fahrzeuge Las Venturas -----
	-- Ambulance --
	local vehicle = createVehicle(416, 1589.5999755859, 1850.6999511719, 10.949999809265, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1593.9000244141, 1850.6999511719, 10.949999809265, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1598.0999755859, 1850.6999511719, 10.949999809265, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1602.3000488281, 1850.6999511719, 10.949999809265, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1606.5, 1850.6999511719, 10.949999809265, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1610.8000488281, 1850.6999511719, 10.949999809265, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	-- Police LV --
	vehicle = createVehicle(598, 1619.1999511719, 1850.6999511719, 10.564999580383, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(598, 1615, 1850.6999511719, 10.564999580383, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	-- Coach (Event) --
	vehicle = createVehicle(437, 1625.3000488281, 1848.8000488281, 10.949999809265, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	-- Fire Truck --
	vehicle = createVehicle(407, 1624.3000488281, 1818.5999755859, 11.050000190735, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(407, 1591.0999755859, 1818.5999755859, 11.050000190735, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10], vehicle)
	-- Leviathan --
	vehicle = createVehicle(417, 1607.841796875, 1800.9755859375, 33.121593475342, 1.0491943359375, 359.99450683594, 265.24841308594, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)

	----- Fahrzeuge Los Santos -----
	-- Maverick --
	vehicle = createVehicle(487, 1118.2998046875, -1301.7001953125, 19.834999084473, 0, 0, 270, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	-- Raindance --
	vehicle = createVehicle(563, 1139.099609375, -1301.400390625, 20.540000915527, 0, 0, 90, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	-- Ambulance --
	vehicle = createVehicle(416, 1145.8000488281, -1297.0999755859, 13.800000190735, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	vehicle = createVehicle(416, 1141.099609375, -1297.0999755859, 13.800000190735, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	vehicle = createVehicle(416, 1134.099609375, -1297.0999755859, 13.800000190735, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	vehicle = createVehicle(416, 1129.2998046875, -1297.0999755859, 13.800000190735, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	vehicle = createVehicle(416, 1129.2998046875, -1305.7001953125, 13.800000190735, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	vehicle = createVehicle(416, 1134.099609375, -1305.7001953125, 13.800000190735, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	vehicle = createVehicle(416, 1141.099609375, -1305.7001953125, 13.800000190735, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	vehicle = createVehicle(416, 1145.8000488281, -1305.7001953125, 13.800000190735, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	-- FBI Rancher --
	vehicle = createVehicle(490, 1121.900390625, -1297.5, 13.699999809265, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	-- Police SF --
	vehicle = createVehicle(597, 1117.5, -1297.400390625, 13.300000190735, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	-- Stratum --
	vehicle = createVehicle(561, 1117.5, -1305.2998046875, 13.435000419617, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	vehicle = createVehicle(561, 1121.900390625, -1305.3000488281, 13.435000419617, 0, 0, 180, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	-- Bus (Event) --
	vehicle = createVehicle(431, 1110.400390625, 13.664999961853, 13.664999961853, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	-- Dune (Event) --
	vehicle = createVehicle(573, 1098.4000244141, -1328.9000244141, 14, 0, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	-- Fire Truck --
	vehicle = createVehicle(407, 1110.8000488281, -1328.3000488281, 13.550000190735, 4.75, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)
	vehicle = createVehicle(407, 1124.1999511719, -1328.3000488281, 13.550000190735, 4.75, 0, 0, "EMERGENCY")
	table.insert(frakselfcars[10],vehicle)


	for key, theVehicle in pairs(frakselfcars[10]) do
		prepare(theVehicle, 10)
		setVehicleColor (theVehicle, 255, 255, 255, 255, 0, 0)
		vioSetElementData(theVehicle, "tank", 100)
		table.insert(frakcars, theVehicle)
		addEventHandler("onVehicleStartEnter", theVehicle, onEnterMedicVehicle)
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()), handlerCreateMedicVehicle)
 
local function handlerMHeal(thePlayer, cmd, toPlayerName)
	if (vioGetElementData(thePlayer,  "fraktion") == 10) then
		if (toPlayerName) then
			local toPlayer = getPlayerFromIncompleteName(toPlayerName)
			if (toPlayer) then
				if (isPedInVehicle(thePlayer) and isPedInVehicle(toPlayer)) then	
					if (vioGetElementData(thePlayer, "isMedicDuty")) then
						if (vioGetElementData(getPedOccupiedVehicle(toPlayer), "frakid")) then
							if (getPedOccupiedVehicle(toPlayer) == getPedOccupiedVehicle(thePlayer)) then
								if (vioGetElementData(getPedOccupiedVehicle(toPlayer), "frakid") == 10) then
									showError(thePlayer, string.format("Du hast %s medizinische Unterstützung geleistet.", getPlayerName(toPlayer)))
									setElementHealth(toPlayer, 100)
									showError(toPlayer, string.format("Du hast von %s medizinische Unterstützung erhalten.", getPlayerName(thePlayer)))
								else
									showError(thePlayer, "Einer von euch ist nicht im Krankenwagen.")
								end
							else
								showError(thePlayer, "Ihr müsst euch beide im selben Krankenwagen befinden.")
							end
						else
							showError(thePlayer, "Einer von euch ist nicht im Krankenwagen.")
						end
					else 
						showError(thePlayer, "Du musst im Dienst sein, um Medizinische Hilfe leisten zu können.")
					end
				else
					showError(thePlayer, "Einer von euch ist nicht im Krankenwagen.")
				end				 
			else
				showError(thePlayer, "Dieser Spieler existiert nicht.")	
			end			
		else
			showError(thePlayer, "Dieser Spieler existiert nicht.")	
		end		
	end
end
addCommandHandler("mheal", handlerMHeal, false, false)

local function handlerMedicDuty(thePlayer)
	local x, y, z = getElementPosition(thePlayer)
	if (vioGetElementData(thePlayer, "fraktion") == 10) then
		if (getDistanceBetweenPoints3D(1607.3505859375, 1816.220703125, 10.8203125, x, y, z)<10 or getDistanceBetweenPoints3D(1144.8000488281, -1319.5999755859, 13.60000038147,x,y,z) < 10) then
			if (vioGetElementData(thePlayer, "isMedicDuty")) then
				takeAllWeapons ( thePlayer );
				vioSetElementData(thePlayer, "isMedicDuty", false)
				setElementModel(thePlayer, vioGetElementData(thePlayer, "skinid"))
				showError(thePlayer, "Du bist nun nicht mehr im Dienst.")
			else
				takeAllWeapons ( thePlayer );
				setPlayerSpawnWeapons(thePlayer);
				vioSetElementData(thePlayer, "isMedicDuty", true)
				setElementModel(thePlayer,vioGetElementData(thePlayer, "FrakSkin"))
				showError(thePlayer, "Du bist nun im Dienst.")
			end
		else
			showError(thePlayer, "Du bist nicht am Krankenhaus.")
		end
	end
end
addCommandHandler("duty", handlerMedicDuty, false, false)

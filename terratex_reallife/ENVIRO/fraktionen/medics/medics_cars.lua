frakselfcars[10] = {}

local function onEnterMedicVehicle(player,seat)
	if (vioGetElementData(player, "fraktion") ~= 10) and (seat == 0) then
		cancelEvent()
	end
end

local function handlerCreateMedicVehicle()
	----- Fahrzeuge Los Santos -----
	-- Ambulance --
	local vehicle = createVehicle(416, 1145.9000244141, -1297.5999755859, 13.699999809265, 0, 0, 0, "Medic")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1141.3000488281, -1297.5999755859, 13.699999809265, 0, 0, 0, "Medic")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1134.0999755859, -1297.5999755859, 13.699999809265, 0, 0, 0, "Medic")
	table.insert(frakselfcars[10], vehicle)
	vehicle= createVehicle(416, 1129.5, -1297.5999755859, 13.699999809265, 0, 0, 0, "Medic")
	table.insert(frakselfcars[10], vehicle)
	-- Sultan --
	vehicle = createVehicle(560, 1122.1999511719, -1297.6999511719, 13.300000190735, 0, 0, 0, "SAHP")
	table.insert(policeVehicles, vehicle)
	table.insert(frakselfcars[10], vehicle)
	addVehicleSirens(vehicle, 2, 2, false, false, true, false)
	setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
	setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
	vehicle = createVehicle(560, 1117.9000244141, -1297.6999511719, 13.300000190735, 0, 0, 0, "SAHP")
	table.insert(policeVehicles, vehicle)
	table.insert(frakselfcars[10], vehicle)
	addVehicleSirens(vehicle, 2, 2, false, false, true, false)
	setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
	setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
	-- Police LV --
	vehicle = createVehicle(598, 1110.5, -1297.8000488281, 13.300000190735, 0, 0, 0, "Medic")
	table.insert(frakselfcars[10], vehicle)
	-- Raindance --
	vehicle = createVehicle(417, 1138.8000488281, -1301.5999755859, 20.549999237061, 0, 0, 90, "Medic")
	table.insert(frakselfcars[10],vehicle)
	-- Maverick --
	vehicle = createVehicle(487, 1118.0999755859, -1301.5999755859, 19.85000038147, 0, 0, 270, "Medic")
	table.insert(frakselfcars[10],vehicle)

	----- Fahrzeuge Las Venturas -----
	-- Raindance --
	vehicle = createVehicle(417, 1607.841796875, 1800.9755859375, 33.121593475342, 1.0491943359375, 359.99450683594, 265.24841308594, "Medic")
	table.insert(frakselfcars[10],vehicle)
	-- Police LS --
	vehicle = createVehicle(596, 1594.6999511719, 1831.6999511719, 10.534999847412, 0, 0, 180, "Medic")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(596, 1599, 1831.6999511719, 10.534999847412, 0, 0, 180, "Medic")
	table.insert(frakselfcars[10], vehicle)
	-- Ambulance --
	vehicle = createVehicle(416, 1603.1999511719, 1830.6999511719, 10.954999923706, 0, 0, 180, "Medic")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1607.3000488281, 1830.6999511719, 10.954999923706, 0, 0, 180, "Medic")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1611.5999755859, 1830.6999511719, 10.954999923706, 0, 0, 180, "Medic")
	table.insert(frakselfcars[10], vehicle)
	vehicle = createVehicle(416, 1615.9000244141, 1830.6999511719, 10.954999923706, 0, 0, 180, "Medic")
	table.insert(frakselfcars[10], vehicle)
	-- Sultan --
	vehicle = createVehicle(560, 1624.3000488281, 1818.4000244141, 10.52499961853, 0, 0, 0, "SAHP")
	table.insert(policeVehicles, vehicle)
	table.insert(frakselfcars[10], vehicle)
	addVehicleSirens(vehicle, 2, 2, false, false, true, false)
	setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
	setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)
	vehicle = createVehicle(560, 1591.3000488281, 1818.4000244141, 10.52499961853, 0, 0, 0, "SAHP")
	table.insert(policeVehicles, vehicle)
	table.insert(frakselfcars[10], vehicle)
	addVehicleSirens(vehicle, 2, 2, false, false, true, false)
	setVehicleSirens(vehicle, 1, 0, 0.6, 0.2, 255, 0, 0, 255, 147.9)
	setVehicleSirens(vehicle, 2, 0, 0.6, 0.2, 0, 0, 255, 255, 56.1)

	for key, theVehicle in pairs(frakselfcars[10]) do
		prepare(theVehicle, 10)
		setVehicleColor (theVehicle, 255, 255, 255, 255, 0, 0)
		vioSetElementData(theVehicle, "tank", 100)
		table.insert(frakcars, theVehicle)
		addEventHandler("onVehicleStartEnter", theVehicle, onEnterMedicVehicle)
	end
end
addEventHandler("factionLoadingReady",getResourceRootElement(getThisResource()), handlerCreateMedicVehicle)
 
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
									showError(thePlayer, "Einer von euch ist nicht im Rettungswagen.")
								end
							else
								showError(thePlayer, "Ihr müsst euch beide im selben Rettungswagen befinden.")
							end
						else
							showError(thePlayer, "Einer von euch ist nicht im Rettungsnwagen.")
						end
					else 
						showError(thePlayer, "Du musst im Dienst sein, um medizinische Hilfe leisten zu können.")
					end
				else
					showError(thePlayer, "Einer von euch ist nicht im Rettungswagen.")
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

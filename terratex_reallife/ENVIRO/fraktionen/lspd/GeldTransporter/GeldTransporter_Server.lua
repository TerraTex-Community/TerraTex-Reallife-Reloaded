gtVehiclePlayerElement = nil
local gtVehicleMarker = createPickup(-2765.02734375, 372.37344360352, 6.339786529541, 3, 1239)
local gtFinishMarkerTable = {
	[1] = {2296.5, -12.39999961853, (26.299999237061 - 1.4)},			-- LSPD
	[2] = {2496.6162109375, -1678.333984375, 12.339521408081},		-- Grove Street
	[3] = {0, 0, 0},																			-- Newsfraktion
	[4] = {0, 0, 0},																			-- Taxifraktion
	[5] = {2296.5, -12.39999961853, (26.299999237061 - 1.4)},			-- SEK
	[6] = {711.564453125, -1434.3916015625, 13.531820297241},		-- Legion of Los Santos
	[7] = {2296.5, -12.39999961853, (26.299999237061 - 1.4)},			-- N.A.M.E
	[8] = {0, 0, 0},																			-- Hitman
	[9] = {0, 0, 0},																			-- LVPD
	[10] = {0, 0, 0},																			-- Medics
	[11] = {2040.1337890625, 1916.4404296875, 12.167406082153},	-- CashForce
	[12] = {2804.8916015625, 2183.91796875, 10.8203125},				-- Violettas
}

local gtIsTransportStarted = false
local gtIsVehicleFreezed = false
local gtIsPlayerGetInVehicle = false
local gtVehiclePlayerElementDeath = false
local gtVehicleFraktionInteger, gtVehicleLastPlayerElement, gtVehicleVehicleElement, gtVehicleFinishMarker, gtVehicleFinishBlib
local gtVehicleFreezedTimer, gtVehicleGetInTimer, gtVehicleCheckRepairTimer, gtVehicleLastPlayerTimer
local gtVehicleGetInPlayerElement, gtVehicleLastPlayerElement

local function GTDestroyElements()
	gtIsTransportStarted = false
	gtIsVehicleFreezed = false
	gtIsPlayerGetInVehicle = false
	if (isElement(gtVehiclePlayerElement)) then
		gtVehiclePlayerElement = nil
		-- destroyElement(gtVehiclePlayerElement)
	end
	if (isElement(gtVehicleFraktionInteger)) then
		destroyElement(gtVehicleFraktionInteger)
	end
	if (isElement(gtVehicleLastPlayerElement)) then
		destroyElement(gtVehicleLastPlayerElement)
	end
	if (isElement(gtVehicleVehicleElement)) then
		destroyElement(gtVehicleVehicleElement)
	end
	if (isElement(gtVehicleFinishMarker)) then
		destroyElement(gtVehicleFinishMarker)
	end
	if (isElement(gtVehicleFinishBlib)) then
		destroyElement(gtVehicleFinishBlib)
	end
	if (isElement(gtVehicleFreezedTimer)) then
		destroyElement(gtVehicleFreezedTimer)
	end
	if (isElement(gtVehicleGetInTimer)) then
		destroyElement(gtVehicleGetInTimer)
	end
	if (isElement(gtVehicleCheckRepairTimer)) then
		destroyElement(gtVehicleCheckRepairTimer)
	end
	if (isElement(gtVehicleLastPlayerTimer)) then
		destroyElement(gtVehicleLastPlayerTimer)
	end
	if (isElement(gtVehicleGetInPlayerElement)) then
		destroyElement(gtVehicleGetInPlayerElement)
	end
	if (isElement(gtVehicleLastPlayerElement)) then
		destroyElement(gtVehicleLastPlayerElement)
	end
end

local function GTFinishMoneyTranportNow(theElement)
	if (gtIsTransportStarted) then
		if (source == gtVehicleFinishMarker) then
			if (isElement(theElement)) then
				if (getElementType(theElement) == "vehicle") then
					if(theElement == gtVehicleVehicleElement) then
						local player = getVehicleOccupant(theElement, 0)
						if (getVehicleOccupant(theElement, 0) == gtVehiclePlayerElement) then
							local fraktion = vioGetElementData(player,"fraktion")
							if (vioGetElementData(gtVehiclePlayerElement, "fraktion") == gtVehicleFraktionInteger) then
								killTimer(gtVehicleCheckRepairTimer)
								showError(gtVehiclePlayerElement, "Herzlichen Glückwunsch! Sie haben das Ziel erreicht.")
								if (gtVehicleFraktionInteger == 1 or gtVehicleFraktionInteger == 5 or gtVehicleFraktionInteger == 7 or gtVehicleFraktionInteger == 8 or gtVehicleFraktionInteger == 9) then
									frakkasse[1] = frakkasse[1] + 120000
									frakdepot_log(1, 1, 120000, string.format("Geltransporter abgegeben: %s", getPlayerName(player)))
								elseif (gtVehicleFraktionInteger == 2 or gtVehicleFraktionInteger == 6 or gtVehicleFraktionInteger == 11 or gtVehicleFraktionInteger == 12) then
									frakkasse[vioGetElementData(gtVehiclePlayerElement, "fraktion")] = frakkasse[vioGetElementData(gtVehiclePlayerElement, "fraktion")] + 50000
									frakdepot_log(vioGetElementData(gtVehiclePlayerElement, "fraktion"), 1, 50000, string.format("Geltransporter abgegeben: %s", getPlayerName(player)))
								end
								for i = 1, 12, 1 do
									if (i ~= 4 and i ~= 10) then
										local players = getPlayersInTeam(team[i])
										for k, v in ipairs(players) do
											if (isElement(v)) then
												outputChatBox("Der Geldtransporter hat seinen Zielort erreicht.", v,  255, 0, 0)
											end
										end
									end
								end
								GTDestroyElements()
							end
						end
					end
				end
			end
		end
	end
end

local function GTUnfreezeLastVehiclePlayerElement()
	setElementFrozen(gtVehicleLastPlayerElement, false)
end

local function GTSetGetInPlayerInVehicle()
	setElementFrozen(gtVehicleGetInPlayerElement, false)
	gtVehiclePlayerElement = gtVehicleGetInPlayerElement
	if (isElement(gtVehicleGetInPlayerElement)) then
		destroyElement(gtVehicleGetInPlayerElement)
	end
	if (isElement(gtVehicleFinishMarker)) then
		destroyElement(gtVehicleFinishMarker)
	end
	if (isElement(gtVehicleFinishBlib)) then
		destroyElement(gtVehicleFinishBlib)
	end
	gtIsPlayerGetInVehicle = false
	if (getVehicleOccupant(gtVehicleVehicleElement, 0) == gtVehicleLastPlayerElement) then
		removePedFromVehicle(gtVehicleLastPlayerElement)
		local x, y, z = getElementPosition(gtVehiclePlayerElement)
		setElementPosition(gtVehicleLastPlayerElement, x + 3, y + 3, z + 2, true)
	end
	warpPedIntoVehicle(gtVehiclePlayerElement, gtVehicleVehicleElement, 0)
	gtVehicleFraktionInteger = vioGetElementData(gtVehiclePlayerElement, "fraktion")
	gtVehicleFinishMarker = createMarker(gtFinishMarkerTable[gtVehicleFraktionInteger][1], gtFinishMarkerTable[gtVehicleFraktionInteger][2], gtFinishMarkerTable[gtVehicleFraktionInteger][3] , "cylinder", 4, 255, 0, 0, 255)
	gtVehicleFinishBlib = createBlip(gtFinishMarkerTable[gtVehicleFraktionInteger][1], gtFinishMarkerTable[gtVehicleFraktionInteger][2], gtFinishMarkerTable[gtVehicleFraktionInteger][3], 53, 2, 255, 0, 0, 255, 0, 99999.0, gtVehiclePlayerElement)
	addEventHandler("onMarkerHit", gtVehicleFinishMarker, GTFinishMoneyTranportNow)
	showError(gtVehicleLastPlayerElement, "Dir wurde das Fahrzeug abgenommen.")
	showError(gtVehiclePlayerElement, "Du hast das Fahrzeug erfolgreich gestohlen.\nFahre nun in deine Base!")
	for i = 1, 12, 1 do
		if (i ~= 4 and i ~= 10) then
			local players = getPlayersInTeam(team[i])
			for k, v in ipairs(players) do
				if (isElement(v)) then
					outputChatBox(string.format("%s hat das Fahrzeug übernommen.", getPlayerName(gtVehiclePlayerElement)), v,  255, 0, 0)
				end
			end
		end
	end
end

local function GTPlayerGetDeath()
	if (isElement(gtVehiclePlayerElement)) then
		if (source == gtVehiclePlayerElement) then
			gtVehiclePlayerElementDeath = true
		end
	end
end
addEventHandler("onPlayerWasted", getRootElement(), GTPlayerGetDeath)

local function GTPlayerGetOutVehicle(thePlayer, seat, jacked, door)
	if (source == gtVehicleVehicleElement) then
		if (thePlayer == gtVehiclePlayerElement) then
			cancelEvent()
		end
	end
end
addEventHandler("onVehicleStartExit", getRootElement(), GTPlayerGetOutVehicle)

local function GTPlayerGetInVehicle(thePlayer, seat, jacked, door)
	if (source == gtVehicleVehicleElement) then
		if (not gtIsTransportStarted) then 
			showError(thePlayer, "Der Truck wurde noch nicht gestartet.")
			return 
		end
		local fraktion = vioGetElementData(thePlayer, "fraktion")
		if (fraktion == 1 or fraktion == 2 or fraktion == 5 or fraktion == 6 or fraktion == 7 or fraktion == 8 or fraktion == 9 or fraktion == 11 or fraktion == 12) then
			if (seat == 0) then
				-- outputChatBox("2: " .. tostring((getVehicleOccupant(gtVehicleVehicleElement, 0) ~= gtVehiclePlayerElement)) .. "\n " .. tostring(gtVehiclePlayerElementDeath), getRootElement())
				if (gtIsVehicleFreezed or (getVehicleOccupant(gtVehicleVehicleElement, 0) ~= gtVehiclePlayerElement and gtVehiclePlayerElementDeath)) then
					if (gtIsPlayerGetInVehicle) then
						if (isElement(gtVehicleGetInPlayerElement)) then
							showError(thePlayer, string.format("%s knackt das Fahrzeug bereits.", getPlayerName(gtVehicleGetInPlayerElement)))
						end
					else
						local canGetIn = false
						if (isTimer(gtVehicleFreezedTimer)) then
							if ((select(1, getTimerDetails(gtVehicleFreezedTimer)) / 1000) >= 5) then
								canGetIn = true
							end
						end
						if (getVehicleOccupant(gtVehicleVehicleElement, 0)) then
							canGetIn = true
						end
						if (canGetIn) then
							gtIsPlayerGetInVehicle = true
							gtVehicleGetInPlayerElement = thePlayer
							setElementFrozen(gtVehicleGetInPlayerElement, true)
							gtVehicleGetInTimer = setTimer(GTSetGetInPlayerInVehicle, 5000, 1)
							if (gtVehiclePlayerElement) then
								gtVehicleLastPlayerElement = gtVehicleGetInPlayerElement
								gtVehiclePlayerName = getPlayerName(gtVehiclePlayerElement)
								setElementFrozen(gtVehicleLastPlayerElement, true)
								if (isElement(gtVehiclePlayerElement)) then
									destroyElement(gtVehiclePlayerElement)
								end
								gtVehicleLastPlayerTimer = setTimer(GTUnfreezeLastVehiclePlayerElement, 8000, 1)
							end
						end
					end
				end
			end
		else
			showError(thePlayer, "Sie sind kein Mitglied der kriminellen Organisation oder der Beamtenfraktion.")
		end
		cancelEvent()
	end
end
addEventHandler("onVehicleStartEnter", getRootElement(), GTPlayerGetInVehicle)

local function GTVehiclePlayerDisconnect()
	if (source == gtVehiclePlayerElement) then
		destroyElement(gtVehiclePlayerElement)
	end
end
addEventHandler("onPlayerQuit", getRootElement(), GTVehiclePlayerDisconnect)

local function GTVehicleIsExplode()
	for i = 1, 12, 1 do
		if (i ~= 4 and i ~= 10) then
			local players = getPlayersInTeam(team[i])
			for k, v in ipairs(players) do
				if (isElement(v)) then
					outputChatBox("Der Geldtransporter wurde leider zerstört.", v,  255, 0, 0)
				end
			end
		end
	end
	GTDestroyElements()
end

local function GTRepairTheVehicleDone()
	setVehicleDamageProof(gtVehicleVehicleElement, false)
	setElementFrozen(gtVehicleVehicleElement, false)
	fixVehicle(gtVehicleVehicleElement)
	local rx, ry, rz = getElementRotation(gtVehicleVehicleElement)
	setElementRotation(gtVehicleVehicleElement, 0, 0, rz)
	gtIsVehicleFreezed = false
	if (isElement(gtVehiclePlayerElement)) then
		for i = 1, 12, 1 do
			if (i ~= 4 and i ~= 10) then
				local players = getPlayersInTeam(team[i])
				for k, v in ipairs(players) do
					if (isElement(v)) then
						outputChatBox("Das Fahrzeug wurde erfolgreich repariert!", v,  255, 0, 0)
					end
				end
			end
		end
	end
end

local function GTRepairTheVehicle()
	if (isElement(gtVehicleVehicleElement)) then
		setVehicleWheelStates(gtVehicleVehicleElement, 0, 0, 0, 0)
		setVehicleDoorState(gtVehicleVehicleElement, 0, 1)
		setVehicleDoorState(gtVehicleVehicleElement, 1, 1)
		setVehicleDoorState(gtVehicleVehicleElement, 2, 1)
		setVehicleDoorState(gtVehicleVehicleElement, 3, 1)
		setVehicleDoorState(gtVehicleVehicleElement, 4, 1)
		setVehicleDoorState(gtVehicleVehicleElement, 5, 1)
		if (getElementHealth(gtVehicleVehicleElement) <= 350 and not isTimer(gtVehicleFreezedTimer)) then
			setVehicleDamageProof(gtVehicleVehicleElement, true)
			setElementHealth(gtVehicleVehicleElement, 400)
			setElementFrozen(gtVehicleVehicleElement, true)
			gtVehicleFreezedTimer = setTimer(GTRepairTheVehicleDone, 30000, 1)
			gtIsVehicleFreezed = true
			if (isElement(gtVehiclePlayerElement)) then
				for i = 1, 12, 1 do
					if (i ~= 4 and i ~= 10) then
						local players = getPlayersInTeam(team[i])
						for k, v in ipairs(players) do
							if (isElement(v)) then
								outputChatBox("Das Fahrzeug ist stark beschädigt und muss repariert werden.", v,  255, 0, 0)
							end
						end
					end
				end
			end
		end
	end
end

local function GTCheckVehicleForRepair()
	GTRepairTheVehicle()
end

local function GTGetVehicleDamage()
	if (source == gtVehicleVehicleElement) then
		GTRepairTheVehicle()
	end
end
addEventHandler("onVehicleDamage", getRootElement(), GTGetVehicleDamage)

local function GTStartMoneyTransportDeFreeze(thePlayer)
	if (not gtIsTransportStarted) then
		setVehicleDamageProof(gtVehicleVehicleElement, false)
		setVehicleFuelTankExplodable(gtVehicleVehicleElement, false)
		addEventHandler("onVehicleExplode", gtVehicleVehicleElement, GTVehicleIsExplode)
		gtVehicleCheckRepairTimer = setTimer(GTCheckVehicleForRepair, 1000, 0)
		addEventHandler("onMarkerHit", gtVehicleFinishMarker, GTFinishMoneyTranportNow)
		setElementFrozen(gtVehicleVehicleElement, false)
		showError(gtVehiclePlayerElement, "Gut, wir sind fertig. Sie können sich nun auf den Weg machen. Viel Glück!")
		gtIsVehicleFreezed = false
		gtIsTransportStarted = true
	end
end

local function GTStartMoneyTransportNow(thePlayer)
	if (not gtIsTransportStarted) then
		local curtime = getRealTime()
		if(curtime["hour"] >= 9 and curtime["hour"] <= 21)then
			local px, py, pz = getElementPosition(thePlayer)
			local mx, my, mz = getElementPosition(gtVehicleMarker)
			if(getDistanceBetweenPoints3D(px, py, pz, mx, my, mz) < 20)then
				if (isBeamter(thePlayer)) then
					if (vioGetElementData(thePlayer, "fraktionsrang") >= 3) then
						gtVehicleVehicleElement = createVehicle(428, -2754.3000488281, 374.60000610352, 4.4000000953674, 0, 0, 180, "Money 1")
						if (gtVehicleVehicleElement) then
                            vioSetElementData(gtVehicleVehicleElement,"isGTruck",true)
							warpPedIntoVehicle(thePlayer, gtVehicleVehicleElement, 0)
							setVehicleLocked(gtVehicleVehicleElement, true)
							setElementFrozen(gtVehicleVehicleElement, true)
							setVehicleDamageProof(gtVehicleVehicleElement, true)
							frakkasse[1] = (frakkasse[1] - 20000)
							frakdepot_log(1, 1, - 20000, string.format("Geltransporter Kaution: %s", getPlayerName(thePlayer)))
							showError(thePlayer, "Ihrer Fraktion wurden $ 20.000,-- als Kaution abgezogen.\nDas Fahrzeug wird nun beladen.\nBitte haben Sie ein wenig Geduld.")
							gtIsVehicleFreezed = true
							gtVehiclePlayerElement = thePlayer
							gtVehiclePlayerName = getPlayerName(gtVehiclePlayerElement)
							gtVehicleFraktionInteger = vioGetElementData(gtVehiclePlayerElement, "fraktion")
							gtVehicleFinishMarker = createMarker(gtFinishMarkerTable[gtVehicleFraktionInteger][1], gtFinishMarkerTable[gtVehicleFraktionInteger][2], gtFinishMarkerTable[gtVehicleFraktionInteger][3] , "cylinder", 4, 255, 0, 0, 255)
							gtVehicleFinishBlib = createBlip(gtFinishMarkerTable[gtVehicleFraktionInteger][1], gtFinishMarkerTable[gtVehicleFraktionInteger][2], gtFinishMarkerTable[gtVehicleFraktionInteger][3], 53, 2, 255, 0, 0, 255, 0, 99999.0, gtVehiclePlayerElement)
							local player = thePlayer
							gtVehicleFreezedTimer = setTimer(GTStartMoneyTransportDeFreeze, 30000, 1, player)
							for i = 1, 12, 1 do
								if (i ~= 4 and i ~= 10) then
									local players = getPlayersInTeam(team[i])
									for k, v in ipairs(players) do
										if (isElement(v)) then
											outputChatBox("Ein Geldtransport ist auf dem Weg. Bitte halten Sie sich fern!", v,  255, 0, 0)
										end
									end
								end
							end
						end
					else
						showError(thePlayer, "Es tut uns leid, aber für einen Geldtransport haben Sie einen zu niedrigen Rang inne.\nBitte senden Sie uns einen Ihrer Vorgesetzten!")
					end
				else
					showError(thePlayer, "Wir übergeben unser Geld nur an vertrauenswürdige Beamte.\nBitte entfernen Sie sich wieder von diesem Ort!")
				end
			else
				showError(thePlayer, "Du bist nicht in Reichweite des Markers.")
			end
		else
			if (curtime["hour"] < 9) then
				showError(thePlayer, "Es ist nicht erlaubt, vor 9 Uhr einen Geldtransport zu starten.")
			elseif (curtime["hour"] > 21) then
				showError(thePlayer, "Es ist nicht erlaubt, nach 21 Uhr einen Geldtransport zu starten.")
			end
		end
	else
		showError(thePlayer, "Es wurde bereits ein Geldtransport gestartet.")
	end
end
addCommandHandler("mtrans", GTStartMoneyTransportNow, false, false)

local function GTOnEnterStartMarker(thePlayer)
	if (source == gtVehicleMarker) then
		local messageString = "Geldtransport"
		messageString = messageString .. "\nEs sind $ 100.000,-- zu transportieren."
		messageString = messageString .. "\nDie Kaution für den Transport beträgt $ 20.000,--."
		messageString = messageString .. "\n\nStarte den Transport mit /mtrans !"
		showError(thePlayer, messageString)
	end
end
addEventHandler("onPickupHit", getRootElement(), GTOnEnterStartMarker)










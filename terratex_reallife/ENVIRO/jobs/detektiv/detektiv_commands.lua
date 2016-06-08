function find_func(thePlayer, Command, toPlayerName)
    local canFind=false
    if(isBeamter(thePlayer))then
        if(isPedInVehicle(thePlayer))then
            if(table.hasValue(policeVehicles, getPedOccupiedVehicle(thePlayer)))then
                canFind = true
            end
        end
    end


	if (vioGetElementData(thePlayer, "job")== 6 and vioGetElementData(thePlayer, "fraktion") == 0) or canFind or vioGetElementData(thePlayer, "job") == 7 or (isBeamter(thePlayer) and vioGetElementData(thePlayer, "Innendienst")) or(vioGetElementData(thePlayer, "fraktion") == 8) then
		if (toPlayerName) then
			local toPlayer = getPlayerFromIncompleteName(toPlayerName)
			if (toPlayer) then
				if (vioGetElementData(thePlayer, stopFind)) then
                    outputChatBox(string.format("Der Spieler %s kann aufgrund eines Schutzes nicht gefunden werden.", getPlayerName(toPlayer)), thePlayer, 255, 0, 0)
                    return false
                end
                if not(vioGetElementData(thePlayer, "hasFind")) then
					if (vioGetElementData(toPlayer, "telefontoggle") == 0) then
						outputChatBox("Es wurde eine exakte Handyortung vorgenommen (rote Markierung)!", thePlayer, 255, 0, 0)
						local theBlip = createBlipAttachedTo(toPlayer, 0, 2, 0, 191, 255, 255, 0, 99999.0, thePlayer)
						setTimer(delete_find_func, 10000, 1, theBlip)
					else
						outputChatBox("Das Handy des Gesuchten ist aus! Eine ungefähre Ortung wurde durchgeführt!(rote Markierung)", thePlayer, 255, 0, 0)
						local xab = math.random(0, 200) - 100
						local yab = math.random(0, 200) - 100
						local px, py, pz = getElementPosition(toPlayer)
						px = px - xab - 50
						py = py - yab - 50
						area = createRadarArea(px, py, 100, 100, 0, 191, 255, 100, thePlayer)
						blip = createBlip(px, py, pz, 0, 3, 0, 191, 255, 255, 0, 9999999, thePlayer)
						setTimer(delete_find_func, 10000, 1, area)
						setTimer(delete_find_func, 10000, 1, blip)
					end
					vioSetElementData(thePlayer, "hasFind", true)
					setTimer(resetFind_func, 10000, 1, thePlayer)
				end
			else
				showError(thePlayer, "Dieser Spieler existiert nicht!")
			end
		else
			showError(thePlayer, "Dieser Spieler existiert nicht!")
		end
	else
		outputChatBox("Zur Nutzung müssen Beamte im Innendienst sein und Personen mit dem Job in keiner Fraktion", thePlayer, 255, 0, 0)
	end
end
addCommandHandler("find", find_func, false, false)

function resetFind_func(thePlayer)
	if(isElement(thePlayer))then
		vioSetElementData(thePlayer,"hasFind",false)
	end
end

function delete_find_func(theBlip)
	destroyElement(theBlip)
end









-- vioGetElementData(thePlayer,"lastHouse")

function sex_func(thePlayer,cmd,toPlayerName)
	if(toPlayerName)then
		local toPlayer=getPlayerFromIncompleteName(toPlayerName)
		if(toPlayer)then
			if (thePlayer ~= toPlayer) then
				if(vioGetElementData(thePlayer,"job")==16)then
					if(vioGetElementData(thePlayer,"lastHouse") or arePlayersInSameVehicle(thePlayer,toPlayer))then
						local p1x,p1y,p1z=getElementPosition(thePlayer)
						local p2x,p2y,p2z=getElementPosition(toPlayer)
						if(getDistanceBetweenPoints3D(p1x,p1y,p1z,p2x,p2y,p2z)<5)then
							setElementData(toPlayer,"sexAngebotVon",thePlayer)
							outputChatBox(string.format("Die Nutte %s hat dir Sex angeboten! (annehmen mit '/accept sex')", getPlayerName(thePlayer)),toPlayer)
							outputChatBox(string.format("Du hast dem Spieler %s Sex angeboten!", getPlayerName(toPlayer)),thePlayer)
						else
							showError(thePlayer,"Ihr beide seit nicht beeinander!")
						end
					else
						showError(thePlayer,"Sie müssen in einen Fahrzeug sein oder in einem Haus um Sex zu haben!")
					end
				elseif(vioGetElementData(toPlayer,"DBID")==vioGetElementData(thePlayer,"verheiratet"))then				
					if(vioGetElementData(thePlayer,"lastHouse") or arePlayersInSameVehicle(thePlayer,toPlayer))then
						local p1x,p1y,p1z=getElementPosition(thePlayer)
						local p2x,p2y,p2z=getElementPosition(toPlayer)
						if(getDistanceBetweenPoints3D(p1x,p1y,p1z,p2x,p2y,p2z)<5)then						
							setElementData(toPlayer,"sexAngebotVon",thePlayer)
							outputChatBox(string.format("Dein Ehepartner %s hat dir Sex angeboten! (annehmen mit '/accept sex')", getPlayerName(thePlayer)),toPlayer)
							outputChatBox(string.format("Du hast deinem Ehepartner %s Sex angeboten!", getPlayerName(toPlayer)),thePlayer)
						else
							showError(thePlayer,"Ihr beide seit nicht beeinander!")
						end
					else
						showError(thePlayer,"Sie müssen in einen Fahrzeug sein oder in einem Haus um Sex zu haben!")
					end
				else
					showError(thePlayer,"Du kannst kein Sex mit dieser Person haben!")
				end
			else
				showError(thePlayer,"Selbstbefriedigung ist zwar schön, befriedigt aber nicht so toll wie Sex mit einem Partner.\nSuch dir einen Partner.")
			end
		else
			showError(thePlayer,"Dieser Spieler existiert nicht!")
		end
	else
		showError(thePlayer,"Usage: /sex [Spielername]")
	end
end
addCommandHandler("sex",sex_func,false,false)

function arePlayersInSameVehicle(thePlayer,toPlayer)
	if(isPedInVehicle(thePlayer) and isPedInVehicle(toPlayer))then
		if(getPedOccupiedVehicle(thePlayer)==getPedOccupiedVehicle(toPlayer))then
			return true
		else
			return false
		end	
	else
		return false
	end
end









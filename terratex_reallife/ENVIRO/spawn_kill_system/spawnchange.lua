isSpawnChangeVehicle={[409]=true,[413]=true,[454]=true,[483]=true,[484]=true,[508]=true,[519]=true,[553]=true,[511]=true}

function spawnchange_func(thePlayer,Command,placestring,slotid)
	if(vioGetElementData(thePlayer,"fraktion"))then
		if(placestring=="fraktion")then
			if(vioGetElementData(thePlayer,"fraktion")>0)then
				if(not(slotid))then
					slotid="lspd"
				end
				if(string.lower(slotid)=="lvpd")then
					vioSetElementData(thePlayer,"spawnplace",109)	
					showError(thePlayer,"Dein Spawn wurde erfolgreich auf die LVPD Fraktionsbase gesetzt")			
				else
					vioSetElementData(thePlayer,"spawnplace",1)	
					showError(thePlayer,"Dein Spawn wurde erfolgreich auf die Fraktionsbase gesetzt")			
				end
			else
				showError(thePlayer,"Du bist in keiner Fraktion!")					
			end
		elseif(placestring=="street")then
			vioSetElementData(thePlayer,"spawnplace",0)
			showError(thePlayer,"Dein Spawn wurde erfolgreich auf den Rookiespawn (Spawn für Neulinge) verlegt!")			
		elseif(placestring=="house")then
			if(vioGetElementData(thePlayer,"hkey")~=0)then
				vioSetElementData(thePlayer,"spawnplace",2)
				showError(thePlayer,"Dein Spawn wurde erfolgreich in dein Haus / in deine Wohnung verlegt!")						
			else
				showError(thePlayer,"Du besitzt kein Haus und bist auch in keinem eingemietet!")	
			end
		elseif(placestring=="premium")then
			if(vioGetElementData(thePlayer,"premium")>0)then
				if(slotid)then
					local slot=tonumber(slotid)
					if(slot)then
						if isElement(vioGetElementData(thePlayer,"slot"..slot)) then
							if isSpawnChangeVehicle[getElementModel(vioGetElementData(thePlayer,"slot"..slot))] then
								vioSetElementData(thePlayer,"spawnplace",3)
								showError(thePlayer,"Dein Spawn wurde erfolgreich in dein Premiumfahrzeug verlegt!")	
								vioSetElementData(thePlayer,"PremiumSpawn",slot)
							else
								outputChatBox("Du musst eine SlotID angeben in der sich eines der folgenden Fahrzeuge befindet:!",thePlayer,255,0,0)	
								outputChatBox("Stretch, Pony, Tropic, Camper, Marquis, Journey, Shamal, Nevada, Beagle",thePlayer,255,0,0)								
							end
						else
							outputChatBox("Du musst eine SlotID angeben in der sich eines der folgenden Fahrzeuge befindet:!",thePlayer,255,0,0)	
							outputChatBox("Stretch, Pony, Tropic, Camper, Marquis, Journey, Shamal, Nevada, Beagle",thePlayer,255,0,0)							
						end
					else
						outputChatBox("Du musst eine SlotID angeben in der sich eines der folgenden Fahrzeuge befindet:!",thePlayer,255,0,0)	
						outputChatBox("Stretch, Pony, Tropic, Camper, Marquis, Journey, Shamal, Nevada, Beagle",thePlayer,255,0,0)					
					end
				else
					outputChatBox("Du musst eine SlotID angeben in der sich eines der folgenden Fahrzeuge befindet:!",thePlayer,255,0,0)	
					outputChatBox("Stretch, Pony, Tropic, Camper, Marquis, Journey, Shamal, Nevada, Beagle",thePlayer,255,0,0)	
				end
			else
				outputChatBox("Du hast kein Premium!",thePlayer,0,255,0)
			end
		elseif(placestring=="job")then
			if(vioGetElementData(thePlayer,"premium")>0)then
				if(vioGetElementData(thePlayer,"job")>0)then
					vioSetElementData(thePlayer,"spawnplace",5)
					showError(thePlayer,"Dein Spawn wurde erfolgreich auf dein Job verlegt!")		
				end			
			else
				showError(thePlayer,"für /Spawnchange job benötigst du Premium!")
			end
		elseif(placestring=="parkhaus")then		
			vioSetElementData(thePlayer,"spawnplace",4)
			showError(thePlayer,"Dein Spawn wurde erfolgreich an das Parkhaus verlegt!")			
		else
			showError(thePlayer,"Usage: /spawnchange [placename] \nPlacenamen: street,fraktion,house,parkhaus\nFür Premiumuser auch: job oder /spawnchange premium slotid - um bei einen Möglichen Fahrzeug zu spawnen! DIe Liste der Fahrzeuge erhälst du bei eingabe ohne SLotID ")			
		end
	end

end
addCommandHandler("spawnchange",spawnchange_func,false,false)









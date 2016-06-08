function anwalt_func(thePlayer,command,CopName,VerbrecherName)
	if(vioGetElementData(thePlayer,"job")==9)then
		if(CopName and VerbrecherName)then
			local cop=getPlayerFromIncompleteName(CopName)
			local Verbrecher=getPlayerFromIncompleteName(VerbrecherName)
			if(cop and Verbrecher)then
				if(isBeamter(cop) and vioGetElementData(Verbrecher,"knastzeit")>0)then
					local cx,cy,cz=getElementPosition(cop)
					local px,py,pz=getElementPosition(thePlayer)
					if(getDistanceBetweenPoints3D(px,py,pz,cx,cy,cz)<10)then
						outputChatBox(string.format("%s bittet um eine Genehmigung, den Verbrecher %s aus den Knast zuholen", getPlayerName(thePlayer), getPlayerName(Verbrecher)),cop,255,0,0)
						outputChatBox("Du kannst die Genehmigung mit /accept anwalt geben",cop,255,0,0)
						outputChatBox(string.format("Du hast %s um eine Genehmigung gebeten", getPlayerName(cop)),thePlayer,255,0,0)
						vioSetElementData(cop,"anwaltWhoRequested",thePlayer)
						vioSetElementData(cop,"thePlayerWhoWillBeOutOfKnast",Verbrecher)			
					else
						showError(thePlayer,"Der Beamte ist nicht in deiner Nähe!")				
					end	
				else
					showError(thePlayer,"Der Beamte ist entweder kein Beamter oder der Verbrecher sitzt nicht mehr im Knast!")				
				end
			else
				showError(thePlayer,"Einer der Spieler existiert nicht!")
			end
		else
			showError(thePlayer,"Nutzung: /anwalt [CopName] [VerbrecherName]")
		end	
	end
end
addCommandHandler("anwalt",anwalt_func)

function anwalt_free_func(thePlayer,command,theVerbrecherName)
	if(vioGetElementData(thePlayer,"job")==9)then
		if(theVerbrecherName)then
			local Verbrecher=getPlayerFromIncompleteName(theVerbrecherName)
			if(Verbrecher)then
				if(vioGetElementData(Verbrecher,"knastzeit")>0)then
					local cx,cy,cz=getElementPosition(Verbrecher)
					local px,py,pz=getElementPosition(thePlayer)
					if(getDistanceBetweenPoints3D(px,py,pz,cx,cy,cz)<30)then					
						if(vioGetElementData(thePlayer,"AnwaltCanGetOut")==Verbrecher)then
							outputChatBox("Du hast den Verbrecher erfolgreich aus dem Knast geholt",thePlayer,255,0,0)
							vioSetElementData(Verbrecher,"knastzeit",1)						
							outputChatBox(string.format("Dank dem Anwalt %s bist du in einer Minute Frei", getPlayerName(thePlayer)),Verbrecher,255,0,0)
							vioSetElementData(thePlayer,"AnwaltCanGetOut",nil)
						else
							showError(thePlayer,"Du hast keine Genehmigung um diese Person aus dem Knast zuholen!")
							showError(thePlayer,"Frag einen Beamten mit /anwalt [CopName] [VerbrecherName]!")								
						end
					else
						showError(thePlayer,"Der Verbrecher ist nicht in deiner Nähe!")				
					end					
				else
					showError(thePlayer,"Der Verbrecher sitzt nicht mehr im Knast!")				
				end
			else
				showError(thePlayer,"Der Spieler existiert nicht!")
			end
		else
			showError(thePlayer,"Nutzung: /free [VerbrecherName]")
		end
	end		
end
addCommandHandler("free",anwalt_free_func)









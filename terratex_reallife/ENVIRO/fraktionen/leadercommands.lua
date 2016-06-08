

function setFraktion(thePlayer,cmd,toPlayerName,toFraktion,theRang)
	
    if(isAdminLevel(thePlayer,2))then
		if(toPlayerName and toFraktion)then
			local toPlayer=getPlayerFromIncompleteName(toPlayerName)
			if(toPlayer)then
				if(tonumber(toFraktion))then
					toFraktion=tonumber(toFraktion)
					if (toFraktion == 8) then
						if not (isAdminLevel(thePlayer, 3)) then
						   showError(thePlayer, "Du hast keine Berechtigung für diese Fraktion")
						   return false
						end
					end
					if(fraktionbezeichner[toFraktion])then
						if(tonumber(theRang))then	
							theRang=tonumber(theRang)
							if(theRang==0)then
								vioSetElementData(toPlayer,"fraktion",0)
								vioSetElementData(toPlayer,"fraktionsrang",0)
								vioSetElementData(toPlayer,"rechte_AllLeader",0) 
								outputChatBox(string.format("%s ist nun Zivilist", getPlayerName(toPlayer)),thePlayer,0,255,0)
								outputChatBox(string.format("%s hat dich zum Zivilisten gemacht", getPlayerName(toPlayer)),thePlayer,0,255,0)	
								setPlayerTeam (toPlayer,nil)								
							elseif(theRang>0 and theRang<7)then
								vioSetElementData(toPlayer,"fraktion",toFraktion)
								vioSetElementData(toPlayer,"fraktionsrang",theRang)
								vioSetElementData(toPlayer,"rechte_AllLeader",0) 
								setPlayerTeam (toPlayer,team[toFraktion])			
								outputChatBox(string.format("%s ist nun %s (Rang:%s) der %s", getPlayerName(toPlayer), fraktionsrange[toFraktion][theRang], theRang, fraktionbezeichner[toFraktion]),thePlayer,0,255,0)
								outputChatBox(string.format("%s hat dich zum %s (Rang:%s) der %s gemacht", getPlayerName(toPlayer), fraktionsrange[toFraktion][theRang], theRang, fraktionbezeichner[toFraktion]),thePlayer,0,255,0)
							else
								showError(thePlayer,"Dieser Rang existiert nicht!")
							end
						else
							if(toFraktion==0)then
								vioSetElementData(toPlayer,"fraktion",0)
								vioSetElementData(toPlayer,"fraktionsrang",0)	
								vioSetElementData(toPlayer,"rechte_AllLeader",0) 
								setPlayerTeam (toPlayer,nil)								
								outputChatBox(string.format("%s ist nun Zivilist", getPlayerName(toPlayer)),thePlayer,0,255,0)
								outputChatBox(string.format("%s hat dich zum Zivilisten gemacht", getPlayerName(toPlayer)),thePlayer,0,255,0)							
							else
								vioSetElementData(toPlayer,"fraktion",toFraktion)
								vioSetElementData(toPlayer,"fraktionsrang",6)	
								vioSetElementData(toPlayer,"rechte_AllLeader",0) 
								setPlayerTeam (toPlayer,team[toFraktion])								
								outputChatBox(string.format("%s ist nun Leader der %s", getPlayerName(toPlayer), fraktionbezeichner[toFraktion]),thePlayer,0,255,0)
								outputChatBox(string.format("%s hat dich zum Leader der %s gemacht", getPlayerName(toPlayer), fraktionbezeichner[toFraktion]),thePlayer,0,255,0)							
							end
						end		
					else
						showError(thePlayer,"FEHLER: Es existiert keine Fraktion mit dieser ID")
					end	
				else
					showError(thePlayer,"Nutzung: /setfraktion Nickname Fraktion Rang (Fehlerhafte Fraktion)")
				end
			else
				showError(thePlayer,"Nutzung: /setfraktion Nickname Fraktion Rang (Fehlerhafte Fraktion)")
			end
		else
			showError(thePlayer,"Nutzung: /setfraktion Nickname Fraktion Rang")
		end	
	end
end
addCommandHandler("setfraktion",setFraktion,false,false)

function invite_func(theMaker,Command,thePlayerName)
	thePlayer=getPlayerFromIncompleteName(thePlayerName)
	if(vioGetElementData(theMaker,"fraktionsrang")==6 or vioGetElementData(theMaker,"rechte_AllLeader") == 1)then
		if(thePlayer==false) or not(isPlayerLoggedIn(thePlayer)) then
			outputChatBox("Dieser Spieler existiert nicht",theMaker,255,0,0)
		else
			if(vioGetElementData(thePlayer,"fraktion")==0)then
				vioSetElementData(thePlayer,"fraktion",vioGetElementData(theMaker,"fraktion"))
				vioSetElementData(thePlayer,"fraktionsrang",1)
				setPlayerTeam (thePlayer,team[vioGetElementData(theMaker,"fraktion")])
				local FraktionsID=vioGetElementData(theMaker,"fraktion")
				outputChatBox(string.format("Du wurdest von %s zum %s der Fraktion %s gemacht!", getPlayerName(theMaker), fraktionsrange[FraktionsID][1], fraktionbezeichner[FraktionsID]),thePlayer,0,255,0)
				outputChatBox(string.format("Du hast %s zum %s der Fraktion %s gemacht!", getPlayerName(thePlayer), fraktionsrange[FraktionsID][1], fraktionbezeichner[FraktionsID]),theMaker,0,255,0)
			else
				outputChatBox("Dieser Spieler ist bereits in einer Fraktion",theMaker,255,0,0)
			
			end	
		end
	end
end
addCommandHandler("invite",invite_func,false,false)

function uninvite_func(theMaker,Command,thePlayerName)
	thePlayer=getPlayerFromIncompleteName(thePlayerName)
	if(vioGetElementData(theMaker,"fraktionsrang")==6 or vioGetElementData(theMaker,"rechte_AllLeader") == 1)then
		if(thePlayer==false) or not(isPlayerLoggedIn(thePlayer)) then
			outputChatBox("Dieser Spieler existiert nicht",theMaker,255,0,0)
		else
		if(vioGetElementData(thePlayer,"fraktion")==vioGetElementData(theMaker,"fraktion"))then
			vioSetElementData(thePlayer,"spawnplace",0)
			vioSetElementData(thePlayer,"fraktion",0)
			vioSetElementData(thePlayer,"fraktionsrang",0)
			vioSetElementData(thePlayer,"FrakSkin",0)			
			vioSetElementData(thePlayer,"rechte_AllLeader",0) 
			setElementModel(thePlayer,vioGetElementData(thePlayer,"skinid"))
			takeAllWeapons ( thePlayer )
			outputChatBox(string.format("Du wurdest von %s aus der Fraktion geschmissen!", getPlayerName(theMaker)),thePlayer,0,255,0)
			outputChatBox(string.format("Du hast %s aus der Fraktion geschmissen!", getPlayerName(thePlayer)),theMaker,0,255,0)
			setPlayerTeam (thePlayer,nil)
		else
		
			outputChatBox("Dieser Spieler ist nicht in deiner Fraktion",theMaker,255,0,0)
		
		end	
		end
	end
end
addCommandHandler("uninvite",uninvite_func,false,false)

function giverank_func(theMaker,Command,thePlayerName,theRank)
	thePlayer=getPlayerFromIncompleteName(thePlayerName)
	theRank=tonumber(theRank)
	if(vioGetElementData(theMaker,"fraktionsrang")==6 or vioGetElementData(theMaker,"rechte_AllLeader") == 1) and theRank then
		if(thePlayer==false) or not(isPlayerLoggedIn(thePlayer)) then
			outputChatBox("Dieser Spieler existiert nicht",theMaker,255,0,0)
		else
		if(vioGetElementData(thePlayer,"fraktion")==vioGetElementData(theMaker,"fraktion"))then
			if(theRank<1) or (theRank>6)then
				outputChatBox("Dies ist ein ungueltiger Rang!",theMaker,255,0,0)
			else
			local FraktionsID=vioGetElementData(theMaker,"fraktion")
			vioSetElementData(thePlayer,"fraktionsrang",theRank)
			takeAllWeapons ( thePlayer )
			outputChatBox(string.format("Du wurdest von %s zum %s befördert!", getPlayerName(theMaker), fraktionsrange[FraktionsID][theRank]),thePlayer,0,255,0)
			outputChatBox(string.format("Du hast %s zum %s befördert!", getPlayerName(thePlayer), fraktionsrange[FraktionsID][theRank]),theMaker,0,255,0)
			end				
		else
			outputChatBox("Dieser Spieler ist nicht in deiner Fraktion",theMaker,255,0,0)
		end			
		end
	end
end
addCommandHandler("giverank",giverank_func,false,false)

function giveLeaderRights(thePlayer,cmd,toPlayerPart)
	if(vioGetElementData(thePlayer,"fraktionsrang")==6)then
		if(toPlayerPart)then
			local toPlayer=getPlayerFromIncompleteName(toPlayerPart)
			if(toPlayer)then
				if(vioGetElementData(thePlayer,"fraktion")==vioGetElementData(toPlayer,"fraktion"))then
					vioSetElementData(toPlayer,"rechte_AllLeader",1) 
					outputChatBox("Dein Leader hat dir die Rechte Invite / Uninvite / GiveRank gegeben!",toPlayer)
					outputChatBox("Du hast dem Spieler die Rechte Invite / Uninvite / GiveRank gegeben!",thePlayer)
				else
					showError(thePlayer,"Dieser Spieler ist nicht in deiner Fraktion!")
				end
			else
				showError(thePlayer,"Dieser Spieler existiert nicht")
			end
		else
			showError(thePlayer,"Dieser Spieler existiert nicht")		
		end
	end
end
addCommandHandler("setrechte",giveLeaderRights,false,false)

function takeLeaderRights(thePlayer,cmd,toPlayerPart)
	if(vioGetElementData(thePlayer,"fraktionsrang")==6)then
		if(toPlayerPart)then
			local toPlayer=getPlayerFromIncompleteName(toPlayerPart)
			if(toPlayer)then
				if(vioGetElementData(thePlayer,"fraktion")==vioGetElementData(toPlayer,"fraktion"))then
					vioSetElementData(toPlayer,"rechte_AllLeader",0) 
					outputChatBox("Dein Leader hat dir die Rechte Invite / Uninvite / GiveRank entzogen!",toPlayer)
					outputChatBox("Du hast dem Spieler die Rechte Invite / Uninvite / GiveRank entzogen!",thePlayer)
				else
					showError(thePlayer,"Dieser Spieler ist nicht in deiner Fraktion!")
				end
			else
				showError(thePlayer,"Dieser Spieler existiert nicht")
			end
		else
			showError(thePlayer,"Dieser Spieler existiert nicht")		
		end
	end
end
addCommandHandler("takerechte",takeLeaderRights,false,false)











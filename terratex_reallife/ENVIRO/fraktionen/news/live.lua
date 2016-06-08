--commands: /live start|stop|invite|uninvite|setleader|help|cancel
-- elementData: isInNewsLive, isInvitetToNewsLive
-- invite und /accept live nur bei weite bis zu 20 Metern
livePlayers={}
liveLeader=nil

function live_func(thePlayer,Command,theCommand,theArgument)
	if(theCommand)then
		if(vioGetElementData(thePlayer,"fraktion")==3)then
			if(theCommand=="help")then
				outputChatBox("/live - Commands",thePlayer)
				outputChatBox("/live start(stop) - Startet(Stoppt) ein Livegespräch",thePlayer)
				outputChatBox("/live (un)invite [Spielername] - Läd einen Spieler in das Livegespräch ein!",thePlayer)
				outputChatBox("/live setleader [Spielername] - setzt einen anderen Newsreporter als Liveleiter!",thePlayer)
				outputChatBox("/live cancel - User kann damit das Livegespräch verlassen!",thePlayer)		
			elseif(liveLeader)then
					if(theCommand=="stop")then
						for theKey,theLiveMember in ipairs(livePlayers) do
							outputChatBox("Der Leiter hat das Livegespräch verlassen, daher wurde das Livegespräch beendet!",theLiveMember,255,150,150)
							vioSetElementData(theLiveMember,"isInNewsLive",false)
						end
						livePlayers={}		
						liveLeader=nil				
					end
					if(theCommand=="start")then
						showError(thePlayer,"Es laeuft bereits ein Livegespraech!")
					end
					
					if(theCommand=="invite")then
						if(theArgument)then
							local player=getPlayerFromIncompleteName(theArgument)
							if(player)or(player==thePlayer)then				
								if(vioGetElementData(player,"isInNewsLive")==false)then
									local px,py,pz=getElementPosition(thePlayer)
									local ix,iy,iz=getElementPosition(player)
									local dis=getDistanceBetweenPoints3D(px,py,pz,ix,iy,iz)
									if(dis<20)then
										vioSetElementData(player,"isInviteToNewsLive",true)										
										outputChatBox("Du wurdest in das Livegspräch eingeladen! annehmen mit /accept live",player,255,150,150)
										outputChatBox("Du hast den Spieler erfolgreich in das Livegespräch eingeladen!",thePlayer,255,150,150)
									else
										showError(thePlayer,"Dieser Spieler ist nicht in deiner Nähe!")								
									end
								else				
									showError(thePlayer,"Dieser Spieler ist bereits im Livegespräch!")
								end
							else
								showError(thePlayer,"Dieser Spieler existiert nicht!")
							end					
						else
							showError(thePlayer,"Usage: /live uninvite [Spielername]")
						end				
								
					end
					
					if(theCommand=="uninvite")then
						if(theArgument)then
							local player=getPlayerFromIncompleteName(theArgument)
							if(player)then				
								if(vioGetElementData(player,"isInNewsLive"))then
									table.deletevalue(livePlayers,player)
									vioSetElementData(player,"isInNewsLive",false)
									outputChatBox("Du wurdest aus dem Livegspräch entfernt!",player,255,150,150)
									outputChatBox("Du hast den Spieler erfolgreich aus dem Livegespräch entfernt!",thePlayer,255,150,150)
								else				
									showError(thePlayer,"Dieser Spieler ist nicht im Livegespräch!")
								end
							else
								showError(thePlayer,"Dieser Spieler existiert nicht!")
							end					
						else
							showError(thePlayer,"Usage: /live uninvite [Spielername]")
						end				
					
					end
					
					if(theCommand=="setleader")then
						if(theArgument)then
							local player=getPlayerFromIncompleteName(theArgument)
							if(player)then
								if(vioGetElementData(player,"fraktion")==3)then
									liveLeader=player
									for theKey,theLiveMember in ipairs(livePlayers) do
										outputChatBox(string.format("%s ist nun Leiter des Gesprächs!", getPlayerName(player)),theLiveMember,255,150,150)
									end	
									outputChatBox("Du wurdest gerade als Leiter des Livegespräches gesetzt!",player,255,150,150)
									outputChatBox("Du hast die Leitung erfolgreich übergeben!",thePlayer,255,150,150)
								else
									showError(thePlayer,"Dieser Spieler ist kein NEwsreporter!")	
								end
							else
								showError(thePlayer,"Dieser Spieler existiert nicht!")
							end					
						else
							showError(thePlayer,"Usage: /live setleader [Spielername]")
						end				
					end
							
			else
				if(theCommand=="start")then
					liveLeader=thePlayer
					outputChatBox("Das Livegspraech wurde gestartet!",thePlayer,255,150,150)				
				else
					showError(thePlayer,"Es lauft kein Livegespraech!")
				end			
			end	
			
		else
			if(theCommand=="cancel")then
				if(vioGetElementData(thePlayer,"isInNewsLive"))then
					vioSetElementData(thePlayer,"isInNewsLive",false)
					table.deletevalue(livePlayers,thePlayer)
					showError(thePlayer,"Du hast das Livegespraech verlassen!")
					outputChatBox(string.format("Der Spieler %s hat das Livegespräch verlassen!", getPlayerName(thePlayer)),liveLeader,255,150,150)
				else
					showError(thePlayer,"Du befindest dich in keinen Livegespraech!")
				end
			end--
		end
	else
		showError(thePlayer,"Usage: /live start|stop|invite|uninvite|setleader|help|cancel")
	end
end
addCommandHandler("live",live_func,false,false)


function onLiveDisconnect()
	if(liveLeader==source)then
		for theKey,theLiveMember in ipairs(livePlayers) do
			outputChatBox("Der Leiter hat das Livegespräch verlassen, daher wurde das Livegespräch beendet!",theLiveMember,255,150,150)
			vioSetElementData(theLiveMember,"isInNewsLive",false)
		end
		livePlayers={}		
		liveLeader=nil		
	elseif(vioGetElementData(source,"isInNewsLive"))then
		table.deletevalue(livePlayers,source)
		outputChatBox(string.format("Der Spieler %s hat das Livegespräch verlassen!", getPlayerName(source)),liveLeader,255,150,150)
	end
end
addEventHandler("onPlayerQuit",getRootElement(),onLiveDisconnect)












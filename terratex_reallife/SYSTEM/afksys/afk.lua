

function afk_func(thePlayer)
	
	if(vioGetElementData(thePlayer,"afk_status")==0)then
		vioSetElementData(thePlayer,"afk_status",1)
		setPlayerNametagText ( thePlayer, "[AFK]-"..getPlayerName(thePlayer) )
		outputChatBox(string.format("Der Spieler %s ist jetzt AFK (/afk).", getPlayerName(thePlayer)))
		outputChatBox("Du bist AFK. Der AFK Modus kann mit /afk wieder aufgehoben werden!",thePlayer,255,0,0)
		vioSetElementData(thePlayer,"afk_end_status",true)
		setTimer(end_afk_check,10000,1,thePlayer)
        vioSetElementData(thePlayer,"playTime_formated","AFK")
		if(vioGetElementData(thePlayer,"Innendienst"))then
			vioSetElementData(thePlayer,"Innendienst",false)
			local message=string.format("!!!INNENDIENST!!! %s hat sich im Innendienst abgemeldet (/afk)!!!INNENDIENST!!!", getPlayerName(thePlayer))
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[1])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[5])) do
								outputChatBox( message,thePlayers,255,0,0)
						end	
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[7])) do
								outputChatBox( message,thePlayers,255,0,0)
						end
						for theKey,thePlayers in ipairs(getPlayersInTeam(team[9])) do
								outputChatBox( message,thePlayers,255,0,0)
						end		

		end
	else
		outputChatBox("Dein AFK-Modus wurde beendet!",thePlayer,255,0,0)
		vioSetElementData(thePlayer,"afk_status",0)		
		setPlayerNametagText ( thePlayer, getPlayerName(thePlayer) )
	end

end
addCommandHandler("afk",afk_func,false,false)

function end_afk_check(thePlayer)
	if(isElement(thePlayer))then
		vioSetElementData(thePlayer,"afk_end_status",false)
	end
end



addEvent("resetAFKevent",true)
function resetAFKTimer()
	local thePlayer=source
	if(thePlayer)then
		vioSetElementData(thePlayer,"afk_timer",0)
		if(vioGetElementData(thePlayer,"afk_status")==1)and not(vioGetElementData(thePlayer,"afk_end_status"))then
			vioSetElementData(thePlayer,"afk_status",0)
			setPlayerNametagText ( thePlayer, getPlayerName(thePlayer) )
			outputChatBox("Dein AFK-Modus wurde beendet da du eine Aktion ausgeführt hast!",thePlayer,255,0,0)
		end
	end
end
addEventHandler("onPlayerCommand",getRootElement(),resetAFKTimer)
addEventHandler("onPlayerChat",getRootElement(),resetAFKTimer)
addEventHandler("resetAFKevent",getRootElement(),resetAFKTimer)















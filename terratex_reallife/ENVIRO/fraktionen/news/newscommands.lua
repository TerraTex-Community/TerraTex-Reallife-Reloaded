function news_func(thePlayer,Command,theText,...)
	if(theText)then
		if(vioGetElementData(thePlayer,"fraktion")==3)then
			if(isInNewsVehicle(thePlayer) or isNearNewsVehicle(thePlayer))then
				local message=theText.." "..table.concat({...}," ")
				outputChatBox(string.format("Newsreporter %s: %s", getPlayerName(thePlayer), message),getRootElement(),200,100,0)			
			else	
				showError(thePlayer,"Du bist nicht in der nähe eines NewsVans!")
			end
		else
			showError(thePlayer,"Du bist kein Newsreporter!")
		end	
	else
		showError(thePlayer,"/news TEXT")
	end
end
addCommandHandler("news",news_func,false,false)
addCommandHandler("n",news_func,false,false)

function createInfoPickupForNews()
	local pickele=createPickup(1026.4248046875,1031.6865234375,11,3,1239,5000)
	addEventHandler("onPickupHit",pickele,InfoPickupForNews,false)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createInfoPickupForNews)

function InfoPickupForNews(player)
	outputChatBox("AD Gutscheine weitergeben mit '/adgs [Anzahl] [Name]' (Können nur News ab Rang 5)",player,255,0,0)
	outputChatBox("Ein Gutschein gilt eine Woche und ermöglicht eine Woche kostenloses AD senden!",player,255,0,0)
	outputChatBox("Wann der Gutschein aktiviert wird, entscheidet der Besitzer über das Inventar!",player,255,0,0)	
end

function adgs_cmd(thePlayer,cmd,anzahl,toplayerpart)
	if(vioGetElementData(thePlayer,"fraktion")==3 and vioGetElementData(thePlayer,"fraktionsrang")>4)then
		anzahl=tonumber(anzahl)
		if(anzahl)then
			local toPlayer=getPlayerFromIncompleteName(toplayerpart)
			if(toPlayer)then
				vioSetElementData(toPlayer,"adgutscheine",vioGetElementData(toPlayer,"adgutscheine")+anzahl)
				outputChatBox(string.format("Dir wurden von %s %s AD-Gutscheine überreicht!", getPlayerName(thePlayer), anzahl),toPlayer,255,0,0)
				outputChatBox(string.format("Du hast %s %s AD-Gutscheine gegeben!", getPlayerName(toPlayer), anzahl),thePlayer,255,0,0)			
			else
				outputChatBox("Nutzung: '/adgs [Anzahl] [Name]'",thePlayer,255,0,0)
			end		
		else
			outputChatBox("Nutzung: '/adgs [Anzahl] [Name]'",thePlayer,255,0,0)
		end
	end
end
addCommandHandler("adgs",adgs_cmd,false,false)

function StopFindPlayer(thePlayer, cmd, OnOff)
    if (vioGetElementData(thePlayer, "fraktion") == 3 or isAdminLevel(thePlayer, 3)) then
        if not (vioGetElementData(thePlayer, stopFind)) then
            vioSetElementData(thePlayer, stopFind, true)
            outputChatBox("stopFind ist nun eingeschalten.", thePlayer, 255, 0, 0)
        else
            vioSetElementData(thePlayer, stopFind, false)
            outputChatBox("stopFind ist nun ausgeschalten.", thePlayer, 255, 0, 0)
        end
    else
        outputChatBox("Du gehörst nicht der News Fraktion an.", thePlayer, 255, 0, 0)
    end
end
addCommandHandler("stopfind", StopFindPlayer, false, false)









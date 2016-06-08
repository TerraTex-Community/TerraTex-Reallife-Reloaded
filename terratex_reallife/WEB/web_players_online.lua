function web_getPlayerList()
	local playerList={}
	for theKey,thePlayer in ipairs(getElementsByType("player"))do
		if(vioGetElementData(thePlayer,"playtime"))then
			local player={}
			player["time"]=vioGetElementData(thePlayer,"playtime")
			player["nickname"]=getPlayerName(thePlayer)
			player["fraktion"]=vioGetElementData(thePlayer,"fraktion")
			table.insert(playerList,player)
		end
	end
	return playerList

end

function web_getSlots()

	return getMaxPlayers ()

end









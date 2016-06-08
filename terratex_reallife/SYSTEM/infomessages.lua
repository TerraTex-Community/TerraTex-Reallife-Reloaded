function messageA()
	local players=getElementsByType("player")
	for theKey,thePlayer in ipairs(players) do
		if(vioGetElementData(thePlayer,"playtime"))then
			if((vioGetElementData(thePlayer,"playtime")/60)<25)then
				outputChatBox("Infomessage fuer Neuanfaenger:",thePlayer,255,255,0)
				outputChatBox("Besuche auch unser Forum: "..config["maindomain"],thePlayer,255,255,0)
				outputChatBox("Komm doch ebenfals auf unseren Teamspeak3 vorbei: "..config["teamspeak"],thePlayer,255,255,0)		
			end	
			outputChatBox("Die Hilfen und allgemeinen Informationen (z.B. Regeln) des Servers findest du unter F1!",thePlayer,255,255,0)	
		end
	end
	setTimer(messageB,1800000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),messageA)


function messageB()
	local players=getElementsByType("player")
	for theKey,thePlayer in ipairs(players) do
		if(vioGetElementData(thePlayer,"playtime"))then
			if((vioGetElementData(thePlayer,"playtime")/60)<25)then
				outputChatBox("Infomessage fuer Neuanfaenger:",thePlayer,255,255,0)
				outputChatBox("Du suchst eine Telefonummer? Ruf die Auskunft an: /call 11880",thePlayer,255,255,0)
				outputChatBox("Bei Fragen und Problemen wende dich an unsere Admins: /report ",thePlayer,255,255,0)		
				outputChatBox("eine Liste der Admins die Online sind erhälst du mit /admins",thePlayer,255,255,0)	
				outputChatBox("eine Liste mit allen Service Telefonnumern erhälst du mit /service",thePlayer,255,255,0)					
			end	
			outputChatBox("Die Regeln des Servers findest du unter F1 und weitere unter /rules!",thePlayer,255,255,0)	
		end
	end
	setTimer(messageC,1800000,1)
end

function messageC()
	local players=getElementsByType("player")
	for theKey,thePlayer in ipairs(players) do
		if(vioGetElementData(thePlayer,"playtime"))then
			if((vioGetElementData(thePlayer,"playtime")/60)<25)then
				outputChatBox("Infomessage fuer Neuanfaenger:",thePlayer,255,255,0)
				outputChatBox("Nutze Alt-Gr um das Klicksystem zu Öffnen und Schließen!",thePlayer,255,255,0)
				outputChatBox("Nutze X und L um Licht und Motor an zu machen!",thePlayer,255,255,0)	
				outputChatBox("Rufe mit F11 die Karte auf um dich besser zu orientieren!",thePlayer,255,255,0)				
			end	
			outputChatBox("Die Regeln des Servers findest du unter F1 und weitere unter /rules!",thePlayer,255,255,0)	
		end
	end
	setTimer(messageA,1800000,1)
end












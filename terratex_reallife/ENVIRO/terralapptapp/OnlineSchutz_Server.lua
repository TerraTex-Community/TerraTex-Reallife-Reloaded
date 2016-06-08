local preis = 5000
function OnlineSchutz_BuyOnlineSchutz()
	local dreissigTage = 2592000
	local time = getRealTime()
	if (getPlayerBank(source) >= preis) then
		changePlayerBank(source, -preis, "sonstiges", string.format("30 Tage Online Schutz.", preis))
		if (vioGetElementData(source, "onlineschutzuntil") < time.timestamp) then
			dreissigTage = dreissigTage + time.timestamp
			vioSetElementData(source, "onlineschutzuntil", (dreissigTage))
		else
			vioSetElementData(source, "onlineschutzuntil", vioGetElementData(source, "onlineschutzuntil") + dreissigTage)
		end
		outputChatBox("Dir wurden 30 Tage OnlineSchutz hinzugefügt.", source, 0, 255, 0)
	else
		outputChatBox("Du hast leider nicht genug Geld auf Deinem Konto.", source, 0, 255, 0)
	end
	triggerClientEvent(source, "osBuyOnlineSchutzClient", source, true)
end
addEvent("osBuyOnlineSchutzServer", true)
addEventHandler("osBuyOnlineSchutzServer", getRootElement(), OnlineSchutz_BuyOnlineSchutz)









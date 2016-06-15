addEvent("BuyTapp", true)
function BuyTapp_func(price, theTapp)
	if (getPlayerMoney(source) < price) then
		outputChatBox("Du hast nicht genug Geld!", source, 255, 0, 0)
	else
		local tapptable = vioGetElementData(source, "tappapps")
		if (tonumber(tapptable[theTapp]) == 1) then
			outputChatBox("Du besitzt diese Tapp bereits!", source, 255, 0, 0)
		else
			MySql.helper.update("user_tapps", { [theTapp] = 1 }, { Nickname = getPlayerName(source)});
			tapptable[theTapp] = 1
            changePlayerMoney(source,-price,"sonstiges","Tappkauf")
			outputChatBox(string.format("Du hast die Tapp %s gekauft, zum Starten die TerraLappTapp neustarten!", theTapp), source, 0, 255, 0)
			if (theTapp == "OnlineSchutz") then
				-- 30 Tage Online Schutz hinzufügen
                local time=getRealTime()
                local dreissigTage=30*24*60*60
                if (vioGetElementData(source, "onlineschutzuntil") < time.timestamp) then
                    dreissigTage = dreissigTage + time.timestamp
                    vioSetElementData(source, "onlineschutzuntil", (dreissigTage))
                else
                    vioSetElementData(source, "onlineschutzuntil", vioGetElementData(source, "onlineschutzuntil") + dreissigTage)
                end
				outputChatBox("Dir wurden 30 Tage OnlineSchutz hinzugefügt.", source, 0, 255, 0)
			end
		end
	end	
end
addEventHandler("BuyTapp", getRootElement(), BuyTapp_func)

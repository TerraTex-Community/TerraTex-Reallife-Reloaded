function createWeihnachtsbaumIcon()
	local icon=createPickup(1489.7138671875,-1608.7177734375,14.039297103882,"cylinder",2.0)
	addEventHandler("onClientPickupHit",icon,hitWeihnachtsPickup)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),createWeihnachtsbaumIcon)


function hitWeihnachtsPickup(thePlayer)
		if(thePlayer==getLocalPlayer())then
			if(tonumber(getElementData(getLocalPlayer(),"geschenk"))>0 and not(isPedInVehicle(thePlayer)))then
			
				askCreate("Fahrzeuggutscheineinlösung", "Ja!", "Nein!", "Willst du einen Gutschein zu einem Fahrzeug (Überraschung) umwandeln?", wantAKart, false)
			
			else
				outputChatBox("Hier kannst du dein Fahrzeuggeschenk abholen, den du zu jedem Advent, Heiligabend oder an den Weihnachsfeiertagen bekommen kannst!",166,0,166)
				outputChatBox("Adventskalernder: Man bekommt täglich 19:30 Uhr ein Geschenk!",166,0,0)
				outputChatBox("Advent Advent: zu jedem Advent, Heiligabend oder an den Weihnachsfeiertagen werden größere Geschenke verschenkt!",166,0,166)
				outputChatBox(config["communityname"].." wünscht frohe Weihnachten!",166,0,166)
			end
		end
end

function wantAKart()
	triggerServerEvent("wantAKart_Event",getLocalPlayer())
end









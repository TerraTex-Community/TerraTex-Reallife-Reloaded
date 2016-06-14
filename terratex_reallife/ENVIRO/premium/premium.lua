function premium_func(thePlayer)
	local time=getRealTime()
	local nickname=getPlayerName(thePlayer)
	local premiumOutTime = MySql.helper.getValueSync("user_premium", "PremiumUntil", {Name = nickname}) - time.timestamp;
	local hasPremGutSchein = MySql.helper.getValueSync("user_premium", "PremiumGutScheine", {Name = nickname});
	triggerClientEvent(thePlayer,"showPremiumInfoGUI",thePlayer,premiumOutTime,hasPremGutSchein)
end
addCommandHandler("premium",premium_func,false,false)

function timestamp_func(thePlayer)
	local time=getRealTime()
	outputChatBox(string.format("Es ist jetzt %s:%s Uhr und %s Sekunden", time.hour, time.minute, time.second),thePlayer,0,255,0)
	outputChatBox(string.format("Heute ist der %s.%s.%s", time.monthday, (time.month+1), (1900+time.year)),thePlayer,0,255,0)
	outputChatBox(string.format("Es sind somit schon %s Sekunden seit 1970 vergangen!", time.timestamp),thePlayer,0,255,0)

end
addCommandHandler("zeit",timestamp_func,false,false)
addCommandHandler("time",timestamp_func,false,false)

function buyPremium_func(thePlayer)
	outputChatBox("Premium kostet 50k.)",thePlayer,0,255,0)
	outputChatBox("Informationen über Premium gibt es im Forum oder mit /premium!",thePlayer,0,255,0)
	outputChatBox("Wenn du dir sicher bist, dass du mit Ingame$ bezahlen willst, gebe /accept premium ein!",thePlayer,0,255,0)
	vioSetElementData(thePlayer,"buyPremiumStart",1947)
end
addCommandHandler("buypremium",buyPremium_func,false,false)

function healme_func(thePlayer)
    if (isAdminLevel(thePlayer, 3)) then
        setPedArmor(thePlayer, 100)
        triggerClientEvent(thePlayer, "addFood", thePlayer, 1000)
        return true
    end
    if(vioGetElementData(thePlayer,"premium")>0)then
		if(vioGetElementData(thePlayer,"hkey")~=0) then
            local hkey=math.abs(vioGetElementData(thePlayer,"hkey"))
            if(haeuser[hkey]:isPlayerInHouse(thePlayer))then
                if not (isTimer(vioGetElementData(thePlayer,"hitTimer"))) then
                    triggerClientEvent(thePlayer,"addFood",thePlayer,300)
                else
                    showError(thePlayer,"Du darfst in einen Kampf nicht heilen!")
                end
            else
                showError(thePlayer,"Du bist nicht in deinen Haus/Wohnung!")
            end
		else
			showError(thePlayer,"Du bist nicht in deinen Haus/Wohnung!")		
		end
    else
		showError(thePlayer,"Du hast kein Premium!")
	end
end
addCommandHandler("healme",healme_func,false,false)



function pColor_func(thePlayer)
	if(vioGetElementData(thePlayer,"premium")>0)then
		if(isPedInVehicle(thePlayer))then
			if(getPedOccupiedVehicleSeat ( thePlayer )==0)then
				local vehicle=getPedOccupiedVehicle(thePlayer)
				if(vioGetElementData(vehicle,"besitzer"))then
					if(vioGetElementData(vehicle,"besitzer")==getPlayerName(thePlayer))then
						triggerClientEvent(thePlayer,"load_PremiumColor_Event",vehicle,vioGetElementData(vehicle,"premColor"),vioGetElementData(vehicle,"Lichterfarbe"))
					else
						showError(thePlayer,"Du bist nicht Besitzer des Fahrzeugs!")						
					end					
				elseif(vioGetElementData(thePlayer,"fraktion")==13)then
                    if(table.hasValue(frakselfcars[13], vehicle))then
                        local lr,lg,lb = getVehicleHeadLightColor ( vehicle  )
                        local color={}
                        color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], color[10], color[11], color[12] = getVehicleColor ( vehicle , true )

                        triggerClientEvent(thePlayer,"load_PremiumColor_Event",vehicle,table.concat(color, "|"),lr.."|"..lg.."|"..lb)
                    else
                        showError(thePlayer,"Du bist nicht Besitzer des Fahrzeugs und dieses Fahrzeug gehört auch nicht zu deiner Fraktion!")
                    end
                else
					showError(thePlayer,"Du bist nicht Besitzer des Fahrzeugs!")						
				end			
			else
				showError(thePlayer,"Du bist nicht Fahrer des Fahrzeugs!")			
			end		
		else
			showError(thePlayer,"Du bist in keinem Fahrzeug!")
		end
	else
		showError(thePlayer,"Du hast kein Premium!")
	end
end
addCommandHandler("pcolor",pColor_func,false,false)


function setColor_func(thePlayer,cmd,colorA,colorB,colorC,colorA2,colorB2,colorC2)
    if not colorA2 or not colorB2 or not colorC2 then
        colorA2,colorB2,colorC2 = colorA,colorB,colorC
   end


	if(isAdminLevel(thePlayer,3))then
		local vehicle=getPedOccupiedVehicle(thePlayer)
		setVehicleHeadLightColor ( vehicle, colorA,colorB,colorC)
		setVehicleColor ( vehicle, colorA,colorB,colorC,colorA2,colorB2,colorC2)
	end
end
addCommandHandler("setcolor",setColor_func,false,false)



addEvent("setPremiumVehicleLightColor",true)
function setPremiumVehicleLightColor_func(newcolorstring)
local thePlayer=source
	if(vioGetElementData(thePlayer,"premium")>0)then
		if(isPedInVehicle(thePlayer))then
			if(getPedOccupiedVehicleSeat ( thePlayer )==0)then
				local vehicle=getPedOccupiedVehicle(thePlayer)
				if(vioGetElementData(vehicle,"besitzer"))then
					if(vioGetElementData(vehicle,"besitzer")==getPlayerName(thePlayer))then
						vioSetElementData(vehicle,"Lichterfarbe",newcolorstring)
						setVehicleOverrideLights ( vehicle,2 )
						local colors=getStringComponents(newcolorstring)
						setVehicleHeadLightColor ( vehicle, tonumber(colors[1]),tonumber(colors[2]),tonumber(colors[3]))
						save_car(vehicle)
					else
						showError(thePlayer,"Du bist nicht Besitzer des Fahrzeugs!")						
					end					

                elseif(vioGetElementData(thePlayer,"fraktion")==13)then
                    if(table.hasValue(frakselfcars[13], vehicle))then
                        vioSetElementData(vehicle,"Lichterfarbe",newcolorstring)
                        setVehicleOverrideLights ( vehicle,2 )
                        setVehicleHeadLightColor ( vehicle, tonumber(colors[1]),tonumber(colors[2]),tonumber(colors[3]))
                    else
                        showError(thePlayer,"Du bist nicht Besitzer des Fahrzeugs und dieses Fahrzeug gehört auch nicht zu deiner Fraktion!")
                    end
                else
                    showError(thePlayer,"Du bist nicht Besitzer des Fahrzeugs!")
                end
            else
				showError(thePlayer,"Du bist nicht Fahrer des Fahrzeugs!")			
			end		
		else
			showError(thePlayer,"Du bist in keinem Fahrzeug!")
		end
	else
		showError(thePlayer,"Du hast kein Premium!")
	end


end
addEventHandler("setPremiumVehicleLightColor",getRootElement(),setPremiumVehicleLightColor_func)

addEvent("setPremiumVehicleColor",true)
function setPremiumVehicleColor_func(newcolorstring)
	local thePlayer=source
	if(vioGetElementData(thePlayer,"premium")>0)then
		if(isPedInVehicle(thePlayer))then
			if(getPedOccupiedVehicleSeat ( thePlayer )==0)then
				local vehicle=getPedOccupiedVehicle(thePlayer)
				if(vioGetElementData(vehicle,"besitzer"))then
					if(vioGetElementData(vehicle,"besitzer")==getPlayerName(thePlayer))then
						vioSetElementData(vehicle,"premColor",newcolorstring)
						local colors=getStringComponents(newcolorstring)
						setVehicleColor ( vehicle, tonumber(colors[1]),tonumber(colors[2]),tonumber(colors[3]),tonumber(colors[4]),tonumber(colors[5]),tonumber(colors[6]))
						save_car(vehicle)
					else
						showError(thePlayer,"Du bist nicht Besitzer des Fahrzeugs!")						
					end
                elseif(vioGetElementData(thePlayer,"fraktion")==13)then
                    if(table.hasValue(frakselfcars[13], vehicle))then
                        local colors=getStringComponents(newcolorstring)
                        setVehicleColor ( vehicle, tonumber(colors[1]),tonumber(colors[2]),tonumber(colors[3]),tonumber(colors[4]),tonumber(colors[5]),tonumber(colors[6]))
                    else
                        showError(thePlayer,"Du bist nicht Besitzer des Fahrzeugs und dieses Fahrzeug gehört auch nicht zu deiner Fraktion!")
                    end
                else
					showError(thePlayer,"Du bist nicht Besitzer des Fahrzeugs!")						
				end			
			else
				showError(thePlayer,"Du bist nicht Fahrer des Fahrzeugs!")			
			end		
		else
			showError(thePlayer,"Du bist in keinem Fahrzeug!")
		end
	else
		showError(thePlayer,"Du hast kein Premium!")
	end

end
addEventHandler("setPremiumVehicleColor",getRootElement(),setPremiumVehicleColor_func)









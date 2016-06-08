fly_typ_1_punkte={--für helis
   {"StarTower",1545.0999755859,-1353.5,329.5},
    {"The White House",1117.5999755859,-2037.8000488281,78.199996948},
    {"Filmstudio",891.5,-1224.0999755859,17},
    {"Farmer Lobby",-1055.1999511719,-1227.5,128.8999938964},
    {"Angel Pie Medical Center",-2215.5,-2322.8000488281,30.6000003814},
    {"SF Airport",-1652.6999511719,-160.19999694824,14.10000038147},
    {"SF Policedepartment",-1680.0999755859,704.90002441406,30.1000003814},
    {"SF Medical Center",-2654.6000976563,632,66.9000015258},
    {"Jizzys StripClub",-2631,1417.5,23.700000762939},
    {"Bayside Industrys",-2227,2324.6000976563,7.5},
    {"Old Grandmas Dinner",-1925.5999755859,2381.8000488281,49.5},
    {"Medical Center El Quebrados",-1517.1999511719,2538.8999023438,55.700000762939},
    {"SOS Human",-1473.5,1490.4000244141,8.3000001907349},
    {"Old Airport",363.79998779297,2535.5,16.700000762939},
    {"Chemie Industry",2620.3000488281,2719.3000488281,36.5},
    {"Emerald Isle",2095.5,2416.8999023438,74.599998474121},
    {"LS Airport",1765.3000488281,-2288.8000488281,26.799999237061}
}
fly_typ_2_punkte={--für große flugzeuge
    {"LS Airport",2004.1999511719,-2493.6000976563,13.5},
    {"SF Aiport",-1652.6999511719,-160.19999694824,14.10000038147},
    {"Alter Flughafen",343.89999389648,2500.3000488281,16.5}
}

flys_typ_1_fahrzeuge={548,417,487,563,469}--helis
flys_typ_2_fahrzeuge={592,511,553,577,519}--flugzeuge

addEvent("goflugyAuftrag_Event",true)
function givePlayerflyersAuftrag_func(auftrag)
	if(vioGetElementData(source,"heliLic")==1)and(vioGetElementData(source,"planeLic")==1)then
		if(getPlayerMoney(source)>=auftrag[1])then
			vioSetElementData(source,"flys_auftrag",true)
			vioSetElementData(source,"flys_sicher",auftrag[1])
            changePlayerMoney(source,-auftrag[1],"job","Flugjob","Sicherheiten")
            outputChatBox(string.format("Dir wurden %s als Sicherheit abgezogen! Du erhälst Sie nach der Rückgabe des Flugzeugs zurück!", toprice(auftrag[1])),source,255,0,0)
			vioSetElementData(source,"flys_gewinn",auftrag[2])
			local vehicle=createVehicle(auftrag[3],1477.62890625,1699.0966796875,15.544939994812,1.7852783203125,0.10986328125,179.90661621094)
            setVehicleColor ( vehicle , math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255) )

            vioSetElementData(vehicle,"hasTank",true)
			fixThatFlugVehicle(vehicle)

            vioSetElementData(vehicle,"tank",200)
			setTimer(fixThatFlugVehicle,2000,1,vehicle)
			setTimer(fixThatFlugVehicle,2500,1,vehicle)
			setTimer(fixThatFlugVehicle,3000,1,vehicle)
			setTimer(fixThatFlugVehicle,500,1,vehicle)
			setTimer(fixThatFlugVehicle,1000,1,vehicle)
			setTimer(fixThatFlugVehicle,1500,1,vehicle)
			vioSetElementData(source,"flys_vehicle",vehicle)
			local marker=false
			local blip=false
			if(auftrag[7]==2)then
				marker=createMarker(fly_typ_2_punkte[auftrag[6]][2],fly_typ_2_punkte[auftrag[6]][3],fly_typ_2_punkte[auftrag[6]][4],"cylinder",4, 88,191,162, 255, source)
				blip=createBlip ( fly_typ_2_punkte[auftrag[6]][2],fly_typ_2_punkte[auftrag[6]][3],fly_typ_2_punkte[auftrag[6]][4], 0, 4, 88,191,162, 255, 0 ,999999.0, source )
			else
				marker=createMarker(fly_typ_1_punkte[auftrag[6]][2],fly_typ_1_punkte[auftrag[6]][3],fly_typ_1_punkte[auftrag[6]][4],"cylinder",4, 88,191,162, 255, source)
				blip=createBlip ( fly_typ_1_punkte[auftrag[6]][2],fly_typ_1_punkte[auftrag[6]][3],fly_typ_1_punkte[auftrag[6]][4], 0, 4, 88,191,162, 255, 0 ,999999.0, source )
			end
			--outputChatBox(tostring(marker).." "..tostring(blip))
			triggerClientEvent(source,"giveNewFlugAutraege",source)
			vioSetElementData(source,"flys_marker",marker)
			vioSetElementData(source,"flys_blip",blip)
			vioSetElementData(vehicle,"flys_driver",source)
			vioSetElementData(source,"flys_spawner_damage",true)
			setTimer(vioSetElementData,5000,1,source,"flys_spawner_damage",false)
			warpPedIntoVehicle(source,vehicle)
			addEventHandler("onMarkerHit",marker,hitflyerserMarker)
			addEventHandler("onVehicleStartExit",vehicle,leaveflyerserVehicle)
			addEventHandler("onVehicleStartEnter",vehicle,enterflyerserVehicle)
		else
			outputChatBox("Du kannst die Sicherheiten nicht bezahlen!",source,255,0,0)
		end
	else
		outputChatBox("Dir fehlt der Flug- und Helicopterschein!",source,255,0,0)
	end
end
addEventHandler("goflugyAuftrag_Event",getRootElement(),givePlayerflyersAuftrag_func)

function fixThatFlugVehicle(vehicle)
	fixVehicle(vehicle)
end

function hitflyerserEndMarker(theHitElement)
	if(isElement(theHitElement))then	
		if(getElementType(theHitElement)=="vehicle")then
			local driver=vioGetElementData(theHitElement,"flys_driver")
			local realDriver=getVehicleOccupant (theHitElement )
			if(driver==realDriver)then
				if(source==vioGetElementData(driver,"flys_marker"))then
					if(getVehicleRealSpeed(theHitElement)<41)then
						if(vioGetElementData(driver,"heliLic")==1)and(vioGetElementData(driver,"planeLic")==1)then
							thePlayer=driver
							outputChatBox("Gut, dass du das Fahrzeug abgegeben hast!!",driver,88,191,162)
							if(isElement(vioGetElementData(thePlayer,"flys_blip")))then
								destroyElement(vioGetElementData(thePlayer,"flys_blip"))
							end
							if(isElement(vioGetElementData(thePlayer,"flys_marker")))then
								destroyElement(vioGetElementData(thePlayer,"flys_marker"))
							end
							local kaution=vioGetElementData(thePlayer,"flys_sicher")
							local gewinn=vioGetElementData(thePlayer,"flys_gewinn")


                            giveJobGehalt(thePlayer,12,1,false,gewinn)
                            changePlayerMoney(thePlayer,kaution,"job","Flugjob","Sicherheiten")
							outputChatBox(string.format("Du erhälst deine Kaution von %s zurück und ", toprice(kaution)),thePlayer,88,191,162)
							outputChatBox(string.format("erhälst dein Gehalt von %s.",  toprice(gewinn)),thePlayer,88,191,162)

							if(isElement(vioGetElementData(thePlayer,"flys_vehicle")))then
								destroyElement(vioGetElementData(thePlayer,"flys_vehicle"))
							end
							vioSetElementData(thePlayer,"flys_vehicle",false)
							vioSetElementData(thePlayer,"flys_marker",false)
							vioSetElementData(thePlayer,"flys_blip",false)
							vioSetElementData(thePlayer,"flys_auftrag",false)
							vioSetElementData(thePlayer,"flys_sicher",false)
							vioSetElementData(thePlayer,"flys_gewinn",false)
                            setAirportBlipsUnvisible(thePlayer)
							

							triggerClientEvent(thePlayer,"cancelFlyBehindyTimer",thePlayer)
							vioSetElementData(thePlayer,"Punkte_Meisterpilot",vioGetElementData(thePlayer,"Punkte_Meisterpilot")+1)
							if(vioGetElementData(thePlayer,"Punkte_Meisterpilot")>999)then
								if(vioGetElementData(thePlayer,"Erfolg_Meisterpilot")~=1)then
									vioSetElementData(thePlayer,"Erfolg_Meisterpilot",1)
									triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"Meisterpilot","1000 beendete Flüge")
								end	
							end
						else
							outputChatBox("Dir fehlt der Flugschein!",driver,255,0,0)
						end
					else
						outputChatBox("Das Flugzeug ist zum Ausladen zu schnell!",driver,255,0,0)
					end
				end
			end
		end
	end
end

function hitflyerserMarker(theHitElement)
	if(getElementType(theHitElement)=="vehicle")then
		local driver=vioGetElementData(theHitElement,"flys_driver")
		local realDriver=getVehicleOccupant (theHitElement )
		if(driver==realDriver)then
			if(source==vioGetElementData(driver,"flys_marker"))then
				if(getVehicleRealSpeed(theHitElement)<41)then
					if(vioGetElementData(driver,"flys_trailer"))then
						destroyElement(vioGetElementData(driver,"flys_trailer"))
					end
					outputChatBox("Gut du hast die Ware abgegeben! Bring nun das Fahrzeug zurück zum Flughafen LV!",driver,88,191,162)
					if(isElement(vioGetElementData(driver,"flys_blip")))then
						destroyElement(vioGetElementData(driver,"flys_blip"))
					end
					if(isElement(vioGetElementData(driver,"flys_marker")))then
						destroyElement(vioGetElementData(driver,"flys_marker"))
					end
					local marker=createMarker(1389.046875,1701.9697265625,10.8203125,"cylinder",4, 88,191,162, 255, driver)
					local blip=createBlip ( 1389.046875,1701.9697265625,10.8203125, 0, 4, 88,191,162, 255, 0 ,999999.0, driver )
					vioSetElementData(driver,"flys_marker",marker)
					vioSetElementData(driver,"flys_blip",blip)
					addEventHandler("onMarkerHit",marker,hitflyerserEndMarker)
				else
					outputChatBox("Das Flugzeug ist zum Ausladen zu schnell!",driver,255,0,0)
				end
			end
		end
	end
end

function cancelflyersJob(thePlayer)
	if(isElement(thePlayer))then
		outputChatBox("Schade, dass du den Auftrag nicht zuende geführt hast!",thePlayer,255,0,0)
		if(isElement(vioGetElementData(thePlayer,"flys_blip")))then
			destroyElement(vioGetElementData(thePlayer,"flys_blip"))
		end
		if(isElement(vioGetElementData(thePlayer,"flys_marker")))then
			destroyElement(vioGetElementData(thePlayer,"flys_marker"))
		end
		if(isElement(vioGetElementData(thePlayer,"flys_vehicle")))then
			destroyElement(vioGetElementData(thePlayer,"flys_vehicle"))
		end
		vioSetElementData(thePlayer,"flys_vehicle",false)
		vioSetElementData(thePlayer,"flys_marker",false)
		vioSetElementData(thePlayer,"flys_blip",false)
		vioSetElementData(thePlayer,"flys_auftrag",false)
		vioSetElementData(thePlayer,"flys_sicher",false)
		vioSetElementData(thePlayer,"flys_gewinn",false)
	end
end
addCommandHandler("cancelflys",cancelflyersJob,false,false)

function onPlayerDisconnectByflyersJob()
	thePlayer=source
	if(isElement(vioGetElementData(thePlayer,"flys_blip")))then
		destroyElement(vioGetElementData(thePlayer,"flys_blip"))
	end
	if(isElement(vioGetElementData(thePlayer,"flys_marker")))then
		destroyElement(vioGetElementData(thePlayer,"flys_marker"))
	end
	if(isElement(vioGetElementData(thePlayer,"flys_vehicle")))then
		destroyElement(vioGetElementData(thePlayer,"flys_vehicle"))
	end
	vioSetElementData(thePlayer,"flys_vehicle",false)
	vioSetElementData(thePlayer,"flys_marker",false)
	vioSetElementData(thePlayer,"flys_blip",false)
	vioSetElementData(thePlayer,"flys_auftrag",false)
	vioSetElementData(thePlayer,"flys_sicher",false)
	vioSetElementData(thePlayer,"flys_gewinn",false)	
end
addEventHandler("onPlayerQuit",getRootElement(),onPlayerDisconnectByflyersJob)

function enterflyerserVehicle(thePlayer,seat)
	if(seat==0)then
		if(vioGetElementData(source,"flys_driver"))then
			if(vioGetElementData(source,"flys_driver")==thePlayer)then
				if(isTimer(vioGetElementData(thePlayer,"flys_timer")))then
					killTimer(vioGetElementData(thePlayer,"flys_timer"))
				end				
				outputChatBox("Schön das du wieder an Board bist!",thePlayer,88,191,162)
			else
				cancelEvent()
				outputChatBox("Dies ist ein Job Vehicle und kann nur von der Person gefahren, die den Auftrag angenommen hat!",thePlayer,255,0,0)
			end		
		end
	end
end

function leaveflyerserVehicle(thePlayer,seat)
	if(seat==0)then
		outputChatBox("Du hast 60 Sekunden um wieder in das Flugzeug zu steigen oder der Job ist gelaufen!",thePlayer,255,0,0)
		local flys_timer=setTimer(cancelflyersJob,60000,1,thePlayer)
		vioSetElementData(thePlayer,"flys_timer",flys_timer)
	end
end

function onflysResourceStart()
	local flysMarker=createMarker(1495.814453125,1682.54296875,10.8125,"cylinder")
	addEventHandler("onMarkerHit",flysMarker,hitAuftragsFlugMarker)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onflysResourceStart)

function hitAuftragsFlugMarker(hitElement)
	if(vioGetElementData(hitElement,"job")==12)then
		if not(vioGetElementData(hitElement,"flys_auftrag")) then
			triggerClientEvent(hitElement,"openflysJobGui",hitElement)
		else
			outputChatBox("Tut mir Leid Sir, Sie haben bereits einen Auftrag und müssen diesen erst erfüllen!",hitElement,255,0,0)
			outputChatBox("Abbruch des Auftrags mit /cancelflys - ACHTUNG: Sicherheiten gehen dabei verloren!",hitElement,255,0,0)
		end
	end
end










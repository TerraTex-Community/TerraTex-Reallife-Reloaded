lks_typ_1_punkte={
	{"Arena",2726.6259765625,-1839.7021484375,10.162282943726,169.51336669922}, -- Lieferrantenjob Arenamarker 
	{"Pizza Stack",2095.8955078125,-1807.0537109375,13.552013397217,8.8193969726562}, -- lieferantenjob -pizza 
	{"Cluckin' Bell",2422.74609375,-1500.20703125,23.992208480835,182.79057312012}, -- lieferantenjob - cluckinbell 
	{"Sprunk",2855.7607421875,-1532.8828125,11.09375,1.7715759277344}, -- lieferantenjob sprunk 
	{"24/7",1322.9599609375,-864.576171875,39.578125,69.129791259766}, -- lieferantenjob 24/7 
	{"Burgershot",1206.2890625,-922.822265625,42.952297210693,275.87915039062}, -- lieferantenjob Burgershot 
	{"Tunning",1050.427734375,-1032.38671875,32.040351867676,87.411315917969}, -- lieferantenjob tunning 
	{"Pay'n'Spray",1015.5322265625,-1033.81640625,31.652410507202,84.274658203125}, -- lieferantenjob Pay'n'Spray 
	{"Tankstelle",1005.7216796875,-940.5537109375,42.1796875,99.161376953125}, -- lieferantenjob tankstelle 
	{"Unitel",1575.71484375,-1852.8134765625,13.539115905762,182.64775085449}, -- lieferantenjob unitel 
	{"Bar & Strip Industries",1827.283203125,-1685.068359375,13.546875,5.9024963378906} -- lieferantenjob barnstrip industries
}
lks_typ_2_punkte={
	{"Star",-79.099998474121,-1126.1999511719,0},
	{"Fleischfabrik",61.400001525879,-243.80000305176,0.60000002384186},
	{"Bioanlage",1352.3000488281,356.10000610352,19.10000038147},
	{"Kagawa Industry",1410.5999755859,1041.6999511719,10.800000190735},
	{"Schafted Industy",1693.4000244141,929.79998779297,10.800000190735},
	{"Farmer Industry2",2849.8999023438,915.90002441406,9.6999998092651},
	{"KACC",2494.3999023438,2773.1999511719,9.8000001907349},
	{"Car Industrys",1615,2358.3999023438,10},
	{"Corgen Industry and Co.",-1490,2649.5,55.799999237061},
	{"Old Grandmas Diner",-1931.8000488281,2385.8000488281,49.5},
	{"Bayside Industry",-2270.3999023438,2327.1000976563,4.8000001907349},
	{"Garden Center",-2589.6000976563,312,4.8000001907349},
	{"Hippy Schopper",-2597.6000976563,55.099998474121,3.2000000476837},
	{"Energy and Co.",-2520.3999023438,-617.90002441406,131.19999694824},
	{"WoodIndustry",-2025.4000244141,-2406.6000976563,29.39999961853},
	{"Trash and Co. KG.",-1901.3000488281,-1728,21.799999237061},
	{"Farming Lobby",-1047.0999755859,-1189.0999755859,127.90000152588},
	{"Ag. Co .",-492.70001220703,-554.59997558594,25.5}
}

lkw_typ_1_fahrzeuge={414,440,456,498,499,609}
lkw_typ_2_fahrzeuge={403,514,515}
lkw_trailer={450,584,591,435}

function reattachTrailer(theTruck)
    attachTrailerToVehicle(theTruck, source) -- Reattach the truck and trailer
end

addEvent("goTruckAuftrag_Event",true)
function givePlayerTruckAuftrag_func(auftrag)
	if(vioGetElementData(source,"truckLic")==1)then
		if(getPlayerMoney(source)>=auftrag[1])then
			vioSetElementData(source,"lkw_auftrag",true)
			vioSetElementData(source,"lkw_sicher",auftrag[1])
            changePlayerMoney(source,-auftrag[1],"job","Truckerjob","Sicherheiten")
            outputChatBox(string.format("Dir wurden %s als Sicherheit abgezogen! Du erhälst Sie nach der Rückgabe des LKWs zurück!", toprice(auftrag[1])),source,255,0,0)
			vioSetElementData(source,"lkw_gewinn",auftrag[2])
			--outputChatBox(tostring(auftrag[2]))
			local vehicle=createVehicle(auftrag[3],2778.84765625,-2456.1328125,14.642349243164,359.53857421875,0,90.390014648438,"TRUCKER")
            setVehicleColor ( vehicle , math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255) )
            vioSetElementData(vehicle,"hasTank",true)
            vioSetElementData(vehicle,"hasTankFactor",0.5)
            vioSetElementData(vehicle,"tank",100)
			local trailer=false
			if(auftrag[4]==2)then
				trailer=createVehicle(auftrag[5],2786.5615234375,-2456.060546875,14.628895759583,359.50012207031,0,91.697387695312,"TRUCKER")
                setVehicleColor ( trailer , math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255), math.random(0,255) )

                attachTrailerToVehicle(vehicle, trailer)
				--setElementSyncer ( trailer ,source)
				addEventHandler("onTrailerDetach", trailer, reattachTrailer)
			end
			if(auftrag[1]>99999)then
				setVehicleHeadLightColor(vehicle,math.random(0,255),math.random(0,255),math.random(0,255))
			end
			vioSetElementData(source,"lkw_vehicle",vehicle)
			vioSetElementData(source,"lkw_trailer",trailer)
			local marker=false
			local blip=false
			if(auftrag[7]==2)then
				marker=createMarker(lks_typ_2_punkte[auftrag[6]][2],lks_typ_2_punkte[auftrag[6]][3],lks_typ_2_punkte[auftrag[6]][4],"cylinder",4, 88,191,162, 255, source)
				blip=createBlip ( lks_typ_2_punkte[auftrag[6]][2],lks_typ_2_punkte[auftrag[6]][3],lks_typ_2_punkte[auftrag[6]][4], 0, 4, 88,191,162, 255, 0 ,999999.0, source )
			else
				marker=createMarker(lks_typ_1_punkte[auftrag[6]][2],lks_typ_1_punkte[auftrag[6]][3],lks_typ_1_punkte[auftrag[6]][4],"cylinder",4, 88,191,162, 255, source)
				blip=createBlip ( lks_typ_1_punkte[auftrag[6]][2],lks_typ_1_punkte[auftrag[6]][3],lks_typ_1_punkte[auftrag[6]][4], 0, 4, 88,191,162, 255, 0 ,999999.0, source )
			end
			--outputChatBox(tostring(marker).." "..tostring(blip))
			triggerClientEvent(source,"giveNewAutraege",source)
			vioSetElementData(source,"lkw_marker",marker)
			vioSetElementData(source,"lkw_blip",blip)
			vioSetElementData(vehicle,"lkw_driver",source)
			warpPedIntoVehicle(source,vehicle)
			addEventHandler("onMarkerHit",marker,hitTruckerMarker)
			addEventHandler("onVehicleStartExit",vehicle,leaveTruckerVehicle)
			addEventHandler("onVehicleStartEnter",vehicle,enterTruckerVehicle)
		else
			outputChatBox("Du kannst die Sicherheiten nicht bezahlen!",source,255,0,0)
		end
	else
		outputChatBox("Dir fehlt der Truckerschein!",source,255,0,0)
	end
end
addEventHandler("goTruckAuftrag_Event",getRootElement(),givePlayerTruckAuftrag_func)

function hitTruckerEndMarker(theHitElement)
	if(isElement(theHitElement))then	
		if(getElementType(theHitElement)=="vehicle")then
			local driver=vioGetElementData(theHitElement,"lkw_driver")
			local realDriver=getVehicleOccupant (theHitElement )
			if(driver==realDriver)then
				if(source==vioGetElementData(driver,"lkw_marker"))then
					if(getVehicleRealSpeed(theHitElement)<31)then
						if(vioGetElementData(driver,"truckLic")==1)then
							if(vioGetElementData(driver,"lkw_trailer"))then
								if(isElement(vioGetElementData(driver,"lkw_trailer")))then
									destroyElement(vioGetElementData(driver,"lkw_trailer"))
								end
							end
							local thePlayer=driver
							outputChatBox("Gut du das Fahrzeug abgegeben!!",driver,88,191,162)
							if(isElement(vioGetElementData(thePlayer,"lkw_blip")))then
								destroyElement(vioGetElementData(thePlayer,"lkw_blip"))
							end
							if(isElement(vioGetElementData(thePlayer,"lkw_marker")))then
								destroyElement(vioGetElementData(thePlayer,"lkw_marker"))
                            end

							local kaution=vioGetElementData(thePlayer,"lkw_sicher")
							local gewinn=vioGetElementData(thePlayer,"lkw_gewinn")

                            giveJobGehalt(thePlayer,11,1,false,gewinn)
                            outputChatBox(string.format("Du erhälst deine Kaution von %s zurück und ", toprice(kaution)),thePlayer,88,191,162)
                            outputChatBox(string.format("erhälst dein Gehalt von %s.",  toprice(gewinn)),thePlayer,88,191,162)
                            changePlayerMoney(thePlayer,kaution,"job","Truckerjob","Sicherheiten")
							if(isElement(vioGetElementData(thePlayer,"lkw_vehicle")))then
								destroyElement(vioGetElementData(thePlayer,"lkw_vehicle"))
							end
							if(isElement(vioGetElementData(thePlayer,"lkw_trailer")))then
								destroyElement(vioGetElementData(thePlayer,"lkw_trailer"))
							end
							vioSetElementData(thePlayer,"lkw_vehicle",false)
							vioSetElementData(thePlayer,"lkw_trailer",false)	
							vioSetElementData(thePlayer,"lkw_marker",false)
							vioSetElementData(thePlayer,"lkw_blip",false)
							vioSetElementData(thePlayer,"lkw_auftrag",false)
							vioSetElementData(thePlayer,"lkw_sicher",false)
							vioSetElementData(thePlayer,"lkw_gewinn",false)

							triggerClientEvent(thePlayer,"cancelBehindyTruckTimer",thePlayer)
							vioSetElementData(thePlayer,"Punkte_Meistertrucker",vioGetElementData(thePlayer,"Punkte_Meistertrucker")+1)
							if(vioGetElementData(thePlayer,"Punkte_Meistertrucker")>999)then
								if(vioGetElementData(thePlayer,"Erfolg_Meistertrucker")~=1)then
									vioSetElementData(thePlayer,"Erfolg_Meistertrucker",1)
									triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"Meistertrucker","1000 beendete Truckeraufträge")
								end	
							end
						else
							outputChatBox("Dir fehlt der Truckerschein!",driver,255,0,0)
						end
					else
						outputChatBox("Das Fahrzeug ist zum Ausladen zu schnell!",driver,255,0,0)
					end
				end
			end
		end
	end
end

function hitTruckerMarker(theHitElement)
	if(getElementType(theHitElement)=="vehicle")then
		local driver=vioGetElementData(theHitElement,"lkw_driver")
		local realDriver=getVehicleOccupant (theHitElement )
		if(driver==realDriver)then
			if(source==vioGetElementData(driver,"lkw_marker"))then
			
				if(getVehicleRealSpeed(theHitElement)<31)then
					if(vioGetElementData(driver,"lkw_trailer"))then
						destroyElement(vioGetElementData(driver,"lkw_trailer"))
					end
					outputChatBox("Gut du hast die Ware abgegeben! Bring nun das Fahrzeug zurück zum Hafen!",driver,88,191,162)
					if(isElement(vioGetElementData(driver,"lkw_blip")))then
						destroyElement(vioGetElementData(driver,"lkw_blip"))
					end
					if(isElement(vioGetElementData(driver,"lkw_marker")))then
						destroyElement(vioGetElementData(driver,"lkw_marker"))
					end
					local marker=createMarker(2762.251953125,-2463.4462890625,13.552277565002,"cylinder",4, 88,191,162, 255, driver)
					local blip=createBlip ( 2762.251953125,-2463.4462890625,13.552277565002, 0, 4, 88,191,162, 255, 0 ,999999.0, driver )
					vioSetElementData(driver,"lkw_marker",marker)
					vioSetElementData(driver,"lkw_blip",blip)
					addEventHandler("onMarkerHit",marker,hitTruckerEndMarker)
				else
					outputChatBox("Das Fahrzeug ist zum Ausladen zu schnell!",driver,255,0,0)
				end
			end
		end
	end
end

function cancelTruckJob(thePlayer)
	if(isElement(thePlayer))then
		outputChatBox("Schade, dass du den Auftrag nicht zuende geführt hast!",thePlayer,255,0,0)
		if(isElement(vioGetElementData(thePlayer,"lkw_blip")))then
			destroyElement(vioGetElementData(thePlayer,"lkw_blip"))
		end
		if(isElement(vioGetElementData(thePlayer,"lkw_marker")))then
			destroyElement(vioGetElementData(thePlayer,"lkw_marker"))
		end
		if(isElement(vioGetElementData(thePlayer,"lkw_vehicle")))then
			destroyElement(vioGetElementData(thePlayer,"lkw_vehicle"))
		end
		if(isElement(vioGetElementData(thePlayer,"lkw_trailer")))then
			destroyElement(vioGetElementData(thePlayer,"lkw_trailer"))
		end
		vioSetElementData(thePlayer,"lkw_vehicle",false)
		vioSetElementData(thePlayer,"lkw_trailer",false)	
		vioSetElementData(thePlayer,"lkw_marker",false)
		vioSetElementData(thePlayer,"lkw_blip",false)
		vioSetElementData(thePlayer,"lkw_auftrag",false)
		vioSetElementData(thePlayer,"lkw_sicher",false)
		vioSetElementData(thePlayer,"lkw_gewinn",false)
	end
end
addCommandHandler("cancellkw",cancelTruckJob,false,false)


function onPlayerDisconnectByTruckJob()
	thePlayer=source
	if(isElement(vioGetElementData(thePlayer,"lkw_blip")))then
		destroyElement(vioGetElementData(thePlayer,"lkw_blip"))
	end
	if(isElement(vioGetElementData(thePlayer,"lkw_marker")))then
		destroyElement(vioGetElementData(thePlayer,"lkw_marker"))
	end
	if(isElement(vioGetElementData(thePlayer,"lkw_vehicle")))then
		destroyElement(vioGetElementData(thePlayer,"lkw_vehicle"))
	end
	if(isElement(vioGetElementData(thePlayer,"lkw_trailer")))then
		destroyElement(vioGetElementData(thePlayer,"lkw_trailer"))
	end
	vioSetElementData(thePlayer,"lkw_vehicle",false)
	vioSetElementData(thePlayer,"lkw_trailer",false)	
	vioSetElementData(thePlayer,"lkw_marker",false)
	vioSetElementData(thePlayer,"lkw_blip",false)
	vioSetElementData(thePlayer,"lkw_auftrag",false)
	vioSetElementData(thePlayer,"lkw_sicher",false)
	vioSetElementData(thePlayer,"lkw_gewinn",false)	
end
addEventHandler("onPlayerQuit",getRootElement(),onPlayerDisconnectByTruckJob)

function enterTruckerVehicle(thePlayer,seat)
	if(seat==0)then
		if(vioGetElementData(source,"lkw_driver"))then
			if(vioGetElementData(source,"lkw_driver")==thePlayer)then
				if(isTimer(vioGetElementData(thePlayer,"lkw_timer")))then
					killTimer(vioGetElementData(thePlayer,"lkw_timer"))
				end
				--[[if(vioGetElementData(thePlayer,"lkw_trailer"))then
					setElementSyncer (vioGetElementData(thePlayer,"lkw_trailer") , thePlayer)
				end]]
				outputChatBox("Schön das du wieder an Board bist!",thePlayer,88,191,162)
			else
				cancelEvent()
				outputChatBox("Dies ist ein Job Vehicle und kann nur von der Person gefahren, die den Auftrag angenommen hat!",thePlayer,255,0,0)
			end		
		end
	end
end

function leaveTruckerVehicle(thePlayer,seat)
	if(seat==0)then
		outputChatBox("Du hast 60 Sekunden um wieder in den Truck zu steigen oder der Job ist gelaufen!",thePlayer,255,0,0)
		local lkw_timer=setTimer(cancelTruckJob,60000,1,thePlayer)
		vioSetElementData(thePlayer,"lkw_timer",lkw_timer)
	end
end

function onLKWResourceStart()
	local lkwMarker=createMarker(2770.587890625,-2447.2724609375,12.64318561554,"cylinder")
	addEventHandler("onMarkerHit",lkwMarker,hitAuftragsMarker)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onLKWResourceStart)

function hitAuftragsMarker(hitElement)
	if(vioGetElementData(hitElement,"job")==11)then
		if not(vioGetElementData(hitElement,"lkw_auftrag")) then
			triggerClientEvent(hitElement,"openLKWJobGui",hitElement)
		else
			outputChatBox("Tut mir Leid Sir, Sie haben bereits einen Auftrag und müssen diesen erst erfüllen!",hitElement,255,0,0)
			outputChatBox("Abbruch des Auftrags mit /cancellkw - ACHTUNG: Sicherheiten gehen dabei verloren!",hitElement,255,0,0)
		end
	end
end










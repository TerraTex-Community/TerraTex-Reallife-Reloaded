
--setNextStation
--send_Station_Info_Bus

--eledata:route, driver,isBusVeh,marker,blip
--killBusTimer

--EVENTS: playSignalHaltestelle,playHalteStellenSound

function setNextStation(hitElement)
	if(getElementType(hitElement)=="vehicle")then
			local thePlayer=vioGetElementData(hitElement,"driver")
			if(vioGetElementData(hitElement,"marker")==source)then
				if(getVehicleRealSpeed(hitElement)<51)then
					--local thePlayer=vioGetElementData(hitElement,"driver")


					vioSetElementData(thePlayer,"Punkte_Busmeister",vioGetElementData(thePlayer,"Punkte_Busmeister")+1)
					if(vioGetElementData(thePlayer,"Punkte_Busmeister")>99)then
						if(vioGetElementData(thePlayer,"Erfolg_Busmeister")==0)then
							vioSetElementData(thePlayer,"Erfolg_Busmeister",1)
							triggerClientEvent(thePlayer,"onClientCreatePokalGUI",thePlayer,"Busmeister","Fahre 100 Haltestellen ab")
						end
                    end

                    local betragDirekt,betragPayDay=giveJobGehalt(thePlayer,4,1)
                    showError(thePlayer,string.format("Du erhälst für diese Haltestelle %s Gehalt. Zusätzlich hast du %s durch Fahrgäste verdient.",toprice(betragPayDay),toprice(betragDirekt)))
					--showError(thePlayer,string.format("Da du die Station erreicht hast erhaelst du %s $", betragDirekt+betragPayDay))


					destroyElement(vioGetElementData(hitElement,"marker"))
					destroyElement(vioGetElementData(hitElement,"blip"))
					local route=vioGetElementData(hitElement,"route")
                    local oldID=vioGetElementData(hitElement,"station")
                    local newID=getNextRouteHaltestellenIndex(route,oldID)
                    vioSetElementData(hitElement,"station",newID)
                    local mx,my,mz=getHaltestellenKoordinatenByRouteID(route,newID)
					local station=vioGetElementData(hitElement,"station")
					local marker=createMarker ( mx,my,mz, "checkpoint", 3, 255, 0,0,255,thePlayer )
					local blip=createBlip ( mx,my,mz, 0, 2, 255, 0,0,255,0, 99999.0, thePlayer )
					addEventHandler("onMarkerHit",marker,setNextStation)
					vioSetElementData(hitElement,"marker",marker)
					vioSetElementData(hitElement,"blip",blip)
					setTimer(send_Station_Info_Bus,5000,1,hitElement)
				else
					outputChatBox("Drossel deine Geschwindigkeit an Haltestellen und nehme Fahrgäste mit!",thePlayer,255,0,0)
				end
			end
		
	end
end

function start_bus_job(thePlayer,busveh)
	outputChatBox("Willkommen an Board, fahre die Stationen ab! Du bekommst extraboni wenn Personen mitfahren!",thePlayer,0,255,0)
end

function busstop_func(thePlayer)
	if(isPedInVehicle(thePlayer))then
			local vehicle=getPedOccupiedVehicle(thePlayer)
		if(vioGetElementData(vehicle,"isBusVeh"))then
			local marker=vioGetElementData(vehicle,"marker")
			local blip=vioGetElementData(vehicle,"blip")
			setBlipColor ( blip, 0, 255, 0,255 )
			setMarkerColor ( marker, 0, 255, 0,255 )
			outputChatBox("Dem Busfahrer wurde signalisiert, dass du aussteigen möchtest!",thePlayer)
			outputChatBox("Ein Gast hat signalisiert, dass er an der nächsten Haltestelle aussteigen möchte!",vioGetElementData(vehicle,"driver"),0,255,0,255)
			triggerClientEvent(vioGetElementData(vehicle,"driver"),"playSignalHaltestelle",vioGetElementData(vehicle,"driver"))		
		end
	end
end
addCommandHandler("busstop",busstop_func,false,false)

function send_Station_Info_Bus(theBus)
	if isElement(theBus) then
	    local route=vioGetElementData(theBus,"route")
        local Station=vioGetElementData(theBus,"station")
        local hName=getHaltestellenNameByRoute(route,Station)
		local occupants = getVehicleOccupants(theBus)
		local seats = getVehicleMaxPassengers(theBus)
		for seat = 0, seats do 
			if occupants[seat] then
				outputChatBox(string.format("Ansage: Die nächste Haltestelle ist: %s Haltestellensignal mit /busstop", hName),occupants[seat],0,255,0)
				triggerClientEvent(occupants[seat],"playHalteStellenSound",occupants[seat],hName)
			end
		end	
	end
end

function exitBusVehicle(thePlayer,seat)
	if(seat==0)then
		local timer=setTimer(destroyTheBus,180000,1,source)
		vioSetElementData(source,"killBusTimer",timer)
		if(isElement(vioGetElementData(source,"marker")))then
			destroyElement(vioGetElementData(source,"marker"))
			destroyElement(vioGetElementData(source,"blip"))
		end
		outputChatBox("Du hast 180 Sekunden um wieder in den Bus zusteigen!",thePlayer,0,255,0)
	else
		outputChatBox("Einen schönen Tag noch, wünscht das SABus-Team",thePlayer,0,255,0)
	end
end

function destroyTheBus(bus)
	if(isElement(bus))then
		destroyElement(bus)
	end
end

function enterBusVehicle(thePlayer,seat)
	if(seat==0)then
		if(vioGetElementData(source,"driver")==thePlayer)then
			if(vioGetElementData(thePlayer,"job")==4)then
				if(isTimer(vioGetElementData(source,"killBusTimer")))then
					killTimer(vioGetElementData(source,"killBusTimer"))
					outputChatBox("Schön das du die Route fortsetzt!",thePlayer,0,255,0)
				end
				local route=vioGetElementData(source,"route")
				-- outputDebugString("2: "..route)
				local station=vioGetElementData(source,"station")
                local mx,my,mz=getHaltestellenKoordinatenByRouteID(route,station)
				local marker=createMarker ( mx,my,mz, "checkpoint", 3, 255, 0,0,255,thePlayer )
				local blip=createBlip (  mx,my,mz, 0, 2, 255, 0,0,255,0, 99999.0, thePlayer )
				addEventHandler("onMarkerHit",marker,setNextStation)
				vioSetElementData(source,"marker",marker)
				vioSetElementData(source,"blip",blip)
				send_Station_Info_Bus(source)
			else			
				removePedFromVehicle(thePlayer)
			end
		else
			removePedFromVehicle(thePlayer)
		end		
	else
		outputChatBox(string.format("Du hast einen Bus betreten und bezahlst %s $ für dein Ticket!", 5.00),thePlayer,0,255,0)
        changePlayerMoney(thePlayer,-5,"sonstiges","Busfahrt")
        changePlayerMoney(vioGetElementData(source,"driver"),5,"sonstiges","Busfahrt")
	end
end

function disableBus()
	local busele=vioGetElementData(source,"busjobvehicle")
	if(isElement(busele))then
		if(isElement(vioGetElementData(busele,"marker")))then
			destroyElement(vioGetElementData(busele,"marker"))
			destroyElement(vioGetElementData(busele,"blip"))
		end
		destroyElement(busele)
	end
end
addEventHandler("onPlayerWasted",getRootElement(),disableBus)
addEventHandler("onPlayerQuit",getRootElement(),disableBus)

function resetPlayerHasSpawnedABus(thePlayer)
    if(isElement(thePlayer))then
	    vioSetElementData(thePlayer,"hasStartedABus",false)
    end
end

local routennamen={["all"]=true,["rookie"]=true,["job"]=true, ["fraktion"]=true, ["sehenswert"]=true}
function startbus_cmd(thePlayer,cmd,routenname)	
	if(vioGetElementData(thePlayer,"job")==4)then
		if(vioGetElementData(thePlayer,"truckLic")>0)then
            if(not vioGetElementData(thePlayer,"busstared")) then vioSetElementData(thePlayer,"busstared",0) end

            if(vioGetElementData(thePlayer,"busstared")<getTimestamp()-300) then
                if(routenname)then
                    if(routennamen[string.lower(routenname)]) then
                        if (not(string.lower(routenname)=="rookie") and not(vioGetElementData(thePlayer,"reiseLic")))then
                            outputChatBox("Für die Route 'all' benötigst du einen Reisepass!",thePlayer,255,0,0)
                        else
                            local x,y,z=getElementPosition(thePlayer)
                            if(getDistanceBetweenPoints3D(x,y,z,1219.38671875,-1812.4951171875,16.59375)<10)then
                                if(vioGetElementData(thePlayer,"hasStartedABus"))then
                                    outputChatBox("Du hast bereits einen Bus erstellt!",thePlayer,255,0,0)
                                else
                                    vioSetElementData(thePlayer,"hasStartedABus",true)
                                    setTimer(resetPlayerHasSpawnedABus,10000,1,thePlayer)
                                    local busveh=createVehicle(431,1256.0751953125,-1806.45703125,13.516704559326,359.43420410156,0,216.49658203125)
                                    vioSetElementData(busveh,"hasTank",true)
                                    vioSetElementData(busveh,"hasTankFactor",0.5)
                                    vioSetElementData(busveh,"route",string.lower(routenname))
                                    vioSetElementData(thePlayer,"route",string.lower(routenname))
                                    vioSetElementData(busveh,"driver",thePlayer)
                                    vioSetElementData(thePlayer,"busjobvehicle",busveh)
                                    vioSetElementData(busveh,"isBusVeh",true)
                                    vioSetElementData(thePlayer,"busstared",getTimestamp())
                                    vioSetElementData(busveh,"station",1)
                                    addEventHandler("onVehicleEnter",busveh,enterBusVehicle)
                                    addEventHandler("onVehicleExit",busveh,exitBusVehicle)
                                    outputChatBox("Zum Beenden des Jobs einfach aus dem Bus aussteigen!",thePlayer,255,0,0)
                                    setElementPosition(thePlayer,1256.0751953125,-1806.45703125,13.516704559326)
                                    warpPedIntoVehicle (thePlayer, busveh, 0 )
                                    start_bus_job(thePlayer,busveh)
                                end
                            else
                                outputChatBox("Du musst in der nähe des Busjobicons sein um ein Busjob zu starten!",thePlayer,255,0,0)
                            end
                        end
                    else
                        outputChatBox("Es gibt nur die Routen: rookie (nur LS für Anfänger), all (ls/lv), fraktion, sehenswert und job",thePlayer,255,0,0)
                    end
                else
                    outputChatBox("Es gibt nur die Routen: rookie (nur LS für Anfänger), all (ls/lv), fraktion, sehenswert und job",thePlayer,255,0,0)
                end
            else
                showError(thePlayer,"Du hast bereits einen Bus in den letzten 5 Minuten gestartet.")
            end
		else
			outputChatBox("Du benötigst eine Truckerlizens!",thePlayer,255,0,0)
		end
	end
end
addCommandHandler("busstart",startbus_cmd,false,false)









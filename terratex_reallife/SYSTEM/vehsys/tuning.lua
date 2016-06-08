local torData={}
local tunVehData={}
local tuningMarker={}

function opentuningMarker()


	setGarageOpen (  7, true)
	setGarageOpen ( 10, true)
	setGarageOpen ( 33, true)
	setGarageOpen ( 18, true)
	setGarageOpen ( 15, true)
	torData[7]={}
	torData[10]={}
	torData[33]={}
	torData[18]={}
	torData[15]={}
	local mark=createMarker(2644.9609375,-2045.8447265625,13.640233039856,"cylinder",2.0,0,0,0,0)
	local veh=createVehicle(560,616.47265625,-3.884765625,1001.026953125)
	setElementInterior(veh,1)
	setElementDimension(veh,1)
    vioSetElementData(mark,"isRacerBase", false)
	table.insert(tuningMarker,{mark,7,veh})
	
	local mark=createMarker(1041.7705078125,-1012.9990234375,32.080799102783,"cylinder",2.0,0,0,0,0)
	veh=createVehicle(560,616.47265625,-3.884765625,1001.026953125)
	setElementInterior(veh,1)
	setElementDimension(veh,2)
    vioSetElementData(mark,"isRacerBase", false)
	table.insert(tuningMarker,{mark,10,veh})
	
	local mark=createMarker(2386.48828125,1051.6982421875,9.9280261993408,"cylinder",2.0,0,0,0,0)
	veh=createVehicle(560,616.47265625,-3.884765625,1001.026953125)
	setElementInterior(veh,1)
	setElementDimension(veh,3)
    vioSetElementData(mark,"isRacerBase", true)
	table.insert(tuningMarker,{mark,33,veh})
	
	local mark=createMarker(-2725.255859375,217.642578125,4.484375,"cylinder",2.0,0,0,0,0)
	veh=createVehicle(560,616.47265625,-3.884765625,1001.026953125)
	setElementInterior(veh,1)
	setElementDimension(veh,4)
    vioSetElementData(mark,"isRacerBase", false)
	table.insert(tuningMarker,{mark,15,veh})
	
	local mark=createMarker(-1935.8095703125,246.93359375,34.4609375,"cylinder",2.0,0,0,0,0)
	veh=createVehicle(560,616.47265625,-3.884765625,1001.026953125)
	setElementInterior(veh,1)
	setElementDimension(veh,5)
    vioSetElementData(mark,"isRacerBase", false)
	table.insert(tuningMarker,{mark,18,veh})
	
	for theKey,theTable in ipairs(tuningMarker)do
		local x,y,z=getElementPosition(theTable[1])
		createBlip(x,y,z,27,0.5,255,0,0,255,0,255,getRootElement())-- TUNING
	end

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),opentuningMarker)


function tuningMarker_func(hitElement)

	if(isElement(hitElement))then
		if(getElementType(hitElement)=="vehicle")then
			for theKey, theMarker in ipairs(tuningMarker) do
				if(theMarker[1]==source)then
					if(isGarageOpen(theMarker[2]) and not(torData[theMarker[2]]["disabled"]))then
						local driver=getVehicleOccupant ( hitElement, 0 )
						if(getVehicleType(hitElement)=="Automobile" and (privCars[hitElement]==true or (table.hasValue(frakselfcars[13], hitElement)) and vioGetElementData(source,"isRacerBase") and vioGetElementData(driver,"fraktion")==13) )then
                            if(table.hasValue(frakselfcars[13], hitElement) and vioGetElementData(source,"isRacerBase"))then
                                setGarageOpen(theMarker[2],false)
                                setElementDimension(driver,theKey)
                                removePedFromVehicle(driver)
                                setElementInterior(driver,1,616.47265625,-3.884765625,1001.026953125)
                                setElementPosition(driver,616.47265625,-3.884765625,1001.026953125)
                                vioSetElementData(driver,"PreTuningGarageID",theMarker[2])
                                tunVehData[theMarker[2]]=hitElement
                                torData[theMarker[2]]["disabled"]=true
                                toggleAllControls(driver,false)
                                vioSetElementData(driver,"cuffed",3)
                                setElementFrozen(hitElement,true)
                                destroyElement(theMarker[3])
                                theMarker[3]=createVehicle(560,616.47265625,-3.884765625,1001.026953125)
                                setElementInterior(theMarker[3],1,616.47265625,-3.884765625,1001.026953125)
                                setElementDimension(theMarker[3],theKey)
                                setElementFrozen(theMarker[3],true)
                                vioSetElementData(driver,"PreTuningVeh",hitElement)
                                setElementModel(theMarker[3],getElementModel(hitElement))
                                vioSetElementData(driver,"PreTuningGarageMarker",source)



                                -- ab hier umschreiben

                                local tuning = getVehicleUpgrades ( hitElement )
                                for theKey,theTuning in ipairs(tuning) do
                                    if(theTuning~=0 and tonumber(theTuning))then
                                        addVehicleUpgrade(theMarker[3],tonumber(theTuning))
                                    end
                                end
                                local colorA,colorB,colorC,colorD = getVehicleColor( hitElement )
                                local colors= colorA.."|"..colorB.."|"..colorC.."|"..colorD
                                local tuningstring=table.concat(tuning, "|")

                                setVehiclePaintjob(theMarker[3],getVehiclePaintjob(hitElement))
                                setVehicleColor(theMarker[3],tonumber(colors[1]),tonumber(colors[2]),tonumber(colors[3]),tonumber(colors[4]))

                                --while not(driver==getVehicleOccupant ( theMarker[3], 0 )) do
                                warpPedIntoVehicle(driver,theMarker[3])
                                --end
                                triggerClientEvent(driver,"showTuningGarage",theMarker[3],colors,getVehiclePaintjob(hitElement),tuningstring)



                            elseif(string.lower(vioGetElementData(hitElement,"besitzer"))==string.lower(getPlayerName(driver)))then
								
								setGarageOpen(theMarker[2],false)								
								setElementDimension(driver,theKey)
								removePedFromVehicle(driver)
								setElementInterior(driver,1,616.47265625,-3.884765625,1001.026953125)
								setElementPosition(driver,616.47265625,-3.884765625,1001.026953125)

								vioSetElementData(driver,"PreTuningGarageID",theMarker[2])
								vioSetElementData(driver,"PreTuningGarageMarker",source)

								tunVehData[theMarker[2]]=hitElement
								
								torData[theMarker[2]]["disabled"]=true
								toggleAllControls(driver,false)
								vioSetElementData(driver,"cuffed",3)
								setElementFrozen(hitElement,true)
								destroyElement(theMarker[3])
								theMarker[3]=createVehicle(560,616.47265625,-3.884765625,1001.026953125)
								setElementInterior(theMarker[3],1,616.47265625,-3.884765625,1001.026953125)
								setElementDimension(theMarker[3],theKey)	
								setElementFrozen(theMarker[3],true)
								vioSetElementData(driver,"PreTuningVeh",hitElement)
								setElementModel(theMarker[3],getElementModel(hitElement))
								
								local tuning=getStringComponents(vioGetElementData(hitElement,"tuning"))									
								for theKey,theTuning in ipairs(tuning) do
									if(theTuning~=0 and tonumber(theTuning))then
										addVehicleUpgrade(theMarker[3],tonumber(theTuning)) 
									end			
								end
								local colors=getStringComponents(vioGetElementData(hitElement,"colors"))
								setVehiclePaintjob(theMarker[3],vioGetElementData(hitElement,"paintjob"))
								setVehicleColor(theMarker[3],tonumber(colors[1]),tonumber(colors[2]),tonumber(colors[3]),tonumber(colors[4]))

								--while not(driver==getVehicleOccupant ( theMarker[3], 0 )) do
									warpPedIntoVehicle(driver,theMarker[3])
								--end
								triggerClientEvent(driver,"showTuningGarage",theMarker[3],vioGetElementData(hitElement,"colors"),vioGetElementData(hitElement,"paintjob"),vioGetElementData(hitElement,"tuning"))
                            else
                                showError(driver,"Wir fassen dieses geklaute Fahrzeug nicht an!")
                            end
						else
							showError(driver,"Dieses Fahrzeug kannst du nicht tunen!")
						end
					end				
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),tuningMarker_func)


addEvent("exitFromTuning",true)

function tuningMarker_Exit(newcolorstring,wasColorChanged,newtuningstring,pricing,paintjob)



	local driver=source
	local veh=vioGetElementData(driver,"PreTuningVeh")
	removePedFromVehicle(driver)
	warpPedIntoVehicle(driver,veh)
	
	for theKey,theUpgrad in ipairs(getVehicleUpgrades ( veh))do
		removeVehicleUpgrade ( veh,theUpgrad )
	end
	local hitElement=getPedOccupiedVehicle(source)	
	local theMarker=vioGetElementData(source,"PreTuningGarageID")
	local theMarkerElement=vioGetElementData(source,"PreTuningGarageMarker")

    local isRaceBase=vioGetElementData(theMarkerElement,"isRacerBase")
    if(vioGetElementData(driver,"fraktion")~=13 or not(table.hasValue(frakselfcars[13], hitElement)))then
        isRaceBase=false
    end

	if(newtuningstring=="")then
		newtuningstring="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
	end
	if(newcolorstring=="")then
		newcolorstring"0|0|0|0"
	end
	
	vioSetElementData(hitElement,"tuning",newtuningstring)
	vioSetElementData(hitElement,"colors",newcolorstring)
	vioSetElementData(hitElement,"paintjob",paintjob)
	
	setVehiclePaintjob(hitElement,paintjob)
	
	local tuning=getStringComponents(newtuningstring)
	local tuningstr=table.concat(tuning," ")
	
	for theKey,theTuning in ipairs(tuning) do
		if(theTuning~=0)then
			addVehicleUpgrade(hitElement,tonumber(theTuning)) 
		end			
	end
	if(wasColorChanged)then
		local colors=getStringComponents(newcolorstring)
		local costr=table.concat(colors," ")
		setVehicleColor(hitElement,tonumber(colors[1]),tonumber(colors[2]),tonumber(colors[3]),tonumber(colors[4]))
		vioSetElementData(hitElement,"premColor","-1")
	end			

	vioSetElementData(driver,"PreTuningGarageID",nil)
	setGarageOpen(theMarker,true)
	
	setTimer(undisabletuningmarker,5000,1,theMarker)
	
	
	local tuning=getStringComponents(vioGetElementData(hitElement,"tuning"))
	for theKey,theTuning in ipairs(tuning) do
		if(theTuning~=0)then
			addVehicleUpgrade(hitElement,tonumber(theTuning)) 
		end			
	end
	local colors=getStringComponents(vioGetElementData(hitElement,"colors"))
	setVehicleColor(hitElement,tonumber(colors[1]),tonumber(colors[2]),tonumber(colors[3]),tonumber(colors[4]))	

	toggleAllControls(driver,true)
	vioSetElementData(driver,"cuffed",0)
	--backspawn
	setElementInterior(driver,0)
	setElementDimension(driver,0)
	setElementHealth(hitElement,1000)


	pricing=pricing+5.00
	---Tunen
    changeBizKasse(6, pricing/5, "Tuning")
    if(not isRaceBase)then
        changePlayerMoney(driver,-pricing,"fahrzeug","Tuning")
    end
	setElementFrozen(hitElement,false)
    if(not table.hasValue(frakselfcars[13], hitElement))then
	    save_car(hitElement)
    end
	
end
addEventHandler("exitFromTuning",getRootElement(),tuningMarker_Exit)


function isintuning_offline()
	if(vioGetElementData(source,"PreTuningGarageID"))then
	
		setGarageOpen(vioGetElementData(source,"PreTuningGarageID"),true)
		
		torData[vioGetElementData(source,"PreTuningGarageID")]["disabled"]=false

	end
end
addEventHandler("onPlayerQuit",getRootElement(),isintuning_offline)

function undisabletuningmarker(marker)
	torData[marker]["disabled"]=false
end









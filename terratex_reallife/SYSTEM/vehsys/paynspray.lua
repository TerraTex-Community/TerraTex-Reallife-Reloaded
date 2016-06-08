function openPaynSpray()
	paynsprayMarker={}
	setGarageOpen ( 12,true)
	setGarageOpen (  8,true)
	setGarageOpen ( 11,true)
	setGarageOpen ( 36,true)
	setGarageOpen ( 40,true)
	setGarageOpen ( 41,true)
	setGarageOpen ( 47,true)
	setGarageOpen ( 32,true)
	setGarageOpen ( 19,true)
	setGarageOpen ( 27,true)
	local mark=createMarker(2063.349609375,-1831.2890625,11.252596855164,"cylinder",4.0,0,0,0,0)
	table.insert(paynsprayMarker,{mark,8})
	local mark=createMarker(487.388671875,-1741.552734375,8.837544441223,"cylinder",4.0,0,0,0,0)
	table.insert(paynsprayMarker,{mark,12})
	local mark=createMarker(1025.044921875,-1020.9736328125,32.098804473877,"cylinder",4.0,0,0,0,0)
	table.insert(paynsprayMarker,{mark,11})	
	local mark=createMarker(1977.2177734375,2162.5048828125,11.0703125,"cylinder",4.0,0,0,0,0)
	table.insert(paynsprayMarker,{mark,36})	
	local mark=createMarker(-1420.5849609375,2584.3154296875,55.84326171875,"cylinder",4.0,0,0,0,0)
	table.insert(paynsprayMarker,{mark,40})	
	local mark=createMarker(-100.0478515625,1117.5234375,19.74169921875,"cylinder",4.0,0,0,0,0)
	table.insert(paynsprayMarker,{mark,41})	
	local mark=createMarker(719.955078125,-456.3466796875,16.3359375,"cylinder",4.0,0,0,0,0)
	table.insert(paynsprayMarker,{mark,47})	
	--local mark=createMarker(2393.5419921875,1491.009765625,10.827350616455,"cylinder",4.0,0,0,0,0)
	--table.insert(paynsprayMarker,{mark,32})
	local mark=createMarker(-1904.517578125,285.4404296875,41.046875,"cylinder",4.0,0,0,0,0)
	table.insert(paynsprayMarker,{mark,19})
	local mark=createMarker(-2425.642578125,1021.76953125,50.397659301758,"cylinder",4.0,0,0,0,0)
	table.insert(paynsprayMarker,{mark,27})
	for theKey,theTable in ipairs(paynsprayMarker)do
		local x,y,z=getElementPosition(theTable[1])
		createBlip(x,y,z,63,0.5,255,0,0,255,0,255,getRootElement())-- Pay'N'Spray
	end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),openPaynSpray)

function paynsprayMarker(hitElement)
	if(isElement(hitElement))then
		if(getElementType(hitElement)=="vehicle")then
			for theKey, theMarker in pairs(paynsprayMarker) do
				if(theMarker[1]==source)then
					local driver=getVehicleOccupant ( hitElement, 0 )
					if(driver)then
						local m,mn,mb,mv=getVehicleWheelStates ( hitElement)
						local m=m+mn+mb+mv
						local health=1000-getElementHealth(hitElement)
                        local price=0
						if(vioGetElementData(driver,"playtime")<1500)then
							price=math.round(health*1.5+m*250)
						else
							price=math.round(health*3.5+m*250)*10
						end
						price=price/100
						if(getPlayerMoney(driver)<price)then
                            showError(driver,"Du hast nicht genug Geld!")
						else
							setElementVelocity(hitElement,0,0,0)
							setGarageOpen(theMarker[2],false)			
							m,mn,mb,mv=getVehicleWheelStates ( hitElement)
							m=m+mn+mb+mv
							toggleAllControls(driver,false)
							vioSetElementData(driver,"cuffed",3)
							vioSetElementData(driver,"isinpaynspray",true)
							vioSetElementData(driver,"lastpayngarage",theMarker[2])
							local timer=((1000-getElementHealth(hitElement))*15)+m*400+500
							setTimer(repairPaynSpray,timer,1,hitElement,theMarker[2],getElementHealth(hitElement),m)
							fixVehicle ( hitElement)
						end
					end
				end
			end
		end
	end
end
addEventHandler("onMarkerHit",getRootElement(),paynsprayMarker)

function repairPaynSpray(hitElement,door,health,m)
	fixVehicle ( hitElement)
	setVehicleWheelStates (hitElement,0,0,0,0)
	local driver=getVehicleOccupant ( hitElement, 0 )
	toggleAllControls(driver,true)
	health=1000-health
    local price=0
	if(vioGetElementData(driver,"playtime")<1500)then
		price=math.round(health*1.5+m*250)
	else
		price=math.round(health*3.5+m*250)*10
	end
	price=price/100
	local isInBeamtenCar=false
	for theKey,theBeamte in ipairs(policeVehicles)do
		if(theBeamte==hitElement)then
			isInBeamtenCar=true
		end
	end
	if(not(isInBeamtenCar))then
        changePlayerMoney(driver,-price,"fahrzeug","PaynSpray")
        changeBizKasse(5, price/5, "Reparatur")
	end
	outputChatBox(string.format("Die Reparatur hat %s gekostet!", toprice(price)),driver)
	vioSetElementData(driver,"cuffed",0)
	setGarageOpen(door,true)	
	vioSetElementData(driver,"isinpaynspray",false)
end

function onquitpayn()
	if(vioGetElementData(source,"isinpaynspray"))then
		setGarageOpen(vioGetElementData(source,"lastpayngarage"),true)
	end
end
addEventHandler("onPlayerQuit",getRootElement(),onquitpayn)









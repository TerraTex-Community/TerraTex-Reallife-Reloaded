frakselfcars[2]={}

function creategrovecars()
local vehicle=createVehicle(423,2491.14453125,-1756.44140625,13.535945892334,0.032958984375,0.0054931640625,270.05493164063,"grove")   --grovecar eiswagen
table.insert(frakselfcars[2],vehicle) 
--outputChatBox(tostring(vehicle))
vehicle=createVehicle(567,2468.90234375,-1669.9697265625,13.288883209229,0.032958984375,5.2349853515625,8.536376953125,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle) 
vehicle=createVehicle(467,2471.662109375,-1653.6318359375,13.141959190369,0.0933837890625,355.341796875,90.796508789063,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle) 
vehicle=createVehicle(412,2484.6279296875,-1654.1416015625,13.225496292114,359.97802734375,354.95178222656,86.934814453125,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle)
 vehicle=createVehicle(534,2499.708984375,-1648.828125,13.256625175476,0.472412109375,0.2362060546875,159.47204589844,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle)
 vehicle=createVehicle(421,2506.86328125,-1651.1650390625,13.618300437927,356.34704589844,359.60998535156,140.30090332031,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle)
 vehicle=createVehicle(467,2517.111328125,-1672.2021484375,13.795434951782,350.66711425781,355.89111328125,58.386840820313,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle)
 vehicle=createVehicle(474,2511.5986328125,-1687.2900390625,13.310326576233,0.0164794921875,359.62097167969,44.62646484375,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle)
 vehicle=createVehicle(475,2461.7236328125,-1686.4951171875,13.368364334106,359.58251953125,0.3240966796875,265.8251953125,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle)
 vehicle=createVehicle(421,2473.8134765625,-1694.5888671875,13.429149627686,359.96154785156,359.94506835938,359.912109375,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle) 
vehicle=createVehicle(567,2472.0615234375,-1703.5888671875,13.416701316833,0.2801513671875,359.88464355469,3.812255859375,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle)
 vehicle=createVehicle(567,2475.65234375,-1703.87890625,13.396607398987,0.3515625,359.97802734375,358.53881835938,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle)
 vehicle=createVehicle(413,2443.212890625,-1634.30859375,13.492918014526,359.18701171875,0.0714111328125,178.34106445313,"grove")   --grovecar 
table.insert(frakselfcars[2],vehicle) 
vehicle=createVehicle(413,2443.078125,-1642.1298828125,13.554611206055,359.53857421875,359.95056152344,179.28039550781,"grove")   --grovecar 

table.insert(frakselfcars[2],vehicle) 
 		for key, theVehicle in pairs(frakselfcars[2]) do
			prepare(theVehicle,2)
			setVehicleColor (theVehicle,86,86,86,86)
			vioSetElementData(theVehicle,"tank",100)
			table.insert(frakcars,theVehicle)
		end
		
	local console=getElementsByType("console")
		vioSetElementData(console[1],"adminlvl",4)
		
 end
 addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),creategrovecars)

 addEvent("triggerMeGroveCar",true)
 function sendGroveEiswagenPosition()
	--outputChatBox(tostring(frakselfcars[2][1]))
	triggerClientEvent(source,"sendGroveEiswagen",source,frakselfcars[2][1])
 end
 addEventHandler("triggerMeGroveCar",getRootElement(),sendGroveEiswagenPosition)
 
 function notingroveCarEnter(thePlayer, seat, jacked ,door)
	if(seat==0)then
		for theKey, theVehicle in pairs(frakselfcars[2]) do
			if(source==theVehicle)then
				if not(vioGetElementData(thePlayer,"fraktion")==2)then
                    showError(thePlayer,"Du kannst das nicht benutzen. Du bist kein Member der GroveStreet!")
					cancelEvent()
				end
			end
		end
	
	end 
 end
 addEventHandler ( "onVehicleStartEnter", getRootElement(), notingroveCarEnter )


 









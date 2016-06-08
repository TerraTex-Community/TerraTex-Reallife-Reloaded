frakselfcars[6] = {}

function createllscars()
	local vehicle = createVehicle(507, 658.591796875, -1501.5361328125, 14.692559242249, 359.7802734375, 359.99450683594, 270.03845214844, "LLS")    --  mafiaauto 
	table.insert(frakselfcars[6], vehicle)  
	vehicle= createVehicle(507, 658.9873046875, -1496.2822265625, 14.692824363708, 359.7802734375, 359.99450683594, 270.02746582031, "LLS")    --  mafiaauto 
	table.insert(frakselfcars[6], vehicle) 
	vehicle = createVehicle(545, 659.6298828125, -1453.4892578125, 14.687247276306, 0, 359.99450683594, 269.74731445313, "LLS")    --  mafiaatu 
	table.insert(frakselfcars[6], vehicle)  
	vehicle = createVehicle(545, 659.4990234375, -1449.8681640625, 14.682627677917, 0, 0.0054931640625, 269.384765625, "LLS")    --  mafiaatu 
	table.insert(frakselfcars[6], vehicle) 
	vehicle = createVehicle(555, 699.8857421875, -1434.2880859375, 13.205555915833, 359.83520507813, 359.85168457031, 321.97631835938, "LLS")    --  mafiaauto 
	table.insert(frakselfcars[6], vehicle) 
	vehicle = createVehicle(409, 729.1669921875, -1439.626953125, 13.338616371155, 0, 0, 89.862670898438, "LLS")    --  mafiaautofor before 
	table.insert(frakselfcars[6], vehicle)
	vehicle = createVehicle(551, 762.7587890625, -1427.943359375, 13.321616172791, 0.010986328125, 0.1153564453125, 181.65344238281, "LLS")    --  mafiaauto 
	table.insert(frakselfcars[6], vehicle) 
	vehicle = createVehicle(551, 766.6904296875, -1427.88671875, 13.351993560791, 359.93957519531, 0.142822265625, 179.33532714844, "LLS")    --  mafiaauto 
	table.insert(frakselfcars[6], vehicle) 
	vehicle = createVehicle(405, 770.291015625, -1428.001953125, 13.407961845398, 359.97802734375, 0.1922607421875, 177.87963867188, "LLS")    --  mafiaauto 
	table.insert(frakselfcars[6], vehicle)
	vehicle = createVehicle(579, 768.576171875, -1439.201171875, 13.417762756348, 358.96728515625, 359.71984863281, 89.005737304688, "LLS")    --  mafiaauto 
	table.insert(frakselfcars[6], vehicle)
	vehicle = createVehicle(579, 758.7724609375, -1437.962890625, 13.370362281799, 358.64868164063, 353.02368164063, 77.93701171875, "LLS")    --  mafiaauto 
	table.insert(frakselfcars[6], vehicle)
	vehicle = createVehicle(487, 726.041015625, -1461.2001953125, 22.40446472168, 0.2197265625, 359.74731445313, 90, "LLS")    --  mafiaauto
	table.insert(frakselfcars[6], vehicle) 
 
	for key, theVehicle in pairs(frakselfcars[6])  do
		prepare(theVehicle, 6)
		setVehicleColor (theVehicle, 0, 0, 0, 0)
		vioSetElementData(theVehicle, "tank", 100)
		table.insert(frakcars, theVehicle)
	end
end
 addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createllscars)

 
 function notinllsCarEnter(thePlayer, seat, jacked ,door)
	if (seat == 0) then
		for theKey, theVehicle in pairs(frakselfcars[6]) do
			if (source == theVehicle) then
				if not(vioGetElementData(thePlayer, "fraktion") == 6) then
                    showError(thePlayer, "Du kannst das nicht benutzen. Du bist kein Member der Legion of Los Santos!")
					cancelEvent()
				end
			end
		end
	end 
 end
 addEventHandler ( "onVehicleStartEnter", getRootElement(), notinllsCarEnter )
 


 









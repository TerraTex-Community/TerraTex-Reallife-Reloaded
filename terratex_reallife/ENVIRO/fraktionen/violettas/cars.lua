frakselfcars[12]={}
function createviolettacars()


 vehicle= createVehicle(467,2820.490234375,2252.017578125,10.560336112976,0.02197265625,359.99450683594,92.971801757813,"Pink Panthers")
 table.insert(frakselfcars[12],vehicle)
 vehicle= createVehicle(467,2820.591796875,2247.974609375,10.560042381287,0.02197265625,0.0164794921875,93.80126953125,"Pink Panthers")
 table.insert(frakselfcars[12],vehicle)
 vehicle= createVehicle(467,2820.7275390625,2244.099609375,10.559128761292,0.02197265625,0.032958984375,94.603271484375,"Pink Panthers")
 table.insert(frakselfcars[12],vehicle)
 vehicle= createVehicle(466,2820.337890625,2240.0439453125,10.568250656128,0.010986328125,0.087890625,98.036499023438,"Pink Panthers")
 table.insert(frakselfcars[12],vehicle)
 vehicle= createVehicle(466,2820.4111328125,2236.4033203125,10.568925857544,0.010986328125,0.0604248046875,95.850219726563,"Pink Panthers")
 table.insert(frakselfcars[12],vehicle)
 vehicle= createVehicle(576,2820.2568359375,2232.7861328125,10.436402320862,0.274658203125,0.2142333984375,93.103637695313,"Pink Panthers")
 table.insert(frakselfcars[12],vehicle)
 vehicle= createVehicle(576,2820.4990234375,2229.169921875,10.426923751831,0.296630859375,0.15380859375,89.763793945313,"Pink Panthers")
 table.insert(frakselfcars[12],vehicle)
 vehicle= createVehicle(576,2820.55078125,2225.0869140625,10.437337875366,0.2691650390625,0.0164794921875,92.587280273438,"Pink Panthers")
 table.insert(frakselfcars[12],vehicle)
 vehicle= createVehicle(576,2820.7255859375,2221.40625,10.436320304871,0.2691650390625,0.06591796875,89.829711914063,"Pink Panthers")
 table.insert(frakselfcars[12],vehicle)
 
 
 
  for theKey,theVehicle in ipairs(frakselfcars[12]) do
		setVehicleColor ( theVehicle, 255,0,255,255,0,255)
		prepare(theVehicle,12)
		addEventHandler("onVehicleStartEnter",theVehicle,donotentercarshforce)
		vioSetElementData(theVehicle,"tank",100)
			table.insert(frakcars,theVehicle)
	end
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createviolettacars)

 
function donotentercarshforce(player,seat)
	if not(vioGetElementData(player,"fraktion")==12)and(seat==0)then
		cancelEvent()
	end
end









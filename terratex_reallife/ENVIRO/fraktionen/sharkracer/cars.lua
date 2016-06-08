frakselfcars[13]={}
function createracecars()

     vehicle= createVehicle(451,2407.0888671875,1020.744140625,10.527860641479,359.53308105469,359.99450683594,269.67590332031, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(412,2392.8623046875,1039.0634765625,10.6577501297,0.186767578125,0,176.8359375, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(412,2397.60546875,1039.48828125,10.652333259583,0.186767578125,359.75280761719,174.50134277344, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(502,2394.2861328125,1017.94921875,10.712985038757,0.3240966796875,0,67.593383789063, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(502,2393.994140625,1013.72265625,10.710673332214,0.3350830078125,0,67.69775390625, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(562,2394.4267578125,1008.953125,10.48073387146,359.54956054688,359.99450683594,63.7646484375, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(562,2394.2724609375,1004.544921875,10.479678153992,359.54406738281,359.99450683594,59.150390625, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(559,2394.447265625,999.640625,10.476634025574,359.98901367188,359.99450683594,56.826782226563, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(559,2394.2373046875,994.65625,10.476656913757,359.98901367188,359.99450683594,55.662231445313, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(559,2393.94140625,989.6865234375,10.47661781311,359.98901367188,359.99450683594,55.118408203125, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(560,2390.2802734375,986.03515625,10.525423049927,359.8681640625,359.99450683594,52.27294921875, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(560,2384.8330078125,986.14453125,10.525995254517,359.8681640625,359.99450683594,48.69140625, "Race")
     table.insert(frakselfcars[13],vehicle)
     vehicle= createVehicle(560,2379.744140625,986.0986328125,10.525149345398,359.8681640625,359.99450683594,46.175537109375, "Race")
     table.insert(frakselfcars[13],vehicle)

    for theKey,theVehicle in ipairs(frakselfcars[13]) do
		setVehicleColor ( theVehicle, math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255),math.random(0,255))
		prepare(theVehicle,13)
		addEventHandler("onVehicleStartEnter",theVehicle,donotenterrace)
		vioSetElementData(theVehicle,"tank",100)
        table.insert(frakcars,theVehicle)
    end
	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createracecars)

 
function donotenterrace(player,seat)
	if not(vioGetElementData(player,"fraktion")==13)and(seat==0)then
		cancelEvent()
	end
end









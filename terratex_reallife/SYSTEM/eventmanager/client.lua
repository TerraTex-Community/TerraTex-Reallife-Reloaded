addEvent("onPlayerEnterWater",true)
addEvent("onPlayerLeaveWater",true)
addEvent("onVehicleEnterWater",true)


local preDefs={
	["wasInWater"]=false,
	["vehiclesInWater"]={}
}


function oneventmanager_func ()
	--PedEnterWater
		if(isElementInWater(getLocalPlayer()))then
			if not(preDefs["wasInWater"])then
				triggerEvent("onPlayerEnterWater",getLocalPlayer())
				triggerServerEvent("onPlayerEnterWater",getLocalPlayer())
				preDefs["wasInWater"]=true			
			end
		else
			if(preDefs["wasInWater"])then
				triggerEvent("onPlayerLeaveWater",getLocalPlayer())
				triggerServerEvent("onPlayerLeaveWater",getLocalPlayer())
				preDefs["wasInWater"]=false			
			end
		end	
	--VehicleEnterWater
		local vehicles=getElementsByType ( "vehicle", getRootElement(), true )
		for theKey,theVehicle in ipairs (vehicles) do
			if(isElementInWater(theVehicle) and not( getVehicleType (theVehicle)=="Boat") and not(getElementModel(theVehicle)==417) and not(getElementModel(theVehicle)==447) and not(getElementModel(theVehicle)==460) and not(getElementModel(theVehicle)==539))then		
				if(not(preDefs["vehiclesInWater"][theVehicle]))then
					preDefs["vehiclesInWater"][theVehicle]=true
					triggerEvent("onVehicleEnterWater",theVehicle)
					triggerServerEvent("onVehiclePreEnterWater",theVehicle)
				end
			else
				preDefs["vehiclesInWater"][theVehicle]=false
			end
		end	
end
addEventHandler ( "onClientRender", getRootElement(), oneventmanager_func )









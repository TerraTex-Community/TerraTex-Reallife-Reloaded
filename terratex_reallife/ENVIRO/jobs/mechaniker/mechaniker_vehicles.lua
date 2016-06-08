mechVehicles={}

--Job Nr. 5

function createMechVehicles()
	
	mechVehicles[1]= createVehicle(552, 1651.1211,-1818.4062,13.2662,0,0,180)    
	mechVehicles[2]= createVehicle(552,1651.121,-1828.479,13.2662,0,0,180)
	mechVehicles[3]= createVehicle(552, 1651.1211,-1808.333,13.2662,0,0,180)
	mechVehicles[4]= createVehicle(552,1651.1211,-1828.4785,13.2662,0,0,180)
	mechVehicles[5]= createVehicle(552,1635.234,-1844.325,13.2662,0,0,0)
	mechVehicles[5]= createVehicle(552,1630.2676,-1844.3252,13.2662,0,0,0)




    for theKey,theVehicle in ipairs(mechVehicles) do
		addEventHandler("onVehicleEnter",theVehicle,kick_from_mechaniker_car)
		prepare(theVehicle,0)

        vioSetElementData(theVehicle,"hasTank",true)
	end
	
	setTimer(respawnMechiCars,300000,1)	
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createMechVehicles)

function kick_from_mechaniker_car(thePlayer,Seat)
	if(Seat==0)then
		if(vioGetElementData(thePlayer,"job")~=5)then
			removePedFromVehicle ( thePlayer )
		end	
	end
end

function respawnMechiCars()
	for key, theVehicle in pairs(mechVehicles) do
		if not(isAnyOneInVehicle(theVehicle))then
			setVehicleOverrideLights (theVehicle,1)
			setVehicleEngineState (theVehicle,false)				
			respawnVehicle (theVehicle)
            vioSetElementData(theVehicle,"tank",100)

		end
	end
	setTimer(respawnMechiCars,300000,1)		
end
 









local sweeperJobCars={}

function createSweeperJob()
	vehicle= createVehicle(574,1657.3779296875,708.8974609375,10.545485496521,0,359.99450683594,1.241455078125)    
	table.insert(sweeperJobCars,vehicle)
	vehicle= createVehicle(574,1661.5830078125,708.666015625,10.545473098755,0,359.99450683594,0.02197265625)  
	table.insert(sweeperJobCars,vehicle)  
	vehicle= createVehicle(574,1665.927734375,709.0634765625,10.545475959778,0,359.99450683594,0.5548095703125) 
	table.insert(sweeperJobCars,vehicle)
	vehicle= createVehicle(574,1670.2265625,709.0126953125,10.545469284058,0,359.99450683594,359.31884765625)     
	table.insert(sweeperJobCars,vehicle)
	vehicle= createVehicle(574,1670.3857421875,731.5810546875,10.545469284058,0,359.99450683594,180.33508300781)    
	table.insert(sweeperJobCars,vehicle)
	vehicle= createVehicle(574,1666.53125,731.0400390625,10.545467376709,0,359.99450683594,180.18676757813)     
	table.insert(sweeperJobCars,vehicle)
	vehicle= createVehicle(574,1662.453125,731.84375,10.545481681824,0,359.99450683594,179.97253417969)     
	table.insert(sweeperJobCars,vehicle)
	vehicle= createVehicle(574,1657.9990234375,732.2216796875,10.545477867126,0,359.99450683594,180.43395996094)    
	table.insert(sweeperJobCars,vehicle)
 	for thekey,theVehicle in ipairs( sweeperJobCars ) do
		addEventHandler("onVehicleEnter",theVehicle,enterSweeperJobCar)
		addEventHandler("onVehicleExit",theVehicle,exitSweeperJobCar)
		addEventHandler("onVehicleStartExit",theVehicle,exitSweeperJobCar)
 		prepare(theVehicle,0)
        vioSetElementData(theVehicle,"hasTank",true)
	end
	respawnSweeperCars()
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),createSweeperJob)

function respawnSweeperCars()
	for key, theVehicle in pairs(sweeperJobCars) do
		if not(isAnyOneInVehicle(theVehicle))then
			setVehicleOverrideLights (theVehicle,1)
			setVehicleEngineState (theVehicle,false)				
			respawnVehicle (theVehicle)
            vioSetElementData(theVehicle,"tank",100)
		end
	end
	setTimer(respawnSweeperCars,300000,1)		
end
 
function enterSweeperJobCar(thePlayer)
	if(vioGetElementData(thePlayer,"job")==13)then
		triggerClientEvent(thePlayer,"startSweeperJob",thePlayer)
	else
		removePedFromVehicle(thePlayer)
	end
end

function exitSweeperJobCar(thePlayer)
	if(vioGetElementData(thePlayer,"job")==13)then
		triggerClientEvent(thePlayer,"exitSweeperJob",thePlayer)
	end
end

addEvent("giveBackSweeperJob",true)
function giveBackSweeperJob_func(kilometer,checkpoints)
	local thePlayer=source
    local betragDirekt,betragPayDay=giveJobGehalt(source,13,checkpoints,kilometer)

	outputChatBox("Sie haben erhalten "..toprice(betragPayDay).." Gehalt.",source)


    vioSetElementData(source,"Punkte_Strassenreiniger",vioGetElementData(source,"Punkte_Strassenreiniger")+kilometer)
    if(vioGetElementData(source,"Punkte_Strassenreiniger")>100000)then
        if(vioGetElementData(source,"Erfolg_Strassenreiniger")~=1)then
            vioSetElementData(source,"Erfolg_Strassenreiniger",1)
            triggerClientEvent(source,"onClientCreatePokalGUI",source,"Straßenreiniger","100km Straße gereinigt.")
        end
    end

end
addEventHandler("giveBackSweeperJob",getRootElement(),giveBackSweeperJob_func)	









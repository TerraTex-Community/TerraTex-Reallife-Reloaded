addEvent("farmerjob_mission_start_9",false)
function farmerjob_mission_start_9()
	--outputChatBox("succesfull")
	local tractor=createVehicle(455,-1050.6953125,-1203.205078125,128.94163513184,358.49487304688,359.60998535156,178.63220214844)   
	setVehicleVariant ( tractor, 3 ,3 )
	setElementPosition(source,-1050.6953125,-1203.205078125,128.94163513184)
	warpPedIntoVehicle(source,tractor)
	--setTimer(setElementCollisionsEnabled,1000,1,tractor,false )
	addEventHandler("onVehicleStartExit",tractor,stopExitingTractor_mission_9)
	addEventHandler("onVehicleStartEnter",tractor,stopExitingTractor_mission_9)
	addEventHandler("onVehicleExplode",tractor,onVehicleMission_3_explode)
	triggerClientEvent(source,"startFarmMission_9",source,tractor)
	vioSetElementData(source,"isFarmingActiv",true)
	outputChatBox("Fahre mit meinen Laster Holz holen! (blauer Marker)",source,0,255,0)	
end
addEventHandler("farmerjob_mission_start_9",getRootElement(),farmerjob_mission_start_9)

addEvent("finish_farmer_mission_9",true)
function finish_farmer_mission_9_func()
	outputChatBox("Danke, dass du das Holz geholt hast!",source,0,255,0)
	vioSetElementData(source,"isFarmingActiv",false)
	farmer_mission_cancel(source)
	destroyElement(getPedOccupiedVehicle(source))
end
addEventHandler("finish_farmer_mission_9",getRootElement(),finish_farmer_mission_9_func)

function stopExitingTractor_mission_9()
	cancelEvent()
end

addEvent("changeVehicleVarianteFuer_mission_9",true)
function changeVehicleVarianteFuer_mission_9_func()
	local veh=getPedOccupiedVehicle(source)
	setVehicleVariant ( veh, 2,1 )
end
addEventHandler("changeVehicleVarianteFuer_mission_9",getRootElement(),changeVehicleVarianteFuer_mission_9_func)










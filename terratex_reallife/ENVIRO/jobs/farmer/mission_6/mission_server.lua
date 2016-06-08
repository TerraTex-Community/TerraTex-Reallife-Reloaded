addEvent("farmerjob_mission_start_6",false)
function farmerjob_mission_start_6()
	--outputChatBox("succesfull")
	local tractor=createVehicle(478,-1050.6953125,-1203.205078125,128.94163513184,358.49487304688,359.60998535156,178.63220214844)   
	setElementPosition(source,-1050.6953125,-1203.205078125,128.94163513184)
	warpPedIntoVehicle(source,tractor)
	--setTimer(setElementCollisionsEnabled,1000,1,tractor,false )
	addEventHandler("onVehicleStartExit",tractor,stopExitingTractor_mission_6)
	addEventHandler("onVehicleStartEnter",tractor,stopExitingTractor_mission_6)
	addEventHandler("onVehicleExplode",tractor,onVehicleMission_3_explode)
	triggerClientEvent(source,"startFarmMission_6",source,tractor)
	vioSetElementData(source,"isFarmingActiv",true)
	outputChatBox("Fahre mit meinen Laster den Dünger aus SF holen! (blauer Marker)",source,0,255,0)	
end
addEventHandler("farmerjob_mission_start_6",getRootElement(),farmerjob_mission_start_6)

addEvent("finish_farmer_mission_6",true)
function finish_farmer_mission_6_func()
	outputChatBox("Danke, dass du den Dünger abgeholt hast!",source,0,255,0)
	vioSetElementData(source,"isFarmingActiv",false)
	farmer_mission_cancel(source)
	destroyElement(getPedOccupiedVehicle(source))
end
addEventHandler("finish_farmer_mission_6",getRootElement(),finish_farmer_mission_6_func)

function stopExitingTractor_mission_6()
	cancelEvent()
end










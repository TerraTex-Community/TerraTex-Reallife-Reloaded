addEvent("farmerjob_mission_start_7",false)
function farmerjob_mission_start_7()
	--outputChatBox("succesfull")
	local tractor=createVehicle(478,-1050.6953125,-1203.205078125,128.94163513184,358.49487304688,359.60998535156,178.63220214844)   
	setElementPosition(source,-1050.6953125,-1203.205078125,128.94163513184)
	warpPedIntoVehicle(source,tractor)
	--setTimer(setElementCollisionsEnabled,1000,1,tractor,false )
	addEventHandler("onVehicleStartExit",tractor,stopExitingTractor_mission_7)
	addEventHandler("onVehicleStartEnter",tractor,stopExitingTractor_mission_7)
	addEventHandler("onVehicleExplode",tractor,onVehicleMission_3_explode)
	triggerClientEvent(source,"startFarmMission_7",source,tractor)
	vioSetElementData(source,"isFarmingActiv",true)
	outputChatBox("Fahre mit meinen Laster Benzin holen! (blauer Marker)",source,0,255,0)	
end
addEventHandler("farmerjob_mission_start_7",getRootElement(),farmerjob_mission_start_7)

addEvent("finish_farmer_mission_7",true)
function finish_farmer_mission_7_func()
	outputChatBox("Danke, dass du Benzin geholt hast!",source,0,255,0)
	vioSetElementData(source,"isFarmingActiv",false)
	destroyElement(getPedOccupiedVehicle(source))
	farmer_mission_cancel(source)
end
addEventHandler("finish_farmer_mission_7",getRootElement(),finish_farmer_mission_7_func)

function stopExitingTractor_mission_7()
	cancelEvent()
end










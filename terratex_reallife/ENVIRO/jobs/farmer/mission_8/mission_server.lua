addEvent("farmerjob_mission_start_8",false)
function farmerjob_mission_start_8()
	--outputChatBox("succesfull")
	local tractor=createVehicle(478,-1050.6953125,-1203.205078125,128.94163513184,358.49487304688,359.60998535156,178.63220214844)   
	setElementPosition(source,-1050.6953125,-1203.205078125,128.94163513184)
	warpPedIntoVehicle(source,tractor)
	--setTimer(setElementCollisionsEnabled,1000,1,tractor,false )
	addEventHandler("onVehicleStartExit",tractor,stopExitingTractor_mission_8)
	addEventHandler("onVehicleStartEnter",tractor,stopExitingTractor_mission_8)
	addEventHandler("onVehicleExplode",tractor,onVehicleMission_3_explode)
	triggerClientEvent(source,"startFarmMission_8",source,tractor)
	vioSetElementData(source,"isFarmingActiv",true)
	outputChatBox("Tante Emma hat für Gerdrude einen Kuchen gebacken! Hol diesen für Sie ab! (blauer Marker)",source,0,255,0)	
end
addEventHandler("farmerjob_mission_start_8",getRootElement(),farmerjob_mission_start_8)

addEvent("finish_farmer_mission_8",true)
function finish_farmer_mission_8_func()
	outputChatBox("Danke, dass du den Kuchen geholt hast!",source,0,255,0)
	vioSetElementData(source,"isFarmingActiv",false)
	farmer_mission_cancel(source)
	destroyElement(getPedOccupiedVehicle(source))
end
addEventHandler("finish_farmer_mission_8",getRootElement(),finish_farmer_mission_8_func)

function stopExitingTractor_mission_8()
	cancelEvent()
end










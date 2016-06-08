addEvent("farmerjob_mission_start_5",false)
function farmerjob_mission_start_5()
	--outputChatBox("succesfull")
	local tractor=createVehicle(532,-163.5947265625,-1410.4521484375,4.0074458122253,0.7196044921875,0.0054931640625,109.19311523438)  
	setElementPosition(source,-163.5947265625,-1410.4521484375,4.0074458122253)
	warpPedIntoVehicle(source,tractor)
	--setTimer(setElementCollisionsEnabled,1000,1,tractor,false )
	addEventHandler("onVehicleStartExit",tractor,stopExitingTractor_mission_5)
	addEventHandler("onVehicleStartEnter",tractor,stopExitingTractor_mission_5)
	triggerClientEvent(source,"startFarmMission_5",source,tractor)
	addEventHandler("onVehicleExplode",tractor,onVehicleMission_3_explode)
	vioSetElementData(source,"isFarmingActiv",true)
	outputChatBox("Die Müllers brauchen Hilfe, bring deren Ernte ein! (Sammle alle grünen Marker ein!",source,0,255,0)	
end
addEventHandler("farmerjob_mission_start_5",getRootElement(),farmerjob_mission_start_5)

addEvent("finish_farmer_mission_5",true)
function finish_farmer_mission_5_func()
	outputChatBox("Danke, dass du das Feld geerntet hast!",source,0,255,0)
	vioSetElementData(source,"isFarmingActiv",false)
	farmer_mission_cancel(source)
	destroyElement(getPedOccupiedVehicle(source))
	setElementPosition(source,-1058.248046875,-1195.4794921875,129.17562866211)
	setTimer(setElementPosition,2000,1,source,-1058.248046875,-1195.4794921875,129.17562866211)
end
addEventHandler("finish_farmer_mission_5",getRootElement(),finish_farmer_mission_5_func)

function stopExitingTractor_mission_5()
	cancelEvent()
end










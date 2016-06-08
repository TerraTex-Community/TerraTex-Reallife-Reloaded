addEvent("farmerjob_mission_start_3",false)
function farmerjob_mission_start_3()
	--outputChatBox("succesfull")
	local tractor=createVehicle(531,-1195.5185546875,-1053.25,129.18412780762,0.384521484375,0,271.91711425781)
	setElementPosition(source,-1195.5185546875,-1053.25,129.18412780762)
	warpPedIntoVehicle(source,tractor)
	--setTimer(setElementCollisionsEnabled,1000,1,tractor,false )
	addEventHandler("onVehicleStartExit",tractor,stopExitingTractor_mission_3)
	addEventHandler("onVehicleStartEnter",tractor,stopExitingTractor_mission_3)
	addEventHandler("onVehicleExplode",tractor,onVehicleMission_3_explode)
	triggerClientEvent(source,"startFarmMission_3",source,tractor)
	vioSetElementData(source,"isFarmingActiv",true)
	outputChatBox("Fahre mit dem Traktor den Dünger aus! (Sammle alle grünen Marker ein!",source,0,255,0)	
end
addEventHandler("farmerjob_mission_start_3",getRootElement(),farmerjob_mission_start_3)

addEvent("finish_farmer_mission_3",true)
function finish_farmer_mission_3_func()
	outputChatBox("Danke, dass du das Feld gedüngt hast!",source,0,255,0)
	vioSetElementData(source,"isFarmingActiv",false)
	destroyElement(getPedOccupiedVehicle(source))
	farmer_mission_cancel(source)
end
addEventHandler("finish_farmer_mission_3",getRootElement(),finish_farmer_mission_3_func)

function stopExitingTractor_mission_3()
	cancelEvent()
end

function onDisconnectMissionFarmer()
	if(vioGetElementData(source,"isFarmingActiv"))then
		local veh=getPedOccupiedVehicle(source)
		if isElement(veh)then
			local anhang=vioGetElementData(tractor,"anhang")
			if(isElement(anhang))then
				destroyElement(anhang)
			end
			destroyElement(veh)
		end			
		triggerClientEvent(source,"DeleteMissionFarmerStop",source)
		--farmer_mission_cancel(source)
	end
	vioSetElementData(source,"isFarmingActiv",false)
	
end
addEventHandler("onPlayerQuit",getRootElement(),onDisconnectMissionFarmer)
addEventHandler("onPlayerWasted",getRootElement(),onDisconnectMissionFarmer)

function onVehicleMission_3_explode()
	local ped=getVehicleOccupant(source)
	destroyElement(source)
	if(isElement(ped))then
		vioSetElementData(ped,"isFarmingActiv",false)
		triggerClientEvent(ped,"DeleteMissionFarmerStop",ped)
	end
end











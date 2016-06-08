addEvent("farmerjob_mission_start_4",false)
function farmerjob_mission_start_4()
	--outputChatBox("succesfull")
	local tractor=createVehicle(531,-1195.5185546875,-1053.25,129.18412780762,0.384521484375,0,271.91711425781)
	setElementPosition(source,-1195.5185546875,-1053.25,129.18412780762)
	warpPedIntoVehicle(source,tractor)
	--setTimer(setElementCollisionsEnabled,1000,1,tractor,false )
	addEventHandler("onVehicleStartExit",tractor,stopExitingTractor_mission_4)
	addEventHandler("onVehicleStartEnter",tractor,stopExitingTractor_mission_3)
	addEventHandler("onVehicleExplode",tractor,onVehicleMission_4_explode)
	local anhaenger=createVehicle(610,-1195.5185546875,-1053.25,129.18412780762,0.384521484375,0,271.91711425781)
	attachTrailerToVehicle ( tractor, anhaenger)
	vioSetElementData(tractor,"anhang",anhaenger)
	addEventHandler("onTrailerDetach", anhaenger, reattachTrailerfarmmission4)
	triggerClientEvent(source,"startFarmMission_4",source,tractor,anhaenger)
	vioSetElementData(source,"isFarmingActiv",true)
	outputChatBox("Fahre mit dem Traktor und Plüge das Feld! (Sammle alle grünen Marker ein!",source,0,255,0)	
end
addEventHandler("farmerjob_mission_start_4",getRootElement(),farmerjob_mission_start_4)

addEvent("finish_farmer_mission_4",true)
function finish_farmer_mission_4_func()
	outputChatBox("Danke, dass du das Feld gepflügt hast!",source,0,255,0)
	vioSetElementData(source,"isFarmingActiv",false)
	farmer_mission_cancel(source)
	destroyElement(vioGetElementData(getPedOccupiedVehicle(source),"anhang"))
	destroyElement(getPedOccupiedVehicle(source))
end
addEventHandler("finish_farmer_mission_4",getRootElement(),finish_farmer_mission_4_func)

function stopExitingTractor_mission_4()
	cancelEvent()
end

function onVehicleMission_4_explode()
	local ped=getVehicleOccupant(source)
	local ang=vioGetElementData(source,"anhang")
	if(isElement(source))then
		destroyElement(source)
	end
	if(isElement(ang))then
		destroyElement(ang)
	end
	vioSetElementData(ped,"isFarmingActiv",false)
	triggerClientEvent(ped,"DeleteMissionFarmerStop",ped)
end

function reattachTrailerfarmmission4(theTruck)
    attachTrailerToVehicle(theTruck, source) -- Reattach the truck and trailer
end 









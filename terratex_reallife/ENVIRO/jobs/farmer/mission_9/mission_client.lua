local mission_9_blib=false

addEvent("startFarmMission_9",true)
function startFarmMission_9_func(tractor)	
	farmerJobExplodeDeleteTable={}
	setTimer(sync_cooli,500,1,tractor)	
	local marker=createMarker ( -564.2568359375,-86.267578125,63.797309875488, "checkpoint", 2.0, 0, 255, 0)
	mission_9_blib=createBlip ( -564.2568359375,-86.267578125,63.797309875488, 0, 2, 0,0,255)
		addEventHandler("onClientMarkerHit",marker,hitShowNextmarker_mission_9,false)		
		table.insert(farmerJobExplodeDeleteTable,marker)		
		table.insert(farmerJobExplodeDeleteTable,mission_9_blib)
end
addEventHandler("startFarmMission_9",getRootElement(),startFarmMission_9_func)

function hitShowNextmarker_mission_9(player)
	if(player==getLocalPlayer())then
		destroyElement(source)
		destroyElement(mission_9_blib)
		outputChatBox("Bring das Holz zur Farm",0,255,0)
		local marker=createMarker ( -1050.6953125,-1203.205078125,128.94163513184 , "checkpoint", 2.0, 0, 255, 0)
		mission_9_blib=createBlip ( -1050.6953125,-1203.205078125,128.94163513184, 0, 2, 0,0,255)
		table.insert(farmerJobExplodeDeleteTable,marker)
		triggerServerEvent("changeVehicleVarianteFuer_mission_9",getLocalPlayer())
		table.insert(farmerJobExplodeDeleteTable,mission_9_blib)
		addEventHandler("onClientMarkerHit",marker,hitShowEndmarker_mission_9,false)
	end
end

function hitShowEndmarker_mission_9(player)
	if(player==getLocalPlayer())then
		destroyElement(source)
		destroyElement(mission_9_blib)
		triggerServerEvent("finish_farmer_mission_9",getLocalPlayer())
	end
end









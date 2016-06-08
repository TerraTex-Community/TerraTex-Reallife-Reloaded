local mission_8_blib=false

addEvent("startFarmMission_8",true)
function startFarmMission_8_func(tractor)	
	farmerJobExplodeDeleteTable={}
	setTimer(sync_cooli,500,1,tractor)	
	local marker=createMarker ( 237.505859375,-95.681640625,1.2059762477875, "checkpoint", 2.0, 0, 255, 0)
	mission_8_blib=createBlip ( 237.505859375,-95.681640625,1.2059762477875, 0, 2, 0,0,255)
		addEventHandler("onClientMarkerHit",marker,hitShowNextmarker_mission_8,false)		
		table.insert(farmerJobExplodeDeleteTable,marker)		
		table.insert(farmerJobExplodeDeleteTable,mission_8_blib)
end
addEventHandler("startFarmMission_8",getRootElement(),startFarmMission_8_func)

function hitShowNextmarker_mission_8(player)
	if(player==getLocalPlayer())then
		destroyElement(source)
		destroyElement(mission_8_blib)
		outputChatBox("Bring den Kuchen zur Farm",0,255,0)
		local marker=createMarker ( -1050.6953125,-1203.205078125,128.94163513184 , "checkpoint", 2.0, 0, 255, 0)
		mission_8_blib=createBlip ( -1050.6953125,-1203.205078125,128.94163513184, 0, 2, 0,0,255)
		table.insert(farmerJobExplodeDeleteTable,marker)		
		table.insert(farmerJobExplodeDeleteTable,mission_8_blib)
		addEventHandler("onClientMarkerHit",marker,hitShowEndmarker_mission_8,false)
	end
end

function hitShowEndmarker_mission_8(player)
	if(player==getLocalPlayer())then
		destroyElement(source)
		destroyElement(mission_8_blib)
		triggerServerEvent("finish_farmer_mission_8",getLocalPlayer())
	end
end









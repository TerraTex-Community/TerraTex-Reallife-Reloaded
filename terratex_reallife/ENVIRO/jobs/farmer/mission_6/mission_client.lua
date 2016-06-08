local mission_6_blib=false

addEvent("startFarmMission_6",true)
function startFarmMission_6_func(tractor)	
	farmerJobExplodeDeleteTable={}
	setTimer(sync_cooli,500,1,tractor)	
	local marker=createMarker ( -2593.236328125,309.02734375,4.5716600418091 , "checkpoint", 2.0, 0, 255, 0)
	mission_6_blib=createBlip ( -2593.236328125,309.02734375,4.5716600418091, 0, 2, 0,0,255)
		addEventHandler("onClientMarkerHit",marker,hitShowNextmarker_mission_6,false)		
		table.insert(farmerJobExplodeDeleteTable,marker)		
		table.insert(farmerJobExplodeDeleteTable,mission_6_blib)
end
addEventHandler("startFarmMission_6",getRootElement(),startFarmMission_6_func)

function hitShowNextmarker_mission_6(player)
	if(player==getLocalPlayer())then
		destroyElement(source)
		destroyElement(mission_6_blib)
		outputChatBox("Bring den Dünger nun wieder zur Farm",0,255,0)
		local marker=createMarker ( -1050.6953125,-1203.205078125,128.94163513184 , "checkpoint", 2.0, 0, 255, 0)
		mission_6_blib=createBlip ( -1050.6953125,-1203.205078125,128.94163513184, 0, 2, 0,0,255)
		table.insert(farmerJobExplodeDeleteTable,marker)		
		table.insert(farmerJobExplodeDeleteTable,mission_6_blib)
		addEventHandler("onClientMarkerHit",marker,hitShowEndmarker_mission_6,false)
	end
end

function hitShowEndmarker_mission_6(player)
	if(player==getLocalPlayer())then
		destroyElement(source)
		destroyElement(mission_6_blib)
		triggerServerEvent("finish_farmer_mission_6",getLocalPlayer())
	end
end









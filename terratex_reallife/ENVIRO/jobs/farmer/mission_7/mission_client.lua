local mission_7_blib=false

addEvent("startFarmMission_7",true)
function startFarmMission_7_func(tractor)	
	farmerJobExplodeDeleteTable={}
	setTimer(sync_cooli,500,1,tractor)	
	local marker=createMarker ( -82.7001953125,-1173.623046875,2.1520614624023 , "checkpoint", 2.0, 0, 255, 0)
	mission_7_blib=createBlip ( -82.7001953125,-1173.623046875,2.1520614624023, 0, 2, 0,0,255)
		addEventHandler("onClientMarkerHit",marker,hitShowNextmarker_mission_7,false)		
		table.insert(farmerJobExplodeDeleteTable,marker)		
		table.insert(farmerJobExplodeDeleteTable,mission_7_blib)
end
addEventHandler("startFarmMission_7",getRootElement(),startFarmMission_7_func)

function hitShowNextmarker_mission_7(player)
	if(player==getLocalPlayer())then
		destroyElement(source)
		destroyElement(mission_7_blib)
		outputChatBox("Bring das Benzin zur Farm",0,255,0)
		local marker=createMarker ( -1050.6953125,-1203.205078125,128.94163513184 , "checkpoint", 2.0, 0, 255, 0)
		mission_7_blib=createBlip ( -1050.6953125,-1203.205078125,128.94163513184, 0, 2, 0,0,255)
		table.insert(farmerJobExplodeDeleteTable,marker)		
		table.insert(farmerJobExplodeDeleteTable,mission_7_blib)
		addEventHandler("onClientMarkerHit",marker,hitShowEndmarker_mission_7,false)
	end
end

function hitShowEndmarker_mission_7(player)
	if(player==getLocalPlayer())then
		destroyElement(source)
		destroyElement(mission_7_blib)
		triggerServerEvent("finish_farmer_mission_7",getLocalPlayer())
	end
end









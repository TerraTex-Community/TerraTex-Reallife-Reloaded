local heuregen=0
local heuregenmarker={
	{-1129.5029296875,-1156.92578125,130.81875610352}, 
	 {-1133.2177734375,-1156.7041015625,130.81875610352}, 
	 {-1136.4443359375,-1156.6357421875,130.81875610352}, 
	 {-1140.068359375,-1156.8271484375,130.81875610352}, 
	 {-1143.58203125,-1156.767578125,130.81875610352}, 
	 {-1146.93359375,-1156.69140625,130.81875610352}, 
	 {-1150.833984375,-1156.8232421875,130.81875610352}, 
	 {-1153.9921875,-1156.7138671875,130.81875610352}, 
	 {-1158.095703125,-1156.90234375,130.81875610352}, 
	 {-1161.6630859375,-1156.8583984375,130.81875610352}, 
	 {-1164.8486328125,-1156.5859375,130.81875610352}, 
	 {-1174.6396484375,-1169.966796875,129.21875}, 
	 {-1179.4013671875,-1169.7099609375,129.21875}, 
	 {-1181.953125,-1169.814453125,129.21875}, 
	 {-1186.6689453125,-1169.6708984375,129.21875}, 
	 {-1189.2080078125,-1169.607421875,129.21875}, 
	 {-1193.970703125,-1169.9091796875,129.21875}, 
	 {-1196.5078125,-1169.9501953125,129.21875}, 
	 {-1201.201171875,-1169.609375,129.21875}, 
	 {-1203.890625,-1170.9755859375,129.21875}, 
	 {-1208.50390625,-1169.880859375,129.21875},
}

addEvent("startFarmMission_2",true)
function startFarmMission_2_func()
	heuregen=0
	for theKey,thePaar in ipairs(heuregenmarker)do
		local marker=createMarker ( thePaar[1],thePaar[2],thePaar[3], "checkpoint", 2.0, 0, 255, 0)
		addEventHandler("onClientMarkerHit",marker,hitHeuregenMarker,false)
	end
end
addEventHandler("startFarmMission_2",getRootElement(),startFarmMission_2_func)

function hitHeuregenMarker(playa)
	if(playa==getLocalPlayer())then
		if(isPedInVehicle(getLocalPlayer()))then
			outputChatBox("Heuballen kann man nur zu Fuß kontrollieren!",255,0,0)
		else
			destroyElement(source)
			heuregen=heuregen+1
			setElementFrozen(playa,true)
			local finished=false
			if(heuregen==table.getn(heuregenmarker))then
				finished=true
			end
			setTimer(finishheuregen,2000,1,finished)
		end
	end
end

function finishheuregen(finished)
	setElementFrozen(getLocalPlayer(),false)
	if(finished)then
		triggerServerEvent("finish_farmer_mission_2",getLocalPlayer())
	end
end









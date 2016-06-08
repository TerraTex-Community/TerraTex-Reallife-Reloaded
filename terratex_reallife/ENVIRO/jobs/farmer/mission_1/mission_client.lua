local gesammelteErdbeeren=0
local erdbeermarker={
	{-1138.00390625,-1134.8681640625,129.21875}, 
	 {-1145.666015625,-1134.619140625,129.21875}, 
	 {-1156.1494140625,-1134.349609375,129.21875}, 
	 {-1187.6572265625,-1096.1279296875,129.2258605957}, 
	 {-1179.6279296875,-1096.2119140625,129.21875}, 
	 {-1171.78515625,-1095.5361328125,129.21875}, 
	 {-1142.5517578125,-1095.509765625,129.21875}, 
	 {-1137.0283203125,-1095.671875,129.21875}, 
	 {-1129.9453125,-1095.4609375,129.21875}, 
	 {-1095.6455078125,-1095.6357421875,129.21875}, 
	 {-1088.853515625,-1096.1240234375,129.21875}, 
	 {-1080.255859375,-1095.568359375,129.21875}, 
	 {-1076.572265625,-1084.4794921875,129.21875}, 
	 {-1084.71875,-1084.388671875,129.21875}, 
	 {-1091.71875,-1084.3115234375,129.21875}, 
	 {-1122.83203125,-1084.39453125,129.21875}, 
	 {-1130.8203125,-1084.7412109375,129.21875}, 
	 {-1140.111328125,-1084.3330078125,129.21875}
}

addEvent("startFarmMission_1",true)
function startFarmMission_1_func()
	gesammelteErdbeeren=0
	for theKey,thePaar in ipairs(erdbeermarker)do
		local marker=createMarker ( thePaar[1],thePaar[2],thePaar[3], "checkpoint", 2.0, 0, 255, 0)
		addEventHandler("onClientMarkerHit",marker,hitErdbeerMarker,false)
	end
end
addEventHandler("startFarmMission_1",getRootElement(),startFarmMission_1_func)

function hitErdbeerMarker(playa)
	if(playa==getLocalPlayer())then
		if(isPedInVehicle(getLocalPlayer()))then
			outputChatBox("Erdbeeren kann man nur zu Fuß sammeln!",255,0,0)
		else
			destroyElement(source)
			gesammelteErdbeeren=gesammelteErdbeeren+1
			setElementFrozen(playa,true)
			local finished=false
			if(gesammelteErdbeeren==table.getn(erdbeermarker))then
				finished=true
			end
			setTimer(FinishErdbeerFreeze,2000,1,finished)
		end
	end
end

function FinishErdbeerFreeze(finished)
	setElementFrozen(getLocalPlayer(),false)
	if(finished)then
		triggerServerEvent("finish_farmer_mission_1",getLocalPlayer())
	end
end









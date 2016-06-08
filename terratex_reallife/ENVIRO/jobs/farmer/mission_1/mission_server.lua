addEvent("farmerjob_mission_start_1",false)
function farmerjob_mission_start_1()
	--outputChatBox("succesfull")
	triggerClientEvent(source,"startFarmMission_1",source)
	vioSetElementData(source,"isFarmingActiv",true)
	outputChatBox("Sammle die Erdbeeren ein! (Sammle alle grünen Marker in den Gewächshäusern ein!)",source,0,255,0)	
end
addEventHandler("farmerjob_mission_start_1",getRootElement(),farmerjob_mission_start_1)

addEvent("finish_farmer_mission_1",true)
function finish_farmer_mission_1_func()
	outputChatBox("Danke, dass du alle Erdebeeren eingesammelt hast!",source,0,255,0)
	vioSetElementData(source,"isFarmingActiv",false)
	farmer_mission_cancel(source)
end
addEventHandler("finish_farmer_mission_1",getRootElement(),finish_farmer_mission_1_func)









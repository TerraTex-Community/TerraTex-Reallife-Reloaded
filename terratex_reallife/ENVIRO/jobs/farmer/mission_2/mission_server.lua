addEvent("farmerjob_mission_start_2",false)
function farmerjob_mission_start_2()
	--outputChatBox("succesfull")
	triggerClientEvent(source,"startFarmMission_2",source)
	vioSetElementData(source,"isFarmingActiv",true)
	outputChatBox("Es könnte bald Regnen! Kontrolliere, ob das Heu Regenfest ist!(Sammle die Grünen Marker ein)",source,0,255,0)	
end
addEventHandler("farmerjob_mission_start_2",getRootElement(),farmerjob_mission_start_2)

addEvent("finish_farmer_mission_2",true)
function finish_farmer_mission_2_func()
	outputChatBox("Danke, dass du alle Heuballen kontrolliert hast!",source,0,255,0)
	vioSetElementData(source,"isFarmingActiv",false)
	farmer_mission_cancel(source)
end
addEventHandler("finish_farmer_mission_2",getRootElement(),finish_farmer_mission_2_func)









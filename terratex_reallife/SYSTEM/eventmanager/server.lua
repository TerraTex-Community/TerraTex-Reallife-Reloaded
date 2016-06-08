addEvent("onPlayerEnterWater",true)
addEvent("onPlayerLeaveWater",true)
addEvent("onVehiclePreEnterWater",true)
addEvent("onVehicleEnterWater",true)


local wasTriggeredVehicleInWater={}
function onVehiclePreEnterWater_func()
	local timer=getRealTime()
	local timestamp=timer.timestamp
	if(wasTriggeredVehicleInWater[source])then
		if((timestamp-wasTriggeredVehicleInWater[source])>0)then
			wasTriggeredVehicleInWater[source]=timestamp
			triggerEvent("onVehicleEnterWater",source,timestamp)			
		end	
	else
		wasTriggeredVehicleInWater[source]=timestamp
		triggerEvent("onVehicleEnterWater",source,timestamp)
	end
end
addEventHandler("onVehiclePreEnterWater",getRootElement(),onVehiclePreEnterWater_func)









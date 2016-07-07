function isreadyforlogin()
	setAmbientSoundEnabled( "gunfire", false )
	setMinuteDuration ( 60000)
	local time = getRealTime()
	local hours = time.hour
	local minutes = time.minute
	setTime(time.hour,time.minute)
	triggerServerEvent("clientisreadyforlogin",getLocalPlayer(),getLocalPlayer())
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),isreadyforlogin)


function showLogin(thePlayer)
    guiSetVisible (Login_Gui , true)
    showCursor ( true , true)
	toggleAllControls ( false, true, true )
end

function showRegister(thePlayer)
    guiSetVisible (Registergui , true)
	showCursor ( true , true)
	toggleAllControls ( false, true, true )
end

addEvent("showRegisterGui",true)
addEvent("showLoginGui",true)
addEventHandler("showRegisterGui",getRootElement(), showRegister)
addEventHandler("showLoginGui",getRootElement(), showLogin)

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











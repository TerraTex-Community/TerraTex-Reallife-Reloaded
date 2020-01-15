local guiEnabled = get("gui_enabled")
local snowToggle = get("snow_toggle")

addEvent("onClientReady",true)
addEventHandler("onClientReady",root,function()

	if (isWinter()) then
		triggerClientEvent(client,"triggerGuiEnabled",client,guiEnabled,snowToggle)
	end
end)

_setRainLevel=setRainLevel
function setRainLevel(int)
	_setRainLevel(0)
	triggerClientEvent(getRootElement(),"changedRainLevel_winter",getRootElement(),int)
end

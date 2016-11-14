local guiEnabled = get("gui_enabled")
local snowToggle = get("snow_toggle")

addEvent("onClientReady",true)
addEventHandler("onClientReady",root,function()
	triggerClientEvent(client,"triggerGuiEnabled",client,guiEnabled,snowToggle)
end)

_setRainLevel=setRainLevel
function setRainLevel(int)
	_setRainLevel(0)
	triggerClientEvent(getRootElement(),"changedRainLevel_winter",getRootElement(),int)
end
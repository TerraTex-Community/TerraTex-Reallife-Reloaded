local guiEnabled = get("gui_enabled")
local snowToggle = get("snow_toggle")

addEvent("onClientReady",true)
addEventHandler("onClientReady",root,function()
	triggerClientEvent(client,"triggerGuiEnabled",client,guiEnabled,snowToggle)
end)

_setRainLevel=setRainLevel
function setRainLevel(int)
	_setRainLevel(0)
	console.log("done");
	triggerClientEvent(getRootElement(),"changedRainLevel_winter",getRootElement(),int)
end

function test()

	setRainLevel(2);
end
addCommandHandler("tt", test)
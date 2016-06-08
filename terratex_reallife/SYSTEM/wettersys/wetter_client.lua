local isWetterEventID=0
addEvent("sendWetterEventToClient_Event",true)
function sendWetterEventToClient_Event_func(id)
	isWetterEventID=id
end
addEventHandler("sendWetterEventToClient_Event",getRootElement(),sendWetterEventToClient_Event_func)









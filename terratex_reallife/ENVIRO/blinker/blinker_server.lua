addEvent("send_blinker", true)
function send_blinker_func(type)
    triggerClientEvent(getRootElement(), "addBlinkerCarType", source, type)
end
addEventHandler("send_blinker", getRootElement(), send_blinker_func)

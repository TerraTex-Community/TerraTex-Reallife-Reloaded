addEvent("send_blinker",true)
function send_blinker_func(typer)
	triggerClientEvent(getRootElement(),"addBlinkerCarType",source,typer)
end
addEventHandler("send_blinker",getRootElement(),send_blinker_func)









local wasAFKTriggered=false


function resetAFKTimer_client()
		if(not(wasAFKTriggered))then
			triggerServerEvent("resetAFKEvent",getLocalPlayer())
			wasAFKTriggered=true
			setTimer(end_afk_trigger,150000,1)
		
		end
end
addEventHandler("onClientKey",getRootElement(),resetAFKTimer_client)
addEventHandler("onClientClick",getRootElement(),resetAFKTimer_client)



function end_afk_trigger()

wasAFKTriggered=false

end









local wasAFKTriggered=false


function resetAFKtimer_client()
		if(not(wasAFKTriggered))then
			triggerServerEvent("resetAFKevent",getLocalPlayer())
			wasAFKTriggered=true
			setTimer(end_afk_trigger,150000,1)
		
		end
end
addEventHandler("onClientKey",getRootElement(),resetAFKtimer_client)
addEventHandler("onClientClick",getRootElement(),resetAFKtimer_client)



function end_afk_trigger()

wasAFKTriggered=false

end









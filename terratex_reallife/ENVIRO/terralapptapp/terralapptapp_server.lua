function showterralapptapp_func(thePlayer, cmd, additionaltext)
	if (vioGetElementData(thePlayer, "terralapptapp") == 1) then
		triggerClientEvent(thePlayer, "open_terralappapps", thePlayer, vioGetElementData(thePlayer, "tappapps"), additionaltext)
	end
end
addCommandHandler("tlt", showterralapptapp_func, false, false)









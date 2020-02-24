function showError(thePlayer,text)
    if (isElement(thePlayer)) then
		if (text) then
			triggerClientEvent(thePlayer, "showErrorText", thePlayer, thePlayer, text)
		end
	end
end

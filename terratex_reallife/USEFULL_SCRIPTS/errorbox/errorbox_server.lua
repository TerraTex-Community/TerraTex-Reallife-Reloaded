--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 08.02.14
-- Time: 23:49
-- To change this template use File | Settings | File Templates.
--


function showError(thePlayer,text)
    if (isElement(thePlayer)) then
		if (text) then
			triggerClientEvent(thePlayer, "showErrorText", thePlayer, thePlayer, text)
		end
	end
end









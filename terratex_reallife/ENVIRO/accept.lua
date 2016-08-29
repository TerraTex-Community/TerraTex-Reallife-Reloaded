local acceptHandler = {};

-- options:
-- requestedDataValues = List of Strings from vioGetElementData if one is not set it will be result in a error message to the user
function registerAcceptHandler(acceptName, func, options)
    assert(not acceptHandler[acceptName], "Accept Handler " .. acceptName .. " already registered.");
    acceptHandler[acceptName] = {
        func = func,
        options = options
    };
end

function call_accept(thePlayer, cmd, acceptName, ...)
    if (acceptHandler[acceptName]) then
        if (acceptHandler[acceptName].options.requestedDataValues and type(acceptHandler[acceptName].options.requestedDataValues) == "table" ) then
            if (table.getSize(acceptHandler[acceptName].options.requestedDataValues) > 0) then
                for theKey, theDataValue in ipairs(acceptHandler[acceptName].options.requestedDataValues) do
                    if (not vioGetElementData(thePlayer, theDataValue)) then
                        outputChatBox("Du hast kein entsprechendes Angebot erhalten oder das Angebot war fehlerhaft!", thePlayer, 255,0,0);
                        showError(thePlayer, "Du hast kein entsprechendes Angebot erhalten oder das Angebot war fehlerhaft!");
                        return;
                    end
                end
            end
        end
        acceptHandler[acceptName].func(thePlayer, cmd, unpack({...}));
    else
        outputChatBox("Es gibt kein /accept " .. tostring(acceptName), thePlayer, 255, 0, 0);
    end
end
addCommandHandler("accept", call_accept, false, false)

--blitzer[1-8]
local blitzerGemeldetePosition = {}

function aktualizeblitzerMeldedPosition()
    triggerClientEvent(getRootElement(), "AktualziaBlitzerMeldedTable_Event", getRootElement(), blitzerGemeldetePosition)
    setTimer(aktualizeblitzerMeldedPosition, 60000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), aktualizeblitzerMeldedPosition)

function newsClickedOnBlitzer(mouseButton, buttonState, clickedElement)
    if (vioGetElementData(source, "fraktion") == 3) and buttonState == "up" then
        if (getElementType(clickedElement) == "blitzer") then

            local x, y, z = getElementPosition(clickedElement)
            local bereitsGemeldet = false
            local timezone = getRealTime()
            for theKey, theBlitzer in ipairs(blitzerGemeldetePosition) do
                if (getDistanceBetweenPoints3D(x, y, z, theBlitzer[1], theBlitzer[2], theBlitzer[3]) < 50) then
                    bereitsGemeldet = true
                end
            end

            if (bereitsGemeldet) then
                outputChatBox("Der Blitzer ist bereits gemeldet!", source, 0, 255, 0)
            else
                local blitzerTable = { x, y, z, (timezone.timestamp + 7200) }
                table.insert(blitzerGemeldetePosition, blitzerTable)
                outputChatBox("Der Blitzer wurde erfolgreich dem Blitzerwarnerssystem gemeldet!", source, 0, 255, 0)
            end
        end
    end
end
addEventHandler("onPlayerClick", getRootElement(), newsClickedOnBlitzer)

function resetGemeldeteBlitzer(source)
    if (vioGetElementData(source, "fraktion") == 3) then
        blitzerGemeldetePosition = {}
        outputChatBox("Die Blitzermeldungen wurden gelöscht", source)
    end
end
addCommandHandler("resetBM", resetGemeldeteBlitzer, false, false)

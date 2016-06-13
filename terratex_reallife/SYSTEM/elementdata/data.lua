elementData = {}

local scheineNameAusLicName = {
    ["autoLic"] = "Autoführerschein",
    ["truckLic"] = "Truckerschein",
    ["planeLic"] = "Flugzeugschein",
    ["bikeLic"] = "Motorradschein",
    ["heliLic"] = "Helicopterschein"
}

function vioSetElementData(player, dataString, value)
    if (isPlayerLoggedIn(player)) then
        if (value == -5) then
            if (dataString == "autoLic" or dataString == "truckLic" or dataString == "planeLic" or dataString == "bikeLic" or dataString == "heliLic") then
                local timer = getRealTime()
                local addeddataString = "last" .. dataString
                if (vioGetElementData(player, addeddataString) > 0) then
                    outputChatBox(string.format("Da du noch in der Probezeit warst wurde die Abnahme deines %s auf 15 Stunden statt 5 Stunden festgesetzt.", scheineNameAusLicName[dataString]), player, 255, 0, 0)
                    value = -15
                end
            end
        end
    end
    if (dataString == "money" or dataString == "bank") then
        value = math.round(value, 2)
    end
    if isElement(player) and dataString and value ~= nil then
        if not elementData[player] then
            elementData[player] = {}
        end
        local before = vioGetElementData(player, dataString)
        elementData[player][dataString] = value
        setElementData(player, dataString, value)
        changeVioElementData(player, dataString, value, before)

    else
        if (not isElement(player)) then
            outputDebugString("ErrorHelp vioSetElementData: " .. debug.traceback())
        end
        return nil
    end
end

function vioGetElementData(player, dataString)

    if player and dataString then
        if not elementData[player] then
            elementData[player] = {}
            return nil
        end

        if elementData[player][dataString] then
            return elementData[player][dataString]
        elseif not elementData[player][dataString] and dataString ~= "adminlvl" and dataString ~= "loggedin" then
            if (not (isElement(player))) then
                outputDebugString("ErrorHelp getElementData: " .. debug.traceback())
            end
            elementData[player][dataString] = getElementData(player, dataString)
            return elementData[player][dataString]
        end
    else
        return nil
    end
end

function freeElementData()
    if (getElementType(source) == "player") then
        triggerEvent("SaveMyData", source)
    end
    elementData[source] = nil
end
addEventHandler("onElementDestroy", getRootElement(), freeElementData)

function changeVioElementData(player, dataString, value, valuebefore)
    if (isPlayerLoggedIn(player)) then


        if (dataString == "autoLic") then
            if (value == -5) then
                MySql.helper.insert("log_loosedriverlicense", {
                    Nickname = getPlayerName(player),
                    Fraktion = vioGetElementData(player, "fraktion")
                });

                vioSetElementData(player, "fuehrerscheinlooser", vioGetElementData(player, "fuehrerscheinlooser") + 1)
            end
        end

        if (dataString == "money") or (dataString == "bank") then
            local money = getPlayerMoney(player) + getPlayerBank(player)
            if (money > 1000000) then
                if (vioGetElementData(player, "Erfolg_Millionaer") == 0) then
                    triggerClientEvent(player, "onClientCreatePokalGUI", player, "Millionaer", "Du hast das erstemal mehr als 1000000$")
                    vioSetElementData(player, "Erfolg_Millionaer", 1)
                end
            end
        end

        --SecureSave
        if (isPlayerLoggedIn(player)) then
            if (dataString == "bizKey" or dataString == "prestigeKey" or dataString == "hkey" or dataString == "fraktionsrang" or dataString == "fraktion" or ((dataString == "money" or dataString == "bank") and ((value - valuebefore) > 10000 or (value - valuebefore) < -10000))) then
                triggerEvent("SaveMyData", player)
            end
        end
    end
end









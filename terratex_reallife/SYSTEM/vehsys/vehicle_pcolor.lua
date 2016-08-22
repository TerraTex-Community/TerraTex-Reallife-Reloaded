function pColor_func(thePlayer)
    if (isPedInVehicle(thePlayer)) then
        if (getPedOccupiedVehicleSeat(thePlayer) == 0) then
            local vehicle = getPedOccupiedVehicle(thePlayer)
            if (vioGetElementData(vehicle, "besitzer")) then
                if (vioGetElementData(vehicle, "besitzer") == getPlayerName(thePlayer)) then
                    triggerClientEvent(thePlayer, "load_PremiumColor_Event", vehicle, vioGetElementData(vehicle, "premColor"), vioGetElementData(vehicle, "Lichterfarbe"))
                else
                    showError(thePlayer, "Du bist nicht Besitzer des Fahrzeugs!")
                end
            elseif (vioGetElementData(thePlayer, "fraktion") == 13) then
                if (table.hasValue(frakselfcars[13], vehicle)) then
                    local lr, lg, lb = getVehicleHeadLightColor(vehicle)
                    local color = {}
                    color[1], color[2], color[3], color[4], color[5], color[6], color[7], color[8], color[9], color[10], color[11], color[12] = getVehicleColor(vehicle, true)

                    triggerClientEvent(thePlayer, "load_PremiumColor_Event", vehicle, table.concat(color, "|"), lr .. "|" .. lg .. "|" .. lb)
                else
                    showError(thePlayer, "Du bist nicht Besitzer des Fahrzeugs und dieses Fahrzeug gehört auch nicht zu deiner Fraktion!")
                end
            else
                showError(thePlayer, "Du bist nicht Besitzer des Fahrzeugs!")
            end
        else
            showError(thePlayer, "Du bist nicht Fahrer des Fahrzeugs!")
        end
    else
        showError(thePlayer, "Du bist in keinem Fahrzeug!")
    end
end
addCommandHandler("pcolor", pColor_func, false, false)

addEvent("setPremiumVehicleLightColor", true)
function setPremiumVehicleLightColor_func(newcolorstring)
    local thePlayer = source
    if (getPedOccupiedVehicleSeat(thePlayer) == 0) then
        local vehicle = getPedOccupiedVehicle(thePlayer)
        if (getPlayerMoney(thePlayer) > 2500 or (vioGetElementData(thePlayer, "fraktion") == 13 and table.hasValue(frakselfcars[13], vehicle))) then
            if (isPedInVehicle(thePlayer)) then
                if (vioGetElementData(vehicle, "besitzer")) then
                    if (vioGetElementData(vehicle, "besitzer") == getPlayerName(thePlayer)) then
                        vioSetElementData(vehicle, "Lichterfarbe", newcolorstring)
                        setVehicleOverrideLights(vehicle, 2)
                        local colors = getStringComponents(newcolorstring)
                        setVehicleHeadLightColor(vehicle, tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]))
                        changePlayerMoney(thePlayer, -2500, "fahrzeug", "/pcolor", "Fahrzeugfarbe")
                        save_car(vehicle)
                        triggerClientEvent(thePlayer, "pColor_Preview_setLightBefore", thePlayer, tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]))
                    else
                        showError(thePlayer, "Du bist nicht Besitzer des Fahrzeugs!")
                    end

                elseif (vioGetElementData(thePlayer, "fraktion") == 13) then
                    if (table.hasValue(frakselfcars[13], vehicle)) then
                        vioSetElementData(vehicle, "Lichterfarbe", newcolorstring)
                        setVehicleOverrideLights(vehicle, 2)
                        setVehicleHeadLightColor(vehicle, tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]))
                        triggerClientEvent(thePlayer, "pColor_Preview_setLightBefore", thePlayer, tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]))
                    else
                        showError(thePlayer, "Du bist nicht Besitzer des Fahrzeugs und dieses Fahrzeug gehört auch nicht zu deiner Fraktion!")
                    end
                else
                    showError(thePlayer, "Du bist nicht Besitzer des Fahrzeugs!")
                end
            else
                showError(thePlayer, "Du bist nicht Fahrer des Fahrzeugs!")
            end
        else
            showError(thePlayer, "Du hast nicht genug Geld um die Lichter des Fahrzeugs zu Färben (2500$)!")
        end
    else
        showError(thePlayer, "Du bist in keinem Fahrzeug!")
    end
end

addEventHandler("setPremiumVehicleLightColor", getRootElement(), setPremiumVehicleLightColor_func)

addEvent("setPremiumVehicleColor", true)
function setPremiumVehicleColor_func(newcolorstring)
    local thePlayer = source
    if (getPedOccupiedVehicleSeat(thePlayer) == 0) then
        local vehicle = getPedOccupiedVehicle(thePlayer)
        if (getPlayerMoney(thePlayer) > 7500 or (vioGetElementData(thePlayer, "fraktion") == 13 and table.hasValue(frakselfcars[13], vehicle))) then
            if (isPedInVehicle(thePlayer)) then
                if (vioGetElementData(vehicle, "besitzer")) then
                    if (vioGetElementData(vehicle, "besitzer") == getPlayerName(thePlayer)) then
                        vioSetElementData(vehicle, "premColor", newcolorstring)
                        local colors = getStringComponents(newcolorstring)
                        setVehicleColor(vehicle, tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]), tonumber(colors[4]), tonumber(colors[5]), tonumber(colors[6]))
                        changePlayerMoney(thePlayer, -7500, "fahrzeug", "/pcolor", "Fahrzeugfarbe")
                        save_car(vehicle)
                        triggerClientEvent(thePlayer, "pColor_Preview_setColorBefore", thePlayer, tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]), tonumber(colors[4]), tonumber(colors[5]), tonumber(colors[6]))
                    else
                        showError(thePlayer, "Du bist nicht Besitzer des Fahrzeugs!")
                    end
                elseif (vioGetElementData(thePlayer, "fraktion") == 13) then
                    if (table.hasValue(frakselfcars[13], vehicle)) then
                        local colors = getStringComponents(newcolorstring)
                        setVehicleColor(vehicle, tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]), tonumber(colors[4]), tonumber(colors[5]), tonumber(colors[6]))
                        triggerClientEvent(thePlayer, "pColor_Preview_setColorBefore", thePlayer, tonumber(colors[1]), tonumber(colors[2]), tonumber(colors[3]), tonumber(colors[4]), tonumber(colors[5]), tonumber(colors[6]))
                    else
                        showError(thePlayer, "Du bist nicht Besitzer des Fahrzeugs und dieses Fahrzeug gehört auch nicht zu deiner Fraktion!")
                    end
                else
                    showError(thePlayer, "Du bist nicht Besitzer des Fahrzeugs!")
                end
            else
                showError(thePlayer, "Du bist nicht Fahrer des Fahrzeugs!")
            end
        else
            showError(thePlayer, "Du hast nicht genug Geld um das Fahrzeug zu Färben (7500$)!")
        end
    else
        showError(thePlayer, "Du bist in keinem Fahrzeug!")
    end
end
addEventHandler("setPremiumVehicleColor", getRootElement(), setPremiumVehicleColor_func)

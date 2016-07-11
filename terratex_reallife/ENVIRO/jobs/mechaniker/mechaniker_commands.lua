-- /repair
-- /accept service
-- 4330 als service nummer
-- repair nur alle 60 Sekunden

function resetHasRepaired(thePlayer, theVehicle, toPlayer)
    if (isElement(thePlayer)) then
        showError(thePlayer, "Ihr Fahrzeug wurde erfolgreich repariert!")
        vioSetElementData(thePlayer, "hasRepaired", false)
    end
    if (isElement(theVehicle)) then
        vioSetElementData(theVehicle, "isInRepairProcedur", false)
        setElementFrozen(theVehicle, false)
        fixVehicle(theVehicle)
        setVehicleWheelStates(theVehicle, 0, 0, 0, 0)
    end
end

function repair_func(thePlayer, Command, ToPlayerName, Price)
    if not (vioGetElementData(thePlayer, "inArena")) then
        if (vioGetElementData(thePlayer, "job") == 5) then
            if (ToPlayerName) and (Price) then
                PriceNum = tonumber(Price)
                if (PriceNum) then
                    if (PriceNum > 5) then
                        toPlayer = getPlayerFromIncompleteName(ToPlayerName)
                        if (toPlayer) then
                            local isGTPlayer = false
                            if (gtVehiclePlayerElement) then
                                if (gtVehiclePlayerElement ~= toPlayer) then -- Geldtransporter
                                isGTPlayer = true
                                end
                            else
                                isGTPlayer = true
                            end
                            if (isGTPlayer) then
                                local x, y, z = getElementPosition(thePlayer)
                                local xs, ys, zs = getElementPosition(toPlayer)
                                local distance = getDistanceBetweenPoints3D(x, y, z, xs, ys, zs)
                                if (distance < 20) then
                                    if not (vioGetElementData(thePlayer, "hasRepaired")) then
                                        outputChatBox(string.format("Der Spieler %s bietet dir eine Fahrzeugreparatur für %s $ an! (/accept repair)", getPlayerName(thePlayer), Price), toPlayer, 0, 196, 196)
                                        vioSetElementData(toPlayer, "mechaPrice", PriceNum)
                                        vioSetElementData(toPlayer, "mechaPlayer", thePlayer)
                                        outputChatBox(string.format("Du hast Spieler %s erfolgreich eine Reparatur angeboten!", getPlayerName(toPlayer)), thePlayer, 0, 196, 196)
                                    else
                                        showError(thePlayer, "Du kannst noch nicht reparieren!")
                                    end
                                else
                                    showError(thePlayer, "Dieser Spieler ist nicht in deiner Nähe!")
                                end
                            end
                        else
                            showError(thePlayer, "Dieser Spieler existiert nicht!")
                        end
                    else
                        showError(thePlayer, "Du musst mindestens 5$ verlangen, da dich die Materialien diesen Preis kosten!")
                    end
                else
                    showError(thePlayer, "Sie haben einen ungültigen Preis angegeben!")
                end
            else
                showError(thePlayer, "Du hast keinen Spieler oder keinen Preis angeben!")
            end
        end
    end
end

addCommandHandler("repair", repair_func, false, false)

function accept_repair(thePlayer)
    if (getPlayerMoney(thePlayer) < vioGetElementData(thePlayer, "mechaPrice")) then
        showError(thePlayer, "Du hast nicht genügend Geld!")
    else
        local mecha = vioGetElementData(thePlayer, "mechaPlayer")
        local toPlayer = mecha
        if (isElement(mecha)) then
            local x, y, z = getElementPosition(thePlayer)
            local xs, ys, zs = getElementPosition(mecha)
            local dis = getDistanceBetweenPoints3D(x, y, z, xs, ys, zs)
            if (dis < 20) then
                if (isPedInVehicle(thePlayer)) then
                    local theVehicle = getPedOccupiedVehicle(thePlayer)
                    local vx, vy, vz = getElementVelocity(theVehicle)
                    local speed = math.round(math.sqrt(vx * vx + vy * vy + vz * vz))
                    if (speed == 0) then
                        changePlayerMoney(thePlayer, -vioGetElementData(thePlayer, "mechaPrice"), "sonstiges", "Mechanikerkosten")
                        vioSetElementData(toPlayer, "hasRepaired", true)
                        local timer = ((1000 - getElementHealth(theVehicle)) * 30)
                        local m, mn, mb, mv = getVehicleWheelStates(theVehicle)
                        local m = m + mn + mb + mv
                        timer = timer + m * 5000
                        if (timer < 500) then
                            timer = 500
                        end
                        setTimer(resetHasRepaired, timer + 500, 1, toPlayer, theVehicle, thePlayer)
                        setElementFrozen(theVehicle, true)
                        vioSetElementData(theVehicle, "isInRepairProcedur", true)
                        setVehicleEngineState(theVehicle, false)
                        vioSetElementData(theVehicle, "motor", false)
                        vioSetElementData(theVehicle, "motornum", 0)
                        changePlayerMoney(toPlayer, vioGetElementData(thePlayer, "mechaPrice") - 50, "job", "Mechaniker", "Reparatur")
                        vioSetElementData(toPlayer, "mechaPrice", false)
                        vioSetElementData(toPlayer, "mechaPlayer", false)
                    else
                        showError(thePlayer, "Ein Fahrzeug kann nur im Stand repariert werden!")
                    end
                else
                    showError(thePlayer, "Du bist in keinem Fahrzeug!")
                end
            else
                showError(thePlayer, "Du bist nicht in der Nähe des Mechanikers!")
            end
        end
    end
end
registerAcceptHandler("repair", accept_repair, {
    requestedDataValues = {"mechaPrice", "mechaPlayer"}
});







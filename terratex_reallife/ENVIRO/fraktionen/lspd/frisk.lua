function frisk_func(thePlayer, Command, vonPlayerName)
    if (vonPlayerName) then
        local vonPlayer = getPlayerFromIncompleteName(vonPlayerName)
        if (vonPlayer) then
            local xv, yv, zv = getElementPosition(vonPlayer)
            local xt, yt, zt = getElementPosition(thePlayer)
            local dis = getDistanceBetweenPoints3D(xv, yv, zv, xt, yt, zt)
            if (dis < 20) then
                if (isBeamter(thePlayer)) then
                    local foundsomething = 0
                    outputChatBox(string.format("%s hat Sie durchsucht!", getPlayerName(thePlayer)), vonPlayer, 0, 255, 255)
                    outputChatBox(string.format("Du hast %s durchsucht. Du hast gefunden:", getPlayerName(vonPlayer)), thePlayer, 0, 255, 255)
                    if (vioGetElementData(vonPlayer, "drogen") > 0) then
                        outputChatBox(string.format("%s Gramm Drogen", vioGetElementData(vonPlayer, "drogen")), thePlayer, 0, 255, 255)
                        foundsomething = 1
                    end
                    if (vioGetElementData(vonPlayer, "mats") > 0) then
                        outputChatBox(string.format("%s Materialien", vioGetElementData(vonPlayer, "mats")), thePlayer, 0, 255, 255)
                        foundsomething = 1
                    end
                    local hasweapons = 0
                    for n = 1, 12, 1 do
                        if not (getPedWeapon(vonPlayer, n) == 0) then
                            hasweapons = hasweapons + 1
                        end
                    end
                    if (hasweapons > 0) then
                        outputChatBox(string.format("%s verschiedene Waffen", hasweapons), thePlayer, 0, 255, 255)
                        foundsomething = 1
                    end
                    if (foundsomething == 0) then
                        outputChatBox("Nichts!", thePlayer, 0, 255, 255)
                    end
                    outputChatBox("Drogen- und Alkoholtest läuft.....", thePlayer, 0, 255, 255)
                    triggerClientEvent(vonPlayer, "checkalkdrug", thePlayer)
                else
                    vioSetElementData(vonPlayer, "friskBy", thePlayer);
                    outputChatBox("Der Spieler " .. getPlayerName(thePlayer) .. " möchte dich durchsuchen. Du kannst es ihm mit '/accept frisk' erlauben.", vonPlayer, 0 ,255, 0)
                    outputChatBox("Der Spieler wurde gefragt, ob du ihn durchsuchen darfst...", thePlayer, 0, 255, 0);
                end
            else
                showError(thePlayer, "Der Spieler ist nicht in deiner Nähe.");
            end
        else
            showError(thePlayer, "Der Spieler existiert nicht.");
        end
    else
        showError(thePlayer, "Nutzung: /frisk [Spielername]");
    end
end
addCommandHandler("frisk", frisk_func, false, false)

function accept_frisk(vonPlayer)
    local thePlayer = vioGetElementData(vonPlayer, "friskBy");
    if (getElementsDistance(thePlayer, vonPlayer) <= 20) then
        local foundsomething = 0
        outputChatBox(string.format("%s hat Sie durchsucht!", getPlayerName(thePlayer)), vonPlayer, 0, 255, 255)
        outputChatBox(string.format("Du hast %s durchsucht. Du hast gefunden:", getPlayerName(vonPlayer)), thePlayer, 0, 255, 255)
        if (vioGetElementData(vonPlayer, "drogen") > 0) then
            outputChatBox(string.format("%s Gramm Drogen", vioGetElementData(vonPlayer, "drogen")), thePlayer, 0, 255, 255)
            foundsomething = 1
        end
        if (vioGetElementData(vonPlayer, "mats") > 0) then
            outputChatBox(string.format("%s Materialien", vioGetElementData(vonPlayer, "mats")), thePlayer, 0, 255, 255)
            foundsomething = 1
        end
        local hasweapons = 0
        for n = 1, 12, 1 do
            if not (getPedWeapon(vonPlayer, n) == 0) then
                hasweapons = hasweapons + 1
            end
        end
        if (hasweapons > 0) then
            outputChatBox(string.format("%s verschiedene Waffen", hasweapons), thePlayer, 0, 255, 255)
            foundsomething = 1
        end
        if (foundsomething == 0) then
            outputChatBox("Nichts!", thePlayer, 0, 255, 255)
        end
    else
        vioSetElementData(vonPlayer, "friskBy", false);
        showError(thePlayer, "Der Spieler kann dich nicht mehr durchsuchen, da du zu weit weg bist.")
    end
end
registerAcceptHandler("frisk", accept_frisk, {
    requestedDataValues = {"friskBy"}
});

addEvent("sendAlkDrugData", true)
function sendAlkDrugData_func(drug, alk)
    outputChatBox("Drogen- und Alkoholtest abgeschlossen. Ergebnis:", source, 0, 255, 255)
    outputChatBox(string.format("Drogen im Blut: %s g", math.round(drug, 2)), source, 0, 255, 255)
    outputChatBox(string.format("Alkohol im Blut: %s Promille", math.round(alk / 2, 2)), source, 0, 255, 255)
end

addEventHandler("sendAlkDrugData", getRootElement(), sendAlkDrugData_func)
bizData = {}
bizPickupInfo = {}
function loadBizFromDB_func()
    local result = MySql.helper.getSync("objects_businesses", "*");
    local zahler;
    for theKey, dasatz in ipairs(result) do
        zahler = tonumber(dasatz["ID"]);
        bizData[zahler] = {}
        bizData[zahler]["Name"] = dasatz["Name"]
        bizData[zahler]["Preis"] = tonumber(dasatz["Preis"])
        bizData[zahler]["Kasse"] = tonumber(dasatz["Kasse"])
        bizData[zahler]["Besitzer"] = MySql.helper.getValueSync("user_data", "Nickname", { bizKey = zahler });

        local bizpickup = createPickup(dasatz["x"], dasatz["y"], dasatz["z"], 3, 1274, 5000)
        addEventHandler("onPickupHit", bizpickup, showBizInfo)
        bizPickupInfo[bizpickup] = zahler
        bizData[zahler]["Pickup"] = bizpickup
        local BesitzerText = "Wert: " .. bizData[zahler]["Preis"]
        if (bizData[zahler]["Besitzer"]) then
            BesitzerText = "Besitzer: " .. bizData[zahler]["Besitzer"]
        end
        setElementShowText(bizpickup, { 0, 0, 255, 255 }, bizData[zahler]["Name"] .. "\n" .. BesitzerText, true, 15, 1.3, 0.2)
    end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadBizFromDB_func)

function showBizInfo(thePlayer)
    local bizNum = bizPickupInfo[source]
    local addText = "nope"
    local BizString = "nope"
    local besitzer = "Niemanden"
    if (bizData[bizNum]["Besitzer"] == false) then
        besitzer = "Niemanden"
        addText = "Kaufen mit /buybiz"
        BizString = string.format("Business: %s\ngehört: %s\nWert: %s\n%s", bizData[bizNum]["Name"], besitzer, bizData[bizNum]["Preis"], addText)
    else
        besitzer = bizData[bizNum]["Besitzer"]
        BizString = string.format("Business: %s\ngehört: %s\nWert: %s", bizData[bizNum]["Name"], besitzer, bizData[bizNum]["Preis"])
    end
    showError(thePlayer, BizString)
end

function getBizNum(x, y, z)
    for theKey, thePickup in pairs(bizPickupInfo) do
        local xs, ys, zs = getElementPosition(theKey)
        local dis = getDistanceBetweenPoints3D(x, y, z, xs, ys, zs)
        if (dis < 5) then
            return thePickup
        end
    end
    return false
end

function savebizzes_norm(timer)
    outputDebugString("Started Biz Save")
    for theKey, theBiz in ipairs(bizData) do
        MySql.helper.update("objects_businesses", { Kasse = theBiz["Kasse"] }, { ID = theKey});
    end
    outputDebugString("Biz Saved")
    setTimer(savebizzes_norm, 3600000, 1)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), savebizzes_norm)

function savebizzes(timer)
    outputDebugString("Started Biz Save")

    for theKey, theBiz in ipairs(bizData) do
        MySql.helper.update("objects_businesses", { Kasse = theBiz["Kasse"] }, { ID = theKey});
    end
    outputDebugString("Biz Saved")
end

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), savebizzes)

function bizbank_func(thePlayer, Command, betrag)
    if (vioGetElementData(thePlayer, "bizKey") == 0) then
        showError(thePlayer, "Du besitzt kein Biz!")
    else
        local biz = vioGetElementData(thePlayer, "bizKey")
        local bx, by, bz = getElementPosition(bizData[biz]["Pickup"])
        local sx, sy, sz = getElementPosition(thePlayer)
        local dis = getDistanceBetweenPoints3D(sx, sy, sz, bx, by, bz)
        if (dis < 5) then
            if (betrag) then
                if (betrag) then
                    if (tonumber(betrag)) then
                        local mon = tonumber(betrag)
                        if (mon > 0) then
                            if (getPlayerMoney(thePlayer) < mon) then
                                showError(thePlayer, "Sie haben nicht genug Geld auf der Hand!")
                            else
                                bizData[biz]["Kasse"] = bizData[biz]["Kasse"] + mon
                                changePlayerMoney(thePlayer, -mon, "sonstiges", "Bizeinzahlung")
                            end
                        else
                            mon = -mon
                            if (bizData[biz]["Kasse"] < mon) then
                                showError(thePlayer, "Soviel Geld ist nicht in der Bizkasse!")
                            else
                                bizData[biz]["Kasse"] = bizData[biz]["Kasse"] - mon
                                changePlayerMoney(thePlayer, mon, "sonstiges", "Bizauszahlung")
                            end
                        end
                        savebizzes()
                    end
                end
            end
            outputChatBox(string.format("In der BizKasse befinden sich: %s", toprice(bizData[biz]["Kasse"])), thePlayer, 255, 255, 0)
        else
            showError(thePlayer, "Du bist nicht in der Nähe vom Biz!")
        end
    end
end

addCommandHandler("bizbank", bizbank_func, false, false)

function sellbizto_func(thePlayer, Command, toPlayerName)
    if (toPlayerName) then
        local toPlayer = getPlayerFromIncompleteName(toPlayerName)
        if (toPlayer) then
            if (vioGetElementData(thePlayer, "bizKey") == 0) then
                showError(thePlayer, "Du besitzt kein Biz!")
            else
                if (vioGetElementData(toPlayer, "bizKey") ~= 0) then
                    showError(thePlayer, "Der Spieler besitzt bereits ein Biz!")
                else
                    local biz = vioGetElementData(thePlayer, "bizKey")
                    if (getElementsDistance(bizData[biz]["Pickup"], thePlayer) < 20) then
                        vioSetElementData(toPlayer, "bizKey", vioGetElementData(thePlayer, "bizKey"))
                        vioSetElementData(thePlayer, "bizKey", 0)

                        bizData[biz]["Besitzer"] = getPlayerName(toPlayer)
                        showError(thePlayer, string.format("Du hast das Biz erfolgreich an %s verkauft!", getPlayerName(toPlayer)))
                        showError(toPlayer, string.format("Dir wurde das Biz von %s verkauft!", getPlayerName(thePlayer)))

                        local BesitzerText = string.format("Wert: %s", bizData[biz]["Preis"])
                        if (bizData[biz]["Besitzer"]) then
                            BesitzerText = string.format("Besitzer: %s", bizData[biz]["Besitzer"])
                        end
                        changeElementShowText(bizData[biz]["Pickup"], { 0, 0, 255, 255 }, bizData[biz]["Name"] .. "\n" .. BesitzerText)
                    else
                        showError(thePlayer, "Du bist nicht in der Nähe deines Biz!")
                    end
                end
            end
        else
            showError(thePlayer, "Dieser Spieler existiert nicht!")
        end
    else
        showError(thePlayer, "Nutzung: /sellbizto [SPielername]")
    end
end
addCommandHandler("sellbizto", sellbizto_func, false, false)

function bizhelp_func(thePlayer)
    outputChatBox("BizHelp:", thePlayer)
    outputChatBox("/buybiz - Biz kaufen", thePlayer)
    outputChatBox("/bizbank [Betrag] - einzahlen,auszahlen,Kontostand abfragen", thePlayer)
    outputChatBox("   [BETRAG] -> Positiv einzahlen; Negativ auszahlen", thePlayer)
    outputChatBox("/sellbiz - Biz an das System verkaufen (65% des Kaufpreises)", thePlayer)
    outputChatBox("/sellbizto - Biz an einen anderen Spieler Übergeben", thePlayer)
end
addCommandHandler("bizhelp", bizhelp_func, false, false)

function sellbiz_func(thePlayer)
    if (vioGetElementData(thePlayer, "bizKey") == 0) then
        showError(thePlayer, "Du besitzt kein Biz!")
    else
        local biz = vioGetElementData(thePlayer, "bizKey")
        if (getElementsDistance(bizData[biz]["Pickup"], thePlayer) < 20) then

            changePlayerMoney(thePlayer, math.round(bizData[biz]["Preis"] / 100 * 65), "sonstiges", "Bizverkauf")
            bizData[biz]["Besitzer"] = false
            showError(thePlayer, "Du hast das Biz erfolgreich verkauft!")
            vioSetElementData(thePlayer, "bizKey", 0)
            local BesitzerText = string.format("Wert: %s", bizData[biz]["Preis"])
            if (bizData[biz]["Besitzer"]) then
                BesitzerText = string.format("Besitzer: %s", bizData[biz]["Besitzer"])
            end
            changeElementShowText(bizData[biz]["Pickup"], { 0, 0, 255, 255 }, bizData[biz]["Name"] .. "\n" .. BesitzerText)

        else
            showError(thePlayer, "Du bist nicht in der Nähe deines Biz!")
        end
    end
end
addCommandHandler("sellbiz", sellbiz_func, false, false)

function buybiz_func(thePlayer, Command)
    local x, y, z = getElementPosition(thePlayer)
    local biz = getBizNum(x, y, z)
    if (biz) then
        if not (bizData[biz]["Besitzer"] == false) then
            showError(thePlayer, "Dieses Buissness gehört bereits jemandem!")
        else
            if (vioGetElementData(thePlayer, "bizKey") == 0) then
                if (getPlayerMoney(thePlayer) < bizData[biz]["Preis"]) then
                    showError(thePlayer, "Du hast nicht genuegend Geld bei dir!")
                else
                    vioSetElementData(thePlayer, "bizKey", biz)
                    changePlayerMoney(thePlayer, -bizData[biz]["Preis"], "sonstiges", "Bizkauf")
                    bizData[biz]["Besitzer"] = getPlayerName(thePlayer)
                    showError(thePlayer, "Du hast das Biz erfolgreich gekauft!")
                    local BesitzerText = string.format("Wert: %s", bizData[biz]["Preis"])
                    if (bizData[biz]["Besitzer"]) then
                        BesitzerText = string.format("Besitzer: %s", bizData[biz]["Besitzer"])
                    end
                    changeElementShowText(bizData[biz]["Pickup"], { 0, 0, 255, 255 }, bizData[biz]["Name"] .. "\n" .. BesitzerText)
                end
            else
                showError(thePlayer, "Du besitzt bereits ein Buissness!")
            end
        end
    else
        showError(thePlayer, "Du bist bei keinem Biz!")
    end
end
addCommandHandler("buybiz", buybiz_func, false, false)

function changeBizKasse(theBizID, Betrag, reason)
    if (bizData[theBizID]) then
        bizData[theBizID]["Kasse"] = bizData[theBizID]["Kasse"] + Betrag

        MySql.helper.insert("log_biz", {
            BizID = theBizID,
            Betrag = Betrag,
            reason = reason
        });
    end
end
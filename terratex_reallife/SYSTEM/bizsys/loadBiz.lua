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
        bizData[zahler]["PaidUntil"] = tonumber(dasatz["PaidUntil"]);

        if (not isDevServer()) then
            if (bizData[zahler]["PaidUntil"] < getRealTime().timestamp) then
                if (bizData[zahler]["Besitzer"]) then
                    MySql.helper.update("user_data", { bizKey = 0 } ,{ bizKey = zahler });
                    save_offline_message(bizData[zahler]["Besitzer"], "Businessvermieter", "Du hast deine Pacht nicht rechtzeitig bezahlt. Das Business wurde zum Verkauf freigegeben.")
                end
                bizData[zahler]["Besitzer"] = false;
                bizData[zahler]["PaidUntil"] = 0;
            elseif (bizData[zahler]["PaidUntil"] - getRealTime().timestamp < 14 * 24 * 60 * 60) then
                if (bizData[zahler]["Besitzer"]) then
                    local rest = (bizData[zahler]["PaidUntil"] - getRealTime().timestamp)/60/60/24;
                    save_offline_message(bizData[zahler]["Besitzer"], "Businessvermieter", "Deine Pacht ist in " .. rest .. " Tagen fällig.");
                end
            end
        end

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

        if (besitzer == getPlayerName(thePlayer)) then
            local timeData = getRealTime( bizData[bizNum]["PaidUntil"] );
            outputChatBox("Die Pacht deines Biz ist noch bezahlt bis: " .. timeData.monthday .. "." .. (timeData.month +1 ) .. "." .. (timeData.year + 1900), thePlayer)
        end
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
    if not isDevServer() then
--        outputDebugString("Started Biz Save")
        for theKey, theBiz in ipairs(bizData) do
            MySql.helper.update("objects_businesses", { Kasse = theBiz["Kasse"], PaidUntil = theBiz["PaidUntil"] }, { ID = theKey});
        end
--        outputDebugString("Biz Saved")
        setTimer(savebizzes_norm, 3600000, 1)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), savebizzes_norm)

function savebizzes(timer)
    if not isDevServer() then
--        outputDebugString("Started Biz Save")

        for theKey, theBiz in ipairs(bizData) do
            MySql.helper.update("objects_businesses", { Kasse = theBiz["Kasse"], PaidUntil = theBiz["PaidUntil"] }, { ID = theKey});
        end
--        outputDebugString("Biz Saved")
    end
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
    outputChatBox("/paylease - Pacht bezahlen", thePlayer)
    outputChatBox("/leaseinfo - Zeigt bis wann die Pacht noch bezahlt ist", thePlayer)
end
addCommandHandler("bizhelp", bizhelp_func, false, false)

function paylease_cmd_info(thePlayer)
    local bizNum = vioGetElementData(thePlayer, "bizKey")
    if (bizNum > 0) then
        local actualTimeStamp = getRealTime().timestamp;
        local calcTimeStamp = bizData[bizNum]["PaidUntil"];
        if (calcTimeStamp < actualTimeStamp) then
            calcTimeStamp = actualTimeStamp;
        end

        local maximum = 60 - ((calcTimeStamp - actualTimeStamp)  / 60 / 60 / 24);
        local paidDays = 0;
        local price = 0;
        if (maximum < 30) then
            calcTimeStamp = calcTimeStamp + (60 * 60 * 24 * maximum);
            price = 150000 * (maximum / 30);
            paidDays = maximum;
        else
            calcTimeStamp = calcTimeStamp + (60 * 60 * 24 * 30);
            price = 150000;
            paidDays = 30;
        end

        if (price <= getPlayerBank(thePlayer)) then
            changePlayerBank(thePlayer, -price, "sonstiges", "Business Pachtkosten")
            bizData[bizNum]["PaidUntil"] = calcTimeStamp;
            showError(thePlayer, "Die Pacht deines Business wurde um " .. paidDays .. " Tage verlängert!");
        else
            showError(thePlayer, "Die Pacht kostet " .. toprice(price) .. ". Du hast nicht genug auf deiner Bank!");
        end
    end
end
addCommandHandler("paylease", paylease_cmd_info, false, false)

function leaseInfo_cmd_func(thePlayer)
    local bizNum = vioGetElementData(thePlayer, "bizKey")
    if (bizNum > 0) then
        local timeData = getRealTime( bizData[bizNum]["PaidUntil"] );
        outputChatBox("Die Pacht deines Biz ist noch bezahlt bis: " .. timeData.monthday .. "." .. (timeData.month +1 ) .. "." .. (timeData.year + 1900), thePlayer)
    end
end
addCommandHandler("leaseinfo", leaseInfo_cmd_func, false, false)

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
                    bizData[biz]["PaidUntil"] = getRealTime().timestamp + (60 * 60 * 24 * 30);
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
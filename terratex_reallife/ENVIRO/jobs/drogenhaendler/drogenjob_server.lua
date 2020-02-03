drogenJobHausElement = false
drogenPed = false

function createDrogenJobElements()

    drogenJobHausElement = createObject(1342, 331.09436035156, 1127.0301513672, 1083.9165039063, 0, 0, 269.99996948242)
    setElementInterior(drogenJobHausElement, 5)
    drogenPed = createPed(128, 330.8388671875, 1128.3251953125, 1083.8828125, -10.0)
    setElementInterior(drogenPed, 5)
    --addEventHandler("onPlayerClick",drogenJobHausElement,cklickOnDrogenHouse)
    --addEventHandler("onPlayerClick",drogenPed,cklickOnDrogenHouse)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createDrogenJobElements)

function cklickOnDrogenHouse(mouseButton, buttonState, clickedElement)
    if (vioGetElementData(source, "job") == 2) then
        if (clickedElement == drogenJobHausElement) or (clickedElement == drogenPed) then
            triggerClientEvent(source, "openDrogenJobGui", source, math.round(serversettings["drogenpreis"], 0))
        end
    end
end
addEventHandler("onPlayerClick", getRootElement(), cklickOnDrogenHouse)

function wantBuyDrogenDealer_drogen_func(menge)
    local x,y,z = getElementPosition(source)
    local dis = getDistanceBetweenPoints3D (x,y,z, getElementPosition(drogenJobHausElement));
    if (dis > 10) then
        triggerClientEvent(source, "closeDrogenJobGui", source);
        return;
    end

    local price = menge * serversettings["drogenpreis"]
    if (getPlayerMoney(source) < price) then
        showError(source, "Du hast nicht genügend Geld dabei!")
    else
        vioSetElementData(source, "drogen", vioGetElementData(source, "drogen") + menge)
        changePlayerMoney(source, -price, "job", "Drogendealer", "Drogenkauf")

        addMoneyOfGFType("drugs", price,true, "Einkauf beim Drogenhändler")

        for theKey, thePlayer in ipairs(getPlayersInTeam(team[2])) do
            outputChatBox("Hauptdrogenkurier: Jemand hat Drogen gekauft!", thePlayer, 255, 0, 0)
        end
        serversettings["drogenpreis"] = serversettings["drogenpreis"] + ((math.random(20, 100)/10) * menge)
        showError(source, "Du hast erfolgreich die Drogen gekauft!")
    end
end
addEvent("wantBuyDrogenDealer_drogen", true)
addEventHandler("wantBuyDrogenDealer_drogen", getRootElement(), wantBuyDrogenDealer_drogen_func)

function reduceDrogenPreis(timeshift)
    if (serversettings["drogenpreis"] > 75) then
        serversettings["drogenpreis"] = serversettings["drogenpreis"] - 5
    else
        serversettings["drogenpreis"] = 75
    end
    setTimer(reduceDrogenPreis, 1800000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), reduceDrogenPreis)

function selldrugs_func(thePlayer, command, toPlayerName, menge, preis)
    if (vioGetElementData(thePlayer, "job") == 2) then
        if (toPlayerName) and tonumber(menge) and tonumber(preis) then
            if (tonumber(menge) < 0) then menge = menge * -1 end
            if (tonumber(preis) < 0) then preis = preis * -1 end
            local toPlayer = getPlayerFromIncompleteName(toPlayerName)
            if (toPlayer) then
                if (vioGetElementData(toPlayer, "drogen") + menge) > 500 then
                    showError(thePlayer, "Der Spieler kann nicht so viele Drogen annehmen!")
                else
                    if (vioGetElementData(thePlayer, "drogen") < tonumber(menge)) then
                        showError(thePlayer, "Du hast nicht soviele Drogen zum verkaufen!")
                    else
                        vioSetElementData(toPlayer, "DrugTradeFrom", thePlayer)
                        vioSetElementData(toPlayer, "DrugTradePrice", tonumber(preis))
                        vioSetElementData(toPlayer, "DrugTradeMenge", tonumber(menge))
                        outputChatBox(string.format("%s hat dir %s Gramm Drogen fuer %s angeboten! annehmen mit /accept drogen", getPlayerName(thePlayer), menge, toprice(preis)), toPlayer, 0, 250, 150)
                        outputChatBox(string.format("Du hast %s Drogen angeboten!", getPlayerName(toPlayer)), thePlayer, 0, 250, 150)
                    end
                end
            end
        else
            showError(thePlayer, "Nutzung: /selldrugs [Spieler] [Menge] [Preis]")
        end
    end
end
addCommandHandler("selldrugs", selldrugs_func, false, false)


function accept_drugs(thePlayer)
    local sx, sy, sz = getElementPosition(thePlayer)
    local tx, ty, tz = getElementPosition(vioGetElementData(thePlayer, "DrugTradeFrom"))
    local dis = getDistanceBetweenPoints3D(sx, sy, sz, tx, ty, tz)
    if (dis > 10) then
        showError(thePlayer, "Sie sind vom Drogendealer zuweit entfernt!")
    else
        local drugDealer = vioGetElementData(thePlayer, "DrugTradeFrom")
        if (vioGetElementData(drugDealer, "drogen") < vioGetElementData(thePlayer, "DrugTradeMenge")) then
            showError(thePlayer, "Der DrogenDealer hat nicht mehr so viele Drogen!")
        else
            if (getPlayerMoney(thePlayer) < vioGetElementData(thePlayer, "DrugTradePrice")) then
                showError(thePlayer, "Du hast genuegend Geld!")
            else
                vioSetElementData(thePlayer, "drogen", vioGetElementData(thePlayer, "drogen") + vioGetElementData(thePlayer, "DrugTradeMenge"))
                vioSetElementData(drugDealer, "drogen", vioGetElementData(drugDealer, "drogen") - vioGetElementData(thePlayer, "DrugTradeMenge"))
                changePlayerMoney(thePlayer, -vioGetElementData(thePlayer, "DrugTradePrice"), "sonstiges", "Drogenkauf")
                changePlayerMoney(drugDealer, vioGetElementData(thePlayer, "DrugTradePrice"), "job", "Drogendealer", "Verkauf")
                outputChatBox("Du hast die Drogen erfolgreich angenohmen", thePlayer, 0, 250, 150)
                outputChatBox(string.format("%s hat die Drogen angenohmen!", getPlayerName(thePlayer)), drugDealer, 0, 250, 150)
            end
        end
        vioSetElementData(thePlayer, "DrugTradeFrom", false)
        vioSetElementData(thePlayer, "DrugTradePrice", false)
        vioSetElementData(thePlayer, "DrugTradeMenge", false)
    end
end
registerAcceptHandler("drogen", accept_drugs, {
    requestedDataValues = {"DrugTradePrice", "DrugTradeFrom", "DrugTradeMenge"}
});




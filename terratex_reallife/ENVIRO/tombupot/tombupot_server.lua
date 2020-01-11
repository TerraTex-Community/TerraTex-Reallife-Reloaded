--DEFINES
local maxTombuTickets = 3
local tombuTicketPrice = 2000
local winTimeHour = 20
local winTimeMinute = 0
local bizPercentage = 1

function getTombuBizPercentage()
    return bizPercentage
end

function createTombuPotLottery()
    local mark = createMarker(822.28997802734, 1.8700000047684, 1003.1799926758, "cylinder", 2)
    setElementInterior(mark, 3)
    addEventHandler("onMarkerHit", mark, requestNewTombuTicket)
    mark = createMarker(-2161.1398925781, 640.29998779297, 1051.3800048828, "cylinder", 2)
    setElementInterior(mark, 1)
    addEventHandler("onMarkerHit", mark, requestNewTombuTicket)
    mark = createMarker(1768.74609375, -1903.650390625, 13, "cylinder", 1)
    addEventHandler("onMarkerHit", mark, requestNewTombuTicket)
    setTimer(isLotteryTime, 60000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createTombuPotLottery)

function requestNewTombuTicket(thePlayer)
    if (isElement(thePlayer) and getElementType(thePlayer) == "player" and not isPedInVehicle(thePlayer)) then
        local tickets = MySql.helper.getCountSync("user_tombupot")
        local gewinn = tickets * (tombuTicketPrice * (1 - (bizPercentage / 100)))
        local playerTicketCount = MySql.helper.getCountSync("user_tombupot", { Nickname = getPlayerName(thePlayer) })
        if (playerTicketCount < maxTombuTickets) then
            triggerClientEvent(thePlayer, "openDialogForBuyTickets", thePlayer, gewinn, tombuTicketPrice, playerTicketCount, maxTombuTickets)
        else
            triggerClientEvent(thePlayer, "openDialogForMaxTickets", thePlayer, gewinn, maxTombuTickets)
        end
    end
end

addEvent("acceptedBuyTomboTicket", true)
function acceptedBuyTomboTicket_func()
    if (getPlayerMoney(source) < tombuTicketPrice) then
        triggerClientEvent(source, "needMoreMoneyTombupot", source)
    else
        changePlayerMoney(source, -tombuTicketPrice, "sonstiges", "Kauf eines Tombupot-Lotterie-Tickets");
        changeBizKasse(16, tombuTicketPrice * (bizPercentage / 100), "Kauf Tombupot-Lotterie-Ticket von "..getPlayerName(source))
        MySql.helper.insert("user_tombupot", {Nickname = getPlayerName(source)});
        local tickets = MySql.helper.getCountSync("user_tombupot")
        local gewinn = tickets * (tombuTicketPrice * (1 - (bizPercentage / 100)))
        triggerClientEvent(source, "confirmTombuTicket", source, winTimeHour, winTimeMinute, gewinn)
    end
end
addEventHandler("acceptedBuyTomboTicket", getRootElement(), acceptedBuyTomboTicket_func)

function isLotteryTime()
    if isDevServer() then
        return;
    end

    local time = getRealTime()
    if (time.hour == winTimeHour and time.minute == winTimeMinute) then
        outputChatBox("Und die Tombupot-Lotterieziehung beginnt....")
        local tickets = MySql.helper.getCountSync("user_tombupot")
        local gewinn = tickets * (tombuTicketPrice * (1 - (bizPercentage / 100)))
        outputChatBox(string.format("Es wurden %s Tickets gekauft, dass ergibt einen Gewinn von %s", tickets, gewinn))
        outputChatBox("Der Gewinner wird ermittelt.......")

        local query = dbQuery(MySql._connection, "SELECT * FROM user_tombupot ORDER BY RAND() LIMIT 1");
        local result = dbPoll(query, -1);
        local dsatz = result[1];

        if (dsatz) then
            outputChatBox(string.format(".... und es hat %s gewonnen!!!!", dsatz["Nickname"]));

            local thePlayer = getPlayerFromName(dsatz["Nickname"])
            if (thePlayer) then
                changePlayerMoney(thePlayer, gewinn, "sonstiges", "Gewinn in der Tombupot-Lotterie")
                outputChatBox("Dein Gewinn wurde dir auf die Hand gegeben!", thePlayer, 155, 155, 0)
            else
                MySql.helper.insert("user_gifts", {
                    Nickname = dsatz["Nickname"],
                    Grund = "Du hast in der Tombupot-Lotterie gewonnen!",
                    Geld = gewinn
                });
            end
        else
            outputChatBox("...... und es hat keiner Teilgenommen!?");
        end

        dbExec(MySql._connection, "TRUNCATE TABLE user_tombupot");

        outputChatBox("Vergesst nicht an der nächsten Tombupot-Lotterieziehung teilzunehmen!")
        outputChatBox("Tickets für die Teilnahme gibts in allen Tombupot-Läden! (Würfel auf der Karte!)")
    else
        setTimer(isLotteryTime, 60000, 1)
    end
end

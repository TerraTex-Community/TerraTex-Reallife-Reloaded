--DEFINES
local maxTombuTickets = 1
local tombuTicketPrice = 500
local winTimeHour = 20
local winTimeMinute = 0

function createTombuPotLottery()
    local mark = createMarker(822.28997802734, 1.8700000047684, 1003.1799926758, "cylinder", 2)
    setElementInterior(mark, 3)
    addEventHandler("onMarkerHit", mark, requestNewTombuTicket)
    mark = createMarker(-2161.1398925781, 640.29998779297, 1051.3800048828, "cylinder", 2)
    setElementInterior(mark, 1)
    addEventHandler("onMarkerHit", mark, requestNewTombuTicket)
    setTimer(isLotteryTime, 60000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createTombuPotLottery)

function requestNewTombuTicket(thePlayer)
    if (isElement(thePlayer)) then
        if (getElementType(thePlayer) == "player") then
            if (MySql.helper.getCountSync("user_tombupot", { Nickname = getPlayerName(thePlayer) }) == maxTombuTickets) then
                showError(thePlayer, "Du hast bereits die Maximale Anzahl an Tickets für die nächste Lotteryziehung")
            else
                triggerClientEvent(thePlayer, "openDialogForMaxTickets", thePlayer, tombuTicketPrice)
            end
        end
    end
end

addEvent("acceptedBuyTomboTicket", true)
function acceptedBuyTomboTicket_func()
    if (getPlayerMoney(source) < tombuTicketPrice) then
        showError(source, "Du hast nicht genug Geld!")
    else
        changePlayerMoney(source, -tombuTicketPrice, "sonstiges", "Kauf eines TombupotTickets");

        MySql.helper.insert("user_tombupot", {Nickname = getPlayerName(source)});
        outputChatBox(string.format("Du hast nun ein weiteres Ticket für die Tombupotlottery erworben! Die Ziehung findet %s:%s Uhr statt!", winTimeHour, winTimeMinute), source, 155, 155, 0)
    end
end
addEventHandler("acceptedBuyTomboTicket", getRootElement(), acceptedBuyTomboTicket_func)

function isLotteryTime()
    local time = getRealTime()
    if (time.hour == winTimeHour and time.minute == winTimeMinute) then
        outputChatBox("Und die TombupotLotteryZiehung beginnt....")
        local tickets = MySql.helper.getCountSync("user_tombupot")
        local gewinn = tickets * tombuTicketPrice * 0.9
        outputChatBox(string.format("Es wurden %s Tickets gekauft, dass ergibt einen Gewinn von %s", tickets, gewinn))
        outputChatBox("Der Gewinner wird ermittelt.......")

        local query = dbQuery(MySql._connection, "SELECT * FROM user_tombupot ORDER BY RAND() LIMIT 1");
        local result = dbPoll(query, -1);
        local dsatz = result[1];

        outputChatBox(string.format(".... und es hat %s gewonnen!!!!", dsatz["Nickname"]))
        local thePlayer = getPlayerFromName(dsatz["Nickname"])
        if (thePlayer) then
            changePlayerMoney(thePlayer, gewinn, "sonstiges", "Gewinn in der Tombupotlotterie")
            outputChatBox("Dein Gewinn wurde dir auf die Hand gegeben!", thePlayer, 155, 155, 0)
        else
            MySql.helper.insert("user_gifts", {
                Nickname = dsatz["Nickname"],
                Grund = "Du hast in der TombupotLottery gewonnen!",
                Geld = gewinn
            });
        end
        dbExec(MySql._connection, "TRUNCATE TABLE user_tombupot");

        outputChatBox("Vergesst nicht an der nächsten Tombupotlottery teilzunehmen!")
        outputChatBox("Tickets für die Teilnahme gibts in allen Lottoläden! (Würfel auf der Karte!)")
    else
        setTimer(isLotteryTime, 60000, 1)
    end
end











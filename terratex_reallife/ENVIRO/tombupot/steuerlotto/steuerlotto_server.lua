--DEFINES
local winTimeHour = 19
local winTimeMinute = 30

function createTombuPotLottery()
    setTimer(isSteuerLotteryTime, 60000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createTombuPotLottery)

function addPlayerToSteuerLotto(thePlayer, amount)
    serversettings["steuerlottojackpot"] = serversettings["steuerlottojackpot"] + (amount / 100);
    local playerTicketCount = MySql.helper.getCountSync("user_steuerlotto", { Nickname = getPlayerName(thePlayer) })
    if (playerTicketCount < 1) then
        MySql.helper.insert("user_steuerlotto", {Nickname = getPlayerName(thePlayer)});
    end
end


function isSteuerLotteryTime()
    if isDevServer() then
        return;
    end

    local time = getRealTime()
    if (time.hour == winTimeHour and time.minute == winTimeMinute) then
        local gewinn = serversettings["steuerlottojackpot"];
        outputChatBox("Und die Steuer-Lotterieziehung beginnt ...")
        outputChatBox("... jeder der in letzten 24h einen PayDay hatte und gerade online ist nimmt automatisch teil ...")
        outputChatBox("... Zu gewinnen gibt es 1% aller Steuereinahmen der letzten 24h: " .. toprice(gewinn) .. " ...")
        outputChatBox("... Der Gewinner wird ermittelt.......")

        local players = getElementsByType ( "player" )

        if (table.getSize(players) > 0) then
            local whereClause = ""
            local isFirst = true
            local values = {};

            for theKey, thePlayer in ipairs(getElementsByType("player")) do
                if (not isFirst) then
                    whereClause = whereClause .. ","
                end
                whereClause = whereClause .. "?"
                table.insert(values, getPlayerName(thePlayer));
            end

            local query = dbQuery(MySql._connection, "SELECT * FROM user_steuerlotto WHERE Nickname IN (".. whereClause .. ") ORDER BY RAND() LIMIT 1", unpack(values));
            local result = dbPoll(query, -1);
            local dsatz = result[1];

            if (dsatz) then
                outputChatBox(string.format(".... und es hat %s gewonnen!!!!", dsatz["Nickname"]));

                local thePlayer = getPlayerFromName(dsatz["Nickname"])

                changePlayerMoney(thePlayer, gewinn, "sonstiges", "Gewinn in der Steuer-Lotterie")
                outputChatBox("Dein Gewinn wurde dir auf die Hand gegeben!", thePlayer, 155, 155, 0)
            else
                outputChatBox("...... und es hat keiner Teilgenommen!?");
            end

            dbExec(MySql._connection, "TRUNCATE TABLE user_steuerlotto");
            serversettings["steuerlottojackpot"] = 0;
        end
    else
        setTimer(isSteuerLotteryTime, 60000, 1)
    end
end

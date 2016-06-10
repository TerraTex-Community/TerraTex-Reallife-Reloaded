function frakdepot_log(Fraktion, Typ, Betrag, Name, Grund)
    if (type(Fraktion) ~= "number") then
        outputDebugString("ERROR frakdepotlog. FrakID not given: " .. debug.traceback())
    end
    local time = getRealTime()
    local timestamp = time.timestamp
    if not Grund then
        local logquery = "INSERT INTO frakkasse_zahlungen (Fraktion, Typ, Betrag, Datum, Name) VALUES ('" .. Fraktion .. "','" .. Typ .. "','" .. Betrag .. "','" .. timestamp .. "','" .. Name .. "')"
        mysql_query(handler, logquery)

    else
        local logquery = "INSERT INTO frakkasse_zahlungen (Fraktion, Typ, Betrag, Datum, Name, Grund) VALUES ('" .. Fraktion .. "','" .. Typ .. "','" .. Betrag .. "','" .. timestamp .. "','" .. Name .. "','" .. Grund .. "')"
        mysql_query(handler, logquery)
    end
end

function save_ad_log(name, text)
    text = mysql_escape_string(logs_handler, text)
    local countAdmins = 0
    for theKey, thePlayer in ipairs(getElementsByType("player")) do
        if (isAdminLevel(thePlayer, 0)) then
            countAdmins = countAdmins + 1
        end
    end

    if (countAdmins == 0) then
        text = mysql_escape_string(handler, text)
        local query = "INSERT INTO log_ad (Nickname,Text) VALUES ('" .. name .. "','" .. text .. "');"
        mysql_query(logs_handler, query)
    end
end


function save_steuer_log(player, betrag, type)
    local query = "INSERT INTO log_steuern (Nickname,Type,Betrag) VALUES ('" .. getPlayerName(player) .. "','" .. type .. "','" .. betrag .. "');"
    mysql_query(logs_handler, query)
end

function save_log(logname, message)
    local filename = "LOGS/" .. logname .. ".log"
    local filehandler
    if not (fileExists(filename)) then
        filehandler = fileCreate(filename)
        fileClose(filehandler)
    end

    filehandler = fileOpen(filename)
    if (filehandler) then

        local fileSize = fileGetSize(filehandler)
        fileSetPos(filehandler, fileSize)
        local messages = " \n " .. message
        fileWrite(filehandler, messages)
        fileClose(filehandler)
    end
end

function chat_log(thePlayer, message)
    local name = getPlayerName(thePlayer)
    local times = getRealTime()



    local logtext = "[" .. times.monthday .. "." .. (times.month + 1) .. "." .. (times.year + 1900) .. " - " .. times.hour .. ":" .. times.minute .. ":" .. times.second .. "] " .. name .. ": " .. message
    save_log("chat", logtext)

    message = mysql_escape_string(logs_handler, message)

    --	local query="INSERT INTO log_chat (Nickname,Message) VALUES ('"..getPlayerName(thePlayer).."','"..message.."');"
    --	mysql_query(logs_handler,query)

    checkServerWerbung(thePlayer, message)
    checkBeleidigung(thePlayer, message)
end

function afind(message, symbol)
    stcounter = 0
    x, y = string.find(message, symbol, 1, true)
    if (x) then
        stcounter = stcounter + 1
        n = 0
        while n ~= 1 do
            x, y = string.find(message, symbol, y + 1, true)
            if (x) then
                stcounter = stcounter + 1
            else
                n = 1
            end
        end
    end
    return stcounter
end

local leichteListe = {}
local schwereListe = {}

function load_beleidigungslisten()
    local query = "SELECT * FROM beleidigungsystem"
    local result = mysql_query(handler, query)
    while (true) do
        local dsatz = mysql_fetch_assoc(result)
        if (dsatz) then
            if (dsatz["Type"] == "0") then
                table.insert(leichteListe, dsatz["Beleidigung"])
            else
                table.insert(schwereListe, dsatz["Beleidigung"])
            end
        else
            break
        end
    end
    local dsatz = mysql_fetch_assoc(result)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), load_beleidigungslisten)

local maybeBeleidigung = {}
local maybeBeleidigungenIDs = 0
function checkBeleidigung(thePlayer, Message)
    local newmessage = Message
    Message = string.lower(Message)
    local counterschwer = 0
    local counterleicht = 0

    for theKey, theBeleidigung in ipairs(leichteListe) do
        counterleicht = counterleicht + afind(Message, theBeleidigung)
    end
    for theKey, theBeleidigung in ipairs(schwereListe) do
        counterschwer = counterschwer + afind(Message, theBeleidigung)
    end





    local bestraft = 0
    if (counterschwer > 0) then
        bestraft = 1
    end
    local InsertID = false
    if (counterleicht > 0) or (counterschwer > 0) then
        --save_log("Beleidigung",getPlayerName(thePlayer)..": "..Message)
        local query = "INSERT INTO log_badword (Nickname,Message,bestraft_per_system) VALUES ('" .. getPlayerName(thePlayer) .. "','" .. newmessage .. "','" .. bestraft .. "');"
        mysql_query(logs_handler, query)
        InsertID = mysql_insert_id(logs_handler)
    end
    if (counterleicht > 0) or (counterschwer > 0) then

        if (bestraft == 1) then
            local players = getElementsByType("player")
            for theKey, thePlayers in ipairs(players) do
                if (isPlayerLoggedIn(thePlayers)) then
                    if (isAdminLevel(thePlayers, 0)) then
                        outputChatBox(string.format("Mögliche Beleidigung detected von %s Die Nachicht lautete:", getPlayerName(thePlayer)), thePlayers, 255, 10, 0)
                        outputChatBox(newmessage, thePlayers, 255, 10, 0)
                        outputChatBox("Diese Beleidigung wurde vom System bereits bestraft!", thePlayers, 255, 10, 0)
                    end
                end
            end
        else
            maybeBeleidigungenIDs = maybeBeleidigungenIDs + 1
            maybeBeleidigung[maybeBeleidigungenIDs] = { getPlayerName(thePlayer), newmessage, InsertID, false, getPlayerSerial(thePlayer), getPlayerIP(thePlayer) }
            local players = getElementsByType("player")
            for theKey, thePlayers in ipairs(players) do
                if (isPlayerLoggedIn(thePlayers)) then
                    if (isAdminLevel(thePlayers, 0)) then
                        outputChatBox(string.format("Eine mögliche Beleidigung von %s wurde gefunden:", getPlayerName(thePlayer)), thePlayers, 255, 10, 0)
                        outputChatBox(string.format("Beleidigungstext: %s", newmessage), thePlayers, 255, 10, 0)
                        outputChatBox(string.format("Bannen mit '/bban %s'", maybeBeleidigungenIDs), thePlayers, 255, 10, 0)
                    end
                end
            end
        end
    end
    if (counterschwer > 0) then
        local reasons = "Beleidigungen sind unerwünscht!"
        local pname = getPlayerName(thePlayer)
        local theBeBanned = thePlayer
        local IP = getPlayerIP(theBeBanned)
        local Serial = getPlayerSerial(theBeBanned)
        local reasons = mysql_escape_string(handler, reasons)
        local pname = mysql_escape_string(handler, pname)

        --local querys="INSERT INTO Ban (Nickname,Serial,IP,Grund,Admin,Beweistext) VALUES ('"..pname.."','".. Serial.."','".. IP .."','"..reasons.."','Anti-Beleidigungs-System','"..Message.."');"
        local querys = "INSERT INTO timeban (Nickname,Grund,Admin,Minuten,Serial) VALUES ('" .. pname .. "','" .. reasons .. " (FÜR TEXT: " .. Message .. ")','Anti-Beleidigungs-System','4320','" .. Serial .. "')"

        mysql_query(handler, querys)

        vioSetElementData(thePlayer, "tbans", vioGetElementData(thePlayer, "tbans") + 1)
        local pln = getPlayerName(thePlayer)
        if (vioGetElementData(thePlayer, "tbans") == 1) then
            MySql.helper.update("userdata", { tban_reason1 = reasons }, { Nickname = pln });
        end
        if (vioGetElementData(thePlayer, "tbans") > 1) then
            local tban_reason = MySql.helper.getValueSync("userdata", "tban_reason1", { Nickname = pln });

            MySql.helper.update("userdata", { tban_reason1 = "no_reason" }, { Nickname = pln });
            local newreason = "2 Timebans: " .. tban_reason .. " + " .. reasons
            local querys = "INSERT INTO warns (Nickname,Admin,Grund) VALUES ('" .. pln .. "','Anti-Beleidigungs-System','" .. newreason .. "');"
            mysql_query(handler, querys)
            vioSetElementData(thePlayer, "tbans", 0)
        end



        outputChatBox(string.format("Der Spieler %s wurde vom Anti-Beleidigungs-System gebannt. Grund: %s", pname, reasons), getRootElement(), 255, 0, 0)
        kickPlayer(thePlayer, reasons)
    end
end

function bban_func(thePlayer, cmd, id)
    if (isAdminLevel(thePlayer, 1)) then
        id = tonumber(id)
        if (id) then
            if (maybeBeleidigung[id]) then
                if not (maybeBeleidigung[id][4]) then

                    local reasons = "Beleidigungen sind unerwünscht!"
                    local pname = maybeBeleidigung[id][1]
                    local theBeBanned = getPlayerFromName(maybeBeleidigung[id][1])
                    if (theBeBanned) then
                        checkAdditionalPunishment(theBeBanned)
                        local IP = getPlayerIP(theBeBanned)
                        local Serial = getPlayerSerial(theBeBanned)
                        local reasons = mysql_escape_string(handler, reasons)
                        local pname = mysql_escape_string(handler, pname)

                        --local querys="INSERT INTO Ban (Nickname,Serial,IP,Grund,Admin,Beweistext) VALUES ('"..pname.."','".. Serial.."','".. IP .."','"..reasons.."','Anti-Beleidigungs-System','"..maybeBeleidigung[id][2].."');"
                        vioSetElementData(theBeBanned, "tbans", vioGetElementData(theBeBanned, "tbans") + 1)
                        local pln = getPlayerName(theBeBanned)
                        if (vioGetElementData(thePlayer, "tbans") == 1) then
                            MySql.helper.update("userdata", { tban_reason1 = reasons }, { Nickname = pln });
                        end
                        if (vioGetElementData(theBeBanned, "tbans") > 1) then
                            local tban_reason = MySql.helper.getValueSync("userdata", "tban_reason1", { Nickname = pln });
                            MySql.helper.update("userdata", { tban_reason1 = "no_reason" }, { Nickname = pln });
                            local newreason = "2 Timebans: " .. tban_reason .. " + " .. reasons
                            local querys = "INSERT INTO warns (Nickname,Admin,Grund) VALUES ('" .. pln .. "','Anti-Beleidigungs-System','" .. newreason .. "');"
                            mysql_query(handler, querys)
                            vioSetElementData(theBeBanned, "tbans", 0)
                        end


                        local querys = "INSERT INTO timeban (Nickname,Grund,Admin,Minuten,Serial) VALUES ('" .. pname .. "','" .. reasons .. " (FÜR TEXT: " .. maybeBeleidigung[id][2] .. ")','Anti-Beleidigungs-System','4320','" .. Serial .. "')"
                        mysql_query(handler, querys)
                        outputChatBox(string.format("Der Spieler %s wurde vom Anti-Beleidigungs-System gebannt. Grund: %s", pname, reasons), getRootElement(), 255, 0, 0)
                        kickPlayer(theBeBanned, reasons)
                        query = "UPDATE log_badword SET bestraft_per_system=1 WHERE ID='" .. maybeBeleidigung[id][3] .. "'"
                        mysql_query(logs_handler, query)
                        maybeBeleidigung[id][4] = true
                    else
                        local IP = maybeBeleidigung[id][6]
                        local Serial = maybeBeleidigung[id][5]
                        local reasons = mysql_escape_string(handler, reasons)
                        local pname = maybeBeleidigung[id][1]
                        checkAdditionalPunishment_offline(pname)

                        --local querys="INSERT INTO Ban (Nickname,Serial,IP,Grund,Admin,Beweistext) VALUES ('"..pname.."','".. Serial.."','".. IP .."','"..reasons.."','Anti-Beleidigungs-System','"..maybeBeleidigung[id][2].."');"
                        local querys = "INSERT INTO timeban (Nickname,Grund,Admin,Minuten,Serial) VALUES ('" .. pname .. "','" .. reasons .. " (FÜR TEXT: " .. maybeBeleidigung[id][2] .. ")','Anti-Beleidigungs-System','4320','" .. Serial .. "')"
                        mysql_query(handler, querys)
                        outputChatBox(string.format("Der Spieler %s wurde vom Anti-Beleidigungs-System gebannt. Grund: %s", pname, reasons), getRootElement(), 255, 0, 0)
                        kickPlayer(theBeBanned, reasons)
                        local query = "UPDATE log_badword SET bestraft_per_system=1 WHERE ID='" .. maybeBeleidigung[id][3] .. "'"
                        mysql_query(logs_handler, query)
                        maybeBeleidigung[id][4] = true
                    end
                else
                    outputChatBox("Diese Beleidigung wurde bereits bestraft!", thePlayer, 255, 0, 0)
                end
            else
                outputChatBox("Diese BeleidigungsID existiert nicht!", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("Diese BeleidigungsID existiert nicht!", thePlayer, 255, 0, 0)
        end
    end
end

addCommandHandler("bban", bban_func, false, false)

function checkServerWerbung(thePlayer, Message)
    local newmessage = Message
    Message = string.lower(Message)
    local counter = 0
    counter = counter + afind(Message, "reallife")
    counter = counter + afind(Message, "www")
    counter = counter + afind(Message, "http")
    counter = counter + afind(Message, ".de")
    counter = counter + afind(Message, ".com")
    counter = counter + afind(Message, ".net")
    counter = counter + afind(Message, ".at")
    counter = counter + afind(Message, ".org")
    counter = counter + afind(Message, ".info")
    counter = counter + afind(Message, ".biz")
    counter = counter + afind(Message, ".eu")
    counter = counter + afind(Message, ".name")
    counter = counter + afind(Message, ".nl")
    counter = counter + afind(Message, ".ch")
    counter = counter + afind(Message, ".cz")
    counter = counter + afind(Message, ".co")
    counter = counter + afind(Message, ".me")
    counter = counter + afind(Message, ".ru")
    counter = counter + afind(Message, "ilife")
    counter = counter + afind(Message, ".se")
    counter = counter + afind(Message, ".ws")
    counter = counter + afind(Message, "vio")


    if (pregFind(Message, '[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}.[0-9]{1,3}')) then
        counter = counter + 1;
    end

    for key, domain in ipairs(config["domains"]) do
        if (afind(Message, domain) > 0) then
            counter = 0
        end
    end




    if (counter > 0) then
        local players = getElementsByType("player")
        for theKey, thePlayers in ipairs(players) do
            if (isPlayerLoggedIn(thePlayers)) then
                if (isAdminLevel(thePlayers, 0)) then
                    outputChatBox(string.format("Mögliche Werbung detected von %s Die Nachicht lautete:", getPlayerName(thePlayer)), thePlayers, 255, 10, 0)
                    outputChatBox(newmessage, thePlayers, 255, 10, 0)
                end
            end
        end
        save_log("Serverwerbung", getPlayerName(thePlayer) .. ": " .. newmessage)
        local query = "INSERT INTO log_serveradvertising (Nickname,Message) VALUES ('" .. getPlayerName(thePlayer) .. "','" .. newmessage .. "');"
        mysql_query(logs_handler, query)
    end
end

function checkMultiaccount(thePlayer)
    local IP = getPlayerIP(thePlayer)
    local Serial = getPlayerSerial(thePlayer)
    local pname = getPlayerName(thePlayer)
    local multiIP = MySql.helper.getCountSync("players", {IP = IP, Nickname = {"!=", pname}})

    local multiSerial = MySql.helper.getCountSync("players", {Serial = Serial, Nickname = {"!=", pname}})
    if (multiIP > 0 or multiSerial > 0) then
        local players = getElementsByType("player")
        for theKey, thePlayers in ipairs(players) do
            if (isPlayerLoggedIn(thePlayers)) then
                if (isAdminLevel(thePlayers, 1)) then
                    --outputChatBox("Möglicher Multiaccount detected: "..pname.." ACCOUNTS: per IP: "..multiIP.." per SERIAL: "..multiSerial,thePlayers,255,10,0)
                    --outputChatBox("Mehr Multiaccountinfos mit /multiacc [Nickname]",thePlayers,255,0,0)
                end
            end
        end
        save_log("multiAccount", "Möglicher Multiaccount detected: " .. pname .. " ACCOUNTS: per IP: " .. multiIP .. " per SERIAL: " .. multiSerial)
    end
end

function multiacc_func(thePlayer, command, toPlayerName)
    if (isAdminLevel(thePlayer, 1)) then
        local pname = toPlayerName
        local IP = MySql.helper.getValueSync("players", "IP", { Nickname = pname });
        local Serial = MySql.helper.getValueSync("players", "Serial", { Nickname = pname });
        if (IP and Serial) then
            local multiIP = MySql.helper.getCountSync("players", {IP = IP})
            local multiSerial = MySql.helper.getCountSync("players", {Serial = Serial})
            local multiIPAccounts = {}
            local multiSerialAccounts = {}

            local result = mysql_query(handler, "SELECT * from players WHERE IP='" .. IP .. "'")
            while (true) do
                local dsatz = mysql_fetch_assoc(result)
                if (not dsatz) then break else
                    table.insert(multiIPAccounts, { dsatz["Nickname"], dsatz["RegDat"], dsatz["LastLogin"] })
                end
            end
            mysql_free_result(result)
            local result = mysql_query(handler, "SELECT * from players WHERE Serial='" .. Serial .. "'")
            while (true) do
                local dsatz = mysql_fetch_assoc(result)
                if (not dsatz) then break else
                    table.insert(multiSerialAccounts, { dsatz["Nickname"], dsatz["RegDat"], dsatz["LastLogin"] })
                end
            end
            mysql_free_result(result)


            local multi = multiIP + multiSerial
            outputChatBox(string.format("Zu dem Spieler %s wurden %s Accounts gefunden: ", pname, multi), thePlayer, 255, 0, 0)
            for theKey, thePlayerTable in ipairs(multiIPAccounts) do
                outputChatBox(string.format("(IP)Nickname: %s; RegDat%s; LastLogin:%s", thePlayerTable[1], thePlayerTable[2], thePlayerTable[3]), thePlayer, 255, 0, 0)
            end
            for theKey, thePlayerTable in ipairs(multiSerialAccounts) do
                outputChatBox(string.format("(IP)Nickname: %s; RegDat%s; LastLogin:%s", thePlayerTable[1], thePlayerTable[2], thePlayerTable[3]), thePlayer, 255, 0, 0)
            end




        else
            outputChatBox(string.format("In Der Datenbank existiert kein Spieler mit dem Namen %s.", pname), thePlayer, 255, 0, 0)
        end
    end
end

addCommandHandler("multiacc", multiacc_func, false, false)











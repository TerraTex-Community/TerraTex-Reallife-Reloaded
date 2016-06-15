function frakdepot_log(Fraktion, Typ, Betrag, Name, Grund)
    if (type(Fraktion) ~= "number") then
        outputDebugString("ERROR frakdepotlog. FrakID not given: " .. debug.traceback())
    end
    local time = getRealTime()
    local timestamp = time.timestamp
    if not Grund then
        MySql.helper.insert("log_faction_inventory", {
            Fraktion = Fraktion,
            Typ = Typ,
            Betrag = Betrag,
            Datum = timestamp,
            Name = Name
        });

    else
        MySql.helper.insert("log_faction_inventory", {
            Fraktion = Fraktion,
            Typ = Typ,
            Betrag = Betrag,
            Datum = timestamp,
            Name = Name,
            Grund = Grund
        });
    end
end

function save_ad_log(name, text)
    local countAdmins = 0
    for theKey, thePlayer in ipairs(getElementsByType("player")) do
        if (isAdminLevel(thePlayer, 0)) then
            countAdmins = countAdmins + 1
        end
    end

    if (countAdmins == 0) then
        MySql.helper.insert("log_ad", {
            Nickname = name,
            Text = text
        });
    end
end


function save_steuer_log(player, betrag, type)
    MySql.helper.insert("log_steuern", {
        Nickname = getPlayerName(player),
        Type = type,
        Betrag = betrag
    });
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
    save_log("chat", logtext);

    MySql.helper.insert("log_chat", {
        Nickname = getPlayerName(thePlayer),
        Message = message
    });

    checkServerWerbung(thePlayer, message)
    checkBeleidigung(thePlayer, message)
end

function afind(message, symbol)
    local stcounter = 0
    local x, y = string.find(message, symbol, 1, true)
    if (x) then
        stcounter = stcounter + 1
        local n = 0
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
    local result = MySql.helper.getSync("admin_data_badwords", "*");
    for theKey, dsatz in ipairs(result) do
        if (dsatz["Type"] == "0") then
            table.insert(leichteListe, dsatz["Beleidigung"])
        else
            table.insert(schwereListe, dsatz["Beleidigung"])
        end
    end
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
        InsertID = MySql.helper.insertSync("log_badword", {
            Nickname = getPlayerName(thePlayer),
            Message = newmessage,
            bestraft_per_system = bestraft
        });
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

        MySql.helper.insert("admin_user_timebans", {
            Nickname = pname,
            Grund = reasons .. "(FÜR TEXT: " .. Message .. ")",
            Admin = "Anti-Beleidigungs-System",
            Minuten = "4320",
            Serial = Serial
        });

        vioSetElementData(thePlayer, "tbans", vioGetElementData(thePlayer, "tbans") + 1)
        local pln = getPlayerName(thePlayer)
        if (vioGetElementData(thePlayer, "tbans") == 1) then
            MySql.helper.update("user_data", { tban_reason1 = reasons }, { Nickname = pln });
        end

        if (vioGetElementData(thePlayer, "tbans") > 1) then
            local tban_reason = MySql.helper.getValueSync("user_data", "tban_reason1", { Nickname = pln });

            MySql.helper.update("user_data", { tban_reason1 = "no_reason" }, { Nickname = pln });
            local newreason = "2 Timebans: " .. tban_reason .. " + " .. reasons

            MySql.helper.insert("admin_user_warns", {
                Nickname = pln,
                Admin = "Anti-Beleidigungs-System",
                Grund = newreason
            });
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

                        vioSetElementData(theBeBanned, "tbans", vioGetElementData(theBeBanned, "tbans") + 1)
                        local pln = getPlayerName(theBeBanned)
                        if (vioGetElementData(thePlayer, "tbans") == 1) then
                            MySql.helper.update("user_data", { tban_reason1 = reasons }, { Nickname = pln });
                        end
                        if (vioGetElementData(theBeBanned, "tbans") > 1) then
                            local tban_reason = MySql.helper.getValueSync("user_data", "tban_reason1", { Nickname = pln });
                            MySql.helper.update("user_data", { tban_reason1 = "no_reason" }, { Nickname = pln });
                            local newreason = "2 Timebans: " .. tban_reason .. " + " .. reasons

                            MySql.helper.insert("admin_user_warns", {
                                Nickname = pln,
                                Admin = "Anti-Beleidigungs-System",
                                Grund = newreason
                            });

                            vioSetElementData(theBeBanned, "tbans", 0)
                        end

                        MySql.helper.insert("admin_user_timebans", {
                            Nickname = pname,
                            Grund = reasons .. " (FÜR TEXT: " .. maybeBeleidigung[id][2] .. ")",
                            Admin = "Anti-Beleidigungs-System",
                            Minuten = 4320,
                            Serial = Serial
                        });

                        outputChatBox(string.format("Der Spieler %s wurde vom Anti-Beleidigungs-System gebannt. Grund: %s", pname, reasons), getRootElement(), 255, 0, 0)
                        kickPlayer(theBeBanned, reasons)

                        MySql.helper.update("log_badword", {bestraft_per_system = 1}, {ID = maybeBeleidigung[id][3]});
                        maybeBeleidigung[id][4] = true
                    else
                        local IP = maybeBeleidigung[id][6]
                        local Serial = maybeBeleidigung[id][5]
                        local pname = maybeBeleidigung[id][1]
                        checkAdditionalPunishment_offline(pname)

                        MySql.helper.insert("admin_user_timebans", {
                            Nickname = pname,
                            Grund = reasons .. " (FÜR TEXT: " .. maybeBeleidigung[id][2] .. ")",
                            Admin = "Anti-Beleidigungs-System",
                            Minuten = 4320,
                            Serial = Serial
                        });

                        outputChatBox(string.format("Der Spieler %s wurde vom Anti-Beleidigungs-System gebannt. Grund: %s", pname, reasons), getRootElement(), 255, 0, 0)
                        kickPlayer(theBeBanned, reasons)

                        MySql.helper.update("log_badword", {bestraft_per_system = 1}, {ID = maybeBeleidigung[id][3]});
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

        MySql.helper.insert("log_serveradvertising", {
            Nickname = getPlayerName(thePlayer),
            Message = newmessage
        });
    end
end

addEvent("kickMeBecauseWrongVersion", true)
function kickMeBecauseWrongVersion_func(player)
    if source ~= client then return end
    kickPlayer(player, "You have an older Version, upgrade on www.mtasa.com!")
end
addEventHandler("kickMeBecauseWrongVersion", getRootElement(), kickMeBecauseWrongVersion_func)

local isDevServerV = false
function isDevServer()
    isDevServerV = fileExists(":" .. getResourceName(getThisResource()) .. "/devmode.dev")
    return isDevServerV
end

serversettings = {}
Tagesdurchnitte = {}

function version_func(thePlayer)
    outputChatBox(string.format("Aktuelle Serverversion: %s", serversettings["Version"]), thePlayer)
end

addCommandHandler("version", version_func, false, false)

function loadSettingsFromDB()
    setAircraftMaxVelocity(50)
    setModelHandling(433, "maxVelocity", 120)
    setModelHandling(433, "engineAcceleration", 25)
    setModelHandling(433, "engineInertia", 80)
    setModelHandling(433, "dragCoeff", 4)
    setModelHandling(433, "driveType", "awd")

    local speedUpTable = { [490] = 15, [596] = 15, [597] = 15, [598] = 15, [470] = 30, [599] = 30 }
    for vehicle, kmh in pairs(speedUpTable) do
        kmh = kmh * 2.5
        local originalTABEL = getOriginalHandling(vehicle)
        local Handler = (originalTABEL["maxVelocity"] + tonumber(kmh)) / originalTABEL["maxVelocity"]
        setModelHandling(vehicle, "maxVelocity", originalTABEL["maxVelocity"] * Handler)
        setModelHandling(vehicle, "engineAcceleration", originalTABEL["engineAcceleration"] * Handler)
        setModelHandling(vehicle, "engineInertia", originalTABEL["engineInertia"] * Handler)
    end

    serversettings["drogenpreis"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "drogenpreis" });
    serversettings["steuersatz"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "steuersatz" });
    serversettings["sozialabgabesatz"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "sozialabgabesatz" });
    serversettings["matspreis"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "matspreis" });
    serversettings["lottojackpot"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "Jackpot" });
    serversettings["Ueberweisungssteuer"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "Ueberweisungssteuer" });
    serversettings["tankpreis"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "tankpreis" });
    serversettings["Version"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "Version" });
    serversettings["atommuell"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "atommuell" });
    serversettings["playerOfMonthPic"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "spielerDesMonats" });
    serversettings["steuerlottojackpot"] = MySql.helper.getValueSync("data_settings", "Wert", { Name = "steuerlottojackpot" });

    setGameType("TerraTex Reallife Reloaded Script " .. serversettings["Version"])
    setRuleValue("Homepage", config["maindomain"])
    setMapName("TerraTex")
    resetWaterLevel(0)

    serversettings["Max_User"] = 0
    if not (fileExists(":" .. getResourceName(getThisResource()) .. "/devmode.dev")) then
        local lastDailyReset = MySql.helper.getValueSync("data_settings", "Wert", { Name = "DailyReset" });

        local time = getRealTime()
        local timestamp = time.timestamp

        if (timestamp - (22 * 60 * 60) > lastDailyReset) then
            MySql.helper.update("data_settings", {Wert = timestamp}, {Name = 'DailyReset'});
            dbExec(MySql._connection, "UPDATE user_vehicles SET fahrzeugalter=fahrzeugalter+1");

            dbExec(MySql._connection, "UPDATE user SET AktiveDays=AktiveDays+1");
            dbExec(MySql._connection, "UPDATE user_data SET AktiveDays=AktiveDays+1");

            local changeaccounts = 0


            local query = "SELECT Nickname FROM user WHERE Nickname IN (SELECT Besitzer FROM user_vehicles WHERE abgeschleppt = 0) AND AktiveDays > 10";
            local qh = dbQuery(MySql._connection, query);
            local result = dbPoll( qh, -1 );
            if (result) then
                for theKey, theRow in ipairs(result) do
                    MySql.helper.update("user_vehicles", {abgeschleppt = 1}, {Besitzer = theRow["Nickname"]});
                    save_offline_message(theRow["Nickname"], "Inaktiv-System", "Aufgrund deiner Inaktivität wurden alle Fahrzeuge abgeschleppt.")

                    changeaccounts = changeaccounts + 1
                end
            end

            local query = "SELECT Nickname FROM user WHERE AktiveDays > 60 AND Nickname IN (SELECT Nickname FROM user_data WHERE newhkey != 0 OR prestigeKey != 0)";
            local qh = dbQuery(MySql._connection, query);
            local result = dbPoll( qh, -1 );
            if (result) then
                for theKey, theRow in ipairs(result) do
                    MySql.helper.update("user_data", {
                        newhkey = 0,
                        prestigeKey = 0
                    }, {Nickname = theRow["Nickname"]})
                    save_offline_message(theRow["Nickname"], "Inaktiv-System", "Aufgrund deiner Inaktivität wurde deine Fraktion, dein Haus, dein Prestige und dein Business zurückgesetzt.")

                    changeaccounts = changeaccounts + 1;
                end
            end

--            local query = "SELECT user_data.* FROM user_data LEFT JOIN user ON user.Nickname=user_data.Nickname WHERE user_data.PlayTime<=60 and user.AktiveDays>=30"
--            local handler = dbQuery(MySql._connection, query);
--            local result = dbPoll(handler, -1);
--
--            if (result) then
--                for theKey, dasatz in ipairs(result) do
--                    MySql.helper.delete("user", {Nickname = dasatz["Nickname"]});
--
--                    save_log("nickdelete", dasatz["Nickname"]);
--                    changeaccounts = changeaccounts + 1;
--                end
--            end


            local query = "SELECT Nickname FROM user WHERE AktiveDays > 365 AND Nickname IN (SELECT Nickname FROM admin_user_bans)";
            local qh = dbQuery(MySql._connection, query);
            local result = dbPoll( qh, -1 );
            if (result) then
                for theKey, dasatz in ipairs(result) do
                    MySql.helper.delete("admin_user_bans", {Nickname = dasatz["Nickname"]});

                    save_log("nickdelete", dasatz["Nickname"]);
                    changeaccounts = changeaccounts + 1;
                end
            end
            outputDebugString(tostring(changeaccounts) .. " Accounts have been Changed")
        end
    else
        isDevServerV = true
    end
    setTimer(saveSettingsInDB, 3600000, 1)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadSettingsFromDB)

function saveSettingsInDB()

    MySql.helper.update("data_settings", { Wert = serversettings["drogenpreis"] }, { Name = "drogenpreis"});
    MySql.helper.update("data_settings", { Wert = serversettings["lottojackpot"] }, { Name = "Jackpot"});
    MySql.helper.update("data_settings", { Wert = serversettings["matspreis"] }, { Name = "matspreis"});
    MySql.helper.update("data_settings", { Wert = serversettings["tankpreis"] }, { Name = "tankpreis"});
    MySql.helper.update("data_settings", { Wert = serversettings["atommuell"] }, { Name = "atommuell"});
    MySql.helper.update("data_settings", { Wert = serversettings["steuerlottojackpot"] }, { Name = "steuerlottojackpot"});
    MySql.helper.update("data_settings", { Wert = rainlevel }, { Name = "regenlevel"});

    setTimer(saveSettingsInDB, 3600000, 1)
end

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), saveSettingsInDB)

function stopResource_func()
    MySql.helper.update("data_settings", { Wert = serversettings["drogenpreis"] }, { Name = "drogenpreis"});
    MySql.helper.update("data_settings", { Wert = serversettings["lottojackpot"] }, { Name = "Jackpot"});
    MySql.helper.update("data_settings", { Wert = serversettings["matspreis"] }, { Name = "matspreis"});
    MySql.helper.update("data_settings", { Wert = serversettings["tankpreis"] }, { Name = "tankpreis"});
    MySql.helper.update("data_settings", { Wert = serversettings["atommuell"] }, { Name = "atommuell"});
    MySql.helper.update("data_settings", { Wert = serversettings["steuerlottojackpot"] }, { Name = "steuerlottojackpot"});
    MySql.helper.update("data_settings", { Wert = rainlevel }, { Name = "regenlevel"});


    local time = getRealTime()
    if (fileExists("LOGS/chat.log")) then
        if (fileExists("LOGS/chat/" .. time.monthday .. "." .. (time.month + 1) .. "." .. (1900 + time.year) .. "-chat.log")) then
            fileRename("LOGS/chat.log", "LOGS/chat/" .. time.monthday .. "." .. (time.month + 1) .. "." .. (1900 + time.year) .. "-" .. (time.timestamp) .. "-chat.log")
        else
            fileRename("LOGS/chat.log", "LOGS/chat/" .. time.monthday .. "." .. (time.month + 1) .. "." .. (1900 + time.year) .. "-chat.log")
        end
    end
end

addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), stopResource_func)

function reduceSchutzGeld(timestate)
    local query = "UPDATE user_data SET schutzgeld=schutzgeld-1 WHERE schutzgeld>0";
    dbExec(MySql._connection, query);

    for theKey, thePlayer in ipairs(getElementsByType("player")) do
        if (vioGetElementData(thePlayer, "schutzgeld")) then
            if (vioGetElementData(thePlayer, "schutzgeld") > 0) then
                vioSetElementData(thePlayer, "schutzgeld", vioGetElementData(thePlayer, "schutzgeld") - 1)
            end
        end
    end

    setTimer(reduceSchutzGeld, 60000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), reduceSchutzGeld)

function timebanreduce()
    local query = "UPDATE admin_user_timebans SET Minuten=Minuten-1;"
    dbExec(MySql._connection, query);
    MySql.helper.delete("admin_user_timebans", {Minuten = {"<=", 0}});

    setTimer(timebanreduce, 60000, 1)
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), timebanreduce)

local startResourceUPGMX = 0
function start_GMX()

    if (string.upper(config["dailyrestarttype"]) ~= "NONE") then
        local hours = getRealTime()
        setTime(hours.hour, hours.minute)
        if (hours.hour == 3) then
            if (startResourceUPGMX > 0) then
                outputDebugString("AUTO GMX Started by Console")
                outputChatBox("Regulärer 3 Uhr Serverneustart in 10 Minuten!", getRootElement(), 255, 0, 0)
                outputChatBox("Regulärer 3 Uhr Serverneustart in 10 Minuten!", getRootElement(), 255, 0, 0)
                outputChatBox("Regulärer 3 Uhr Serverneustart in 10 Minuten!", getRootElement(), 255, 0, 0)

                if (string.upper(config["dailyrestarttype"]) == "SHUTDOWN") then
                    setTimer(startShutDown, (10 * 60 * 1000), 1)
                else
                    setTimer(gmx_start, (10 * 60 * 1000), 1)
                end
                setTimer(gmxRestTime, 60000, 1, (10))
            else
                setTimer(start_GMX, 3600000, 1)
            end
        else
            startResourceUPGMX = startResourceUPGMX + 1
            setTimer(start_GMX, 3600000, 1)
        end
    end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), start_GMX)

function resetLogins()
    for theKey, thePlayer in ipairs(getElementsByType('player')) do
        vioSetElementData(thePlayer, "loggedin", false)
    end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), resetLogins)

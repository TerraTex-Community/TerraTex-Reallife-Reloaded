--
-- Created by IntelliJ IDEA.
-- User: Geramy
-- Date: 31.07.2014
-- Time: 20:15
-- To change this template use File | Settings | File Templates.
--

function checkAdditionalPunishment(thePlayer)
    checkAdditionalPunishment_offline(getPlayerName(thePlayer))
end

function checkAdditionalPunishment_offline(playerName)
    local tryKickPlayer = false

    local result = MySql.helper.getSync("admin_user_paroles", "*", { Nickname = playerName });

    for theKey, dasatz in ipairs(result) do

        local time = getTimestamp()
        if (time < tonumber(dasatz["until"])) then
            if (tonumber(dasatz["warn"]) > 0) then
                for i = 0, tonumber(dasatz["warn"]), 1 do

                    MySql.helper.insert("admin_user_warns", {
                        Admin = dasatz["Adminname"],
                        Grund = dasatz["Grund"],
                        Nickname = dasatz["Nickname"]
                    });

                end
                save_offline_message(dasatz["Nickname"], "Bewährungssystem", "Durch dein Fehlverhalten wurde deine Bewährungsstrafe nun durchgeführt und du hast " .. dasatz["warn"] .. " Warns erhalten")

                if (MySql.helper.getCountSync("admin_user_warns", { Nickname = dasatz["Nickname"] }) > 2) then
                    local serial = MySql.helper.getValueSync("user", "Serial", { Nickname = dasatz["Nickname"] });

                    MySql.helper.insert("admin_user_bans", {
                        Nickname = dasatz["Nickname"],
                        Serial = serial,
                        IP = 0,
                        Grund = "3 Warns",
                        Admin = "Warnsystem"
                    });
                    tryKickPlayer = true
                end
            end
            if (tonumber(dasatz["tban"]) > 0) then
                MySql.helper.insert("admin_user_timebans", {
                    Nickname = dasatz["Nickname"],
                    Grund = "Bewährungsstrafe: " .. dasatz["Grund"],
                    Admin = dasatz["Adminname"],
                    Minuten = dasatz["tban"]
                });
                save_offline_message(dasatz["Nickname"], "Bewährungssystem", "Durch dein Fehlverhalten wurde deine Bewährungsstrafe nun durchgeführt und du hast einen Timeban erhalten")
                tryKickPlayer = true
            end
            if (tonumber(dasatz["perma"]) > 0) then
                local serial = MySql.helper.getValueSync("user", "Serial", { Nickname = dasatz["Nickname"] });

                MySql.helper.insert("admin_user_bans", {
                    Nickname = dasatz["Nickname"],
                    Serial = serial,
                    IP = 0,
                    Grund = "Bewährungsstrafe: " .. dasatz["Grund"],
                    Admin = dasatz["Adminname"]
                });
                tryKickPlayer = true
            end
        end

        MySql.helper.delete("admin_user_paroles", {ID = dasatz["ID"]});
        if (tryKickPlayer) then
            if (getPlayerFromName(playerName)) then
                setTimer(kickMeIfYouCan, 10000, 1, getPlayerFromName(playerName))
            end
        end
    end
end

function kickMeIfYouCan(thePlayer)
    kickPlayer(thePlayer, "Deine Bewährungsstrafe wurde durch dein Fehlverhalten fällig")
end


function checkAdditionalPunishment(thePlayer)
    checkAdditionalPunishment_offline(getPlayerName(thePlayer))
end

function checkAdditionalPunishment_offline(playerName)
    local tryKickPlayer = false

    local result = MySql.helper.getSync("admin_user_paroles", "*", { Nickname = playerName });

    for _, daSatz in ipairs(result) do

        local time = getTimestamp()
        if (time < tonumber(daSatz["until"])) then
            if (tonumber(daSatz["warn"]) > 0) then
                for i = 0, tonumber(daSatz["warn"]), 1 do

                    MySql.helper.insert("admin_user_warns", {
                        Admin = daSatz["Adminname"],
                        Grund = daSatz["Grund"],
                        Nickname = daSatz["Nickname"]
                    });

                end
                save_offline_message(daSatz["Nickname"], "Bewährungssystem", "Durch dein Fehlverhalten wurde deine Bewährungsstrafe nun durchgeführt und du hast " .. daSatz["warn"] .. " Warns erhalten")

                if (MySql.helper.getCountSync("admin_user_warns", { Nickname = daSatz["Nickname"] }) > 2) then
                    local serial = MySql.helper.getValueSync("user", "Serial", { Nickname = daSatz["Nickname"] });

                    MySql.helper.insert("admin_user_bans", {
                        Nickname = daSatz["Nickname"],
                        Serial = serial,
                        IP = 0,
                        Grund = "3 Warns",
                        Admin = "Warnsystem"
                    });
                    tryKickPlayer = true
                end
            end
            if (tonumber(daSatz["tban"]) > 0) then
                MySql.helper.insert("admin_user_timebans", {
                    Nickname = daSatz["Nickname"],
                    Grund = "Bewährungsstrafe: " .. daSatz["Grund"],
                    Admin = daSatz["Adminname"],
                    Minuten = daSatz["tban"]
                });
                save_offline_message(daSatz["Nickname"], "Bewährungssystem", "Durch dein Fehlverhalten wurde deine Bewährungsstrafe nun durchgeführt und du hast einen Timeban erhalten")
                tryKickPlayer = true
            end
            if (tonumber(daSatz["perma"]) > 0) then
                local serial = MySql.helper.getValueSync("user", "Serial", { Nickname = daSatz["Nickname"] });

                MySql.helper.insert("admin_user_bans", {
                    Nickname = daSatz["Nickname"],
                    Serial = serial,
                    IP = 0,
                    Grund = "Bewährungsstrafe: " .. daSatz["Grund"],
                    Admin = daSatz["Adminname"]
                });
                tryKickPlayer = true
            end
        end

        MySql.helper.delete("admin_user_paroles", {ID = daSatz["ID"]});
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


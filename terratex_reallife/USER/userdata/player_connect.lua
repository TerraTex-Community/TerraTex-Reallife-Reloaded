local sonderzeichen = { " ", "ä", "ü", "ö", ",", "#", "'", "+", "*", "~", ":", ";", "=", "}", "?", "\\", "{", "&", "/", "§", "\"", "!", "°", "@", "|", "`", "´" }

-- error bei . ^ und $
privVeh = {}

function playerConnect(playerNick, playerIP, playerUsername, playerSerial, playerVersionNumber)
    vioSetElementData(source, "playTime_formated", "connecting")
    if playerNick == "Player" then
        cancelEvent(true, "Der Nick \"Player\" ist nicht gestattet! Wähle im Settings-Menü einen neuen!")
        return true;
    else

        for theKey, theSonder in ipairs(sonderzeichen) do
            if (string.find(playerNick, theSonder)) then
                --outputDebugString(theSonder)
                cancelEvent(true, "Es sind keine Farbcodes und Sonderzeichen gestattet!")
                return true;
            end
        end

        if (utfLen(playerNick) ~= string.len(playerNick)) then
            --cancelEvent(true,"Dein Nickname beinhaltet nicht erlaubte Sonderzeichen.")
            --return true;
            outputDebugString("UTFLEN: " .. tostring(utfLen(playerNick)) .. " ~= STRINGLEN " .. tostring(string.len(playerNick)))
        end

        local testtag = pregReplace(config["clantag"], "\\[", "")
        testtag = pregReplace(testtag, "\\]", "")
        if (string.find(string.lower(playerNick), string.lower(testtag))) then
            --outputDebugString(theSonder)
            if (MySql.helper.getValueSync("user", "Nickname", { Nickname = playerNick })) then
            else
                cancelEvent(true, "Das ClanTag " .. config["clantag"] .. " kann nur durch einen Admin vergeben werden!")
                return true;
            end
        elseif (MySql.helper.existSync("user", { Nickname = config["clantag"] .. playerNick })) then
            cancelEvent(true, "Ein Mitglied des " .. config["clantag"] .. "s trägt bereits diesen Namen!")
            return true;
        end

        if isNumeric(playerNick) then
            cancelEvent(true, "Es muessen Buchstaben enthalten sein!")
            return true;
        end


        if (MySql.helper.existSync("admin_user_bans", { IP = playerIP })) then

            local reason = MySql.helper.getValueSync("admin_user_bans", "Grund", { IP = playerIP });

            local datum = MySql.helper.getValueSync("admin_user_bans", "Bandatum", { IP = playerIP });
            local admin = MySql.helper.getValueSync("admin_user_bans", "Admin", { IP = playerIP });
            local banstring = string.format("Du wurdest am %s von Admin %s vom Server gebannt Grund%s weitere Info unter cp.terratex.eu", datum, admin, reason)
            cancelEvent(true, banstring)
            return true;
        else

            if (MySql.helper.existSync("admin_user_bans", { Nickname = playerNick })) then
                local reason = MySql.helper.getValueSync("admin_user_bans", "Grund", { Nickname = playerNick });
                local datum = MySql.helper.getValueSync("admin_user_bans", "Bandatum", { Nickname = playerNick });
                local admin = MySql.helper.getValueSync("admin_user_bans", "Admin", { Nickname = playerNick });
                local banstring = string.format("Du wurdest am %s von Admin %s vom Server gebannt Grund%s weitere Info unter cp.terratex.eu", datum, admin, reason)
                cancelEvent(true, banstring)
                return true;
            else
                if (MySql.helper.existSync("admin_user_bans", { Serial = playerSerial })) then
                    local reason = MySql.helper.getValueSync("admin_user_bans", "Grund", { Serial = playerSerial });
                    local datum = MySql.helper.getValueSync("admin_user_bans", "Bandatum", { Serial = playerSerial });
                    local admin = MySql.helper.getValueSync("admin_user_bans", "Admin", { Serial = playerSerial });
                    local banstring = string.format("Du wurdest am %s von Admin %s vom Server gebannt Grund%s weitere Info unter cp.terratex.eu", datum, admin, reason)
                    cancelEvent(true, banstring)
                    return true;
                else

                    if (MySql.helper.existSync("admin_user_timebans", { Nickname = playerNick })) then

                        local reason = MySql.helper.getValueSync("admin_user_timebans", "Grund", { Nickname = playerNick });
                        local admin = MySql.helper.getValueSync("admin_user_timebans", "Admin", { Nickname = playerNick });
                        local rest = MySql.helper.getValueSync("admin_user_timebans", "Minuten", { Nickname = playerNick });
                        local timestring = rest .. " Minuten"
                        if (rest >= 120) then
                            rest = math.round(rest / 60, 0)
                            timestring = rest .. " Stunden"
                        end
                        local banstring = string.format("Du bist noch %s gebannt! \nvon: %s \nGrund: %s", timestring, admin, reason)
                        cancelEvent(true, banstring)
                        return true;
                    end
                end
            end
        end

        --MultiaccCheck
        if not (MySql.helper.existSync("user", { Nickname = playerNick })) then
            if (MySql.helper.existSync("user", { Serial = playerSerial })) then
                if (MySql.helper.existSync("admin_whitelist_multiaccounts", { Serial = playerSerial })) then

                    local multiSerialAccounts = {}
                    local id = 0

                    local result = MySql.helper.getSync("admin_whitelist_multiaccounts", "*", { Serial = playerSerial });

                    for theKey, dsatz in ipairs(result) do
                        id = dsatz["ID"]
                    end
                    vioSetElementData(source, "deleteMultiAccErlaubnis", id)
                else
                    cancelEvent(true, string.format("Es wurden bereits Accounts von diesem PC, auf dem Server registriert. Infos über bereits registrierte Accounts auf: http://cp.terratex.eu/?page=multi&id=%s [Such ID: %s]", id, id))
                    return true;
                end
            end
        end

        if (MySql.helper.getValueSync("user", "force_nickchange", { Nickname = playerNick }) == 1) then
            cancelEvent(true, "Dein Account ist gesperrt: Dein Nickname entspricht nicht den Richtlinien. Beantrage einen Nickchange auf " .. config["maindomain"] .. " um einen Account wieder freizuschalten.")
            return true;
        end
    end
end
addEventHandler("onPlayerConnect", getRootElement(), playerConnect)

addEvent("clientisreadyforlogin", true)
function playerreadylogin()
    vioSetElementData(source, "logtries", 0)
    if (MySql.helper.existSync("user", { Nickname = getPlayerName(source) })) then
        triggerClientEvent(source, "showLoginGui", source, source)
    else
        triggerClientEvent(source, "showRegisterGui", source, source)
    end
end
addEventHandler("clientisreadyforlogin", getRootElement(), playerreadylogin)

function RegisterPlayerData(nickname, pass, email, gebt, gebm, geby, werber)

    local salt = randomstring(25)

    if (werber ~= "" and MySql.helper.existSync("user", { Nickname = werber })) or werber == "" then

        if not (MySql.helper.existSync("user", { Nickname = nickname })) then

            if (config["password_hash"] == "md5") then
                pass = md5(salt .. pass)
            elseif (config["password_hash"] == "osha256") then
                pass = sha256(salt .. pass)
            elseif (config["password_hash"] == "sha256") then
                pass = hash("sha256", salt .. pass)
            else
                pass = hash("sha512", salt .. pass)
            end

            local query = "INSERT INTO user (UUID,Nickname,Passwort,EMail,Geb_T,Geb_M,Geb_Y,werber,Salt,Serial,IP) VALUES (uuid(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            dbExec(MySql._connection, query, nickname, pass, email, gebt, gebm, geby, werber, salt, getPlayerSerial(source), getPlayerIP(source));

            MySql.helper.insert("user_data", { Nickname = nickname });
            MySql.helper.insert("user_grades", { Nickname = nickname });
            MySql.helper.insert("user_licenses", { Nickname = nickname });
            MySql.helper.insert("user_jobskills", { Nickname = nickname });
            MySql.helper.insert("user_inventory", { Nickname = nickname });
            MySql.helper.insert("user_achievements", { Nickname = nickname });
            MySql.helper.insert("user_tapps", { Nickname = nickname });
            MySql.helper.insert("faction_userrights", { Nickname = nickname });
            MySql.helper.insert("user_premium", { Name = nickname });

            dbExec(MySql._connection, "UPDATE user SET RegDat=LastUpdate WHERE Nickname = ?", nickname);

            showCursor(source, false)
            triggerClientEvent(source, "hideRegisterGui", source)
            showError(source, "Du wurdest erfolgreich registriert! Logge dich nun ein!")

            vioSetElementData(source, "logtries", 0)
            if (MySql.helper.existSync("user", { Nickname = getPlayerName(source) })) then
                triggerClientEvent(source, "showLoginGui", source, source)
            else
                triggerClientEvent(source, "showRegisterGui", source, source)
            end
            if (vioGetElementData(source, "deleteMultiAccErlaubnis")) then
                MySql.helper.delete("admin_whitelist_multiaccounts", { ID = vioGetElementData(source, "deleteMultiAccErlaubnis") });
            end
        else
            showError(source, "Ein ubekannter Fehler ist aufgetretten!")
        end
    else
        showError(source, "Ein Fehler ist aufgetretten. Der angegebene Werber existiert nicht!")
    end
end
addEvent("registerPlayer", true)
addEventHandler("registerPlayer", getRootElement(), RegisterPlayerData)

function resetIsLogged(source)
    if (isElement(source)) then
        vioSetElementData(source, "isLoggedInNow", false)
    end
end

function LoginPlayerData(nickname, pw)
    local passdb = MySql.helper.getValueSync("user", "Passwort", { Nickname = nickname });
    local saltdb = MySql.helper.getValueSync("user", "Salt", { Nickname = nickname });

    local pass;
    pw = saltdb .. pw
    if (config["password_hash"] == "md5") then
        pass = md5(pw)
    elseif (config["password_hash"] == "osha256") then
        pass = sha256(pw)
    elseif (config["password_hash"] == "sha256") then
        pass = hash("sha256", pw)
    else
        pass = hash("sha512", pw)
    end

    if (passdb == pass) and not (vioGetElementData(source, "isLoggedInNow")) then
        vioSetElementData(source, "isLoggedInNow", true)
        setTimer(resetIsLogged, 5000, 1, source)
        triggerClientEvent(source, "bindclicksys_event", source)

        if not (MySql.helper.existSync("user_data", { Nickname = getPlayerName(source) })) then
            MySql.helper.insertSync("user_data", { Nickname = nickname });
        end

        if not (MySql.helper.existSync("user_jobskills", { Nickname = getPlayerName(source) })) then
            MySql.helper.insertSync("user_jobskills", { Nickname = nickname });
        end

        if not (MySql.helper.existSync("user_inventory", { Nickname = getPlayerName(source) })) then
            MySql.helper.insertSync("user_inventory", { Nickname = nickname });
        end
        if not (MySql.helper.existSync("user_achievements", { Nickname = getPlayerName(source) })) then
            MySql.helper.insertSync("user_achievements", { Nickname = nickname });
        end
        if not (MySql.helper.existSync("user_premium", { Name = getPlayerName(source) })) then
            MySql.helper.insertSync("user_premium", { Name = nickname });
        end
        if not (MySql.helper.existSync("user_tapps", { Nickname = getPlayerName(source) })) then
            MySql.helper.insertSync("user_tapps", { Nickname = nickname });
        end
        if not (MySql.helper.existSync("faction_userrights", { Nickname = getPlayerName(source) })) then
            MySql.helper.insertSync("faction_userrights", { Nickname = nickname });
        end
        if not (MySql.helper.existSync("user_licenses", { Nickname = getPlayerName(source) })) then
            MySql.helper.insertSync("user_licenses", { Nickname = nickname });
        end
        if not (MySql.helper.existSync("user_grades", { Nickname = getPlayerName(source) })) then
            MySql.helper.insertSync("user_grades", { Nickname = nickname });
        end

        setPedStat(source, 69, 500) --test
        setPedStat(source, 70, 999)
        setPedStat(source, 71, 999)
        setPedStat(source, 72, 999)
        setPedStat(source, 73, 999)
        setPedStat(source, 74, 999)
        setPedStat(source, 75, 999)
        setPedStat(source, 76, 999)
        setPedStat(source, 77, 999)
        setPedStat(source, 78, 999)
        setPedStat(source, 79, 999)

        triggerClientEvent(source, "setAtomKatastropheClient", source, atomkatastrophe)

        if (isDevServer()) then
            triggerClientEvent(source, "recieveNewDevState", source)
        end

        local ip = getPlayerIP(source)
        local serial = getPlayerSerial(source)
        MySql.helper.update("user", { Serial = serial }, { Nickname = nickname });
        MySql.helper.update("user", { IP = ip }, { Nickname = nickname });

        dbExec(MySql._connection, "UPDATE user SET LastLogin=LastUpdate WHERE Nickname = ?", nickname);

        local tmp = MySql.helper.getSync("user", "*", { Nickname = nickname });
        local playersData = tmp[1];
        tmp = MySql.helper.getSync("user_data", "*", { Nickname = nickname });
        local userdataData = tmp[1];
        tmp = MySql.helper.getSync("user_licenses", "*", { Nickname = nickname });
        local lizensenData = tmp[1];
        tmp = MySql.helper.getSync("user_inventory", "*", { Nickname = nickname });
        local inventarData = tmp[1];
        tmp = MySql.helper.getSync("user_jobskills", "*", { Nickname = nickname });
        local jobskillsData = tmp[1];
        tmp = MySql.helper.getSync("user_achievements", "*", { Nickname = nickname });
        local archievmentsData = tmp[1];
        tmp = MySql.helper.getSync("user_grades", "*", { Nickname = nickname });
        local zeugnisData = tmp[1];
        tmp = MySql.helper.getSync("faction_userrights", "*", { Nickname = nickname });
        local rechteData = tmp[1];

        setPlayerName(source, playersData["Nickname"])

        --Rechte Data Loading
        vioSetElementData(source, "rechte_AllLeader", tonumber(rechteData["AllLeader"]))

        --playerData Loading--
        vioSetElementData(source, "Geb_T", tonumber(playersData["Geb_T"]))
        vioSetElementData(source, "Geb_M", tonumber(playersData["Geb_M"]))
        vioSetElementData(source, "Geb_Y", tonumber(playersData["Geb_Y"]))
        vioSetElementData(source, "DBID", tonumber(playersData["ID"]))
        vioSetElementData(source, "UniqueID", playersData["UUID"])
        vioSetElementData(source, "isDeveloper", tonumber(playersData["isDeveloper"]))

        --UserData Loading--
        vioSetElementData(source, "adminlvl", tonumber(userdataData["AdminLVL"]))
        vioSetElementData(source, "SupportLVL", tonumber(userdataData["SupportLVL"]))
        vioSetElementData(source, "spawnplace", tonumber(userdataData["Spawn"]))
        vioSetElementData(source, "skinid", tonumber(userdataData["Skin"]))
        vioSetElementData(source, "fraktion", tonumber(userdataData["Fraktion"]))
        vioSetElementData(source, "fraktionsrang", tonumber(userdataData["Fraktionsrang"]))
        vioSetElementData(source, "tode", tonumber(userdataData["Tode"]))
        vioSetElementData(source, "todezeit", tonumber(userdataData["TodZeit"]))
        vioSetElementData(source, "todelast", tonumber(userdataData["TodeLast"]))
        vioSetElementData(source, "playtime", tonumber(userdataData["PlayTime"]))
        vioSetElementData(source, "money", tonumber(userdataData["Geld"]))
        vioSetElementData(source, "bank", tonumber(userdataData["Bank"]))
        vioSetElementData(source, "addPayDayGehalt", tonumber(userdataData["paydaygehalt"]))
        vioSetElementData(source, "PremiumSpawn", tonumber(userdataData["PremiumSpawn"]))
        vioSetElementData(source, "schutzgeld", tonumber(userdataData["schutzgeld"]))
        vioSetElementData(source, "fuehrerscheinlooser", tonumber(userdataData["fuehrerscheinlooser"]))
        vioSetElementData(source, "job", tonumber(userdataData["Job"]))
        vioSetElementData(source, "knastzeit", tonumber(userdataData["Knastzeit"]))
        vioSetElementData(source, "lastknastzeit", tonumber(userdataData["lastKnastzeit"]))
        vioSetElementData(source, "alkaknast", tonumber(userdataData["alkaknast"]))
        vioSetElementData(source, "stvo", tonumber(userdataData["Stvo"]))
        vioSetElementData(source, "wanteds", tonumber(userdataData["Wanteds"]))
        vioSetElementData(source, "kaution", tonumber(userdataData["Kaution"]))
        vioSetElementData(source, "maxslots", tonumber(userdataData["VehSlots"]))
        vioSetElementData(source, "tbans", tonumber(userdataData["tbans"]))
        vioSetElementData(source, "ueberweisungssumme", tonumber(userdataData["ueberweisungssumme"]))
        vioSetElementData(source, "versicherung", tonumber(userdataData["versicherung"]))
        vioSetElementData(source, "lebensversicherung", tonumber(userdataData["lebensversicherung"]))
        vioSetElementData(source, "stvoFreePayDays", tonumber(userdataData["stvoFreePayDays"]))
        vioSetElementData(source, "FrakSkin", tonumber(userdataData["FrakSkin"]))
        vioSetElementData(source, "Hufeisen", tonumber(userdataData["Hufeisen"]))
        vioSetElementData(source, "speedtank", tonumber(userdataData["speedtank"]))
        vioSetElementData(source, "fisheslasthour", tonumber(userdataData["fisheslasthour"]))
        vioSetElementData(source, "hkey", tonumber(userdataData["newhkey"]))
        vioSetElementData(source, "kopfgeld", tonumber(userdataData["kopfgeld"]))
        vioSetElementData(source, "bizKey", tonumber(userdataData["bizKey"]))
        vioSetElementData(source, "prestigeKey", tonumber(userdataData["prestigeKey"]))
        vioSetElementData(source, "ingamespenden", tonumber(userdataData["ingamespenden"]))
        vioSetElementData(source, "tut", tonumber(userdataData["tutorial_gui"]))
        vioSetElementData(source, "mussAlka", tonumber(userdataData["mussAlka"]))

        vioSetElementData(source, "verheiratet", tonumber(userdataData["verheiratet"]))
        if (vioGetElementData(source, "verheiratet") ~= 0) then
            vioSetElementData(source, "verheiratetMitName", MySql.helper.getValueSync("user", "Nickname", { ID = vioGetElementData(source, "verheiratet") }))

            if (vioGetElementData(source, "verheiratetMitName") == false) then
                vioSetElementData(source, "verheiratet", 0)
                vioSetElementData(source, "verheiratetMitName", "niemand")
            end
        end

        local telenummer = tonumber(userdataData["Telefonnummer"])
        if (telenummer == 0) then
            local g = 0
            while (g == 0) do
                telenummer = math.random(100000, 999999)
                if not (MySql.helper.existSync("user_data", { Telefonnummer = telenummer })) then
                    g = telenummer
                end
            end
        end
        vioSetElementData(source, "telefon", telenummer)

        --inventar
        vioSetElementData(source, "drogen", tonumber(inventarData["Drogen"]))
        vioSetElementData(source, "tachodig_addon", tonumber(inventarData["tachodig_addon"]))
        vioSetElementData(source, "adgutscheine", tonumber(inventarData["adgutscheine"]))
        vioSetElementData(source, "adaktiv", tonumber(inventarData["adaktiv"]))
        vioSetElementData(source, "mats", tonumber(inventarData["Materials"]))
        vioSetElementData(source, "kanister", tonumber(inventarData["Benzinkanister"]))
        vioSetElementData(source, "lottoschein", tonumber(inventarData["Lottoschein"]))
        vioSetElementData(source, "rubbellos", tonumber(inventarData["Rubbellos"]))
        vioSetElementData(source, "lotto", inventarData["Lotto"])
        vioSetElementData(source, "snack", tonumber(inventarData["Snack"]))
        vioSetElementData(source, "hamburger", tonumber(inventarData["Hamburger"]))
        vioSetElementData(source, "terralapptapp", tonumber(inventarData["terralapptapp"]))
        vioSetElementData(source, "fertigessen", tonumber(inventarData["Fertigessen"]))
        vioSetElementData(source, "schnellhilfe", tonumber(inventarData["Schnellhilfe"]))
        vioSetElementData(source, "carfinder", tonumber(inventarData["CarFinder"]))
        vioSetElementData(source, "usecarfinder", tonumber(inventarData["UseCarFinder"]))
        vioSetElementData(source, "Hufeisenhelfer", tonumber(inventarData["Hufeisenhelfer"]))
        vioSetElementData(source, "geschenk", tonumber(inventarData["geschenk"]))
        vioSetElementData(source, "dice", tonumber(inventarData["dice"]))
        vioSetElementData(source, "Kondome", tonumber(inventarData["Kondome"]))
        vioSetElementData(source, "blutmesser", tonumber(inventarData["blutmesser"]))

        --Lizensen
        vioSetElementData(source, "autoLic", tonumber(lizensenData["autoLic"]))
        vioSetElementData(source, "truckLic", tonumber(lizensenData["truckLic"]))
        vioSetElementData(source, "planeLic", tonumber(lizensenData["planeLic"]))
        vioSetElementData(source, "bikeLic", tonumber(lizensenData["bikeLic"]))
        vioSetElementData(source, "boatLic", tonumber(lizensenData["boatLic"]))
        vioSetElementData(source, "heliLic", tonumber(lizensenData["heliLic"]))
        vioSetElementData(source, "lastautoLic", tonumber(lizensenData["lastautoLic"]))
        vioSetElementData(source, "lasttruckLic", tonumber(lizensenData["lasttruckLic"]))
        vioSetElementData(source, "lastplaneLic", tonumber(lizensenData["lastplaneLic"]))
        vioSetElementData(source, "lastbikeLic", tonumber(lizensenData["lastbikeLic"]))
        vioSetElementData(source, "lastheliLic", tonumber(lizensenData["lastheliLic"]))
        vioSetElementData(source, "quadLic", tonumber(lizensenData["quadLic"]))
        vioSetElementData(source, "sonstigeLic", tonumber(lizensenData["sonstigeLic"]))
        vioSetElementData(source, "angelLic", tonumber(lizensenData["angelLic"]))
        vioSetElementData(source, "waffenLic", tonumber(lizensenData["waffenLic"]))
        vioSetElementData(source, "persoLic", tonumber(lizensenData["persoLic"]))
        vioSetElementData(source, "reiseLic", tonumber(lizensenData["reiseLic"]))

        --Archievments
        vioSetElementData(source, "Erfolg_Fischermeister", tonumber(archievmentsData["Erfolg_Fischermeister"]))
        vioSetElementData(source, "Punkte_Fischermeister", tonumber(archievmentsData["Punkte_Fischermeister"]))
        vioSetElementData(source, "Erfolg_MrLicenses", tonumber(archievmentsData["Erfolg_MrLicenses"]))
        vioSetElementData(source, "Erfolg_First_50", tonumber(archievmentsData["Erfolg_First_50"]))
        vioSetElementData(source, "Erfolg_First_100", tonumber(archievmentsData["Erfolg_First_100"]))
        vioSetElementData(source, "Erfolg_First_1000", tonumber(archievmentsData["Erfolg_First_1000"]))
        vioSetElementData(source, "Erfolg_Millionaer", tonumber(archievmentsData["Erfolg_Millionaer"]))
        vioSetElementData(source, "Erfolg_10erFahrzeugrausch", tonumber(archievmentsData["Erfolg_10erFahrzeugrausch"]))
        vioSetElementData(source, "Erfolg_20erFahrzeugrausch", tonumber(archievmentsData["Erfolg_20erFahrzeugrausch"]))
        vioSetElementData(source, "Erfolg_50erFahrzeugrausch", tonumber(archievmentsData["Erfolg_50erFahrzeugrausch"]))
        vioSetElementData(source, "Erfolg_Busmeister", tonumber(archievmentsData["Erfolg_Busmeister"]))
        vioSetElementData(source, "Punkte_Busmeister", tonumber(archievmentsData["Punkte_Busmeister"]))
        vioSetElementData(source, "Erfolg_Lotto1", tonumber(archievmentsData["Erfolg_Lotto1"]))
        vioSetElementData(source, "Erfolg_Lotto2", tonumber(archievmentsData["Erfolg_Lotto2"]))
        vioSetElementData(source, "Erfolg_Lotto3", tonumber(archievmentsData["Erfolg_Lotto3"]))
        vioSetElementData(source, "Erfolg_Rubbellosgluck", tonumber(archievmentsData["Erfolg_Rubbellosgluck"]))
        vioSetElementData(source, "Erfolg_10erLos", tonumber(archievmentsData["Erfolg_10erLos"]))
        vioSetElementData(source, "Erfolg_Benzin_leer", tonumber(archievmentsData["Erfolg_Benzin_leer"]))
        vioSetElementData(source, "Erfolg_Mein_erstes_Geld", tonumber(archievmentsData["Erfolg_Mein_erstes_Geld"]))
        vioSetElementData(source, "Erfolg_MyOwnHome", tonumber(archievmentsData["Erfolg_MyOwnHome"]))
        vioSetElementData(source, "Erfolg_MyOwnBiz", tonumber(archievmentsData["Erfolg_MyOwnBiz"]))
        vioSetElementData(source, "Erfolg_Autoeinsteiger", tonumber(archievmentsData["Erfolg_Autoeinsteiger"]))
        vioSetElementData(source, "Erfolg_Mein_erstes_Brot", tonumber(archievmentsData["Erfolg_Mein_erstes_Brot"]))
        vioSetElementData(source, "Erfolg_Ersatztanke", tonumber(archievmentsData["Erfolg_Ersatztanke"]))
        vioSetElementData(source, "Erfolg_Fraktionseinsteiger", tonumber(archievmentsData["Erfolg_Fraktionseinsteiger"]))
        vioSetElementData(source, "Erfolg_10Hufeisen", tonumber(archievmentsData["Erfolg_10Hufeisen"]))
        vioSetElementData(source, "Erfolg_100Hufeisen", tonumber(archievmentsData["Erfolg_100Hufeisen"]))
        vioSetElementData(source, "Erfolg_1000Hufeisen", tonumber(archievmentsData["Erfolg_1000Hufeisen"]))
        vioSetElementData(source, "Punkte_Meisterpilot", tonumber(archievmentsData["Punkte_Meisterpilot"]))
        vioSetElementData(source, "Erfolg_Meisterpilot", tonumber(archievmentsData["Erfolg_Meisterpilot"]))
        vioSetElementData(source, "Punkte_Meistertrucker", tonumber(archievmentsData["Punkte_Meistertrucker"]))
        vioSetElementData(source, "Erfolg_Meistertrucker", tonumber(archievmentsData["Erfolg_Meistertrucker"]))
        vioSetElementData(source, "Erfolg_KMPokal", tonumber(archievmentsData["Erfolg_KMPokal"]))
        vioSetElementData(source, "Erfolg_TerraFriend", tonumber(archievmentsData["Erfolg_TerraFriend"]))
        vioSetElementData(source, "Erfolg_Strassenreiniger", tonumber(archievmentsData["Erfolg_Strassenreiniger"]))
        vioSetElementData(source, "Punkte_Strassenreiniger", tonumber(archievmentsData["Punkte_Strassenreiniger"]))
        vioSetElementData(source, "Erfolg_Meeresreiniger", tonumber(archievmentsData["Erfolg_Meeresreiniger"]))
        vioSetElementData(source, "Punkte_Meeresreiniger", tonumber(archievmentsData["Punkte_Meeresreiniger"]))
        vioSetElementData(source, "Erfolg_Muellsammler", tonumber(archievmentsData["Erfolg_Muellsammler"]))
        vioSetElementData(source, "Punkte_Muellsammler", tonumber(archievmentsData["Punkte_Muellsammler"]))
        vioSetElementData(source, "Erfolg_Pizzaraser", tonumber(archievmentsData["Erfolg_Pizzaraser"]))
        vioSetElementData(source, "Punkte_Pizzaraser", tonumber(archievmentsData["Punkte_Pizzaraser"]))
        vioSetElementData(source, "Erfolg_Farmerjunge", tonumber(archievmentsData["Erfolg_Farmerjunge"]))
        vioSetElementData(source, "Punkte_Farmerjunge", tonumber(archievmentsData["Punkte_Farmerjunge"]))
        vioSetElementData(source, "Erfolg_Steinraeumer", tonumber(archievmentsData["Erfolg_Steinraeumer"]))
        vioSetElementData(source, "Punkte_Steinraeumer", tonumber(archievmentsData["Punkte_Steinraeumer"]))
        vioSetElementData(source, "Erfolg_Langlaeufer", tonumber(archievmentsData["Erfolg_Langlaeufer"]))
        vioSetElementData(source, "Punkte_Langlaeufer", tonumber(archievmentsData["Punkte_Langlaeufer"]))
        vioSetElementData(source, "Erfolg_Rekordschwimmer", tonumber(archievmentsData["Erfolg_Rekordschwimmer"]))
        vioSetElementData(source, "Punkte_Rekordschwimmer", tonumber(archievmentsData["Punkte_Rekordschwimmer"]))

        --JobSkills
        vioSetElementData(source, "fischSkill", tonumber(jobskillsData["fischSkill"]))
        vioSetElementData(source, "fischSkillPoints", tonumber(jobskillsData["fischSkillPoints"]))
        vioSetElementData(source, "busSkill", tonumber(jobskillsData["busSkill"]))
        vioSetElementData(source, "busSkillPoints", tonumber(jobskillsData["busSkillPoints"]))
        vioSetElementData(source, "muellSkill", tonumber(jobskillsData["muellSkill"]))
        vioSetElementData(source, "muellSkillPoints", tonumber(jobskillsData["muellSkillPoints"]))
        vioSetElementData(source, "pizzaSkill", tonumber(jobskillsData["pizzaSkill"]))
        vioSetElementData(source, "pizzaSkillPoints", tonumber(jobskillsData["pizzaSkillPoints"]))
        vioSetElementData(source, "truckSkill", tonumber(jobskillsData["truckSkill"]))
        vioSetElementData(source, "truckSkillPoints", tonumber(jobskillsData["truckSkillPoints"]))
        vioSetElementData(source, "sweeperSkill", tonumber(jobskillsData["sweeperSkill"]))
        vioSetElementData(source, "sweeperSkillPoints", tonumber(jobskillsData["sweeperSkillPoints"]))
        vioSetElementData(source, "flyersSkill", tonumber(jobskillsData["flyersSkill"]))
        vioSetElementData(source, "flyersSkillPoints", tonumber(jobskillsData["flyersSkillPoints"]))
        vioSetElementData(source, "farmerSkill", tonumber(jobskillsData["farmerSkill"]))
        vioSetElementData(source, "farmerSkillPoints", tonumber(jobskillsData["farmerSkillPoints"]))
        vioSetElementData(source, "bergWerkSkill", tonumber(jobskillsData["bergWerksSkill"]))
        vioSetElementData(source, "bergWerkSkillPoints", tonumber(jobskillsData["bergWerkSkillPoints"]))
        vioSetElementData(source, "meeresSkill", tonumber(jobskillsData["meeresSkill"]))
        vioSetElementData(source, "meeresSkillPoints", tonumber(jobskillsData["meeresSkillPoints"]))

        --Zeugnis
        vioSetElementData(source, "NAME_orientierung", tonumber(zeugnisData["NAME_orientierung"]))
        vioSetElementData(source, "NAME_theorie_Beamte", tonumber(zeugnisData["NAME_theorie_Beamte"]))
        vioSetElementData(source, "NAME_Gelaendefahr", tonumber(zeugnisData["NAME_Gelaendefahr"]))
        vioSetElementData(source, "NAME_sozial", tonumber(zeugnisData["NAME_sozial"]))
        vioSetElementData(source, "NAME_Waffenumgang", tonumber(zeugnisData["NAME_Waffenumgang"]))
        vioSetElementData(source, "NAME_spezFahrtest", tonumber(zeugnisData["NAME_spezFahrtest"]))
        vioSetElementData(source, "NAME_Strategisch", tonumber(zeugnisData["NAME_Strategisch"]))
        vioSetElementData(source, "NAME_praktisch_Beamte", tonumber(zeugnisData["NAME_praktisch_Beamte"]))
        vioSetElementData(source, "NAME_refresh", tonumber(zeugnisData["refresh"]))

        vioSetElementData(source, "last_fishes", 0)

        local warns = MySql.helper.getCountSync("admin_user_warns", { Nickname = nickname })

        vioSetElementData(source, "warns", warns)
        vioSetElementData(source, "telefontoggle", 0)
        vioSetElementData(source, "Tazer", 0)
        vioSetElementData(source, "cuffed", 0)
        vioSetElementData(source, "antiflut", 0)

        if (vioGetElementData(source, "knastzeit") == 0) then
            vioSetElementData(source, "alkaknast", 0)
        end

        vioSetElementData(source, "cuffed", 0)
        vioSetElementData(source, "schutzzahlung", false)
        if (vioGetElementData(source, "playtime") < (25 * 60)) then
            setPlayerNametagText(source, "[ROOKIE]-" .. getPlayerName(source))
        else
            setPlayerNametagText(source, getPlayerName(source))
        end

        vioSetElementData(source, "fishpoints", 0)
        if (vioGetElementData(source, "fraktion") > 0) then
            setPlayerTeam(source, team[vioGetElementData(source, "fraktion")])
        end
        setPlayerWantedLevel(source, vioGetElementData(source, "wanteds"))

        triggerClientEvent(source, "hideLoginGui", source)

        if (vioGetElementData(source, "tut") == 0) then
            triggerClientEvent(source, "showTutGui_first", source, source)
            vioSetElementData(source, "tut", 1)
        end

        local maxslot = vioGetElementData(source, "maxslots")
        local zah = 0

        for k = 1, vioGetElementData(source, "maxslots"), 1 do
            vioSetElementData(source, "slot" .. k, -1)
        end

        for theKey, thevehicleentry in ipairs(privVeh) do
            if (string.lower(thevehicleentry[1]) == string.lower(getPlayerName(source))) then
                local slot = thevehicleentry[2]
                vioSetElementData(source, "slot" .. slot, thevehicleentry[3])
            end
        end

        setPlayerMoney(source, vioGetElementData(source, "money"))

        local time = getRealTime()
        local premiumOutTime = MySql.helper.getValueSync("user_premium", "PremiumUntil", { Name = nickname }) - time.timestamp;

        vioSetElementData(source, "premium", 0)
        if (premiumOutTime > 0) then
            local days = math.round(((premiumOutTime / 60) / 60) / 24)
            vioSetElementData(source, "premium", premiumOutTime)
            outputChatBox(string.format("Du hast noch %s Tage Premium!", days), source, 0, 255, 0)
            if (days < 7) then
                outputChatBox("ACHTUNG! Dein Premiumstatus läuft bald aus! Verlängere jetzt dein Premium!", source, 0, 255, 0)
            end
        else
            outputChatBox("Du hast kein Premium? Kauf dir doch welches! Infos unter /premium!", source, 0, 255, 0)
        end

        local onlineSchutzUntil = MySql.helper.getValueSync("user_tapps", "OnlineSchutzUntil", { Nickname = nickname }) - time.timestamp;
        vioSetElementData(source, "onlineschutzuntil", 0)
        if (onlineSchutzUntil > 0) then
            local days = math.round(((onlineSchutzUntil / 60) / 60) / 24)
            vioSetElementData(source, "onlineschutzuntil", onlineSchutzUntil + time.timestamp)
            outputChatBox(string.format("Du hast noch %s Tage OnlineSchutz!", days), source, 0, 255, 0)
            if (days < 7) then
                outputChatBox("ACHTUNG! Dein OnlineSchutz läuft bald aus! Verlängere jetzt deinen OnlineSchutz!", source, 0, 255, 0)
            end
        end

        outputServerLog(nickname .. " logged in!")
        loadGutschriften(source)

        local timer = getRealTime()

        vioSetElementData(source, "loggedin", timer.timestamp)
        vioSetElementData(source, "afk_timer", 0)
        vioSetElementData(source, "afk_status", 0)

        if (vioGetElementData(source, "fraktion") > 1 and vioGetElementData(source, "fraktion") ~= 5) then
            setPlayerSpawn(source, vioGetElementData(source, "spawnplace"), vioGetElementData(source, "FrakSkin"), vioGetElementData(source, "fraktion"), 113)
        else
            setPlayerSpawn(source, vioGetElementData(source, "spawnplace"), vioGetElementData(source, "skinid"), vioGetElementData(source, "fraktion"), 113)
        end

        loadTapps(source)

        fadeCamera(source, true, 5.0)
        setCameraTarget(source, source)

        triggerClientEvent(source, "empfangeRuhezonenData", source, ruhezonen)
        sendalkacolshape_func(source)
    else
        local logversuche = tonumber(vioGetElementData(source, "logtries"))
        logversuche = logversuche + 1
        vioSetElementData(source, "logtries", logversuche)
        local rest = 5 - logversuche

        showError(source, string.format("Sie haben ein falsches Passwort eingegeben! Sie haben noch %s Versuche!", rest))

        if (rest == 0) then
            kickPlayer(source, "Zuviele LogIn Versuche mit falschen Passwort!")
        end
    end
end
addEvent("loginPlayer", true)
addEventHandler("loginPlayer", getRootElement(), LoginPlayerData)

function loadTapps(thePlayer)
    local appTable = {}
    appTable["Tapp-Marketplace"] = 1
    appTable["Friendlist"] = MySql.helper.getValueSync("user_tapps", "Friendlist", { Nickname = getPlayerName(thePlayer) })
    appTable["GPS"] = MySql.helper.getValueSync("user_tapps", "GPS", { Nickname = getPlayerName(thePlayer) })
    appTable["Stopuhr"] = MySql.helper.getValueSync("user_tapps", "Stopuhr", { Nickname = getPlayerName(thePlayer) })
    appTable["Blitzermelder"] = MySql.helper.getValueSync("user_tapps", "Blitzermelder", { Nickname = getPlayerName(thePlayer) })
    appTable["Kompass"] = MySql.helper.getValueSync("user_tapps", "Kompass", { Nickname = getPlayerName(thePlayer) })
    appTable["EMail"] = MySql.helper.getValueSync("user_tapps", "EMail", { Nickname = getPlayerName(thePlayer) })
    appTable["Notizblock"] = MySql.helper.getValueSync("user_tapps", "Notizblock", { Nickname = getPlayerName(thePlayer) })
    appTable["Colorpicker"] = MySql.helper.getValueSync("user_tapps", "Colorpicker", { Nickname = getPlayerName(thePlayer) })
    appTable["TicTacToe"] = MySql.helper.getValueSync("user_tapps", "TicTacToe", { Nickname = getPlayerName(thePlayer) })
    appTable["MineSweeper"] = MySql.helper.getValueSync("user_tapps", "MineSweeper", { Nickname = getPlayerName(thePlayer) })
    appTable["OnlineBanking"] = MySql.helper.getValueSync("user_tapps", "OnlineBanking", { Nickname = getPlayerName(thePlayer) })
    appTable["OnlineSchutz"] = MySql.helper.getValueSync("user_tapps", "OnlineSchutz", { Nickname = getPlayerName(thePlayer) })
    vioSetElementData(thePlayer, "tappapps", appTable)

    local mails = MySql.helper.getCountSync("user_emails", { neu = 1, Empfaenger = getPlayerName(thePlayer) })
    if (mails) then
        if (tonumber(mails)) then
            if (tonumber(mails) > 0) then
                if (appTable["EMail"] == 1) then
                    outputChatBox(string.format("Sie haben %s neue Emails!", mails), thePlayer, 255, 0, 0)
                else
                    outputChatBox("Sie haben neue Emails. Kaufen Sie sich die Email-Tapp des Terralapptapps um sie zu lesen!", thePlayer, 255, 0, 0)
                end
            end
        end
    end
end

function dontcmd()
    if (not (isPlayerLoggedIn(source))) then
        cancelEvent()
    end
end
addEventHandler("onPlayerCommand", getRootElement(), dontcmd)

function loadGutschriften(thePlayer)
    local result = MySql.helper.getSync("user_gifts", "*", { Nickname = getPlayerName(thePlayer) });

    for theKey, dasatz in ipairs(result) do
        outputChatBox(dasatz["Grund"], thePlayer, 0, 255, 0)
        outputChatBox("Du erhälst dafür:", thePlayer, 0, 255, 0)

        if (tonumber(dasatz["Geld"]) > 0) or (tonumber(dasatz["Geld"]) < 0) then
            outputChatBox(string.format("- Geld: %s", toprice(dasatz["Geld"])), thePlayer, 0, 255, 0)
            changePlayerBank(thePlayer, tonumber(dasatz["Geld"]), "sonstiges", "Gutschrift", dasatz["Grund"])
        end

        if (tonumber(dasatz["VehSlots"]) > 0) then
            outputChatBox(string.format("- Fahrzeugslots: %s", dasatz["VehSlots"]), thePlayer, 0, 255, 0)
            vioSetElementData(thePlayer, "maxslots", vioGetElementData(thePlayer, "maxslots") + tonumber(dasatz["VehSlots"]))
            local k = 0
            for k = 0, tonumber(dasatz["VehSlots"]) - 1, 1 do
                vioSetElementData(thePlayer, "slot" .. vioGetElementData(thePlayer, "maxslots") - k, -1)
            end
        end

        MySql.helper.delete("user_gifts", { ID = dasatz["ID"] });
    end

    local result = MySql.helper.getSync("user_offline_messages", "*", { Nickname = getPlayerName(thePlayer) });

    for theKey, dasatz in ipairs(result) do
        outputChatBox(string.format("Offline-Message von %s: %s (Zeit: %s)", dasatz["VonName"], dasatz["Message"], dasatz["Time"]), thePlayer)
        MySql.helper.delete("user_offline_messages", { ID = dasatz["ID"] });
    end

    MySql.helper.update("user", { AktiveDays = 0 }, { Nickname = getPlayerName(thePlayer) });
    MySql.helper.update("user_data", { AktiveDays = 0 }, { Nickname = getPlayerName(thePlayer) });
end

function save_offline_message(playername, vonname, text)
    if (not playername or not vonname or not text or type(playername) ~= "string" or type(vonname) ~= "string" or type(text) ~= "string") then
        outputDebugString("ErrorHelp save_offline_message: " .. debug.traceback())
    end
    MySql.helper.insert("user_offline_messages", {
        Nickname = playername,
        VonName = vonname,
        Message = text
    });
end
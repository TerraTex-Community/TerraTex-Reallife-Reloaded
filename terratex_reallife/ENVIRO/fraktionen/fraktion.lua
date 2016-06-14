team = {}
frakkasse = {}
blacklist = {}
frakmun = {}
frakcars = {}
frakdrogen = {}
frakschutz = {}
fraksteuer = {}
frakselfcars = {}

fraktionbezeichner = {}
fraktionsrange = {}

function teamserstellen()

    local result = MySql.helper.getSync("faction_names", "*");
    for theKey, dasatz in ipairs(result) do
        fraktionbezeichner[tonumber(dasatz["ID"])] = dasatz["Name"];
    end

    result = MySql.helper.getSync("faction_ranks", "*");
    for theKey, dasatz in ipairs(result) do
        if (not fraktionsrange[tonumber(dasatz["FrakID"])]) then
            fraktionsrange[tonumber(dasatz["FrakID"])] = {}
        end
        fraktionsrange[tonumber(dasatz["FrakID"])][tonumber(dasatz["RangID"])] = dasatz["Name"]
    end

    blacklist[0] = false
    frakkasse[0] = false
    blacklist[0] = false
    frakmun[0] = false
    frakdrogen[0] = false
    frakschutz[0] = false

    --Create first all Teams for Scoreboard
    team[1] = createTeam(fraktionbezeichner[1], 0, 250, 250) --SAPD
    team[9] = createTeam(fraktionbezeichner[9], 0, 250, 250) --LVPD
    team[5] = createTeam(fraktionbezeichner[5], 200, 140, 140) --SEK
    team[7] = createTeam(fraktionbezeichner[7], 200, 140, 140) --NAME

    team[10] = createTeam(fraktionbezeichner[10], 250, 0, 0) --Medics
    team[3] = createTeam(fraktionbezeichner[3], 200, 100, 0) --NEWS
    team[4] = createTeam(fraktionbezeichner[4], 255, 255, 0) --Taxi

    team[2] = createTeam(fraktionbezeichner[2], 200, 140, 140) -- Grove Street
    team[12] = createTeam(fraktionbezeichner[12], 200, 140, 140) --Violettas
    team[13] = createTeam(fraktionbezeichner[13], 200, 140, 140) --Racers
    team[6] = createTeam(fraktionbezeichner[6], 200, 140, 140) --LLS
    team[11] = createTeam(fraktionbezeichner[11], 200, 140, 140) --CashForce
    team[8] = createTeam(fraktionbezeichner[8], 255, 255, 255) -- Black Aliens


    --Set Settings of the Fraktion
    --SAPD
    vioSetElementData(team[1], "hidden", false)
    frakkasse[1] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 1 });
    blacklist[1] = false;
    frakmun[1] = false;
    frakdrogen[1] = false;
    frakschutz[1] = false;
    fraksteuer[1] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 1 });

    -- Grove Street
    vioSetElementData(team[2], "hidden", false)
    blacklist[2] = {};
    frakkasse[2] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 2 });
    frakmun[2] = MySql.helper.getValueSync("faction_inventory", "Munition", { FrakID = 2 });
    frakdrogen[2] = MySql.helper.getValueSync("faction_inventory", "Drogen", { FrakID = 2 });
    frakschutz[2] = {};
    fraksteuer[2] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 2 });

    --NEWS
    vioSetElementData(team[3], "hidden", false)
    blacklist[3] = false;
    frakkasse[3] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 3 });
    frakmun[3] = false;
    frakdrogen[3] = false;
    frakschutz[3] = false;
    fraksteuer[3] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 3 });

    --TAXI
    vioSetElementData(team[4], "hidden", false)
    blacklist[4] = false;
    frakkasse[4] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 4 });
    frakmun[4] = false;
    frakdrogen[4] = false;
    frakschutz[4] = false;
    fraksteuer[4] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 4 });

    -- SEK
    vioSetElementData(team[5], "hidden", false)
    blacklist[5] = false;
    frakkasse[5] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 5 });
    frakmun[5] = false;
    frakdrogen[5] = false;
    frakschutz[5] = false;
    fraksteuer[5] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 5 });

    -- LLS
    vioSetElementData(team[6], "hidden", false)
    blacklist[6] = {};
    frakkasse[6] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 6 });
    frakmun[6] = MySql.helper.getValueSync("faction_inventory", "Munition", { FrakID = 6 });
    frakdrogen[6] = MySql.helper.getValueSync("faction_inventory", "Drogen", { FrakID = 6 });
    frakschutz[6] = {};
    fraksteuer[6] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 6 });

    -- NAME
    vioSetElementData(team[7], "hidden", false)
    blacklist[7] = false;
    frakkasse[7] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 7 });
    frakmun[7] = false;
    frakdrogen[7] = false;
    frakschutz[7] = false;
    fraksteuer[7] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 7 });

    -- Black Aliens
    vioSetElementData(team[8], "hidden", true)
    blacklist[8] = false;
    frakkasse[8] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 8 });
    frakmun[8] = false;
    frakdrogen[8] = false;
    frakschutz[8] = false;
    fraksteuer[8] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 8 });

    --LVPD
    vioSetElementData(team[9], "hidden", true)
    blacklist[9] = false;
    frakkasse[9] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 9 });
    frakmun[9] = false;
    frakdrogen[9] = false;
    frakschutz[9] = false;
    fraksteuer[9] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 9 });

    -- Medics
    vioSetElementData(team[10], "hidden", false)
    blacklist[10] = false;
    frakkasse[10] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 10 });
    frakmun[10] = false;
    frakdrogen[10] = false;
    frakschutz[10] = false;
    fraksteuer[10] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 10 });

    -- CashForce
    vioSetElementData(team[11], "hidden", false)
    blacklist[11] = {};
    frakkasse[11] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 11 });
    frakmun[11] = MySql.helper.getValueSync("faction_inventory", "Munition", { FrakID = 11 });
    frakdrogen[11] = MySql.helper.getValueSync("faction_inventory", "Drogen", { FrakID = 11 });
    frakschutz[11] = {};
    fraksteuer[11] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 11 });

    -- Violettas
    vioSetElementData(team[12], "hidden", false)
    blacklist[12] = {};
    frakkasse[12] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 12 });
    frakmun[12] = MySql.helper.getValueSync("faction_inventory", "Munition", { FrakID = 12 });
    frakdrogen[12] = MySql.helper.getValueSync("faction_inventory", "Drogen", { FrakID = 12 });
    frakschutz[12] = {};
    fraksteuer[12] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 12 });

    --Racers
    vioSetElementData(team[13], "hidden", false)
    blacklist[13] = {};
    frakkasse[13] = MySql.helper.getValueSync("faction_inventory", "Kasse", { FrakID = 13 });
    frakmun[13] = MySql.helper.getValueSync("faction_inventory", "Munition", { FrakID = 13 });
    frakdrogen[13] = MySql.helper.getValueSync("faction_inventory", "Drogen", { FrakID = 13 });
    frakschutz[13] = {};
    fraksteuer[13] = MySql.helper.getValueSync("faction_inventory", "Steuersatz", { FrakID = 13 });
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), teamserstellen)

addEvent("sendMeFrakData", true)
function sendMeFrakData_func()
    triggerClientEvent(source, "receiveFrakData", source, fraktionbezeichner, fraktionsrange)
end
addEventHandler("sendMeFrakData", getRootElement(), sendMeFrakData_func)

function fsteuer_func(thePlayer, command, steuersatz)
    if (vioGetElementData(thePlayer, "fraktionsrang") > 5) then
        if (steuersatz) then
            if (tonumber(steuersatz)) then
                steuersatz = tonumber(steuersatz)
                steuersatz = math.floor(steuersatz)
                if (steuersatz > 0 and steuersatz < 41) then
                    local fraktion = vioGetElementData(thePlayer, "fraktion")
                    fraksteuer[fraktion] = steuersatz
                    outputChatBox(string.format("Der Steuersatz der Fraktion wurde auf %s Prozent festgesetzt!", steuersatz), thePlayer, 255, 0, 0)
                else
                    outputChatBox("Der Steuersatz muss zwischen 1 und 40 Prozent liegen", thePlayer, 255, 0, 0)
                end
            else
                outputChatBox("Der Steuersatz muss zwischen 1 und 40 Prozent liegen", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("Der Steuersatz muss zwischen 1 und 40 Prozent liegen", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("fsteuer", fsteuer_func, false, false)

function save_frakkasse(counter)

    for theFraktion, theMoney in pairs(frakkasse) do
        MySql.helper.update("faction_inventory", { Kasse = theMoney }, { FrakID = theFraktion });
    end
    for theFraktion, theMoney in pairs(frakmun) do
        MySql.helper.update("faction_inventory", { Munition = theMoney }, { FrakID = theFraktion });
    end
    for theFraktion, theMoney in pairs(frakdrogen) do
        MySql.helper.update("faction_inventory", { Drogen = theMoney }, { FrakID = theFraktion });
    end
    for theFraktion, theMoney in pairs(fraksteuer) do
        MySql.helper.update("faction_inventory", { Steuersatz = theMoney }, { FrakID = theFraktion });
    end

    setTimer(save_frakkasse, 3600000, 1)
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), save_frakkasse)

function save_frakkasseB()
    for theFraktion, theMoney in pairs(frakkasse) do
        MySql.helper.update("faction_inventory", { Kasse = theMoney }, { FrakID = theFraktion });
    end
    for theFraktion, theMoney in pairs(frakmun) do
        MySql.helper.update("faction_inventory", { Munition = theMoney }, { FrakID = theFraktion });
    end
    for theFraktion, theMoney in pairs(frakdrogen) do
        MySql.helper.update("faction_inventory", { Drogen = theMoney }, { FrakID = theFraktion });
    end
    for theFraktion, theMoney in pairs(fraksteuer) do
        MySql.helper.update("faction_inventory", { Steuersatz = theMoney }, { FrakID = theFraktion });
    end
end
addEventHandler("onResourceStop", getResourceRootElement(getThisResource()), save_frakkasseB)

function frakkasse_func(thePlayer, Command, money, grund, ...)
    local frak = vioGetElementData(thePlayer, "fraktion")
    if (frakkasse[frak]) then
        if (money) then
            if (tonumber(money)) then
                if (grund) then
                    local message = grund .. " " .. table.concat({ ... }, " ")
                    local mon = tonumber(money)
                    if (mon > 0) then
                        if (getPlayerMoney(thePlayer) < mon) then
                            showError(thePlayer, "Sie haben nicht genug Geld auf der Hand!")
                        else
                            frakkasse[frak] = frakkasse[frak] + mon
                            changePlayerMoney(thePlayer, -mon, "fraktion", "Frakkasse", "Einzahlung:" .. message)
                            frakdepot_log(frak, 1, mon, getPlayerName(thePlayer), message)
                        end
                    else
                        if (vioGetElementData(thePlayer, "fraktionsrang") > 3) then
                            mon = -mon
                            if (frakkasse[frak] < mon) then
                                showError(thePlayer, "Soviel Geld ist nicht in der fraktionskasse!")
                            else
                                frakkasse[frak] = frakkasse[frak] - mon
                                frakdepot_log(frak, 1, -mon, getPlayerName(thePlayer), message)
                                changePlayerMoney(thePlayer, mon, "fraktion", "Frakkasse", "Auszahlung:" .. message)
                            end
                        else
                            showError(thePlayer, "Du benoetigst mindestens Rang 4 um Geld zu entnehmen!")
                        end
                    end
                else
                    showError(thePlayer, "Kein Grund angegeben.")
                end
            end
        end
        outputChatBox(string.format("In der Fraktionkasse befinden sich: %s", toprice(frakkasse[frak])), thePlayer, 255, 255, 0)
    end
end
addCommandHandler("frakkasse", frakkasse_func, false, false)

function heal_func(thePlayer)
    local px, py, pz = getElementPosition(thePlayer)
    if (vioGetElementData(thePlayer, "fraktion")) then
        if (frakmun[vioGetElementData(thePlayer, "fraktion")]) then
            local cx = munkisten[vioGetElementData(thePlayer, "fraktion")][1]
            local cy = munkisten[vioGetElementData(thePlayer, "fraktion")][2]
            local cz = munkisten[vioGetElementData(thePlayer, "fraktion")][3]
            if (getDistanceBetweenPoints3D(cx, cy, cz, px, py, pz) < 5) then
                local hp = (100 - getElementHealth(thePlayer)) * 10
                local armor = (100 - getPedArmor(thePlayer)) * 100
                local gesamt = (hp + armor + 100)
                frakdepot_log(vioGetElementData(thePlayer, "fraktion"), 3, -gesamt, "/heal-" .. getPlayerName(thePlayer))
                if (frakmun[vioGetElementData(thePlayer, "fraktion")] > gesamt) then
                    frakmun[vioGetElementData(thePlayer, "fraktion")] = frakmun[vioGetElementData(thePlayer, "fraktion")] - gesamt
                    triggerClientEvent(thePlayer, "addFood", thePlayer, 300)
                    setPedArmor(thePlayer, 150)
                    outputChatBox(string.format("Dein Leben, dein Essensbalken und deine Rüstung wurden für %s Materialien aus dem Fraktionsdepot aufgefüllt!", gesamt), thePlayer, 255, 0, 0)
                else
                    outputChatBox("Im Fraktionsdepot befinden sich nicht genug Materialien!", thePlayer, 255, 0, 0)
                end
            end
        end
    end
end
addCommandHandler("heal", heal_func, false, false)

function frakdrogen_func(thePlayer, Command, money)
    local px, py, pz = getElementPosition(thePlayer)
    local cx = munkisten[vioGetElementData(thePlayer, "fraktion")][1]
    local cy = munkisten[vioGetElementData(thePlayer, "fraktion")][2]
    local cz = munkisten[vioGetElementData(thePlayer, "fraktion")][3]
    if (cx) then
        local dis = getDistanceBetweenPoints3D(px, py, pz, cx, cy, cz)
        if (dis < 5) then
            local frak = vioGetElementData(thePlayer, "fraktion")
            if (frakdrogen[frak]) then
                if (money) then
                    if (tonumber(money)) then
                        local mon = tonumber(money)
                        if (mon > 0) then
                            if (vioGetElementData(thePlayer, "drogen") < mon) then
                                showError(thePlayer, "Sie haben nicht genug Drogen auf der Hand!")
                            else
                                frakdrogen[frak] = frakdrogen[frak] + mon
                                vioSetElementData(thePlayer, "drogen", vioGetElementData(thePlayer, "drogen") - mon)
                                frakdepot_log(frak, 2, mon, getPlayerName(thePlayer))
                            end
                        else
                            if (vioGetElementData(thePlayer, "fraktionsrang") > 3) then
                                mon = -mon
                                if (frakdrogen[frak] < mon) then
                                    showError(thePlayer, "Soviel Drogen sind nicht in dem Fraktionsdrogendepot!")
                                else
                                    frakdrogen[frak] = frakdrogen[frak] - mon
                                    frakdepot_log(frak, 2, -mon, getPlayerName(thePlayer))
                                    vioSetElementData(thePlayer, "drogen", vioGetElementData(thePlayer, "drogen") + mon)
                                end
                            else
                                showError(thePlayer, "Du benoetigst mindestens Rang 4 um Drogen zu entnehmen!")
                            end
                        end
                    end
                end
                outputChatBox(string.format("In dem Fraktionsdrogendepot befinden sich %sg Drogen", frakdrogen[frak]), thePlayer, 255, 255, 0)
            end
        else
            showError(thePlayer, "Du bist nicht in der Nähe des Fraktionsdepots")
        end
    end
end
addCommandHandler("frakdrug", frakdrogen_func, false, false)

function frakmats_func(thePlayer, Command, money)
    local px, py, pz = getElementPosition(thePlayer)
    local cx = munkisten[vioGetElementData(thePlayer, "fraktion")][1]
    local cy = munkisten[vioGetElementData(thePlayer, "fraktion")][2]
    local cz = munkisten[vioGetElementData(thePlayer, "fraktion")][3]
    if (cx) then
        local dis = getDistanceBetweenPoints3D(px, py, pz, cx, cy, cz)
        if (dis < 5) then
            local frak = vioGetElementData(thePlayer, "fraktion")
            if (frakmun[frak]) then
                if (money) then
                    if (tonumber(money)) then
                        local mon = tonumber(money)
                        if (mon > 0) then
                            if (vioGetElementData(thePlayer, "mats") < mon) then
                                showError(thePlayer, "Sie haben nicht genug Materialien auf der Hand!")
                            else
                                frakmun[frak] = frakmun[frak] + mon
                                vioSetElementData(thePlayer, "mats", vioGetElementData(thePlayer, "mats") - mon)
                                frakdepot_log(frak, 3, mon, getPlayerName(thePlayer))
                            end
                        else
                            if (vioGetElementData(thePlayer, "fraktionsrang") > 3) then
                                mon = -mon
                                if (frakmun[frak] < mon) then
                                    showError(thePlayer, "Soviel Materialien sind nicht in dem FraktionsMaterialdepot!")
                                else
                                    frakmun[frak] = frakmun[frak] - mon
                                    frakdepot_log(frak, 3, -mon, getPlayerName(thePlayer))
                                    vioSetElementData(thePlayer, "mats", vioGetElementData(thePlayer, "mats") + mon)
                                end
                            else
                                showError(thePlayer, "Du benoetigst mindestens Rang 4 um Materialien zu entnehmen!")
                            end
                        end
                    end
                end
                outputChatBox(string.format("In dem Fraktionsdrogendepot befinden sich %s Materialien", frakmun[frak]), thePlayer, 255, 255, 0)
            end
        else
            outputChatBox("Du bist nicht in der nähe des Fraktionsdepos", thePlayer, 255, 255, 0)
        end
    end
end
addCommandHandler("frakmats", frakmats_func, false, false)

function loadfromBlacklistDB()
    for n = 1, table.getn(team), 1 do
        if (blacklist[n] ~= false) then
            local result = MySql.helper.getSync("faction_blacklist", "*", {Fraktion = n});
            for theKey, dasatz in ipairs(result) do
                table.insert(blacklist[n], { dasatz["Name"], dasatz["ID"], dasatz["Von"], dasatz["Grund"] });
            end
        end
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadfromBlacklistDB)

function checkbyblacklist_func(thePlayer, cmd, types, frakid)
    if (vioGetElementData(thePlayer, "fraktionsrang") > 4 or isAdminLevel(thePlayer, 1)) then
        if (not (frakid) or vioGetElementData(thePlayer, "adminlvl") == 0) then
            local frakid = vioGetElementData(thePlayer, "fraktion")
            local result = MySql.helper.getSync("faction_blacklist", "*", {Fraktion = frakid});
            outputChatBox("Blacklist: ", thePlayer, 255, 255, 0)
            for theKey, data in ipairs(result) do
                local playerName = data["Name"]
                local vonName = data["Von"]
                local Grund = data["Grund"]

                if (types == "online") then
                    if (getPlayerFromName(playerName)) then
                        outputChatBox(string.format("%s von %s wegen %s", playerName, vonName, Grund), thePlayer, 255, 255, 0)
                    end
                elseif (types == "offline") then
                    if (not getPlayerFromName(playerName)) then
                        outputChatBox(string.format("%s von %s wegen %s", playerName, vonName, Grund), thePlayer, 255, 255, 0)
                    end
                else
                    outputChatBox(string.format("%s von %s wegen %s", playerName, vonName, Grund), thePlayer, 255, 255, 0)
                end
            end
        elseif (frakid and isAdminLevel(thePlayer, 1)) then
            frakid = tonumber(frakid)
            local result = MySql.helper.getSync("faction_blacklist", "*", {Fraktion = frakid});

            outputChatBox(string.format("Blacklist der Fraktion %s: ", fraktionbezeichner[frakid]), thePlayer, 255, 255, 0)

            for theKey, data in ipairs(result) do
                local playerName = data["Name"]
                local vonName = data["Von"]
                local Grund = data["Grund"]
                if (types == "online") then
                    if (getPlayerFromName(playerName)) then
                        outputChatBox(string.format("%s von %s wegen %s", playerName, vonName, Grund), thePlayer, 255, 255, 0)
                    end
                elseif (types == "offline") then
                    if (not getPlayerFromName(playerName)) then
                        outputChatBox(string.format("%s von %s wegen %s", playerName, vonName, Grund), thePlayer, 255, 255, 0)
                    end
                else
                    outputChatBox(string.format("%s von %s wegen %s", playerName, vonName, Grund), thePlayer, 255, 255, 0)
                end
            end
        else
            showError(thePlayer, "Params: /checkblacklist [all|online|offline] [adminonly: frakid]")
        end
    else
        showError(thePlayer, "keine Berechtigung!")
    end
end
addCommandHandler("checkblacklist", checkbyblacklist_func, false, false)

function setblacklist_func(thePlayer, command, toPlayerName, grund, ...)
    if (vioGetElementData(thePlayer, "fraktionsrang") > 2) then
        if (blacklist[vioGetElementData(thePlayer, "fraktion")] ~= false) then
            if (toPlayerName) then
                if (grund) then
                    local reason = grund .. table.concat({ ... }, " ")
                    local toPlayer = getPlayerFromIncompleteName(toPlayerName)
                    if (toPlayer) then
                        local toPlayerName = getPlayerName(toPlayer)
                        local isonit = false
                        for theKey, thePerson in ipairs(blacklist[vioGetElementData(thePlayer, "fraktion")]) do
                            if (thePerson[1] == toPlayerName) then
                                isonit = true
                                break
                            end
                        end
                        if (isonit) then
                            showError(thePlayer, "Dieser Spieler ist bereits auf der Blacklist!")
                        else
                            if (vioGetElementData(toPlayer, "playtime") < 1500) then
                                showError(thePlayer, "Dieser Spieler ist noch im Neulingsstatus (ROOKIE) und kann daher auf keine Blacklist gesetzt werden!")
                            else
                                local id = MySql.helper.insertSync("faction_blacklist", {
                                    Name = toPlayerName,
                                    Fraktion = vioGetElementData(thePlayer, "fraktion"),
                                    Von = getPlayerName(thePlayer),
                                    Grund = reason
                                });

                                table.insert(blacklist[vioGetElementData(thePlayer, "fraktion")], { toPlayerName, id })
                                showError(thePlayer, "Dieser Spieler ist jetzt auf der Blacklist!")
                            end
                        end

                    else
                        showError(thePlayer, "Dieser Spieler ist nicht Online!")
                    end
                else
                    outputChatBox("Du hast keinen Grund angegeben!", thePlayer)
                end
            end
        end
    end
end
addCommandHandler("setblacklist", setblacklist_func, false, false)

function unsetblacklist_func(thePlayer, command, toPlayerName)
    if (vioGetElementData(thePlayer, "fraktionsrang") > 2) then
        if (blacklist[vioGetElementData(thePlayer, "fraktion")] ~= false) then
            if (toPlayerName) then
                local toPlayer = getPlayerFromIncompleteName(toPlayerName)
                if (toPlayer) then
                    local toPlayerName = getPlayerName(toPlayer)
                    local isonit = false
                    local isonitkey = 0
                    for theKey, thePerson in ipairs(blacklist[vioGetElementData(thePlayer, "fraktion")]) do
                        if (thePerson[1] == toPlayerName) then
                            isonit = true
                            isonitkey = theKey
                            break
                        end
                    end
                    if not (isonit) then
                        showError(thePlayer, "Dieser Spieler ist nicht auf der Blacklist!")
                    else
                        MySql.helper.delete("faction_blacklist", {
                            Name = toPlayerName,
                            Fraktion = vioGetElementData(thePlayer, "fraktion")
                        });
                        table.remove(blacklist[vioGetElementData(thePlayer, "fraktion")], isonitkey)
                        showError(thePlayer, "Dieser Spieler ist jetzt nicht mehr auf der Blacklist!")
                    end

                else
                    showError(thePlayer, "Dieser Spieler ist nicht Online!")
                end
            end
        end
    end
end
addCommandHandler("unsetblacklist", unsetblacklist_func, false, false)

function blacklist_func(thePlayer)
    if (blacklist[vioGetElementData(thePlayer, "fraktion")] ~= false) then
        outputChatBox("blacklist:", thePlayer, 255, 255, 0)
        if (blacklist[vioGetElementData(thePlayer, "fraktion")]) then
            local wastring = ""
            local count = 0
            for theKey, player in ipairs(blacklist[vioGetElementData(thePlayer, "fraktion")]) do
                if (getPlayerFromName(player[1])) then
                    wastring = wastring .. " " .. player[1] .. ";"
                    count = count + 1
                    if (count == 4) then
                        count = 0
                        outputChatBox(wastring, thePlayer, 255, 255, 0)
                        wastring = ""
                    end
                end
            end
            if (count > 0) then
                outputChatBox(wastring, thePlayer, 255, 255, 0)
            end
        end
    end
end
addCommandHandler("blacklist", blacklist_func, false, false)

function showSchutz_func(thePlayer, cmd, state)

    if (frakschutz[vioGetElementData(thePlayer, "fraktion")]) then
        if (state == "all") then
            if (frakschutz[vioGetElementData(thePlayer, "fraktion")]) then
                outputChatBox("Folgende Personen haben heute Schutzgeld gezahlt:", thePlayer, 255, 0, 0)
                for thePlayers, theKey in pairs(frakschutz[vioGetElementData(thePlayer, "fraktion")]) do
                    outputChatBox(thePlayers .. " " .. isPlayerSchutzOnline(thePlayers), thePlayer, 255, 0, 0)
                end
            end
        elseif (state == "online") then
            if (frakschutz[vioGetElementData(thePlayer, "fraktion")]) then
                outputChatBox("Folgende Personen haben heute Schutzgeld gezahlt:", thePlayer, 255, 0, 0)
                for thePlayers, theKey in pairs(frakschutz[vioGetElementData(thePlayer, "fraktion")]) do
                    if (isPlayerSchutzOnline(thePlayers) == "(Online)") then
                        outputChatBox(thePlayers .. " " .. isPlayerSchutzOnline(thePlayers), thePlayer, 255, 0, 0)
                    end
                end
            end
        elseif (state == "offline") then
            if (frakschutz[vioGetElementData(thePlayer, "fraktion")]) then
                outputChatBox("Folgende Personen haben heute Schutzgeld gezahlt:", thePlayer, 255, 0, 0)
                for thePlayers, theKey in pairs(frakschutz[vioGetElementData(thePlayer, "fraktion")]) do
                    if (isPlayerSchutzOnline(thePlayers) == "(Offline)") then
                        outputChatBox(thePlayers .. " " .. isPlayerSchutzOnline(thePlayers), thePlayer, 255, 0, 0)
                    end
                end
            end
        else
            outputChatBox("Nutzung: /showschutz [all,offline,online]", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("showschutz", showSchutz_func, false, false)

function isPlayerSchutzOnline(player)
    if (getPlayerFromName(player)) then
        return "(Online)"
    else
        return "(Offline)"
    end
end

function schutzgeld_func(thePlayer, command, toplayername, betrag)
    if (frakschutz[vioGetElementData(thePlayer, "fraktion")]) then
        if (toplayername) and (betrag) then
            local toPlayer = getPlayerFromIncompleteName(toplayername)
            local toBetrag = tonumber(betrag)
            if (toPlayer) then
                if (toBetrag) then
                    if (toBetrag > 0) then
                        if not (frakschutz[vioGetElementData(thePlayer, "fraktion")][getPlayerName(toPlayer)]) then
                            local px, py, pz = getElementPosition(thePlayer)
                            local tx, ty, tz = getElementPosition(toPlayer)
                            local dis = getDistanceBetweenPoints3D(px, py, pz, tx, ty, tz)
                            if (dis < 10) then
                                if (getPlayerMoney(toPlayer) < toBetrag) then
                                    outputChatBox("Dieser Spieler hat nicht so viel Geld!", thePlayer, 255, 0, 0)
                                else
                                    outputChatBox(getPlayerName(thePlayer) .. " bietet dir Schutz für " .. toprice(betrag) .. " an!", toPlayer, 255, 0, 0)
                                    outputChatBox("Nimm an mit /accept schutz", toPlayer, 255, 0, 0)
                                    vioSetElementData(toPlayer, "schutzzahlung", toBetrag)
                                    vioSetElementData(toPlayer, "schutzfrak", vioGetElementData(thePlayer, "fraktion"))
                                    outputChatBox("Du hast " .. getPlayerName(toPlayer) .. " Schutz für " .. toprice(betrag) .. " angeboten!", thePlayer, 255, 0, 0)
                                end
                            else
                                outputChatBox("Dieser Spieler ist nicht in deiner Nähe!", thePlayer, 255, 0, 0)
                            end
                        else
                            outputChatBox("Dieser Spieler hat bereits Schutzgeld bezahlt!", thePlayer, 255, 0, 0)
                        end
                    else
                        outputChatBox("Der Betrag muss positiv sein!", thePlayer, 255, 0, 0)
                    end
                else
                    outputChatBox("Nutzung: /schutzgeld [Spielername] [Betrag]", thePlayer, 255, 0, 0)
                end
            else
                outputChatBox("Dieser Spieler existiert nicht!", thePlayer, 255, 0, 0)
            end
        else
            outputChatBox("Nutzung: /schutzgeld [Spielername] [Betrag]", thePlayer, 255, 0, 0)
        end
    else
        outputChatBox("Du gehörst zu keiner Mafia/Gang", thePlayer, 255, 0, 0)
    end
end
addCommandHandler("schutzgeld", schutzgeld_func, false, false)

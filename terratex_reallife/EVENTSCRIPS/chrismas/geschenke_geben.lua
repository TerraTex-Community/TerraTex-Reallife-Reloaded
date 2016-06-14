--KARTAUSLÖSESTELLE!!!!
addEvent("wantAKart_Event", true)
function wantAKart_Event_func()
    if (vioGetElementData(source, "geschenk") > 0) then
        local freeslots = 0
        local firstfreeslot = 0
        for zah = vioGetElementData(source, "maxslots"), 1, -1 do
            if tonumber(vioGetElementData(source, "slot" .. zah)) == -1 then
                freeslots = freeslots + 1
                firstfreeslot = zah
            end
        end
        if (freeslots == 0) then
            showError(source, "Du hast keinen freien Slot mehr!")
        else

            local winTable = { 409, 434, 457, 504, 542, 554, 572, 578, 583, 604, 605, 568 }
            local randid = winTable[math.random(table.getn(winTable))]

            vioSetElementData(source, "geschenk", vioGetElementData(source, "geschenk") - 1)
            local spawnVeh = createVehicle(randid, 1500.59765625, -1594.275390625, 13.109892845154, 0, 0, 268.30810546875)
            vioSetElementData(source, "slot" .. firstfreeslot, spawnVeh)
            vioSetElementData(spawnVeh, "besitzer", getPlayerName(source))
            vioSetElementData(spawnVeh, "slotid", firstfreeslot)
            vioSetElementData(spawnVeh, "spawnx", 0)
            vioSetElementData(spawnVeh, "spawny", 0)
            vioSetElementData(spawnVeh, "spawnz", 0)
            vioSetElementData(spawnVeh, "spawnrx", 0)
            vioSetElementData(spawnVeh, "spawnry", 0)
            vioSetElementData(spawnVeh, "spawnrz", 0)
            vioSetElementData(spawnVeh, "motor", false)
            vioSetElementData(spawnVeh, "colors", "0|0|0|0")
            vioSetElementData(spawnVeh, "locked", true)
            vioSetElementData(spawnVeh, "tuning", "0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0")
            vioSetElementData(spawnVeh, "paintjob", 3)
            vioSetElementData(spawnVeh, "model", randid)
            vioSetElementData(spawnVeh, "tank", 100)
            vioSetElementData(spawnVeh, "kmstand", 0)
            vioSetElementData(spawnVeh, "falter", 0)
            vioSetElementData(spawnVeh, "abgeschleppt", 0)
            vioSetElementData(spawnVeh, "kaufpreis", 1000)
            vioSetElementData(spawnVeh, "Lichterfarbe", "255|255|255")
            vioSetElementData(spawnVeh, "premColor", "-1")
            fixVehicle(spawnVeh)
            setTimer(fixVehicle, 1000, 1, spawnVeh)
            setTimer(fixVehicle, 2000, 1, spawnVeh)
            setTimer(fixVehicle, 3000, 1, spawnVeh)
            table.insert(privVeh, { getPlayerName(source), firstfreeslot, spawnVeh })
            privCars[spawnVeh] = true

            MySql.helper.insert("user_vehicles", {
                SlotID = firstfreeslot,
                Besitzer = getPlayerName(source),
                Model = randid,
                SpawnX = 0,
                SpawnY = 0,
                SpawnZ = 0,
                SpawnRX = 0,
                SpawnRY = 0,
                SpawnRZ = 0,
                Colors = "0|0|0|0",
                kaufpreis = 1000
            });

            local dbid = MySql.helper.getValueSync("user_vehicles", "ID", { SlotID = firstfreeslot, Besitzer = getPlayerName(source) });
            outputDebugString("Buyed Car dbid:" .. tostring(dbid))
            vioSetElementData(spawnVeh, "dbid", dbid)

            warpPedIntoVehicle(source, spawnVeh)
            outputChatBox("Denke daran das Kart sinnvoll zu parken!", source, 166, 0, 166)
        end
    end
end
addEventHandler("wantAKart_Event", getRootElement(), wantAKart_Event_func)

local adventDay = { [1] = true, [8] = true, [15] = true, [22] = true, [24] = true, [25] = true, [26] = true }
function adventPresent()
    setTimer(adventPresent, 60000, 1)
    local time = getRealTime()
    if (time.hour == 19 and time.minute == 30) then
        if (time.monthday < 27 and time.month == 11) then
            if (adventDay[time.monthday]) then
                for theKey, thePlayers in ipairs(getElementsByType("player")) do
                    if (isPlayerLoggedIn(thePlayers)) then
                        give_AdventsPresent(thePlayers, math.random(table.getn(adventPresets_big)))
                    end
                end
            else
                for theKey, thePlayers in ipairs(getElementsByType("player")) do
                    if (isPlayerLoggedIn(thePlayers)) then
                        give_nonAdventsPresent(thePlayers, math.random(table.getn(adventPresents_small)))
                    end
                end
            end
        end
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), adventPresent)

function give_AdventsPresent(player, presentID)
    local text = adventPresets_big[presentID][2]
    if (text == "adgutschein") then
        vioSetElementData(player, "adgutscheine", vioGetElementData(player, "adgutscheine") + 3)
        outputChatBox("Zum Advent hast du 3 AD-Gutscheine als Weihnachtsgeschenk geschenkt bekommen!", player, 166, 0, 166)
    elseif (text == "geld") then
        outputChatBox("Zum Advent hast du 10000$ als Weihnachtsgeschenk geschenkt bekommen!", player, 166, 0, 166)
        changePlayerMoney(player, 10000, "sonstiges", "Geschenk vom Server")
    elseif (text == "fahrzeuggutschein") then
        outputChatBox("Zum Advent hast du ein Fahrzeuggutschein als Weihnachtsgeschenk geschenkt bekommen!", player, 166, 0, 166)
        outputChatBox("Diesen kannst du unter dem Weihnachtsbaum beim Icon einlösen!", player, 166, 0, 166)
        vioSetElementData(player, "geschenk", vioGetElementData(player, "geschenk") + 1)
    elseif (text == "Premium") then
        outputChatBox("Zum Advent hast du 30 Tage Premium geschenkt bekommen", player, 166, 0, 166)
        local thirty = 2592000
        local time = getRealTime()
        local premiumOutTime = MySql.helper.getValueSync("user_premium", "PremiumUntil", { Name = getPlayerName(player) }) - time.timestamp;
        if (premiumOutTime > 0) then
            thirty = thirty + premiumOutTime
        end
        MySql.helper.update("user_premium", { PremiumUntil = (time.timestamp + thirty) }, { Name = getPlayerName(player) });
        vioSetElementData(player, "premium", (time.timestamp + thirty))
        outputChatBox(string.format("Du hast nun noch %s Tage Premium!", math.round((((thirty / 60) / 60) / 24))), player, 166, 0, 166)
    end
end

function give_nonAdventsPresent(player, presentID)
    local text = adventPresents_small[presentID][2]
    if ("hamburger" == text) then
        vioSetElementData(player, "hamburger", vioGetElementData(player, "hamburger") + 10)
        outputChatBox("Der Adventskalender bescherte dir 10 Hamburger!", player, 166, 0, 166)
    elseif ("lotto" == text) then
        vioSetElementData(player, "lottoschein", vioGetElementData(player, "lottoschein") + 10)
        outputChatBox("Der Adventskalender bescherte dir 10 Lottoscheine!", player, 166, 0, 166)
    elseif ("carfinder" == text) then
        vioSetElementData(player, "carfinder", vioGetElementData(player, "carfinder") + 5)
        outputChatBox("Der Adventskalender bescherte dir 5 Carfinder!", player, 166, 0, 166)
    elseif ("schnellhilfe" == text) then
        vioSetElementData(player, "schnellhilfe", vioGetElementData(player, "schnellhilfe") + 2)
        outputChatBox("Der Adventskalender bescherte dir 2 Schnellhilfen!", player, 166, 0, 166)
    elseif ("geld" == text) then
        changePlayerMoney(player, 1000, "sonstiges", "Geschenk vom Server")
        outputChatBox("Der Adventskalender bescherte dir 1000$ Geld!", player, 166, 0, 166)
    elseif ("benzin" == text) then
        vioSetElementData(player, "kanister", vioGetElementData(player, "kanister") + 10)
        outputChatBox("Der Adventskalender bescherte dir 10 Kanister!", player, 166, 0, 166)
    elseif ("fertigessen" == text) then
        vioSetElementData(player, "fertigessen", vioGetElementData(player, "fertigessen") + 10)
        outputChatBox("Der Adventskalender bescherte dir 10 Fertigessen!", player, 166, 0, 166)
    elseif ("snack" == text) then
        vioSetElementData(player, "snack", vioGetElementData(player, "snack") + 30)
        outputChatBox("Der Adventskalender bescherte dir 30 Snacks!", player, 166, 0, 166)
    elseif ("Kondome" == text) then
        vioSetElementData(player, "Kondome", vioGetElementData(player, "Kondome") + 10)
        outputChatBox("Der Adventskalender bescherte dir 10 Kondome!", player, 166, 0, 166)
    end
end

adventPresets_big = {
    { 3, "adgutschein" },
    { 10000, "geld" },
    { 5000, "geld" },
    { 1, "fahrzeuggutschein" },
    { 1, "fahrzeuggutschein" },
    { 30, "Premium" },
    { 15, "Premium" }
}

adventPresents_small = {
    { 10, "hamburger" },
    { 10, "lotto" },
    { 5, "carfinder" },
    { 2, "schnellhilfe" },
    { 1000, "geld" },
    { 10, "benzin" },
    { 10, "fertigessen" },
    { 30, "snack" },
    { 10, "Kondome" }
}

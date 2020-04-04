--[[Ostereier auslesen]]
local eiID = 1241
local maxEier = 45 --pro Spawn
local eier = {}
local respawntime = 60 --in Minuten
local lastTimer = false
local minEier = 15

function ostern_init()
    local timer = getRealTime()
    --vom 18.04.2014 - 21.04.2014
    if (isEaster()) then

        local query = "SELECT * FROM objects_events_pickups WHERE State='0' AND event='ostern' ORDER BY RAND() LIMIT 0," .. maxEier
        local runQuery = dbQuery(MySql._connection, query);
        local result = dbPoll(runQuery, -1);
        for theKey, dsatz in ipairs(result) do

            local ei = createPickup(dsatz["X"], dsatz["Y"], dsatz["Z"], 3, eiID)
            setElementDimension(ei, tonumber(dsatz["Dim"]))
            setElementInterior(ei, tonumber(dsatz["Inte"]))

            vioSetElementData(ei, "isEi", true)
            vioSetElementData(ei, "eiID", tonumber(dsatz["ID"]))
            addEventHandler("onPickupHit", ei, eiHit)
            table.insert(eier, ei)
        end

        lastTimer = setTimer(respawnEier, respawntime * 60 * 1000, 1)
    else
        MySql.helper.update("objects_events_pickups", { State = 0, gefundenVon = nil }, { event = "ostern" });
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), ostern_init)

function respawnEier()
    for theKey, theEi in ipairs(eier) do
        if (isElement(theEi)) then
            destroyElement(theEi)
        end
    end
    eier = {}
    local query = "SELECT * FROM objects_events_pickups WHERE State='0' AND event='ostern' ORDER BY RAND() LIMIT 0," .. maxEier

    local runQuery = dbQuery(MySql._connection, query);
    local result = dbPoll(runQuery, -1);
    for theKey, dsatz in ipairs(result) do

        local ei = createPickup(dsatz["X"], dsatz["Y"], dsatz["Z"], 3, eiID)
        setElementDimension(ei, tonumber(dsatz["Dim"]))
        setElementInterior(ei, tonumber(dsatz["Inte"]))

        vioSetElementData(ei, "isEi", true)
        vioSetElementData(ei, "eiID", tonumber(dsatz["ID"]))
        addEventHandler("onPickupHit", ei, eiHit)
        table.insert(eier, ei)
    end

    lastTimer = setTimer(respawnEier, respawntime * 60 * 1000, 1)
end

function eiHit(thePlayer)
    if (vioGetElementData(source, "isEi")) then
        local id = vioGetElementData(source, "eiID")
        destroyElement(source)
        local pName = getPlayerName(thePlayer)

        MySql.helper.update("objects_events_pickups", { State = 1 }, { ID = id });
        MySql.helper.update("objects_events_pickups", { gefundenVon = pName }, { ID = id });

        local anzGefunden = MySql.helper.getValueSync("objects_events_pickups", "count(*)", { gefundenVon = pName, event = "ostern" });

        outputChatBox("Osterhase: Glückwunsch, du hast jetzt schon " .. anzGefunden .. " Ostereier gefunden", thePlayer, math.random(1, 255), math.random(1, 255), math.random(1, 255))
        giveEasterPresent(thePlayer)

        local thereAreEier = 0
        for theKey, theEi in ipairs(eier) do
            if (isElement(theEi)) then
                thereAreEier = thereAreEier + 1
            end
        end
        if (thereAreEier < minEier) then
            killTimer(lastTimer)
            respawnEier()
        end
    end
end

function giveEasterPresent(player)
    local config = easterPresents[math.random(1, table.getSize(easterPresents))];
    local amount = math.random(1, config.maxAmount);
    if ("hamburger" == config.item) then
        vioSetElementData(player, "hamburger", vioGetElementData(player, "hamburger") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Hamburger gefunden!", player, 166, 0, 166)
    elseif ("lotto" == config.item) then
        vioSetElementData(player, "lottoschein", vioGetElementData(player, "lottoschein") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Lottoscheine gefunden!", player, 166, 0, 166)
    elseif ("carfinder" == config.item) then
        vioSetElementData(player, "carfinder", vioGetElementData(player, "carfinder") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Carfinder gefunden!", player, 166, 0, 166)
    elseif ("schnellhilfe" == config.item) then
        vioSetElementData(player, "schnellhilfe", vioGetElementData(player, "schnellhilfe") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Schnellhilfen gefunden!", player, 166, 0, 166)
    elseif ("geld" == config.item) then
        changePlayerMoney(player, amount, "sonstiges", "Geschenk vom Server")
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " $ gefunden!", player, 166, 0, 166)
    elseif ("benzin" == config.item) then
        vioSetElementData(player, "kanister", vioGetElementData(player, "kanister") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Benzinkanister gefunden!", player, 166, 0, 166)
    elseif ("fertigessen" == config.item) then
        vioSetElementData(player, "fertigessen", vioGetElementData(player, "fertigessen") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Fertigessen gefunden!", player, 166, 0, 166)
    elseif ("snack" == config.item) then
        vioSetElementData(player, "snack", vioGetElementData(player, "snack") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Snacks gefunden!", player, 166, 0, 166)
    elseif ("kondome" == config.item) then
        vioSetElementData(player, "Kondome", vioGetElementData(player, "Kondome") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Kondome gefunden!", player, 166, 0, 166)
    elseif ("gold" == config.item) then
        vioSetElementData(player, "Gold", vioGetElementData(player, "Gold") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Gold gefunden!", player, 166, 0, 166)
    elseif ("hufeisenhelfer" == config.item) then
        vioSetElementData(player, "Hufeisenhelfer", vioGetElementData(player, "Hufeisenhelfer") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Hufeisenhelfer gefunden!", player, 166, 0, 166)
    elseif ("blutstreifentest" == config.item) then
        vioSetElementData(player, "blutmesser", vioGetElementData(player, "blutmesser") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Blutstreifentests gefunden!", player, 166, 0, 166)
    elseif ("carslot" == config.item) then
        vioSetElementData(player, "maxslots", vioGetElementData(player, "maxslots") + amount)
        outputChatBox("Du hast im Inneren des Eis " .. amount .. " Carslots gefunden!", player, 166, 0, 166)
    elseif ("coronaskillbooster" == config.item) then
        extendGoldItem(player, "Corona.SkillBooster", amount)
        outputChatBox("Du hast im Inneren des Eis einen Special Skill Booster für " .. amount .. " Tage gefunden!", player, 166, 0, 166)
    elseif ("coronamoneybooster" == config.item) then
        extendGoldItem(player, "Corona.MoneyBooster", amount)
        outputChatBox("Du hast im Inneren des Eis einen Special Money Booster für " .. amount .. " Tage gefunden!", player, 166, 0, 166)
    end
end

easterPresents = {
    { ["maxAmount"] = 3, ["item"] = "adgutschein" },
    { ["maxAmount"] = 5, ["item"] = "adgutschein" },
    { ["maxAmount"] = 10, ["item"] = "hamburger" },
    { ["maxAmount"] = 15, ["item"] = "hamburger" },
    { ["maxAmount"] = 20, ["item"] = "hamburger" },
    { ["maxAmount"] = 10, ["item"] = "lotto" },
    { ["maxAmount"] = 5, ["item"] = "lotto" },
    { ["maxAmount"] = 2, ["item"] = "lotto" },
    { ["maxAmount"] = 3, ["item"] = "carfinder" },
    { ["maxAmount"] = 5, ["item"] = "carfinder" },
    { ["maxAmount"] = 7, ["item"] = "carfinder" },
    { ["maxAmount"] = 2, ["item"] = "schnellhilfe" },
    { ["maxAmount"] = 10, ["item"] = "schnellhilfe" },
    { ["maxAmount"] = 20, ["item"] = "schnellhilfe" },
    { ["maxAmount"] = 5000, ["item"] = "geld" },
    { ["maxAmount"] = 30000, ["item"] = "geld" },
    { ["maxAmount"] = 100000, ["item"] = "geld" },
    { ["maxAmount"] = 1, ["item"] = "gold" },
    { ["maxAmount"] = 10, ["item"] = "gold" },
    { ["maxAmount"] = 25, ["item"] = "gold" },
    { ["maxAmount"] = 5, ["item"] = "benzin" },
    { ["maxAmount"] = 10, ["item"] = "benzin" },
    { ["maxAmount"] = 15, ["item"] = "benzin" },
    { ["maxAmount"] = 50, ["item"] = "fertigessen" },
    { ["maxAmount"] = 25, ["item"] = "fertigessen" },
    { ["maxAmount"] = 10, ["item"] = "fertigessen" },
    { ["maxAmount"] = 10, ["item"] = "snack" },
    { ["maxAmount"] = 30, ["item"] = "snack" },
    { ["maxAmount"] = 50, ["item"] = "snack" },
    { ["maxAmount"] = 10, ["item"] = "kondome" },
    { ["maxAmount"] = 30, ["item"] = "kondome" },
    { ["maxAmount"] = 50, ["item"] = "kondome" },
    { ["maxAmount"] = 7, ["item"] = "hufeisenhelfer" },
    { ["maxAmount"] = 5, ["item"] = "hufeisenhelfer" },
    { ["maxAmount"] = 2, ["item"] = "hufeisenhelfer" },
    { ["maxAmount"] = 10, ["item"] = "blutstreifentest" },
    { ["maxAmount"] = 15, ["item"] = "blutstreifentest" },
    { ["maxAmount"] = 20, ["item"] = "blutstreifentest" },
    { ["maxAmount"] = 1, ["item"] = "carslot" },
    { ["maxAmount"] = 1, ["item"] = "coronaskillbooster" },
    { ["maxAmount"] = 7, ["item"] = "coronaskillbooster" },
    { ["maxAmount"] = 1, ["item"] = "coronamoneybooster" },
    { ["maxAmount"] = 7, ["item"] = "coronamoneybooster" }
}

function addEi_func(thePlayer, cmd, comment, ...)
    if (isAdminLevel(thePlayer, 4)) then
        local commentar = ''
        if (comment) then
            commentar = comment .. " " .. table.concat({ ... }, " ")
        end

        local int = getElementInterior(thePlayer)
        local dim = getElementDimension(thePlayer)
        local x, y, z = getElementPosition(thePlayer)

        local insertQuery = "INSERT INTO objects_events_pickups (x,y,z,inte,dim,comment) VALUES ('%s','%s','%s','%s','%s','%s')"

        MySql.helper.insert("objects_events_pickups", {
            x = x,
            y = y,
            z = z,
            inte = int,
            dim = dim,
            comment = commentar,
            event = "ostern"
        });

        local ei = createPickup(x, y, z, 3, eiID, 200)
        setElementDimension(ei, dim)
        setElementInterior(ei, int)

    end
end
addCommandHandler("addei", addEi_func, false, false)

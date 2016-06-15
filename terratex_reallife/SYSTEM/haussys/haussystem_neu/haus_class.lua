--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 24.04.2014
-- Time: 16:53
-- To change this template use File | Settings | File Templates.
--
--[[
-- Attributsliste:
--      Coord = {x , y , z}
--      irid
--      preis, miete, kasse, city, qm, stockwerke, wert, ID, besitzer, locked,
-- }]]

Haus = {}
Haus.__index = Haus

function Haus:constructor(ID, hx, hy, hz, irid, preis, miete, kasse, city, qm, stockwerke, wert)
    self.coords = { tonumber(hx), tonumber(hy), tonumber(hz) }
    self.irid = tonumber(irid)
    self.preis = tonumber(preis)
    self.miete = tonumber(miete)
    self.kasse = tonumber(kasse)
    self.city = tonumber(city)
    self.qm = tonumber(qm)
    self.stockwerke = tonumber(stockwerke)
    self.wert = tonumber(wert)
    self.ID = tonumber(ID)

    if (self.miete > 0 and self.irid == 0) then
        self.miete = 0
    end

    --Besitzer auslesen
    self.besitzer = MySql.helper.getValueSync("user_data", "Nickname", { newhkey = ID });

    --Erstellung des Pickups
    self.pickup = createPickup(hx, hy, hz, 3, 1273, 5000)
    addEventHandler("onPickupHit", self.pickup, bind(self.pickupHit, self))

    --Löschung nicht Handelbarer Häuser
    if not (self.besitzer) then
        if (self.city == 3) then
            self.besitzer = 'Nicht verkäuflich'
            save_log("hauscanbedeleted", tostring(self.ID))
        end
        self.locked = false
    else
        --setzen des "Ist Verkauft" Icons
        setPickupType(self.pickup, 3, 1272)
        self.locked = true
    end

    --Informationen am Pickup (Hausschild)
    local showText = "Hausnummer: %s\nBesitzer: %s\n%s\n"
    local bT = self.besitzer
    local hT = "Miete: %s"
    if (self.miete > 0) then
        hT = string.format(hT, self.miete)
    else
        hT = string.format(hT, "Keine möglich")
    end
    if not bT then
        bT = "Keiner"
        hT = "Hauswert: " .. toprice(self.preis)
    end

    showText = string.format(showText, self.ID, bT, hT)

    setElementShowText(self.pickup, { 0, 0, 255, 255 }, showText, true, 15, 1.3, 0.2)
end

function Haus:save()
    MySql.helper.update("objects_houses", {
        Miete = self.miete,
        Kasse = self.kasse,
        IRID = self.irid
    }, {ID = self.ID});
    outputDebugString("Save House " .. self.ID)
end

function Haus:getCoords()
    return self.coords[1], self.coords[2], self.coords[3]
end

function Haus:getStockwerke()
    return self.stockwerke
end


function Haus:getWert()
    return self.wert
end

function Haus:getQM()
    return self.qm
end

function Haus:getCity()
    return self.city
end

function Haus:destructor()
    destroyElement(self.pickup)
    MySql.helper.delete("objects_houses", {ID = self.ID});
    self = nil
end

function Haus:pickupHit(thePlayer)
    local Text = ""
    local desc = "Diese Bruchbude"
    if (self.wert == 1) then
        desc = "Dieses Mittelständige Haus"
    elseif (self.wert == 2) then
        desc = "Diese Villa"
    end
    local irQM = 0
    if (self.irid ~= 0) then
        irQM = iraeume[self.irid]:getQM()
    end
    local miete = "keine"
    if (self.miete > 0) then
        miete = toprice(self.miete)
    end

    local tausstatt = "heruntergekommenden"
    if (self.irid ~= 0) then
        if (iraeume[self.irid]:getWert() == 1) then
            tausstatt = "guten"
        elseif (iraeume[self.irid]:getWert() == 2) then
            tausstatt = "luxuriösen"
        end
    end



    if (self.besitzer) then
        if (getPlayerName(thePlayer) == self.besitzer) then
            Text = "Hausnummer: %s\nAktueller Hauswert: %s\nHauskasse: %s\nMiete: %s\n%s mit %s Stockwerken bietet %s qm Wohnfläche \n(von %s möglichen qm) mit einer %s Ausstattung."
            Text = string.format(Text, self.ID, toprice(self.preis + iraeume[self.irid]:getPreis()), toprice(self.kasse), miete, desc, self.stockwerke, irQM, self.qm, tausstatt)
        else
            Text = "Hausnummer: %s\nAktueller Hauswert: %s\nMiete %s\n%s mit %s Stockwerken bietet %s qm Wohnfläche \n(von %s möglichen qm) mit einer %s Ausstattung."
            Text = string.format(Text, self.ID, toprice(self.preis + iraeume[self.irid]:getPreis()), miete, desc, self.stockwerke, irQM, self.qm, tausstatt)
        end
    else
        Text = "Hausnummer: %s\nAktueller Hauspreis: %s\n%s mit %s Stockwerken kann je nach Innenausstattung bis zu %s qm Wohnfläche bieten."
        Text = string.format(Text, self.ID, self.preis, desc, self.stockwerke, self.qm)
    end

    triggerClientEvent(thePlayer, "showHInfo", thePlayer, Text)
end

function Haus:changeKasse(betrag)
    self.kasse = self.kasse + betrag
    self:save()
end

function Haus:setKasse(betrag)
    self.kasse = betrag
    self:save()
end

function Haus:getMiete()
    return self.miete
end

function Haus:setMiete(miete)
    self.miete = miete

    local result = MySql.helper.getSync("user_data", "Nickname", {hkey = (-self.ID)});
    for theKey, theRow in ipairs(result) do
        MySql.helper.insert("user_offline_messages", {
            VonName = "Mietsystem",
            Message = "Die Miete deiner Wohnung wurde auf " .. miete .. " gesetzt!",
            Nickname = theRow["Nickname"]
        })
    end

    for theKey, toPlayer in ipairs(getElementsByType("player")) do
        if (vioGetElementData(toPlayer, "hkey")) then
            if (self.ID == -vioGetElementData(toPlayer, "hkey")) then
                outputChatBox(string.format("Die Miete deiner Wohnung wurde auf %s gesetzt!", miete), toPlayer)
            end
        end
    end
    self:updateInfoText()
    self:save()
end

function Haus:setPlayerIn(thePlayer)
    if (self:getIRaum() ~= 0) then
        local x, y, z, int = iraeume[self.irid]:getSpawnCoords()
        setElementInterior(thePlayer, int)
        setElementDimension(thePlayer, self.ID)
        setElementPosition(thePlayer, x, y, z)
    end
end

function Haus:setPlayerOut(thePlayer)
    if (self:getIRaum() ~= 0) then
        setElementInterior(thePlayer, 0)
        setElementDimension(thePlayer, 0)
        setElementPosition(thePlayer, self.coords[1], self.coords[2], self.coords[3])
    end
end

function Haus:setBesitzer(thePlayer)
    if (thePlayer) then
        self.besitzer = getPlayerName(thePlayer)
        setPickupType(self.pickup, 3, 1272)
    else
        if (self:getCity() ~= 3) then
            self.besitzer = false
            setPickupType(self.pickup, 3, 1273)
        else
            self.besitzer = "nicht handelbar"
            setPickupType(self.pickup, 3, 1273)
        end
    end
    self:updateInfoText()
end

function Haus:getBesitzer()
    return self.besitzer
end

function Haus:updateInfoText()
    local showText = "Hausnummer: %s\nBesitzer: %s\n%s\n"
    local bT = self.besitzer
    local hT = "Miete: %s"
    if (self.miete > 0) then
        hT = string.format(hT, self.miete)
    else
        hT = string.format(hT, "Keine möglich")
    end
    if not bT then
        bT = "Keiner"
        hT = "Hauswert: " .. toprice(self.preis)
    end

    showText = string.format(showText, self.ID, bT, hT)

    changeElementShowText(self.pickup, { 0, 0, 255, 255 }, showText)
end

function Haus:getPreis()
    local preis = self.preis
    if (self:getIRaum() ~= 0) then
        preis = preis + iraeume[self:getIRaum()]:getPreis()
    end
    return preis
end

function Haus:getKasse()
    return self.kasse
end

function Haus:getIRaum()
    return self.irid
end

function Haus:setIRaum(irid)
    self.irid = irid
    self:save()
end

function Haus:isLocked()
    return self.locked
end

function Haus:setLock(lockstate)
    if (lockstate == nil and type(lockstate) == "nil") then
        self.locked = not self.locked
    elseif (lockstate == false) then
        self.locked = false
    elseif (lockstate == true) then
        self.locked = true
    end
end

function Haus:getPlayerSpawn()
    if (self.irid == 0) then
        return self.coords[1], self.coords[2], self.coords[3], 0, 0
    else
        local x, y, z, int = iraeume[self.irid]:getSpawnCoords()
        return x, y, z, int, self.ID
    end
end

function Haus:getDistance(x, y, z)
    local dis = getDistanceBetweenPoints3D(x, y, z, self.coords[1], self.coords[2], self.coords[3])
    return dis
end

function Haus:getPlayerDistance(thePlayer)
    local x, y, z = getElementPosition(thePlayer)
    local dis = getDistanceBetweenPoints3D(x, y, z, self.coords[1], self.coords[2], self.coords[3])
    return dis
end

function Haus:isPlayerInHouse(thePlayer, dis)
    if not dis then dis = 50 end
    local x, y, z, int, dim = self:getPlayerSpawn()
    if (int == getElementInterior(thePlayer) and dim == getElementDimension(thePlayer)) then
        if (getElementsDistanceToPoint(thePlayer, x, y, z) < dis) then
            return true
        else
            return false
        end
    else
        return false
    end
end

--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 17.10.2016
-- Time: 15:44
-- To change this template use File | Settings | File Templates.
--

local gfx, gfy, gfz, gfsizeInner, gfsizeOuter, showGf = false;

function showKillGfText()

    local gfElement = getElementByID("GFSync");
    local data = getElementData(gfElement, "data");

    local restTime = 0;
    if (data.timerEnd > 0) then
        restTime = data.timerEnd - getRealTime().timestamp;
    end

    if (restTime > 0 and (table.hasValue(data.attackers, getLocalPlayer()) or table.hasValue(data.defenders, getLocalPlayer()))) then
        --        Spieler ist im GF
        local minutes = math.floor(restTime / 60);
        local seconds = math.floor(restTime - (minutes * 60));
        if (seconds < 10) then
            seconds = "0" .. seconds;
        end

        local screenX, screenY = guiGetScreenSize();
        local sX = (screenX / 2) - (456 / 2)
        local sY = 0

        dxDrawRectangle(sX, sY, 456.0, 56.0, tocolor(0, 0, 0, 255), false)
        local taxastring = "Rundenzeit: " .. minutes .. ":" .. seconds;

        dxDrawText(taxastring, sX, sY, (sX + 456), (sY + 56), tocolor(255, 255, 255, 255), 2.0, "default", "center", "center", false, false, false)

    end


    if (showGf) then
        checkGfPositioning()

        local s = 0;
        for s = 0, 600, 100 do

            local listI = getCoordinateList(gfsizeInner, s, tocolor(255, 255, 0, 100))
            local listO = getCoordinateList(gfsizeOuter, s, tocolor(255, 0, 0, 100))

            dxDrawPrimitive3D("trianglestrip", false, unpack(listI))
            dxDrawPrimitive3D("trianglestrip", false, unpack(listO))
        end
    end
end
addEventHandler("onClientRender", getRootElement(), showKillGfText)

local wasOutSideOfArea = false;
local firstNotificationOfOutsideArea = 0;
local secondsUntilDeath = 10
function checkGfPositioning()
    if (isPlayerOutSideOfGFArea()) then
        if (not wasOutSideOfArea) then
            firstNotificationOfOutsideArea = getRealTime().timestamp
            wasOutSideOfArea = true
        end

        local restSeconds = secondsUntilDeath - (getRealTime().timestamp - firstNotificationOfOutsideArea)

        local text = "Du hast das GF Gebiet verlassen. Kehre in den nächsten " .. restSeconds .. " Sekunden zurück oder du wirst getötet!";

        local screenW, screenH = guiGetScreenSize();
        dxDrawText(text, 0, 0, screenW, screenH, tocolor(255, 0, 0), 1.5, "default", "center", "center", false, true, true, false, false, 0, 0, 0);

        if (restSeconds < 0) then
            setElementHealth(getLocalPlayer(), 0)
            killPed(getLocalPlayer())
        end
    else
        firstNotificationOfOutsideArea = 0
        wasOutSideOfArea = false
    end
end

function isPlayerOutSideOfGFArea()

    local gfElement = getElementByID("GFSync");
    local data = getElementData(gfElement, "data");

    if (tonumber(getElementData(gfElement, "startedRound")) == 0) then
        return false
    end

    local px,py,pz = getElementPosition(getLocalPlayer())
    local distanceToMid = getDistanceBetweenPoints3D(gfx, gfy, gfz,px,py,pz)

    -- angreifer
    if (data.attackFaction == tonumber(getElementData(getLocalPlayer(), "fraktion"))) then
        if (tonumber(data.round) % 2 == 1) then
            -- muss außen sein
            return distanceToMid > gfsizeOuter
        else
            -- muss im inneren sein
            return distanceToMid > gfsizeInner
        end
    else
        if (tonumber(data.round) % 2 == 1) then
            -- muss inneren sein
            return distanceToMid > gfsizeInner
        else
            -- muss im außen sein
            return distanceToMid > gfsizeOuter
        end
    end

end

function setGangFightColShapes(enable, ex, ey, ez, esizeInner, esizeOuter)
    showGf = enable;
    gfx = ex;
    gfy = ey;
    gfz = ez;
    gfsizeInner = esizeInner;
    gfsizeOuter = esizeOuter;
end
addEvent("event_gf_set_col_shapes", true)
addEventHandler("event_gf_set_col_shapes", getRootElement(), setGangFightColShapes)

function findPointOnCircle(originX, originY, radius, angleRadians)
    local newX = radius * math.cos(angleRadians) + originX
    local newY = radius * math.sin(angleRadians) + originY

    return newX, newY
end

function getCoordinateList(radius, start, color)
    local listTable = {}

    local i = start;
    for i = start, start + 100, 1 do
        local cAngle = i / 100;
        local nx, ny =  findPointOnCircle(gfx, gfy , radius, cAngle);
        table.insert(listTable, {nx, ny, gfz - 25, color});
        table.insert(listTable, {nx, ny, gfz + 25, color});
    end
    return listTable;
end


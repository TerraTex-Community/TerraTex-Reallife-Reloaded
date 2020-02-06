--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 17.10.2016
-- Time: 15:44
-- To change this template use File | Settings | File Templates.
--

local gfx, gfy, gfz, gfsizeInner, gfsizeOuter, showGf = false;
local killGFTimer = false;
local colshape = false;

addEvent("sendGfKillWarning", true);
function sendGfKillWarning_func(seconds)
    --  source = colshape
    colshape = source;
    if (isTimer(killGFTimer)) then
        killTimer(killGFTimer);
    end
    killGFTimer = setTimer(killPlayer, seconds * 1000, 1);
end
addEventHandler("sendGfKillWarning", getRootElement(), sendGfKillWarning_func);

function killPlayer()
    if (isTimer(killGFTimer)) then
        killTimer(killGFTimer);
    end
    if not isElementWithinColShape(getLocalPlayer(), colshape) then
        setElementHealth(getLocalPlayer(), 0);
    end
end

function showKillGfText()
    if (isTimer(killGFTimer)) then
        local timeLeft = getTimerDetails(killGFTimer);
        timeLeft = math.round(timeLeft / 1000);

        local text = "Du hast das GF Gebiet verlassen. Kehre in den nächsten " .. timeLeft .. " Sekunden zurück oder du wirst getötet!";

        local screenW, screenH = guiGetScreenSize();
        dxDrawText(text, 0, 0, screenW, screenH, tocolor(255, 0, 0), 1.5, "default", "center", "center", false, true, true, false, false, 0, 0, 0);

        if (not isElementWithinColShape(getLocalPlayer(), colshape)) then
            killTimer(killGFTimer);
            killGFTimer = false;
            colshape = false;
        end
    end

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
        local listI = getCoordinateList(gfsizeInner, tocolor(255, 255, 0, 100))
        local listO = getCoordinateList(gfsizeOuter, tocolor(255, 0, 0, 100))

        dxDrawPrimitive3D("trianglestrip", false, unpack(listI))
        dxDrawPrimitive3D("trianglestrip", false, unpack(listO))
    end
end
addEventHandler("onClientRender", getRootElement(), showKillGfText)

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

function getCoordinateList(radius, color)
    local listTable = {}

    local i = 0;
    for i = 0, 630, 1 do
        local cAngle = i / 100;
        local nx, ny =  findPointOnCircle(gfx, gfy , radius, cAngle);
        table.insert(listTable, {nx, ny, gfz - 25, color});
        table.insert(listTable, {nx, ny, gfz + 25, color});
    end
    return listTable;
end


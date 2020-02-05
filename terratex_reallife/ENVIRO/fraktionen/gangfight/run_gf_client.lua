--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 17.10.2016
-- Time: 15:44
-- To change this template use File | Settings | File Templates.
--

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
end
addEventHandler("onClientRender", getRootElement(), showKillGfText)

local x, y, sizeInner, sizeOuter, showGf;
function setGangFightColShapes(enable, ex, ey, esizeInner, esizeOuter)
    showGf = enable;
    x = ex;
    y= ey;
    sizeInner = esizeInner;
    sizeOuter = esizeOuter;
end
addEvent("event_gf_set_col_shapes", true)
addEventHandler("event_gf_set_col_shapes", getRootElement(), setGangFightColShapes)



-- @todo: calc borders of colshape and show them
-- js code for it:
--let canvas, ctx, player
--
--function init() {
--    canvas = document.getElementById("canvas")
--    ctx = canvas.getContext( "2d" )
--
--
--    const midX = 30;
--    const midY = 50;
--    const r = 100;
--
--    ctx.fillRect(midX,midY,1,1);
--
--for (let i = 0; i < 7; i += 0.01) {
--const pos = findPointOnCircle(midX, midY , r, i);
--ctx.fillRect(pos.x,pos.y,1,1);
--}
--
--}
--function findPointOnCircle(originX, originY , radius, angleRadians) {
--var newX = radius * Math.cos(angleRadians) + originX
--
--var newY = radius * Math.sin(angleRadians) + originY
--
--return {"x" : newX, "y" : newY}
--
--}

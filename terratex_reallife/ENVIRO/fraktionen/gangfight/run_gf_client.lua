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
    if (isTimer(killGFTimer)) then killTimer(killGFTimer); end
    if not isElementWithinColShape (getLocalPlayer(), colshape) then
        setElementHealth(getLocalPlayer(), 0);
    end
end

function showKillGfText()
    if (isTimer(killGFTimer)) then
        local timeLeft = getTimerDetails ( killGFTimer);
        timeLeft = math.round(timeLeft / 1000);

        local text = "Du hast das GF Gebiet verlassen. Kehre in den nächsten " .. timeLeft .. " Sekunden zurück oder du wirst getötet!";

        local screenW, screenH = guiGetScreenSize();
        dxDrawText ( text, 0,0, screenW, screenH, tocolor(255,0,0), 1.5, "default", "center", "center", false, true, true, false, false, 0, 0, 0 );
    end

    local gfElement = getElementById("GFSync");
    local data = getElementData(gfElement, "data");

    if (isTimer(data.timer) and (table.hasValue(data.Attackers, getLocalPlayer()) or table.hasValue(data.Defenders, getLocalPlayer()))) then
--        Spieler ist im GF
        local restTime = math.floor(getTimerDetails ( data.timer ) / 1000);
        local minutes = math.floor(restTime / 60);
        local seconds = math.floor(restTime - (minutes * 60));
        if (seconds < 10) then
            seconds = "0" .. seconds;
        end

        local screenX, screenY = getScreenSize();

        local sX = (screenX / 2) - (456 / 2)
        local sY = (screenY / 2) - (56 / 2)

        dxDrawRectangle(sX,sY,456.0,56.0,tocolor(0,0,0,255),false)
        local taxastring="Rundenzeit: "..minutes..":"..seconds;

        dxDrawText(taxastring,sX,sY,(sX + 456),(sY + 56), tocolor(255,255,255,255),2.0,"default","center","center",false,false,false)

    end
end
addEventHandler ( "onClientRender", getRootElement(), showKillGfText )
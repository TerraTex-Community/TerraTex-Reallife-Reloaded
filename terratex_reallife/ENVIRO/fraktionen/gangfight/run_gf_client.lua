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
end
addEventHandler ( "onClientRender", getRootElement(), showKillGfText )
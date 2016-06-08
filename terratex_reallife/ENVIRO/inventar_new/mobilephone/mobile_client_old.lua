--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 15.08.2014
-- Time: 15:47
-- To change this template use File | Settings | File Templates.
--


-- @todo: verschieben in eigene Datei zu enviro
local mutephone=false
function mutephone_func()
    mutephone=not(mutephone)
    if(mutephone)then
        outputChatBox("Du hast dein Telefon stumm geschaltet!",255,0,0)
    else
        outputChatBox("Du hast den Klingelton deines Telefons wieder aktiviert!",255,0,0)
    end
end
addCommandHandler("mutephone",mutephone_func,false,false)

local telesound=false
addEvent("playTeleKlingel",true)
function playTeleKlingel_func()
    if(not(mutephone))then
        telesound=playSound("/FILES/SOUNDS/tutsounds/Ring1.wav")
    end
end
addEventHandler("playTeleKlingel",getRootElement(),playTeleKlingel_func)

addEvent("stopTeleKlingel",true)
function stopTeleKlingel_func()
    if(isElement(telesound))then
        stopSound ( telesound )
    end
end
addEventHandler("stopTeleKlingel",getRootElement(),stopTeleKlingel_func)









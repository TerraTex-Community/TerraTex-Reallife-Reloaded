--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 30.07.2014
-- Time: 14:47
-- To change this template use File | Settings | File Templates.
--

function setMeSupportMode(thePlayer)
    if(isAdminLevel(thePlayer,0))then
        if(vioGetElementData(thePlayer,"smode"))then
            vioSetElementData(thePlayer,"smode",false)
            outputChatBox("Supportmodus beendet",thePlayer)
        else
            outputChatBox("Supportmodus gestartet",thePlayer)
            vioSetElementData(thePlayer,"smode",true)
        end
    end
end
addCommandHandler("smode",setMeSupportMode,false,false)










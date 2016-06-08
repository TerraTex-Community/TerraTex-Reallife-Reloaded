--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 01.06.2014
-- Time: 15:44
-- To change this template use File | Settings | File Templates.
--

local lastZoneName=""
local showUntil=0


addEventHandler("onClientRender", getRootElement(),
    function()
        local screenW, screenH = guiGetScreenSize()

        local x,y,z=getElementPosition(getLocalPlayer())
        local newZoneName=getZoneName(x,y,z)
        if(lastZoneName~=newZoneName)then
            lastZoneName=newZoneName
            showUntil=getTimestamp() + 5
        end
        if(showUntil>=getTimestamp())then
            --schatten
            --text
            dxDrawTextWithShadow(3,tocolor(0,0,0,255),lastZoneName, (screenW - (480/1600*screenW)) / 2, (screenH - (87/900*screenH) - 10), ((screenW - (480/1600*screenW)) / 2) + (480/1600*screenW), ( (screenH - (87/900*screenH) - 10)) + (87/900*screenH), tocolor(149, 221, 255, 235), (2.50/1600*screenW), "diploma", "center", "center", false, false, true, false, false)
        end
    end
)











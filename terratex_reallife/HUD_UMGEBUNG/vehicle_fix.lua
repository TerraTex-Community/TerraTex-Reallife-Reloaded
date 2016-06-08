--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 01.06.2014
-- Time: 15:43
-- To change this template use File | Settings | File Templates.
--


local vehicleShowUntil=0
local vehicleName=""

addEventHandler("onClientRender", getRootElement(),
    function()
        local screenW, screenH = guiGetScreenSize()
        if(getTimestamp()<vehicleShowUntil)then

            dxDrawTextWithShadow(3,tocolor(0,0,0,255),vehicleName, (screenW - (480/1600*screenW)) / 2, (screenH - (87/900*screenH) - (87/900*screenH) - 20), ((screenW - (480/1600*screenW)) / 2) + (480/1600*screenW), ( (screenH - (87/900*screenH) - (87/900*screenH) - 20)) + (87/900*screenH), tocolor(4, 63, 0, 250), (2.00/1600*screenW), "bankgothic", "center", "center", false, false, false, false, false)
        end
    end
)

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer)
        if(thePlayer==getLocalPlayer())then
            vehicleName=getVehicleName ( getPedOccupiedVehicle(getLocalPlayer()) )
            vehicleShowUntil=getTimestamp()+5
        end
    end
)









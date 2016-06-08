--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 01.06.2014
-- Time: 15:11
-- To change this template use File | Settings | File Templates.
--

local radioName=0
local radioShowUntil=0

addEventHandler("onClientResourceStart", getRootElement(),
    function()
        setPlayerHudComponentVisible ( "radio", false )
        setPlayerHudComponentVisible ( "area_name", false )
        setPlayerHudComponentVisible ( "vehicle_name", false )
    end
)

addEventHandler("onClientRender", getRootElement(),
    function()

        local screenW, screenH = guiGetScreenSize()

        if(radioShowUntil>=getTimestamp())then

            --schatten

            local size=(1.80/1600*screenW)
            --text
            dxDrawTextWithShadow(3,tocolor(0,0,0,255), getRadioChannelName(radioName), (screenW - (528/1600*screenW)) / 2, 10, ((screenW - (528/1600*screenW)) / 2) + (528/1600*screenW), ( 10) + (81/900*screenH), tocolor(211, 144, 0, 255), size, "bankgothic", "center", "center", false, false, false, false, false)
        end
    end
)


function stationDraw(station)
    radioName=station
    radioShowUntil=getTimestamp()+5
end
addEventHandler("onClientPlayerRadioSwitch", getLocalPlayer(), stationDraw)

addEventHandler("onClientVehicleEnter", getRootElement(),
    function(thePlayer)
        if(thePlayer==getLocalPlayer())then
            radioName=getRadioChannel ( )
            radioShowUntil=getTimestamp()+5
        end
    end
)









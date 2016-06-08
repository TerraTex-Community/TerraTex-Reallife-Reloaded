--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 08.05.2014
-- Time: 11:59
-- To change this template use File | Settings | File Templates.
--

local HshowUntil=0
local HshowText=""

addEvent("showHInfo",true)
function showHInfo_func(text)
    HshowText=text
    local timer=getRealTime()
    HshowUntil=timer.timestamp + 20
end
addEventHandler("showHInfo",getRootElement(),showHInfo_func)




addEventHandler("onClientRender", root,
    function()

        local timer=getRealTime()
        if(HshowUntil>=timer.timestamp)then

            addEventHandler("onClientResourceStart", resourceRoot,
                function()

                end
            )
            local screenW, screenH = guiGetScreenSize()

            dxDrawRectangle(30, (screenH - 130) / 2, 332, 130, tocolor(9, 9, 9, 241), true)
            dxDrawText(HshowText, 50, (screenH - 110) / 2, (50) + 312, ( (screenH - 110) / 2) + 110, tocolor(255, 255, 255, 255), 1.00, "arial", "left", "center", false, true, true, false, false)

        end
    end
)

function setAllFunitureEnabled()
    for i = 0, 4 do
        setInteriorFurnitureEnabled(i, true)
    end
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),setAllFunitureEnabled)









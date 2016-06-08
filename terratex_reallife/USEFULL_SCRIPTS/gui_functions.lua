--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 00:34
-- To change this template use File | Settings | File Templates.
--


-- @Description: Gibt die neue Höhe eines Elements zurück, Abhängig vom Inhaltstext (Breite ist feststehend)
function resizeHeight(element)
    local x,y=guiGetSize ( element , false)
    local calcHeight=guiLabelGetFontHeight ( element )
    local calcWidth=guiLabelGetTextExtent ( element )
    local newHeight=math.round(((calcWidth/x)+1)*calcHeight)
    -- outputDebugString("newHeight: "..newHeight)
    guiSetSize ( element, x, newHeight, false )
    return newHeight
end

--[[--------------------------------------------------------------------------------------------------------------------------]]
--@Description: Abfrage ob irgendein GUI (welches das Self GUI verhindern soll) angezeigt wird
allGuis={}
function isAnyGuiVisible()
    local anyvis=false
    for theKey,theGui in ipairs(allGuis) do
        if(guiGetVisible(theGui)==true)then
            anyvis=true
        end
    end
    return anyvis
end
--[[--------------------------------------------------------------------------------------------------------------------------]]
-- @Description: Verhindern von Binds solange ein Memo oder Textfeld editiert wird
function disable_input_gui()
    if(getElementType(source)=="gui-edit")then
        toggleAllControls (false,true,true )
    end
    if(getElementType(source)=="gui-memo")then
        toggleAllControls (false,true,true )
    end
end
addEventHandler("onClientGUIFocus",getRootElement(),disable_input_gui)

function enable_input_gui()
    toggleAllControls (true,true,true)
end
addEventHandler("onClientGUIBlur",getRootElement(),enable_input_gui)











--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 00:34
-- To change this template use File | Settings | File Templates.
--

function setGuiCenter(element, setNewX, setNewY)
    if (setNewX == nil) then
        setNewX = true;
    end

    if (setNewY == nil) then
        setNewY = true;
    end

    local screenW, screenH = guiGetScreenSize()
    local windowW, windowH = guiGetSize(element, false)
    local oldX, oldY = guiGetPosition(element, false)
    local x, y = (screenW - windowW) /2,(screenH - windowH) /2
    if (not setNewX) then
        x = oldX
    end

    if (not setNewY) then
        y = oldY
    end

    return guiSetPosition(element, x, y, false)
end

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
        if (isElement(theGui)) then
            if(guiGetVisible(theGui)==true)then
                anyvis=true
            end
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


local guisToCloseOnDistance = {}
function registerGuiToCloseOnPositionChange(gui, maxDistance, closeFunc)
    local currentPositionX, currentPositionY, currentPositionZ = getElementPosition(getLocalPlayer())
    table.insert(guisToCloseOnDistance, {
        position = {currentPositionX, currentPositionY, currentPositionZ},
        gui = gui,
        maxDistance = maxDistance,
        closeFunc = closeFunc
    });
end

function checkDistanceOnGui()
    local currentPositionX, currentPositionY, currentPositionZ = getElementPosition(getLocalPlayer())
    for theKey, theGui in ipairs(guisToCloseOnDistance) do
        if (theGui.gui) then
            if (
                isElement(theGui.gui) and
                getDistanceBetweenPoints3D(currentPositionX, currentPositionY, currentPositionZ, theGui.position[1], theGui.position[2], theGui.position[3]) > theGui.maxDistance
            ) then
                theGui.gui = false;
                closeFunc();
            end
        end
    end
end
addEventHandler ( "onClientRender", getRootElement(), checkDistanceOnGui )

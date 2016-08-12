--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 01:21
-- To change this template use File | Settings | File Templates.
--

function getElementsDistance(elementA,elementB)
    local x,y,z=getElementPosition(elementA)
    local x2,y2,z2=getElementPosition(elementB)
    local dis=getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    return dis
end

function getElementsDistance2D(elementA,elementB)
    local x,y,z=getElementPosition(elementA)
    local x2,y2,z2=getElementPosition(elementB)
    local dis=getDistanceBetweenPoints2D(x,y,x2,y2)
    return dis
end

function getElementsDistanceToPoint(elementA,x,y,z)
    local x2,y2,z2=getElementPosition(elementA)

    local dis= getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
    return dis
end

function getElementsDistance2DToPoint(elementA,x,y,z)
    local x2,y2,z2=getElementPosition(elementA)
    local dis=getDistanceBetweenPoints2D(x,y,x2,y2)
    return dis
end

function hasElementData(element, dataEntry, values, transformToNumberic)
    if transformToNumberic ~= true then
        transformToNumberic = false;
    end

    local elementData = getElementData(element, dataEntry);
    if transformToNumberic then
       elementData = tonumber(elementData);
    end

    if (type(values) ~= "table") then
        values = {values};
    end

    for theKey, theValue in ipairs(values) do
        if transformToNumberic then
            theValue = tonumber(theValue);
        end

        if (elementData == theValue) then
            return true;
        end
    end

    return false;
end
--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 16.06.2016
-- Time: 19:56
-- To change this template use File | Settings | File Templates.
--

function isInsideRadarArea(area, px, py)
    local sizeX, sizeY = getRadarAreaSize ( area )
    local x,y,z = getElementPosition(area)
    outputDebugString("coords: " .. tostring(x).." "..tostring(y));

    return (px > x and px < (x + sizeX) and py > y and py < (y + sizeY));
end


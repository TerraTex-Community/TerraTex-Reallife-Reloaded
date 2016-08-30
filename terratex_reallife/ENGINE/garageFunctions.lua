local garage = {}
createGarage = function(pID, pModel, px1, py1, pz1, prx1, pry1, prz1, px2, py2, pz2, prx2, pry2, prz2)
    if (pID >= 0 and pID <= 49) then
        return nil
    end
    garage[pID] = {x1 = px1, y1 = py1, z1 = pz1, rx1 = prx1, ry1 = pry1, rz1 = prz1, x2 = px2, y2 = py2, z2 = pz2, rx2 = prx2, ry2 = pry2, rz2 = prz2}
    garage[pID].obj = createObject(pModel, px1, py1, pz1, prx1, pry1, prz1)
    garage[pID].state = false
    return garage[pID].obj
end

_setGarageOpen = setGarageOpen
setGarageOpen = function(garageID, open)
    if (garageID >= 0 and garageID <= 49) then
        return _setGarageOpen(garageID, open)
    elseif (garage[garageID]) then
        if (garage[garageID].state ~= open) then
            stopObject(garage[garageID].obj)
            local rx,ry,rz = getElementRotation(garage[garageID].obj)
            if (garage[garageID].state == false) then
                moveObject(garage[garageID].obj, math.abs(garage[garageID].ry2-ry)/90*2000, garage[garageID].x2, garage[garageID].y2, garage[garageID].z2, garage[garageID].rx2-rx, garage[garageID].ry2-ry, garage[garageID].rz2-rz)
            else
                moveObject(garage[garageID].obj, math.abs(garage[garageID].ry1-ry)/90*2000, garage[garageID].x1, garage[garageID].y1, garage[garageID].z1, garage[garageID].rx1-rx, garage[garageID].ry1-ry, garage[garageID].rz1-rz)
            end
            garage[garageID].state = open
        end
        return true
    else
        return false
    end
end

_isGarageOpen = isGarageOpen
isGarageOpen = function(garageID)
    if (garageID >= 0 and garageID <= 49) then
        return _isGarageOpen(garageID)
    elseif (garage[garageID]) then
        return garage[garageID].state
    else
        return false
    end
end

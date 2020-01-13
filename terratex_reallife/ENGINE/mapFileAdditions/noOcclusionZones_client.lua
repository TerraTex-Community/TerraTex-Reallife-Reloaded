local zones = {
    {x = 2695.24, y = -2649.56, radius = 280, dimension = 0, interior = 0} --Atomkraftwerk
}

function createZones()
    for key,value in pairs(zones) do
        zones[key].colCircle = createColCircle(zones[key].x, zones[key].y, zones[key].radius)
    end
    addEventHandler("onClientElementColShapeHit", getLocalPlayer(), enterZone)
    addEventHandler("onClientElementColShapeLeave", getLocalPlayer(), leaveZone)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createZones)

function enterZone(theShape)
    local thePlayer = getLocalPlayer()
    for key,value in pairs(zones) do
        if (theShape == zones[key].colCircle and getElementDimension(thePlayer) == zones[key].dimension and getElementInterior(thePlayer) == zones[key].interior) then
            setOcclusionsEnabled(false)
            --outputDebugString("occlusionsEnabled: false")
        end
    end
end

function leaveZone(theShape)
    local thePlayer = getLocalPlayer()
    for key,value in pairs(zones) do
        if (theShape == zones[key].colCircle and getElementDimension(thePlayer) == zones[key].dimension and getElementInterior(thePlayer) == zones[key].interior) then
            setOcclusionsEnabled(true)
            --outputDebugString("occlusionsEnabled: true")
        end
    end
end

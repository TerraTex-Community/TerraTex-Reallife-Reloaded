addEventHandler("onClientResourceStart", resourceRoot,
        function()
            GPS_Window = {}
            GPS_Button = {}
            GPS_Label = {}
            GPS_Image = {}

            GPS_Window[1] = guiCreateWindow(576, 280, 681, 543, "GPS-Travel Tapp", false)
            GPS_Image[1] = guiCreateStaticImage(13, 27, 500, 500, "FILES/IMAGES/radar.jpg", false, GPS_Window[1])
            GPS_Button[1] = guiCreateButton(529, 149, 136, 28, "Navigation beenden!", false, GPS_Window[1])
            GPS_Label[1] = guiCreateLabel(528, 36, 140, 100, "Um eine GPS-Navigation zu starten, einfach einen Punkt auf der Karte anklicken!", false, GPS_Window[1])
            guiLabelSetHorizontalAlign(GPS_Label[1], "left", true)
            GPS_Button[2] = guiCreateButton(529, 184, 136, 28, "Tapp schließen!", false, GPS_Window[1])
            GPS_Image[2] = guiCreateStaticImage(532, 258, 16, 16, "FILES/IMAGES/ziel.png", false, GPS_Window[1])
            GPS_Label[2] = guiCreateLabel(563, 258, 104, 26, "gesetzter Zielpunkt", false, GPS_Window[1])
            guiSetVisible(GPS_Window[1], false)

            addEventHandler("onClientGUIClick", GPS_Button[2], closeGPSTapp, false)
            addEventHandler("onClientGUIClick", GPS_Button[1], endNavigation, false)
            addEventHandler("onClientGUIClick", GPS_Image[1], startGPS, false)
        end
)
local lastGPSZiel = false
local lastGPSBlip = false
local lastGPSZielCoord = { false, false, false }
local lastGPSMarker = false

function showGPSDisplay()
    guiSetVisible(GPS_Window[1], true)
end

function closeGPSTapp()
    guiSetVisible(GPS_Window[1], false)
end

local function getAreaID(x, y)
    return math.floor((y + 3000) / 750) * 8 + math.floor((x + 3000) / 750)
end

function findNodeClosestToPoint_client(db, x, y, z)
    local areaID = getAreaID(x, y)
    local minDist, minNode
    local nodeX, nodeY, dist
    for id, node in pairs(db[areaID]) do
        nodeX, nodeY = node.x, node.y
        dist = (x - nodeX) * (x - nodeX) + (y - nodeY) * (y - nodeY)
        if not minDist or dist < minDist then
            minDist = dist
            minNode = node
        end
    end
    return minNode.x, minNode.y, minNode.z
end

local lastTimer = false
function startGPS(button, _, absoluteX, absoluteY)

    if (button == "left") then

        local absX, absY = guiGetPosition(GPS_Image[1], false)
        local absX2, absY2 = guiGetPosition(GPS_Window[1], false)

        absoluteX = absoluteX - (absX2 + absX)
        absoluteY = absoluteY - (absY2 + absY)

        if isElement(lastGPSZiel) then
            destroyElement(lastGPSZiel)
        end
        if isElement(lastGPSBlip) then
            destroyElement(lastGPSBlip)
        end
        if isElement(lastGPSMarker) then
            destroyElement(lastGPSMarker)
        end
        local x = absoluteX / 500 * 6000 - 3000
        local y = absoluteY / 500 * 6000 - 3000
        local copyX, copyY = x, -y
        x, y, z = findNodeClosestToPoint_client(vehicleNodes_client, x, y, 0)
        y = -y
        lastGPSZiel = guiCreateStaticImage((absoluteX - 8 + absX), (absoluteY - 8 + absY), 16, 16, "FILES/IMAGES/ziel.png", false, GPS_Window[1])
        lastGPSBlip = createBlip(copyX, copyY, z, 41, 2, 255, 0, 0, 255, 0, 99999.0, getRootElement())
        lastGPSMarker = createMarker(copyX, copyY, z, "checkpoint")
        addEventHandler("onClientMarkerHit", lastGPSMarker, endNavigation_marker)
        lastGPSZielCoord = { x, y, z }
        if (isTimer(lastTimer)) then
            killTimer(lastTimer)
        end

        gpsTimer()
    end
end

function gpsTimer()
    lastTimer = setTimer(gpsTimer, 10000, 1)
    clientSetGPSRoute()
end

function clientSetGPSRoute()
    if (lastGPSZielCoord[1]) then
        executeCommandHandler("path2", lastGPSZielCoord[1] .. " " .. lastGPSZielCoord[2] .. " " .. lastGPSZielCoord[3])
    else
        removeLinePoints()
        table.each(GPSMarker, destroyElement)
        if (isTimer(lastTimer)) then
            killTimer(lastTimer)
        end
    end
end

function endNavigation()
    outputChatBox("Die Navigation wurde beendet")
    if isElement(lastGPSZiel) then
        destroyElement(lastGPSZiel)
    end
    if isElement(lastGPSBlip) then
        destroyElement(lastGPSBlip)
    end
    if isElement(lastGPSMarker) then
        destroyElement(lastGPSMarker)
    end
    lastGPSZiel = false
    lastGPSBlip = false
    lastGPSZielCoord = { false, false, false }
    lastGPSMarker = false
    removeLinePoints()

    table.each(GPSMarker, destroyElement)
    if (isTimer(lastTimer)) then
        killTimer(lastTimer)
    end
    lastTimer = false

end

function endNavigation_marker(hitElement)
    if (hitElement == getLocalPlayer()) then
        endNavigation()
    end
end













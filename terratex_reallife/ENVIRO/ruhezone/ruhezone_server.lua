ruhezonen = {}

function createAndLoadRuheZonen()
    local result = MySql.helper.getSync("objects_restareas", "*");
    for theKey, dasatz in ipairs(result) do
        local area = createRadarArea(tonumber(dasatz["leftX"]), tonumber(dasatz["buttonY"]), tonumber(dasatz["sizeX"]), tonumber(dasatz["sizeY"]), 0, 200, 0, 150, getRootElement())
        ruhezonen[tonumber(dasatz["ID"])] = area
    end
end

addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createAndLoadRuheZonen)

function isInRuheZone(thePlayer)
    local x, y, z = getElementPosition(thePlayer)
    for theKey, theArea in pairs(ruhezonen) do
        if (isInsideRadarArea(theArea, x, y)) then
            return true
        end
    end
    return false
end

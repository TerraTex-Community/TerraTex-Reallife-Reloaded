--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 16.06.2016
-- Time: 15:48
-- To change this template use File | Settings | File Templates.
--

local teleportMarkers = {}
function getTeleportMarkers()
    return teleportMarkers;
end

function loadTeleportMarkers()
    local markersFromDatabase = MySql.helper.getSync("objects_teleport_markers", "*");

    local marker;
    for theKey, theMarkerData in ipairs(markersFromDatabase) do
        marker = createMarker(theMarkerData.x, theMarkerData.y, theMarkerData.z, theMarkerData.markerType, theMarkerData.markerSize);
        setElementInterior(marker, marker.interior);
        setElementDimension(marker, marker.dimension);

        vioSetElementData(marker, "additionalData", theMarkerData);

        table.insert(teleportMarkers, marker);
        addEventHandler("onMarkerHit", marker, onTeleportMarkerHit);
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), loadTeleportMarkers)

function onTeleportMarkerHit(hitElement, matchingDimension)

end
function createSkinShopMarkers()
    for theKey, thePosition in ipairs(skinShopPositions) do
        local marker = createMarker(unpack(thePosition), "corona", 1)
        createBlip(unpack(thePosition), 45, 0.5, 255, 0, 0, 255, 0, 255, getRootElement())
        addEventHandler("onMarkerHit", marker, hitSkinShopMarker)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createSkinShopMarkers)

function hitSkinShopMarker(thePlayer)
    if (isElement(thePlayer)) then
        if (getElementType(thePlayer) == "player") then
            if (not vioGetElementData(thePlayer, "isCopSwat")) then
                if not (isPedInVehicle(thePlayer)) then

                    -- @todo: has to be reworked?
                    triggerClientEvent(thePlayer, "showSkinGui", thePlayer, isUserDutyInFaction(thePlayer))

                end
            end
        end
    end
end

function isUserDutyInFaction(thePlayer)
    if (isBeamter(thePlayer) or vioGetElementData(thePlayer, "fraktion") == 4 or vioGetElementData(thePlayer, "fraktion") == 10) then
        if (vioGetElementData(thePlayer, "taxi_duty") or vioGetElementData(thePlayer, "isCopDuty") or vioGetElementData(thePlayer, "isMedicDuty")) then
            return true;
        end
    end
    return false;
end

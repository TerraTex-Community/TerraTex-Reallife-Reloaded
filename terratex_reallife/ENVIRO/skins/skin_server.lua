function createSkinShopMarkers()
    for theKey, thePosition in ipairs(skinShopPositions) do
        local marker = createMarker(unpack(thePosition), "corona", 1)
        createBlip(unpack(thePosition), 45, 0.5, 255, 0, 0, 255, 0, 255, getRootElement())
        addEventHandler("onMarkerHit", marker, hitSkinShopMarker)
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createSkinShopMarkers)

addEvent("event_skin_shop_buy", true)
function skin_shop_buy(modelId)
    changeBizKasse(15,5, "Skin Einkauf")

    if (getSkinFactionId(client) > 0) then
        vioSetElementData(client,"FrakSkin", modelId)
        setElementModel(client,vioGetElementData(client,"FrakSkin"))
    else
        vioSetElementData(client,"skinid", modelId)
        setElementModel(client,vioGetElementData(client,"skinid"))
    end
end
addEventHandler("event_skin_shop_buy", getRootElement(), skin_shop_buy)

function hitSkinShopMarker(thePlayer)
    if (isElement(thePlayer)) then
        if (getElementType(thePlayer) == "player") then
            if (not vioGetElementData(thePlayer, "isCopSwat")) then
                if not (isPedInVehicle(thePlayer)) then
                    triggerClientEvent(thePlayer, "event_skin_shop_open", thePlayer, getSkinFactionId(thePlayer))
                end
            end
        end
    end
end

function getSkinFactionId(thePlayer)
    local factionId = vioGetElementData(thePlayer, "fraktion")
    if (factionId == 4 or factionId == 10 or isBeamter(thePlayer)) then
        if (vioGetElementData(thePlayer, "taxi_duty") or vioGetElementData(thePlayer, "isCopDuty") or vioGetElementData(thePlayer, "isMedicDuty")) then
            return factionId;
        end

        return 0
    end

    return factionId;
end

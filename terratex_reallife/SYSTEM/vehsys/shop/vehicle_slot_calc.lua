function getPlayerSlotData(thePlayer)
    local slotTable = {
        totalSlots = vioGetElementData(thePlayer, "maxslots"),
        freeSlots = nil,
        firstFreeSlot = nil,
        price = nil
    };

    local freeSlots = 0
    local firstFreeSlot = 0
    for zah = vioGetElementData(source, "maxslots"), 1, -1 do
        if tonumber(vioGetElementData(source, "slot" .. zah)) == -1 then
            freeSlots = freeSlots + 1
            firstFreeSlot = zah
        end
    end

    slotTable.freeSlots = freeSlots;
    slotTable.firstFreeSlot = firstFreeSlot;
    slotTable.price = getSlotPrice(slotTable.totalSlots);

    return slotTable;
end

function getSlotPrice(currentMaxSlots)
    local slotPrice = math.pow(2, (currentMaxSlots - 1)) * 1000

    if (latestSlot > 9) then
        slotPrice = math.pow(2, 9) * 1000 + math.pow(2, (currentMaxSlots - 5)) * 300
    end
    if (latestSlot > 14) then
        slotPrice = math.pow(2, 9) * 1000 + math.pow(2, 9) * 300 + math.pow(2, (currentMaxSlots - 10)) * 300
    end
    if (latestSlot > 20) then
        slotPrice = math.pow(2, 9) * 1000 + math.pow(2, 9) * 300 + math.pow(2, 10) * 300 + math.pow(1.3, (currentMaxSlots - 1)) * 300
    end

    return slotPrice;
end

local vehicleShopWindow = nil;
local vehicleShopBrowser = nil;
local vehicleList;
local vehicleLatestSlotData;

-- @todo: close window on distance

addEvent("openVehicleShop", true)
function openVehicleShop(vehicleJson, slotData)
    vehicleList = fromJSON(vehicleJson);
    vehicleLatestSlotData = fromJSON(slotData)

    if (vehicleShopWindow) then
        if isElement(vehicleShopWindow) then
            destroyElement(vehicleShopWindow);
        end
        vehicleShopWindow = false;
        vehicleShopBrowser = false;
    end
    vehicleShopWindow = guiCreateWindow(0, 0, 880, 600, "Fahrzeugshop", false);
    table.insert(allGuis, vehicleShopWindow);
    setGuiCenter(vehicleShopWindow);
    registerGuiToCloseOnPositionChange(vehicleShopWindow, 5, closeVehShop)

    local browser = guiCreateBrowser(10, 10, 880, 600, true, false, false, vehicleShopWindow);

    addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
            function()
                setBrowserAjaxHandler(source, "ajax_vehshop_close.html", closeVehShop);
                loadBrowserURL(source, "http://mta/local/UI/VehicleShop.html");
            end);

    addEventHandler("onClientBrowserDocumentReady", guiGetBrowser(browser),
            function(url)
                showCursor(true)
                vehicleShopBrowser = source;
                updateSlotData(vehicleLatestSlotData.totalSlots, vehicleLatestSlotData.freeSlots, vehicleLatestSlotData.price);

                for theKey, theVehicle in ipairs(vehicleList) do
                    -- addVehicleToShopList(id, name, price, inSale, salePercentage, salePrice)
                    local addFunc = "addVehicleToShopList(";
                    addFunc = addFunc .. theVehicle.modelId .. ", "
                    addFunc = addFunc .. "\"" .. theVehicle.name .. "\", "
                    addFunc = addFunc .. "\"" .. toprice(theVehicle.price) .. "\""

                    if (theVehicle.inSell) then
                        addFunc = addFunc .. ", "
                        addFunc = addFunc .. "true, "
                        addFunc = addFunc .. theVehicle.inSellPercentage .. ", "
                        addFunc = addFunc .. "\"" .. toprice(theVehicle.price * (100 - theVehicle.inSellPercentage) / 100) .. "\""
                    end

                    addFunc = addFunc .. ");"
                    executeBrowserJavascript(vehicleShopBrowser, addFunc)
                end
            end);

end
addEventHandler("openVehicleShop", getRootElement(), openVehicleShop)

function updateSlotData(totalSlots, freeSlots, price)
    if (vehicleShopBrowser and isElement(vehicleShopBrowser)) then
        -- totalSlots, freeSlots, slotPrice
        local slotFunc = "setSlotData(";
        slotFunc = slotFunc .. totalSlots;
        slotFunc = slotFunc .. ", " .. freeSlots;
        slotFunc = slotFunc .. ", \"" .. toprice(price) .. "\");";

        executeBrowserJavascript(vehicleShopBrowser, slotFunc)
    end
end


function closeVehShop()
    if isElement(vehicleShopWindow) then
        destroyElement(vehicleShopWindow);
    end
    vehicleShopWindow = false;
    vehicleShopBrowser = false;
end

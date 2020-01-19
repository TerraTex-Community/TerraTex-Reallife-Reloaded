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
                setBrowserAjaxHandler(source, "ajax_vehshop_buySlot.html", buySlot);
                setBrowserAjaxHandler(source, "ajax_vehshop_buyCar.html", buyCar);
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

function successOnBuySlot(slotDataJson)
    if (vehicleShopBrowser and isElement(vehicleShopBrowser)) then
        local slotData = fromJSON(slotDataJson)
        updateSlotData(slotData.totalSlots, slotData.freeSlots, slotData.price);

        executeBrowserJavascript(vehicleShopBrowser, "showBuySlotSuccessMessage()")
    end
end
addEvent("event_vehicleShopBuySlot_success", true)
addEventHandler("event_vehicleShopBuySlot_success", getRootElement(), errorOnBuySlot)

function errorOnBuySlot(txt)
    if (vehicleShopBrowser and isElement(vehicleShopBrowser)) then
        local slotData = fromJSON(slotDataJson)
        updateSlotData(slotData.totalSlots, slotData.freeSlots, slotData.price);

        executeBrowserJavascript(vehicleShopBrowser, "showBuySlotErrorMessage(\"" .. txt .."\")")
    end
end
addEvent("event_vehicleShopBuySlot_error", true)
addEventHandler("event_vehicleShopBuySlot_error", getRootElement(), errorOnBuySlot)

function ajax_vehshop_buySlot()
    triggerServerEvent("event_vehicleShopBuySlot", getLocalPlayer())
end

function ajax_vehshop_buyCar(get)
    if (get) then
        if (get.modelId and tonumber(get.modelId)) then
        --    buy a car
        end
    end
end

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

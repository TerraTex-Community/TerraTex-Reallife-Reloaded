local vehicleShopWindow = nil;
local vehicleShopBrowser = nil;

-- @todo: close window on distance

addEvent("openVehicleShop", true)
function openVehicleShop(vehicleJson)
    local vehicleList = fromJSON(vehicleJson);

    if (vehicleShopWindow) then
        if isElement(vehicleShopWindow) then destroyElement(vehicleShopWindow); end
        vehicleShopWindow = false;
        vehicleShopBrowser = false;
    else
        vehicleShopWindow = guiCreateWindow(0, 0, 880, 600, "Fahrzeugshop", false);
        table.insert(allGuis, vehicleShopWindow);
        setGuiCenter(vehicleShopWindow);

        local browser = guiCreateBrowser(10, 10, 880, 600, true, false, false, vehicleShopWindow);


        addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
            function()
                loadBrowserURL(source, "http://mta/local/UI/VehicleShop.html");
            end);

        addEventHandler("onClientBrowserDocumentReady", guiGetBrowser(browser),
            function(url)
                showCursor(true)
                vehicleShopBrowser = source;

                for theKey, theVehicle in ipairs(vehicleList) do
                    -- addVehicleToShopList(id, name, price, inSale, salePercentage, salePrice)
                    local addFunc = "addVehicleToShopList(";
                    addFunc = addFunc .. theVehicle.modelId .. ", "
                    addFunc = addFunc .. "\"" .. theVehicle.name .. "\", "
                    addFunc = addFunc .. toprice(theVehicle.price)

                    if (theVehicle.inSell) then
                        addFunc = addFunc .. ", "
                        addFunc = addFunc .. "true, "
                        addFunc = addFunc .. theVehicle.inSellPercentage .. ", "
                        addFunc = addFunc .. toprice(theVehicle.price * (100 - theVehicle.inSellPercentage) / 100)
                    end

                    addFunc = addFunc .. ");"
                    executeBrowserJavascript(vehicleShopBrowser, addFunc)
                end
            end);
    end

end
addEventHandler("openVehicleShop", getRootElement(), openVehicleShop)


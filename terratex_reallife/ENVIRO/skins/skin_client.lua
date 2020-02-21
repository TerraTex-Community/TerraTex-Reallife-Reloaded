local skinShopWindow = nil;
local skinShopBrowser = nil;
local startSkin = 0;

addEvent("event_skin_shop_open", true);
function skinShopOpen(factionId)
    startSkin = getElementModel(getLocalPlayer())

    if (skinShopWindow) then
        if isElement(skinShopWindow) then
            destroyElement(skinShopWindow);
        end
        skinShopWindow = false;
        skinShopBrowser = false;
    end
    skinShopWindow = guiCreateWindow(0, 0, 880, 600, "Skin Shop", false);
    table.insert(allGuis, skinShopWindow);
    setGuiCenter(skinShopWindow);
    registerGuiToCloseOnPositionChange(skinShopWindow, 5, closeSkinShop)

    local browser = guiCreateBrowser(10, 10, 880, 600, true, false, false, skinShopWindow);

    addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
            function()

                setBrowserAjaxHandler(source, "ajax_skinshop_close.html", closeSkinShop);
                setBrowserAjaxHandler(source, "ajax_skinshop_tryskin.html", ajax_skinshop_tryskin);
                setBrowserAjaxHandler(source, "ajax_skinshop_buyskin.html", ajax_skinshop_buyskin);

                loadBrowserURL(source, "http://mta/local/UI/SkinShop.html");
            end);

    addEventHandler("onClientBrowserDocumentReady", guiGetBrowser(browser),
            function(url)
                showCursor(true)
                skinShopBrowser = source;

                local skinString = table.concat(getSkinList(factionId), ",");

                executeBrowserJavascript(skinShopBrowser, "showOnlySkins([" .. skinString .. "]);");
            end);

end
addEventHandler("event_skin_shop_open", getRootElement(), skinShopOpen)

function closeSkinShop()
    setElementModel(getLocalPlayer(), startSkin);

    if (isElement(skinShopBrowser)) then
        destroyElement(skinShopBrowser);
    end
    if (isElement(skinShopWindow)) then
        destroyElement(skinShopWindow);
    end

    skinShopBrowser = false;
    skinShopWindow = false;

    showCursor(false);
end

function ajax_skinshop_buyskin(get)
    if (get) then
        if (get.modelId and tonumber(get.modelId)) then
            closeSkinShop();
            triggerServerEvent("event_skin_shop_buy", getLocalPlayer(), tonumber(get.modelId));
        end
    end
end

function ajax_skinshop_tryskin(get)
    if (get) then
        if (get.modelId and tonumber(get.modelId)) then
            setElementModel(getLocalPlayer(), tonumber(get.modelId));
        end
    end
end

function getSkinList(factionId)
    local validSkins = getValidPedModels();
    local showSkins = {}
    if (factionId == 0) then
        for theKey, theSkinId in ipairs(validSkins) do
            if (not isFactionSkin(theSkinId)) then
                table.insert(showSkins, theSkinId);
            end
        end
    else
        for theKey, factionSkin in pairs(factionSkins[factionId]) do
            if (table.hasValue(validSkins, factionSkin)) then
                table.insert(showSkins, factionSkin);
            end
        end
    end
    return showSkins;
end

function isFactionSkin(skinId)
    for theFactionId, theFactionTable in pairs(factionSkins) do
        if (table.hasValue(theFactionTable, skinId)) then
            return true;
        end
    end
    return false
end


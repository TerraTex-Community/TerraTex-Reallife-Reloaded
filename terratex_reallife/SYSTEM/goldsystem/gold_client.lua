local goldWindow;
local goldBrowser;
function startGoldUI()
    if (goldWindow) then
        if isElement(goldWindow) then destroyElement(goldWindow) end
        goldWindow = false;
    else
        goldWindow = guiCreateWindow(0, 0, 720, 550, "Goldseller", false)
        table.insert(allGuis, goldWindow);
        setGuiCenter(goldWindow);

        local browser = guiCreateBrowser(0, 0, 720, 550, true, false, false, goldWindow)


        addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
            function()
                setBrowserAjaxHandler ( source, "ajax_gold_buy.html", buyNewGold)
                setBrowserAjaxHandler ( source, "ajax_gold_item.html", buyGoldItem)
                setBrowserAjaxHandler ( source, "ajax_gold_close.html", closeGoldShop)
                loadBrowserURL(source, "http://mta/local/UI/Gold.html");
            end
        )

        addEventHandler ( "onClientBrowserDocumentReady" , guiGetBrowser(browser) ,
            function ( url )
                showCursor(true)
                browserActualizeFields(source)
                goldBrowser = source;
            end
        )
    end
end
addCommandHandler("gold", startGoldUI, false, false)

function closeGoldShop()
    if isElement(goldWindow) then destroyElement(goldWindow); end
    showCursor(false);
    goldWindow = false;
    goldBrowser = false;
end

function buyGoldItem(get, post)
    if (get) then
        if (get.item) then
            triggerServerEvent("buyGoldItem", getLocalPlayer(), get.item);
        end
    end
end

function buyNewGold(get, post)
    if (get) then
        if (get.amount and tonumber(get.amount)) then
            if (tonumber(get.amount) * config["gold.price"] <= getPlayerMoney(getLocalPlayer())) then
                if (tonumber(get.amount) > 0) then
                    triggerServerEvent("buyNewGold", getLocalPlayer(), tonumber(get.amount));
                end
            else
                showError(getLocalPlayer(), "Du hast nicht genug Geld um so viel Gold zu kaufen!");
            end
        end
    end
end

function browserActualizeFields(browser)
    local js = "$(document).ready(function(){";
    js = js .. "$('#imBesitz').html(" .. getElementData(getLocalPlayer(), "Gold") .. ");";
    js = js .. "$('#pricePerGold').val(" .. config["gold.price"] .. ");";

    js = js .. getItemJS("FuelBooster");
    js = js .. getItemJS("HufeisenBooster");
    js = js .. getItemJS("FoodBooster");
    js = js .. getItemJS("SkillBooster");

    js = js .. "});";
    executeBrowserJavascript(browser, js)
end

function getItemJS(itemId)
    local js;
    local realTime = getRealTime();
    local timestamp = realTime.timestamp;

    if tonumber(getElementData(getLocalPlayer(), "Gold." .. itemId)) then
        if (tonumber(getElementData(getLocalPlayer(), "Gold." .. itemId)) >= timestamp) then
            local days = math.floor((tonumber(getElementData(getLocalPlayer(), "Gold." .. itemId)) - timestamp) / 60 / 60 / 24)
            if (days > 0) then
                js = "setBuyState('" .. itemId .. "', " .. days .. ");"
            else
                js = "setBuyState('" .. itemId .. "', false, true);"
            end
        else
            js = "setBuyState('" .. itemId .. "', false, false);"
        end
    else
        js = "setBuyState('" .. itemId .. "', false, false);"
    end

    return js;
end

function actualizeGoldAmount_func()
    if (goldBrowser) then
        browserActualizeFields(goldBrowser)
    end
end
addEvent("actualizeGoldAmount", true)
addEventHandler("actualizeGoldAmount", getRootElement(), actualizeGoldAmount_func)

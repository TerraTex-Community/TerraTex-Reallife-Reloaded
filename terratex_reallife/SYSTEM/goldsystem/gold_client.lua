--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 21.06.2016
-- Time: 14:12
-- To change this template use File | Settings | File Templates.
--
local goldWindow;
local goldBrowser;
function startGoldUI()
    if (goldWindow) then
        if isElement(goldWindow) then destroyElement(goldWindow) end
        goldWindow = false;
    else
        goldWindow = guiCreateWindow(0, 0, 700, 550, "Goldseller", false)
        setGuiCenter(goldWindow);

        local browser = guiCreateBrowser(0, 0, 700, 550, true, false, false, goldWindow)


        addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
            function()
                setBrowserAjaxHandler ( source, "ajax_gold_buy.html", buyNewGold)
                setDevelopmentMode ( true, true )
                toggleBrowserDevTools ( source, true )
                loadBrowserURL(source, "http://mta/local/UI/Gold.html");
            end
        )

        addEventHandler ( "onClientBrowserDocumentReady" , guiGetBrowser(browser) ,
            function ( url )
                browserActualizeFields(source)
                goldBrowser = source;
            end
        )
    end
end
addCommandHandler("gold", startGoldUI, false, false)

function buyNewGold(get, post)
    if (get) then
        if (get.amount) then
            if (get.amount * config["gold.price"] <= getPlayerMoney(getLocalPlayer())) then
                if (get.amount > 0) then
                    triggerServerEvent("buyNewGold", getLocalPlayer(), get.amount);
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
    js = js .. "$('#pricePerGold').val(" .. config["gold.price"] .. "); });";

    executeBrowserJavascript(browser, js);
end


function actualizeGoldAmount_func()
    if (goldBrowser) then
        browserActualizeFields(goldBrowser)
    end
end
addEvent("actualizeGoldAmount", true)
addEventHandler("actualizeGoldAmount", getRootElement(), actualizeGoldAmount_func)
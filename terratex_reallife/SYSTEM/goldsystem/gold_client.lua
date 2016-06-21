--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 21.06.2016
-- Time: 14:12
-- To change this template use File | Settings | File Templates.
--
local goldWindow;
function startGoldUI()
    if (goldWindow) then
        if isElement(goldWindow) then destroyElement(goldWindow) end
        goldWindow = false;
    else
        goldWindow = guiCreateWindow(0, 0, 700, 550, "Goldseller", false)
        setGuiCenter(goldWindow);

        local browser = guiCreateBrowser(0, 0, 700, 550, true, false, false, goldWindow)

        setBrowserAjaxHandler ( guiGetBrowser(browser), "ajax_gold_buy.html", buyNewGold)

        addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
            function()
                loadBrowserURL(source, "http://mta/local/UI/Gold.html");
                browserActualizeFields(source);
            end
        )
    end
end
addCommandHandler("gold", startGoldUI, false, false)

function buyNewGold(get, post)
    if (get.amount) then
        if (get.amount * config["gold.price"] <= getPlayerMoney(getLocalPlayer())) then

        else
            showError(getLocalPlayer(), "Du hast nicht genug Geld um so viel Gold zu kaufen!");
        end
    end
end

function browserActualizeFields(browser)
    executeBrowserJavascript ( browser, "$('#imBesitz').val(" .. getElementData(getLocalPlayer(), "Gold") .. ");");
    executeBrowserJavascript ( browser, "$('#pricePerGold').val(" + config["gold.price"] + ");");
end

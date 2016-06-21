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
        goldWindow = guiCreateWindow(0, 0, 700, 512, "Goldseller", false)
        setGuiCenter(goldWindow);

        local browser = guiCreateBrowser(0, 0, 700, 512, false, false, false, goldWindow)

        setBrowserAjaxHandler ( browser, "gold.html" , function(get, post)
            if (get.button and get.button == "true") then
                showError(getLocalPlayer(), "You Clicked on a buy button!");
            end
        end )

        addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
            function()
                loadBrowserURL(source, "http://mta/local/UI/gold.html")
            end
        )
    end
end
addCommandHandler("testgold", startGoldUI, false, false)
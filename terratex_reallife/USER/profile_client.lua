--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 15.07.2016
-- Time: 17:13
-- To change this template use File | Settings | File Templates.
--

local profileWindow;
local profileBrowser;

function startProfileUI()

    if (profileWindow) then
        if isElement(profileWindow) then destroyElement(profileWindow) end
        profileWindow = false;
    end

    profileWindow = guiCreateWindow(0, 0, 525, 475, "Profile", false)
    table.insert(allGuis, profileWindow);
    setGuiCenter(profileWindow);

    local browser = guiCreateBrowser(0, 15, 525, 475, true, false, false, profileWindow)


    addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
        function()
--            setBrowserAjaxHandler(source, "ajax_login_login.html", login)
            loadBrowserURL(source, "http://mta/local/UI/Profile.html");
        end)

    addEventHandler("onClientBrowserDocumentReady", guiGetBrowser(browser),
        function(url)
            showCursor(true, true);
            toggleAllControls(false, true, true);
            profileBrowser = source;
        end)
end
addCommandHandler("profile", startProfileUI, false, false);




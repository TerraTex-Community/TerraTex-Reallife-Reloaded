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

    local browser = guiCreateBrowser(0, 15, 525, 475, true, false, false, profileWindow);
    showCursor(true);


    addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
        function()
            setBrowserAjaxHandler(source, "ajax_profile_close.html", close_profile)
            loadBrowserURL(source, "http://mta/local/UI/Profile.html");
            triggerServerEvent("getProfileData", source);
        end)

    addEventHandler("onClientBrowserDocumentReady", guiGetBrowser(browser),
        function(url)
            showCursor(true, true);
            toggleAllControls(false, true, true);
            profileBrowser = source;
        end)
end
addCommandHandler("profile", startProfileUI, false, false);

function close_profile()
    showCursor(false);
    if isElement(profileWindow) then destroyElement(profileWindow) end
    profileWindow = false;
end

function sendProfileData_func(data)
    executeBrowserJavascript(profileBrowser, "setProfileData('" .. data.email.. "','" .. data.birthday .. "',"..tostring(data.vacation) .. ");");
end
addEvent("sendProfileData", true);
addEventHandler("sendProfileData", getRootElement(), sendProfileData_func);



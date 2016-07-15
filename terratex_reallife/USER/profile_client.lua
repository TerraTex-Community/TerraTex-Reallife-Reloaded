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

    addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
        function()
            setBrowserAjaxHandler(source, "ajax_profile_close.html", close_profile)
            setBrowserAjaxHandler(source, "ajax_profile_passwordchange.html", change_password)
            setBrowserAjaxHandler(source, "ajax_profile_set_vacation.html", urlaubsModus)
            loadBrowserURL(source, "http://mta/local/UI/Profile.html");
        end)

    addEventHandler("onClientBrowserDocumentReady", guiGetBrowser(browser),
        function(url)
            showCursor(true, true);
            toggleAllControls(false, true, true);
            profileBrowser = source;
            triggerServerEvent("getProfileData", getLocalPlayer());
        end)
end
addCommandHandler("profile", startProfileUI, false, false);

function change_password(get, post)
    if (get) then
        if (get.oldPassword and get.newPassword and get.newPasswordWdh) then
            if (get.oldPassword ~= "" and get.newPassword ~= "" and get.newPasswordWdh ~= "") then
                if (get.newPassword == get.newPasswordWdh)then
                    triggerServerEvent("profileChangePassword", getLocalPlayer(), get.oldPassword, get.newPassword);
                else
                    showError(getLocalPlayer(), "Die neuen Passwörter stimmen nicht überein!");
                end
            else
                showError(getLocalPlayer(), "Du hast die Felder nicht vollständig ausgefüllt!");
            end
        else
            showError(getLocalPlayer(), "Du hast die Felder nicht vollständig ausgefüllt!");
        end
    end
end

function cleanPasswordFields_func()
    executeBrowserJavascript(profileBrowser, "$('#oldpassword').val('');" );
    executeBrowserJavascript(profileBrowser, "$('#newpassword').val('');" );
    executeBrowserJavascript(profileBrowser, "$('#newpasswordwdh').val('');" );
end
addEvent("cleanPasswordFields", true);
addEventHandler("cleanPasswordFields", getRootElement(), cleanPasswordFields_func);

function close_profile()
    showCursor(false);
    if isElement(profileWindow) then destroyElement(profileWindow) end
    profileWindow = false;
end

function sendProfileData_func(data)
    local datastring = "setProfileData('" .. data.email.. "','" .. data.birthday .. "',"..tostring(data.vacation) .. ");";
    executeBrowserJavascript(profileBrowser, datastring );
end
addEvent("sendProfileData", true);
addEventHandler("sendProfileData", getRootElement(), sendProfileData_func);

function urlaubsModus()
    triggerServerEvent("setVacationMode", getLocalPlayer())
end



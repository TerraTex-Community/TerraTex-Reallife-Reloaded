--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 07.07.2016
-- Time: 14:29
-- To change this template use File | Settings | File Templates.
--

local loginWindow;
local loginBrowser;

function startLoginUI()

    if (loginWindow) then
        if isElement(loginWindow) then destroyElement(loginWindow) end
        loginWindow = false;
    end

    loginWindow = guiCreateWindow(0, 0, 525, 475, "Login", false)
    table.insert(allGuis, loginWindow);
    setGuiCenter(loginWindow);

    local browser = guiCreateBrowser(0, 15, 525, 475, true, false, false, loginWindow)


    addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
        function()
            setBrowserAjaxHandler(source, "ajax_login_login.html", login)
            loadBrowserURL(source, "http://mta/local/UI/Login.html");
        end)

    addEventHandler("onClientBrowserDocumentReady", guiGetBrowser(browser),
        function(url)
            showCursor(true, true);
            toggleAllControls(false, true, true);
            loginBrowser = source;
            executeBrowserJavascript(source, "$('#supportmail').html('" .. config["supportmail"] .. "');");
        end)
end
addEvent("showLoginGui", true);
addEventHandler("showLoginGui", getRootElement(), startLoginUI);

function disableLoginGui()
    if (isElement(loginWindow)) then
        destroyElement(loginWindow);
    end
    loginWindow = false;
    showCursor(false)
    toggleAllControls(true, true, true)
end
addEvent("hideLoginGui", true)
addEventHandler("hideLoginGui", getRootElement(), disableLoginGui)

local wasLoginSended = false;
function login(get, post)
    get = post;
    if (get) then
        if (get.password) then
            if (not wasLoginSended) then
                wasLoginSended = true;
                setTimer(reloadLoginGui, 1000, 1);

                if (decodeURI(get.password) == "") then
                    showError(getLocalPlayer(), "Du hast kein korrektes Passwort eingegeben!");
                else
                    triggerServerEvent("loginPlayer", getLocalPlayer(), getPlayerName(getLocalPlayer()), decodeURI(get.password));
                end
            end
        end
    end
end

function reloadLoginGui()
    if (loginWindow) then
        wasLoginSended = false;
    end
end

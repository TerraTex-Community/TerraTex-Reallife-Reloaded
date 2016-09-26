--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 07.07.2016
-- Time: 14:55
-- To change this template use File | Settings | File Templates.
--

local registerWindow;
local registerBrowser;

function startRegisterUI()

    if (registerWindow) then
        if isElement(registerWindow) then destroyElement(registerWindow); end
        registerWindow = false;
    end

    registerWindow = guiCreateWindow(0, 0, 800, 600, "Registrieren auf " .. config["communityname"], false);
    table.insert(allGuis, registerWindow);
    setGuiCenter(registerWindow);

    local browser = guiCreateBrowser(0, 15, 800, 600, true, false, false, registerWindow);


    addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
        function()
            setBrowserAjaxHandler(source, "ajax_register_register.html", register);
            loadBrowserURL(source, "http://mta/local/UI/Register.html");
        end)

    addEventHandler("onClientBrowserDocumentReady", guiGetBrowser(browser),
        function(url)
            showCursor(true, true);
            toggleAllControls(false, true, true);
            registerBrowser = source;
        end)
end

addEvent("showRegisterGui", true)
addEventHandler("showRegisterGui", getRootElement(), startRegisterUI)

function disableRegisterGui()
    destroyElement(registerWindow);
    showCursor(false);
    toggleAllControls(true, true, true);
end
addEvent("hideRegisterGui", true)
addEventHandler("hideRegisterGui", getRootElement(), disableRegisterGui)

local hasClickedRegisterGui = false;
function reloadRegisterGUI()
    hasClickedRegisterGui = false
end

function register(get, post)
    get = post;
    if get then
        if (get.password and get.passwordwdh and get.gender and get.birthday and get.email) then
            if(not get.recruiter) then get.recruiter = "" end

            local birthdayParts = string.explode(get.birthday, "-");

            if (not (hasClickedRegisterGui)) then
                if (not (utf_check(decodeURI(get.password))) or not (utf_check(decodeURI(get.email))) or not (utf_check(decodeURI(get.recruiter)))) then
                    showError(getLocalPlayer(), "Sponderzeichen sind nur begrenzt möglich. Du verwendest Sonderzeichen, die nicht möglich sind!")
                else
                    if (get.password == "") then get.password = "a" end
                    if (get.passwordwdh == "") then get.passwordwdh = "z" end

                    if (get.password == get.passwordwdh) then
                        if string.len(get.email) > 0 then
                            if (table.getSize(birthdayParts) == 3) then
                                if ((tonumber(birthdayParts[1]) < 32) and (tonumber(birthdayParts[1]) > 0)) then
                                    if ((tonumber(birthdayParts[2]) < 13) and (tonumber(birthdayParts[2]) > 0)) then
                                        if ((tonumber(birthdayParts[3]) < 2016) and (tonumber(birthdayParts[3]) > 1900)) then
                                            if (decodeURI(get.recruiter) == "") then get.recruiter = "" end
                                            triggerServerEvent("registerPlayer", getLocalPlayer(), getPlayerName(getLocalPlayer()), decodeURI(get.password), decodeURI(get.email),
                                                birthdayParts[1], birthdayParts[2], birthdayParts[3], decodeURI(get.recruiter), decodeURI(get.gender))
                                        else
                                            showError(getLocalPlayer(), "Du hast kein korrektes Geburstdatum eingegeben(3)!")
                                        end
                                    else
                                        showError(getLocalPlayer(), "Du hast kein korrektes Geburstdatum eingegeben(2)!")
                                    end
                                else
                                    showError(getLocalPlayer(), "Du hast kein korrektes Geburstdatum eingegeben (1)!")
                                end
                            else
                                showError(getLocalPlayer(), "Du hast kein korrektes Geburstdatum eingegeben (1)!")
                            end
                        else
                            showError(getLocalPlayer(), "Du hast keine Email angegeben!")
                        end
                    else
                        showError(getLocalPlayer(), "Die Passwoerter stimmen nicht ueberein!")
                    end
                end
                hasClickedRegisterGui = true
                setTimer(reloadRegisterGUI, 1000, 1)
            end
        else
            showError(getLocalPlayer(), "Einige Felder sind nicht correct ausgefüllt!")
        end
    end
end
--
-- Created by IntelliJ IDEA.
-- User: Geramy92
-- Date: 04.07.2016
-- Time: 15:55
-- To change this template use File | Settings | File Templates.
--
local managementWindow;
local managementBrowser;
function showLeaderManagementGUI()
    if (getElementData(getLocalPlayer(), "fraktionsrang") == 6 or getElementData(getLocalPlayer(), "rechte_AllLeader") == 1) then

        if (managementWindow) then
            if isElement(managementWindow) then destroyElement(managementWindow); end
            managementWindow = false;
        else
            managementWindow = guiCreateWindow(0, 0, 800, 600, "Fraktionsmanagement", false);
            table.insert(allGuis, managementWindow);
            setGuiCenter(managementWindow);

            local browser = guiCreateBrowser(10, 10, 800, 600, true, false, false, managementWindow);


            addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
                function()
                    setBrowserAjaxHandler(source, "ajax_faction_management_load_page.html", loadFManagementPage);
                    loadBrowserURL(source, "http://mta/local/UI/Fraktionsmanagement/Main.html");
                end);

            addEventHandler("onClientBrowserDocumentReady", guiGetBrowser(browser),
                function(url)
                    showCursor(true)
                    browserActualizeFields(source)
                    managementBrowser = source;
                end);
        end
    end
end
addCommandHandler("fmanage", showLeaderManagementGUI, false, false)

function loadFManagementPage(get, post)
    if (get) then
        if (get.id) then
            if (get.id == "overview") then
                triggerServerEvent("getFactionOverviewData", getLocalPlayer());
            elseif (get.id == "logout") then
                if isElement(managementWindow) then destroyElement(managementWindow); end
                managementWindow = false;
            end
        end
    end
end

function _renderFraktionsManagementOverviewPage(dataTable)
    local htmlFile = fileOpen("UI/Fraktionsmanagement/_Overview.html", true);

    if htmlFile then
        local html = "";
        while not fileIsEOF(htmlFile) do
            html = html .. fileRead(htmlFile, 500);
        end
        fileClose(htmlFile)

        for theKey, theContent in pairs(dataTable) do
            html = string.gsub(html, "%%" .. theKey .. "%%", theContent)
        end

        html = string.gsub(html, '"', '\\"');
        html = string.gsub(html, '\n', '');
        html = string.gsub(html, '\r', '');

        executeBrowserJavascript(managementBrowser, "setContent(\"" .. html .. "\");");

    else
        outputDebugString("Unable to open \"UI/Fraktionsmanagement/_Overview.html\"")
    end
end

addEvent("sendFactionOverviewData", true)
addEventHandler("sendFactionOverviewData", getRootElement(), _renderFraktionsManagementOverviewPage)
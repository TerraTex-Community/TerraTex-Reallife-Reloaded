--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 12.08.2016
-- Time: 11:40
-- To change this template use File | Settings | File Templates.
--
local policePCData = {
    vehicles = {},
    blitzer = {}
};
local policePCWindow;
local policePCBrowser;
local policePCTimer = {
    refreshPoliceVehicles = false,
}

local function killAllPolicePcTimer()
    for theKey, theTimer in pairs(policePCTimer) do
        if (theTimer and isTimer(theTimer )) then
            killTimer ( theTimer );
            policePCTimer[theKey] = false;
        end
    end
end

function startpolicePCUI()
    if (policePCWindow) then
        if isElement(policePCWindow) then destroyElement(policePCWindow) end
        policePCWindow = false;
        killAllPolicePcTimer();
    else
        policePCWindow = guiCreateWindow(0, 0, 640, 500, "PoliceComputer TerraPoliceOS 2016", false)
        table.insert(allGuis, policePCWindow);
        setGuiCenter(policePCWindow);

        local browser = guiCreateBrowser(0, 15, 640, 500, true, false, false, policePCWindow);

        addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
            function()
                setBrowserAjaxHandler(source, "ajax_policePC_load_page.html", loadPolicePCPage);
                loadBrowserURL(source, "http://mta/local/UI/PolicePC/Main.html");
            end
        )

        addEventHandler ( "onClientBrowserDocumentReady" , guiGetBrowser(browser) ,
            function ( url )
                showCursor(true)
                browserActualizeFields(source)
                policePCBrowser = source;
            end
        )

        killAllPolicePcTimer();
        policePCTimer.refreshPoliceVehicles = setTimer(refreshPoliceVehicles, 1000, 0);
    end
end

addEvent("onShowPolicePC", true);
function onShowPolicePC_func()
    startpolicePCUI();
end
addEventHandler("onShowPolicePC", getRootElement(), onShowPolicePC_func);

function setPolicePcData(type, values)
    policePCData[type] = values;
end

function loadPolicePCPage(get, post)
    if (get) then
        if (get.id) then
            if (get.id == "overview") then
--                triggerServerEvent("getFactionOverviewData", getLocalPlayer());
            elseif (get.id == "logout") then
                if isElement(policePCWindow) then destroyElement(policePCWindow); end
                policePCWindow = false;
            end
        end
    end
end




--
--function _renderFraktionsManagementOverviewPage(dataTable)
--    local htmlFile = fileOpen("UI/Fraktionsmanagement/_Overview.html", true);
--
--    if htmlFile then
--        local html = "";
--        while not fileIsEOF(htmlFile) do
--            html = html .. fileRead(htmlFile, 500);
--        end
--        fileClose(htmlFile)
--
--        for theKey, theContent in pairs(dataTable) do
--            html = string.gsub(html, "%%" .. theKey .. "%%", theContent)
--        end
--
--        html = string.gsub(html, '"', '\\"');
--        html = string.gsub(html, '\n', '');
--        html = string.gsub(html, '\r', '');
--
--        executeBrowserJavascript(managementBrowser, "setContent(\"" .. html .. "\");");
--
--    else
--        outputDebugString("Unable to open \"UI/Fraktionsmanagement/_Overview.html\"")
--    end
--end
--addEvent("sendFactionOverviewData", true);
--addEventHandler("sendFactionOverviewData", getRootElement(), _renderFraktionsManagementOverviewPage);
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
                    setBrowserAjaxHandler(source, "ajax_faction_management_execute_member_function.html", executeFactionManagementFunction);
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
            elseif (get.id == "members") then
                triggerServerEvent("getFactionMemberData", getLocalPlayer());
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
addEvent("sendFactionOverviewData", true);
addEventHandler("sendFactionOverviewData", getRootElement(), _renderFraktionsManagementOverviewPage);

function _renderFraktionsManagementMemberPage(data)
    local htmlFile = fileOpen("UI/Fraktionsmanagement/_Member.html", true);
    local htmlRowFile = fileOpen("UI/Fraktionsmanagement/__Member_Row.html", true);

    if htmlFile and htmlRowFile then
        local html = "";
        local htmlRank = "";
        while not fileIsEOF(htmlFile) do
            htmlRank = htmlRank .. fileRead(htmlFile, 500);
        end
        fileClose(htmlFile)

        local htmlRow = "";
        while not fileIsEOF(htmlRowFile) do
            htmlRow = htmlRow .. fileRead(htmlRowFile, 500);
        end
        fileClose(htmlRowFile)

        local rankId = 6;
        for rankId = 6, 1, -1 do
            local rankData = data[rankId];

            local rankRowHtml = "";
            for theKey, thePlayer in ipairs(rankData.members) do
                local newRow = htmlRow;


                newRow = string.gsub(newRow, "%%nickname%%", thePlayer.Nickname);

                if (thePlayer.AktiveDays < 0) then
                    newRow = string.gsub(newRow, "%%lastLogin%%", "im Urlaubsmodus");
                elseif (thePlayer.AktiveDays > 0) then
                    newRow = string.gsub(newRow, "%%lastLogin%%", "vor " .. thePlayer.AktiveDays .. " Tagen - " .. thePlayer.LastLogin .. " Online");
                elseif (thePlayer.LastLogin == "ist gerade Online") then
                    newRow = string.gsub(newRow, "%%lastLogin%%", "ist gerade Online");
                else
                    newRow = string.gsub(newRow, "%%lastLogin%%", "zuletzt Heute Online");
                end

                rankRowHtml = rankRowHtml .. newRow;
            end

            local newRank = htmlRank;
            newRank = string.gsub(newRank, "%%id%%", rankId);
            newRank = string.gsub(newRank, "%%rank%%", rankData.rankName);
            newRank = string.gsub(newRank, "%%rows%%", rankRowHtml);

            html = html .. newRank
        end

        html = string.gsub(html, "%%rang1name%%", data[1].rankName);
        html = string.gsub(html, "%%rang2name%%", data[2].rankName);
        html = string.gsub(html, "%%rang3name%%", data[3].rankName);
        html = string.gsub(html, "%%rang4name%%", data[4].rankName);
        html = string.gsub(html, "%%rang5name%%", data[5].rankName);
        html = string.gsub(html, "%%rang6name%%", data[6].rankName);

        html = string.gsub(html, '"', '\\"');
        html = string.gsub(html, '\n', '');
        html = string.gsub(html, '\r', '');

        executeBrowserJavascript(managementBrowser, "setContent(\"" .. html .. "\");");

    end
end
addEvent("sendFactionMemberData", true);
addEventHandler("sendFactionMemberData", getRootElement(), _renderFraktionsManagementMemberPage)

function executeFactionManagementFunction(get)
    if (get) then
        if (get.func) then
            if (get.func == "kick") then
                if (get.nickname) then
                    triggerServerEvent("factionManagementKickMember", getLocalPlayer(), get.nickname )
                end
            elseif(get.func == "giverank") then
                if (get.nickname and get.rank) then
                    triggerServerEvent("factionManagementGiveRankMember", getLocalPlayer(), get.nickname, get.rank )
                end
            end
        end
    end
end

function factionManagementMemberKick_func(nickname)
    executeBrowserJavascript(managementBrowser, "$(\"tr[data-nickname='" .. nickname .. "']\").remove();");
end
addEvent("factionManagementMemberKick", true);
addEventHandler("factionManagementMemberKick", getRootElement(), factionManagementMemberKick_func)

function factionManagementMemberGiveRank_func()
    triggerServerEvent("getFactionMemberData", getLocalPlayer());
end
addEvent("factionManagementMemberGiveRank", true);
addEventHandler("factionManagementMemberGiveRank", getRootElement(), factionManagementMemberGiveRank_func)

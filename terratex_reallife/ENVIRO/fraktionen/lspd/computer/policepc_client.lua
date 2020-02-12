--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 12.08.2016
-- Time: 11:40
-- To change this template use File | Settings | File Templates.
--
local policePCData = {
    vehicles = {},
    removeVehicles = {},
    blitzer = {},
    lastJails = {},
    activePlayer = false,
    lastActivePlayerCrimeLevel = 0
};
local policePCWindow;
local policePCBrowser;
local policePCTimer = {
    general = false,
    refreshPoliceVehicles = false,
}

local policePCActivePage = "overview";

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
--        if isElement(policePCWindow) then destroyElement(policePCWindow) end
--        policePCWindow = false;
--        killAllPolicePcTimer();
    else
        policePCWindow = guiCreateWindow(0, 0, 800, 600, "PoliceComputer TerraPoliceOS 2016", false)
        table.insert(allGuis, policePCWindow);
        setGuiCenter(policePCWindow);

        local browser = guiCreateBrowser(0, 15, 800, 600, true, false, false, policePCWindow);

        addEventHandler("onClientBrowserCreated", guiGetBrowser(browser),
            function()
                policePCBrowser = source;
                setBrowserAjaxHandler(source, "ajax_policePC_load_page.html", loadPolicePCPage);
                setBrowserAjaxHandler(source, "ajax_policePC_dBlitzer.html", policePCdBlitzer);
                setBrowserAjaxHandler(source, "ajax_policePC_akte.html", policePCAkte);
                loadBrowserURL(source, "http://mta/local/UI/PolicePC/Main.html");
            end
        )

        addEventHandler ( "onClientBrowserDocumentReady" , guiGetBrowser(browser) ,
            function ( url )
                showCursor(true)
                policePCBrowser = source;
--                setDevelopmentMode (true, true)
--                toggleBrowserDevTools ( policePCBrowser, true )
            end
        )

        killAllPolicePcTimer();
        policePCTimer.refreshPoliceVehicles = setTimer(refreshPoliceVehicles, 1000, 0);
        policePCTimer.general = setTimer(actualizePolicePCPage, 1000, 0);
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
            policePCData.activePlayer = false;
            policePCData.lastActivePlayerCrimeLevel = 0;
            if (get.id == "overview") then
                local html = HTML.getFile("UI/PolicePC/_Vehicles.html", true);
                if html then
                    html = HTML.prepare(html);
                    executeBrowserJavascript(policePCBrowser, "setContent(\"" .. html .. "\");");
                else
                    outputDebugString("Unable to open \"UI/PolicePC/_Vehicles.html\"")
                end
            elseif (get.id == "jail") then
                local html = HTML.getFile("UI/PolicePC/_JailList.html", true);
                if html then
                    html = HTML.prepare(html);
                    executeBrowserJavascript(policePCBrowser, "setContent(\"" .. html .. "\");");
                    actualizePolicePCPage();
                else
                    outputDebugString("Unable to open \"UI/PolicePC/_JailList.html\"")
                end
            elseif (get.id == "suspects") then
                local html = HTML.getFile("UI/PolicePC/_Suspects.html", true);
                if html then
                    html = HTML.prepare(html);
                    executeBrowserJavascript(policePCBrowser, "setContent(\"" .. html .. "\");");
                    actualizePolicePCPage();
                else
                    outputDebugString("Unable to open \"UI/PolicePC/_Suspects.html\"")
                end
            elseif (get.id == "codelist") then
                local html = HTML.getFile("UI/PolicePC/_CrimeList.html", true);
                if html then
                    html = HTML.prepare(html);
                    executeBrowserJavascript(policePCBrowser, "setContent(\"" .. html .. "\");");
                    loadCrimesToPolicePCPage();
                else
                    outputDebugString("Unable to open \"UI/PolicePC/_Suspects.html\"")
                end
            elseif (get.id == "PlayerCrimeList") then
                local html = HTML.getFile("UI/PolicePC/_PlayerCrimeList.html", true);
                if html then
                    html = HTML.prepare(html, {
                        playerName = get.nickname,
                        stvo = getElementData(getPlayerFromName(get.nickname), "stvo")
                    });
                    executeBrowserJavascript(policePCBrowser, "setContent(\"" .. html .. "\");");
                    loadCrimesToPolicePCPage(true);
                    policePCData.activePlayer = getPlayerFromName(get.nickname);
                else
                    outputDebugString("Unable to open \"UI/PolicePC/_PlayerCrimeList.html\"")
                end
            elseif (get.id == "logout") then
                if isElement(policePCWindow) then destroyElement(policePCWindow); end
                policePCWindow = false;
                killAllPolicePcTimer();
            end

            policePCActivePage = get.id;

        end
    end
end

addEvent("renderPlayerCrimes", true);
function renderPlayerCrimes_func(crimesList)
    if (policePCActivePage == "PlayerCrimeList") then
        executeBrowserJavascript(policePCBrowser, "startReloadPlayerCrimeList();");

        local crimeLevel = tonumber(getElementData(policePCData.activePlayer, "crimeLevel"));
        policePCData.lastActivePlayerCrimeLevel = crimeLevel;

        local time = getRealTime();
        local unixTimeStamp = time.timestamp;

        for theKey, theCrime in ipairs(crimesList) do
            local isDeleteAble = (tonumber(theCrime.UNIX_TIMESTAMP) + (24 * 60 * 60)) >= unixTimeStamp;
            local js = "addCrimeToPlayerCrimeList(";
            js = js .. theCrime.ID;
            js = js .. "," .. theCrime.CrimeID;
            js = js .. ", \"" .. theCrime.CategorieName ..  " - " .. theCrime.Name .. "\"";
            js = js .. ", \"" .. theCrime.AdditionalReason .. "\"";
            js = js .. ", \"" .. theCrime.Timestamp .. "\"";

            local giveBy = theCrime.ReporterUser;
            if (not giveBy or tostring(giveBy) == "") then
                giveBy = theCrime.ReporterDisplay;
            end

            js = js .. ", \"" .. giveBy .. "\"";

            if (isDeleteAble) then
                js = js .. ", true);";
            else
                js = js .. ", false);";
            end

            executeBrowserJavascript(policePCBrowser, js);
        end
        executeBrowserJavascript(policePCBrowser, "finishPlayerCrimeList();");
    end
end
addEventHandler("renderPlayerCrimes", getRootElement(), renderPlayerCrimes_func)


function loadPlayerCrimeList()
    executeBrowserJavascript(policePCBrowser, "startReloadPlayerCrimeList();");
    triggerServerEvent("getPlayerCrimesForClient", getLocalPlayer(), policePCData.activePlayer);
end

function loadCrimesToPolicePCPage(addColumn)
    local syncElement = getElementByID("CrimeSystem");
    local items = getElementData(syncElement, "CrimesByCategorieIdById");

    for categorieID, categorieData in pairs(items) do
        if (categorieData.hidden == 0) then
            executeBrowserJavascript(policePCBrowser, "createCategory(" .. categorieID .. ", \"" .. categorieData.name .. "\");");

            for crimeID, crimeData in pairs(categorieData.crimes) do
                if not addColumn then
                    executeBrowserJavascript(policePCBrowser, "createCrime(" .. crimeID .. ", " .. categorieID .. ", \"" .. crimeData.Name .. "\");");
                else
                    executeBrowserJavascript(policePCBrowser, "createCrime(" .. crimeID .. ", " .. categorieID .. ", \"" .. crimeData.Name .. "\", true);");
                end
            end
        end
    end
end

function actualizePolicePCPage()
    if (policePCActivePage == "overview") then

        ---show cars
        local carHtml = HTML.getFile("UI/PolicePC/__carEntry.html", true);
        if (carHtml) then
            for theKey, theVehicle in pairs(policePCData.vehicles) do

                local htmlCopy = carHtml;
                local posX, posY, posZ = unpack(theVehicle.position);

                -- convert X and Y to Percentage
                posX = (posX + 3000) / 60;
                posY = (-(posY - 3000)) / 60;


                local cops = table.concat(theVehicle.cops, ", ");

                htmlCopy = HTML.prepare(htmlCopy, {carId = theVehicle.id, top = posY, left = posX, cops = cops});

                local js = "setCar(" .. theVehicle.id .. ",\"" ..  htmlCopy .. "\",";
                js = js .. posY .. "," .. posX.. ");";

                executeBrowserJavascript(policePCBrowser, js);
            end

            for theKey, theVehicle in pairs(policePCData.removeVehicles) do
                executeBrowserJavascript(policePCBrowser, "removeCar(\"" .. theVehicle.id .. "\");");
            end

        end

        ---show blitzer
        local blitzerHtml = HTML.getFile("UI/PolicePC/__blitzerEntry.html", true);
        if (blitzerHtml) then

            for theKey, blitzerElement in ipairs(getElementsByType("blitzer")) do
                local htmlCopy = blitzerHtml;
                if (getElementData(blitzerElement, "state")) then
                    local posX, posY, posZ = getElementPosition(getElementData(blitzerElement, "object"));
                    posX = (posX + 3000) / 60;
                    posY = (-(posY - 3000)) / 60;

                    htmlCopy = HTML.prepare(htmlCopy, {top = posY, left = posX, blitzerId = getElementID(blitzerElement)});

                    local js = "setBlitzer(\"" .. getElementID(blitzerElement) .. "\",\"" ..  htmlCopy .. "\",";
                    js = js .. posY .. "," .. posX ..");"

                    executeBrowserJavascript(policePCBrowser, js);
                else
                    executeBrowserJavascript(policePCBrowser, "removeBlitzer(\"" .. getElementID(blitzerElement) .. "\");");
                end
            end
        end
    elseif (policePCActivePage == "jail") then

        for theKey, thePlayer in ipairs(policePCData.lastJails) do
            if (not getPlayerFromName(thePlayer)) then
                executeBrowserJavascript(policePCBrowser, "removeJailPlayer(\"" .. thePlayer .. "\");");
            end
        end
        policePCData.lastJails = {};

        for theKey, thePlayer in ipairs(getElementsByType("player")) do
            if (getElementData(thePlayer, "knastzeit")) then
                if (getElementData(thePlayer, "knastzeit") > 0) then
                    local time = getElementData(thePlayer, "knastzeit");
                    local totalTime = getElementData(thePlayer, "lastknastzeit");
                    local jail = CrimeSystem._jailNames[CrimeSystem._jailIdToText[getElementData(thePlayer, "alkaknast")]];

                    table.insert(policePCData.lastJails, getPlayerName(thePlayer));
                    executeBrowserJavascript(policePCBrowser, "setJailPlayer(\"" .. getPlayerName(thePlayer) .. "\", \"" .. jail .."\", " .. time ..", " .. totalTime .." );");

                    if (getElementData(thePlayer, "mussAlka") == 1) then
                        executeBrowserJavascript(policePCBrowser, "setJailPlayerAlka(\"" .. getPlayerName(thePlayer) .. "\");");
                    end
                else
                    executeBrowserJavascript(policePCBrowser, "removeJailPlayer(\"" .. getPlayerName(thePlayer) .. "\");");
                end
            else
                executeBrowserJavascript(policePCBrowser, "removeJailPlayer(\"" .. getPlayerName(thePlayer) .. "\");");
            end
        end
    elseif (policePCActivePage == "suspects") then
        for theKey, thePlayer in ipairs(getElementsByType("player")) do
            if (getElementData(thePlayer, "stvo") and getElementData(thePlayer, "crimeLevel")) then

                local crimeLevel = tonumber(getElementData(thePlayer, "crimeLevel"));

                local crimeState = "-";
                if (crimeLevel > 0) then
                    for theKey, theState in ipairs(CrimeSystem._criminalStates) do
                        if (theState.minPercentage <= crimeLevel) then
                            crimeState = theState.name;
                        end
                    end
                end

                local stvo = getElementData(thePlayer, "stvo");

                executeBrowserJavascript(policePCBrowser, "setSuspect(\"" .. getPlayerName(thePlayer) .. "\", \"" .. crimeState .."\", " .. stvo ..");");

                if (getElementData(thePlayer, "mussAlka") == 1) then
                    executeBrowserJavascript(policePCBrowser, "setSuspectAlka(\"" .. getPlayerName(thePlayer) .. "\");");
                end
            end
        end
    elseif (policePCActivePage == "PlayerCrimeList") then
        local stvo = getElementData(policePCData.activePlayer, "stvo");
        executeBrowserJavascript(policePCBrowser, "setStVO(".. stvo ..");");

        local crimeLevel = tonumber(getElementData(policePCData.activePlayer, "crimeLevel"));

        if (crimeLevel ~= policePCData.lastActivePlayerCrimeLevel) then
            loadPlayerCrimeList();
        end
    end
end

addEvent("policePCUpdateFile", true);
function policePCUpdateFile_func()
    if (policePCWindow and policePCActivePage == "PlayerCrimeList" and source == policePCData.activePlayer) then
        loadPlayerCrimeList();
    end
end
addEventHandler("policePCUpdateFile", getRootElement(), policePCUpdateFile_func)

function removeDisconnectedPlayer()
    if (policePCActivePage == "suspects") then
        executeBrowserJavascript(policePCBrowser, "removeSuspect(\"" .. getPlayerName(source) .. "\");");
    end
end
addEventHandler( "onClientPlayerQuit", getRootElement(), removeDisconnectedPlayer )

function policePCdBlitzer(get)
    if (get) then
        if (get.id) then
            triggerServerEvent("executeServerCommandHandler", getLocalPlayer(), "dblitzer", get.id);
        else
            showError(getLocalPlayer(), "Bitte gebe eine Blitzer ID ein!");
        end
    end
end

function policePCAkte(get)
    if (get) then
        if (get.todo) then
            if (get.todo == "stvo") then
                local stvos = get.count;
                local reason = decodeURI(get.reason);
                triggerServerEvent("executeServerCommandHandler", getLocalPlayer(), "stvo", getPlayerName(policePCData.activePlayer) .. " " .. stvos .. " " .. reason);
            elseif (get.todo == "crime") then
                local crime = decodeURI(get.crime);
                local addreason = decodeURI(get.addreason);
                triggerServerEvent("executeServerCommandHandler", getLocalPlayer(), "su", getPlayerName(policePCData.activePlayer).. " " .. crime.. " " .. addreason);
            elseif (get.todo == "deletecrime") then
                triggerServerEvent("deleteCrime", getLocalPlayer(), policePCData.activePlayer, get.crimeId);
            end
        end
    end
end


local showPlayerSoS = {}
local markerId = 0

function processPlayerSoSMarker(player)
    markerId = markerId + 1
    table.insert(showPlayerSoS, {
        markerId = markerId,
        playerElement = player,
        showUntil = (getRealTime().timestamp + 30)
    });
end
addEvent("showSOSOnPolicePC", true)
addEventHandler("showSOSOnPolicePC", getRootElement(), processPlayerSoSMarker)

function renderMarker()
    if (isElement(policePCBrowser) and policePCActivePage == "overview") then
        local removeIds = {}
        for theId, theMarker in ipairs(showPlayerSoS) do
            if (theMarker.showUntil < getRealTime().timestamp or not isElement(theMarker.playerElement)) then
                executeBrowserJavascript(policePCBrowser, "removeSOSSignal(" .. theMarker.markerId .. ");");
                table.insert(removeIds, theId);
            else
                local posX, posY, posZ = getElementPosition(theMarker.playerElement);
                posX = (posX + 3000) / 60;
                posY = (-(posY - 3000)) / 60;

                local js = "updateSosSignal(".. theMarker.markerId .. "," .. posY .. "," .. posX ..");"

                executeBrowserJavascript(policePCBrowser, js);
            end
        end

        for id, theId in ipairs(removeIds) do
            table.remove(showPlayerSoS, theId);
        end

    end
end
addEventHandler("onClientRender", getRootElement(), renderMarker)


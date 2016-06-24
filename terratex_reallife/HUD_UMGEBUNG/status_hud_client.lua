--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 24.06.2016
-- Time: 17:44
-- To change this template use File | Settings | File Templates.
--
local showHud = false;
local browser = false;
local moneyChanged = true;
local moneyValue = 0;
local lastHour = -1;
local lastMinutes = -1;
local lastGold = -1;
local lastWeapon = -1;
local lastOxygenLevel = -1;
local inWater = false;

local lastFood = -1;
local lastHealth = -1;
local lastArmor = -1;
local lastWanted = -1;

local lastAmmoInClip = -1;
local lastTotalAmmo = -1;

function showHud_func(showHudBool)
    showHud = showHudBool;
end
addEvent("showHud", true)
addEventHandler("showHud", getRootElement(), showHud_func)


function createHud()
    setPlayerHudComponentVisible ( "ammo", false);
    setPlayerHudComponentVisible ( "armour", false);
    setPlayerHudComponentVisible ( "breath", false);
    setPlayerHudComponentVisible ( "clock", false);
    setPlayerHudComponentVisible ( "health", false);
    setPlayerHudComponentVisible ( "money", false);
    setPlayerHudComponentVisible ( "weapon", false);
    setPlayerHudComponentVisible ( "wanted", false);

    local screenWidth, screenHeight = guiGetScreenSize();

    browser = createBrowser(550, 700, true, true);
    --setDevelopmentMode(true, true);
    --toggleBrowserDevTools ( browser, true)

    addEventHandler("onClientBrowserCreated", browser,
        function()
            loadBrowserURL(source, "http://mta/local/UI/Hud.html");
            addEventHandler("onClientRender", root, hud_render)
        end
    )

end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), createHud)

function hud_render()
    if (showHud and not(isPlayerMapVisible ()) and not(isPedDead (getLocalPlayer()))) then
        local screenWidth, screenHeight = guiGetScreenSize();
        if (not isBrowserLoading ( browser )) then
            if (moneyChanged) then
                executeBrowserJavascript ( browser, "setMoney(" .. moneyValue .. ");");
                moneyChanged = false;
            end

            local hours, minutes = getTime();
            if (lastHour ~= hours or minutes ~= lastMinutes) then
                executeBrowserJavascript( browser, "setClock(" .. hours .."," .. minutes ..");");
                lastHour = hours;
                lastMinutes = minutes;
            end

            if (tonumber(getElementData(getLocalPlayer(), "Gold")) ~= lastGold) then
                executeBrowserJavascript( browser, "setGold(" .. tonumber(getElementData(getLocalPlayer(), "Gold")) ..");");
                lastGold = tonumber(getElementData(getLocalPlayer(), "Gold"));
            end


            local weaponChanged = false;
            if (getPedWeapon ( getLocalPlayer() ) ~= lastWeapon) then
                executeBrowserJavascript( browser, "setWeapon(" .. getPedWeapon ( getLocalPlayer() ) .. ");");
                lastWeapon = getPedWeapon ( getLocalPlayer() );
                weaponChanged = true;
            end

            local ammoInClip = getPedAmmoInClip ( getLocalPlayer() );
            local totalAmmo = getPedTotalAmmo ( getLocalPlayer());

            if (weaponChanged or ammoInClip~=lastAmmoInClip or totalAmmo~=lastTotalAmmo) then
                local newString = ammoInClip .. "/"..(totalAmmo - ammoInClip);
                if (getPedWeapon ( getLocalPlayer() ) < 16 or getPedWeapon ( getLocalPlayer()) == 12 or getPedWeapon ( getLocalPlayer()) > 43)then
                    newString = "";
                elseif (getWeaponProperty ( getPedWeapon (getLocalPlayer()), "pro", "maximum_clip_ammo" ) == 1) then
                    newString = totalAmmo;
                end

                executeBrowserJavascript( browser, "setAmmoString('" .. newString .. "');");

                lastAmmoInClip = ammoInClip;
                lastTotalAmmo = totalAmmo;
            end

            if (isElementInWater(getLocalPlayer()) ~= inWater or lastOxygenLevel ~= getPedOxygenLevel( getLocalPlayer() )) then
                executeBrowserJavascript( browser, "setStatus('oxygen', " .. (getPedOxygenLevel( getLocalPlayer() ) / 10) .. ");");
                executeBrowserJavascript( browser, "setIconHidden('oxygen', " .. tostring(not isElementInWater(getLocalPlayer())) .. ");");
                lastOxygenLevel = getPedOxygenLevel ( getLocalPlayer() )
                inWater = isElementInWater(getLocalPlayer())
            end

            if (getPedArmor(getLocalPlayer()) ~= lastArmor) then
                executeBrowserJavascript( browser, "setStatus('armor', " .. getPedArmor(getLocalPlayer()) .. ");");
                lastArmor = getPedArmor(getLocalPlayer());
            end

            if (getElementHealth(getLocalPlayer()) ~= lastHealth) then
                executeBrowserJavascript( browser, "setStatus('health', " .. getElementHealth(getLocalPlayer()) .. ");");
                lastHealth = getElementHealth(getLocalPlayer());
            end

            if (tonumber(getElementData(getLocalPlayer(), "wanteds")) ~= lastWanted) then
                local percent = tonumber(getElementData(getLocalPlayer(), "wanteds")) / 6 * 100;
                executeBrowserJavascript( browser, "setStatus('wanteds', " .. percent .. ");");
                lastWanted = tonumber(getElementData(getLocalPlayer(), "wanteds"));
            end

            if (getFood() ~= lastFood) then
                executeBrowserJavascript( browser, "setStatus('food', " .. getFood() .. ");");
                lastFood = getFood();
            end
        end
        dxDrawImage(screenWidth - 550, 0, 550, 700, browser, 0, 0, 0, tocolor(255,255,255,255), true);
    end
end

function setHudNewMoney(value)
    moneyChanged = true;
    moneyValue = value;
end
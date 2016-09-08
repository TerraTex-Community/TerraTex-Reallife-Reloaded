--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 07.09.2016
-- Time: 15:32
-- To change this template use File | Settings | File Templates.
--

function onPlayerDisconnect(quitType, reason, responsibleElement)
    if (isPlayerLoggedIn(source)) then
        -- GMX and ShutDown -> Save Weapons -> all Other Kicks delete them
        local position = pack(getElementPosition(source));
        local rotation = pack(getElementRotation(source));
        local int = getElementInterior(source);
        local dim = getElementDimension(source);
        local hospitalTime = getElementData(source, "todezeit");
        local duty = vioGetElementData(source, "isMedicDuty") or vioGetElementData(source, "isCopDuty") or vioGetElementData(source, "taxi_duty");
        if (duty) then duty = 1; else duty = 0; end
        local weapons = getPlayerWeapons(source);

        -- for HudStats:
        local HudStats = {
            Armor = getPedArmor(source),
            Health = getElementHealth(source),
            Food = getElementData(source, "lastFood")
        };

        -- AdditionalData for interiors -> Which Interiors are existing???
        local AdditionalData = {
            inBurgerShot = vioGetElementData(source, "inBurgerShot"),
            inclucknbell = vioGetElementData(source, "inclucknbell"),
            in247bell = vioGetElementData(source, "in247bell"),
            inpizzastack = vioGetElementData(source, "inpizzastack"),
            insexbell = vioGetElementData(source, "insexbell"),
            inarena = vioGetElementData(source, "inArena"),
            iniraumshop = vioGetElementData(source, "inIraumShop");
        };

        MySql.helper.update("user_offline_data", {
            Position = toJSON(position),
            Rotation = toJSON(rotation),
            Interior = int,
            Dimension = dim,
            AdditionalData = toJSON(AdditionalData),
            Weapons = toJSON(weapons),
            HudStats = toJSON(HudStats),
            DutyState = duty,
            HostpitalTime = hospitalTime,
            LastDisconnect = getRealTime().timestamp,
            WasSavedBefore = 1
        }, {
            Nickname = getPlayerName(source)
        });
    end
end
addEventHandler("onPlayerQuit", getRootElement(), onPlayerDisconnect)


local frakSpawnInZiviSkin = {1, 4, 5, 9, 10};
function spawnPlayerOnServerConnect(thePlayer)
    local playerName = getPlayerName(thePlayer);
    local result = MySql.helper.getSync("user_offline_data", "*", {Nickname = playerName});
    local offlineData = result[1];

    if (tonumber(offlineData.WasSavedBefore) == 1) then
        local position = fromJSON(offlineData.Position);
        local rotation = fromJSON(offlineData.Rotation);
        local interior = tonumber(offlineData.Interior);
        local dimension = tonumber(offlineData.Interior);
        local additionalData = fromJSON(offlineData.AdditionalData);

        local skin = vioGetElementData(thePlayer, "skinid");
        if (vioGetElementData(thePlayer, "fraktion") > 1 and not table.hasValue(frakSpawnInZiviSkin, vioGetElementData(thePlayer, "fraktion"))) then
            skin = vioGetElementData(thePlayer, "FrakSkin");
        end

        if additionalData.inarena then
            position = {2745.8544921875, -1837.2998046875, 10.328806877136};
            rotation = {0, 0, 154.12683105469};
            interior = 0;
            dimension = 0;
        elseif additionalData.iniraumshop then
            interior = 0;
            dimension = 0;
            position = {967.048828125, 2153.7392578125, 10.8203125};
            rotation = {0, 0, 0};
        end

        spawnPlayer(thePlayer, position[1], position[2], position[3], rotation[3], skin, interior, dimension, team[vioGetElementData(thePlayer, "fraktion")]);

        local timestamp = getRealTime().timestamp;

        if (timestamp - tonumber(offlineData.LastDisconnect) < (2 * 60 * 60)) then
            if (tonumber(offlineData.DutyState) == 1) then
                if (isBeamter(thePlayer)) then
                    vioSetElementData(thePlayer, "isCopDuty", true);
                elseif (vioGetElementData(thePlayer, "fraktion") == 10) then
                    vioSetElementData(thePlayer, "isMedicDuty", true);
                elseif (vioGetElementData(thePlayer, "fraktion") == 4) then
                    vioSetElementData(thePlayer, "taxi_duty", true);
                end

                setElementModel(thePlayer, vioGetElementData(thePlayer, "FrakSkin"));
            end
        end

        for theKey, theValue in pairs(additionalData) do
            if theKey ~= "inarena" and theKey ~= "iniraumshop" then
                vioSetElementData(thePlayer, theKey, theValue);
            end
        end

        local hudStats = fromJSON(offlineData.HudStats);
        if (tonumber(hudStats.Health) > 0) then
            setElementHealth(thePlayer, tonumber(hudStats.Health))
        end
        if (tonumber(hudStats.Armor) > 0) then
            setPedArmor(thePlayer, tonumber(hudStats.Health))
        end
        if (tonumber(hudStats.Food) > 0) then
            triggerClientEvent(thePlayer, "setFoodLvl", thePlayer, tonumber(hudStats.Food));
        end

        for theWeaponId, theAmmo in pairs(fromJSON(offlineData.Weapons)) do
            giveWeapon(thePlayer, theWeaponId, theAmmo);
        end

        if (tonumber(offlineData.HostpitalTime) > 0) then
            vioSetElementData(thePlayer, "overwriteDeathTime", tonumber(offlineData.HostpitalTime));
            killPed(thePlayer);
        end
    else
        if (vioGetElementData(thePlayer, "fraktion") > 1 and vioGetElementData(thePlayer, "fraktion") ~= 5) then
            setPlayerSpawn(thePlayer, vioGetElementData(thePlayer, "spawnplace"), vioGetElementData(thePlayer, "FrakSkin"), vioGetElementData(thePlayer, "fraktion"), 113)
        else
            setPlayerSpawn(thePlayer, vioGetElementData(thePlayer, "spawnplace"), vioGetElementData(thePlayer, "skinid"), vioGetElementData(thePlayer, "fraktion"), 113)
        end
    end

    MySql.helper.update("user_offline_data", {
        LastDisconnect = getRealTime().timestamp,
        WasSavedBefore = 0
    }, {
        Nickname = getPlayerName(source)
    });
end
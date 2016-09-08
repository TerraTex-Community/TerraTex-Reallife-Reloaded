--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 07.09.2016
-- Time: 14:37
-- To change this template use File | Settings | File Templates.
--

local frakGetRearmInsteadOfSpawnWeapons = { 7 }

local frakSpawnWeapons = {
    -- News
    [3] = {
        [43] = 9999
    },
    -- Taxi
    [4] = {
        [41] = 2000
    },
    -- Medics
    [10] = {
        [41] = 2000
    }
};

local frakRearmWeapons = {
    -- SAPD
    [1] = {
        [1] = { [3] = 1, [22] = 500},
        [2] = { [3] = 1, [22] = 500, [29] = 950},
        [3] = { [3] = 1, [24] = 250, [29] = 1350},
        [4] = { [3] = 1, [24] = 250, [29] = 1350, [31] = 750},
        [5] = { [3] = 1, [24] = 250, [29] = 1500, [31] = 1500},
        [6] = { [3] = 1, [24] = 250, [29] = 1500, [31] = 1500, [34] = 50},
    },
    -- Grove
    [2] = {
        [1] = { [5] = 1, [23] = 100, [25] = 10, [29] = 100},
        [2] = { [5] = 1, [23] = 150, [25] = 10, [29] = 350, [30] = 150},
        [3] = { [5] = 1, [23] = 250, [25] = 10, [29] = 550, [30] = 750},
        [4] = { [5] = 1, [24] = 150, [25] = 10, [29] = 1500, [30] = 1500},
        [5] = { [5] = 1, [24] = 150, [25] = 10, [29] = 1500, [30] = 1500},
        [6] = { [5] = 1, [24] = 150, [25] = 10, [29] = 1500, [30] = 1500, [34] = 20},
    },
    -- SEK
    [5] = {
        [1] = { [3] = 1, [23] = 100, [25] = 10, [29] = 800, [31] = 250},
        [2] = { [3] = 1, [23] = 150, [25] = 10, [29] = 800, [31] = 250},
        [3] = { [3] = 1, [24] = 100, [25] = 10, [29] = 800, [31] = 800},
        [4] = { [3] = 1, [24] = 150, [25] = 10, [29] = 800, [31] = 1000},
        [5] = { [3] = 1, [24] = 150, [25] = 10, [29] = 1500, [31] = 1500},
        [6] = { [3] = 1, [24] = 150, [25] = 10, [29] = 1500, [31] = 1500, [34] = 20},
    },
    -- NAME
    [7] = {
        [1] = { [3] = 1, [24] = 100, [29] = 250, [31] = 800},
        [2] = { [3] = 1, [24] = 100, [29] = 250, [31] = 1000},
        [3] = { [3] = 1, [24] = 150, [29] = 550, [31] = 1200},
        [4] = { [3] = 1, [24] = 150, [29] = 100, [31] = 1500},
        [5] = { [3] = 1, [24] = 150, [29] = 100, [31] = 1500},
        [6] = { [3] = 1, [24] = 150, [29] = 1500, [31] = 1500, [34] = 20},
    }
};
-- LVPD = LSPD
frakRearmWeapons[9] = frakRearmWeapons[1];
-- BÖSE FRAKTIONEN
frakRearmWeapons[6] = frakRearmWeapons[2];
frakRearmWeapons[11] = frakRearmWeapons[2];
frakRearmWeapons[12] = frakRearmWeapons[2];

function setPlayerRearmWeapons(thePlayer)
    local fraktion = vioGetElementData(thePlayer, "fraktion");
    local rang = vioGetElementData(thePlayer, "fraktionsrang");

    if (frakRearmWeapons[fraktion]) then
        if (frakRearmWeapons[fraktion][rang]) then
            for theWeaponId, ammo in pairs (frakRearmWeapons[fraktion][rang]) do
                giveWeapon(thePlayer, theWeaponId, ammo)
            end
        end
    end
end

function setPlayerSpawnWeapons(thePlayer)
    local fraktion = vioGetElementData(thePlayer, "fraktion");
    local rang = vioGetElementData(thePlayer, "fraktionsrang");

    if (table.hasValue(frakGetRearmInsteadOfSpawnWeapons, fraktion)) then
        setPlayerRearmWeapons(thePlayer);
    else
        if (frakSpawnWeapons[fraktion]) then
            for theWeaponId, ammo in pairs (frakSpawnWeapons[fraktion]) do
                giveWeapon(thePlayer, theWeaponId, ammo)
            end
        end
    end
end

function setPlayerAusrustung()
    if (checkMunKistenDistance(source)) then

        local fraktion = vioGetElementData(source, "fraktion");
        if (frakmun[fraktion]) then
            if (2000 < frakmun[fraktion]) then
                frakmun[fraktion] = frakmun[fraktion] - 2000
                frakdepot_log(fraktion, 3, -2000, "Spawn-" .. getPlayerName(source))
                outputChatBox("Standardwaffenpaket für 2000 Munition erhalten!", source, 0, 255, 0);
            else
                outputChatBox("Deine Fraktion hat keine Munition mehr!", source, 0, 255, 0);
                return;
            end
        end
    end

    setPedArmor(source, 100)
    setPlayerRearmWeapons(source)
end
addEvent("giveMeStandardAusrustung", true)
addEventHandler("giveMeStandardAusrustung", getRootElement(), setPlayerAusrustung)
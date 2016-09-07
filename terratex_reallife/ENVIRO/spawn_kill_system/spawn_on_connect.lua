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
            LastDisconnect = getRealTime().time,
            WasSavedBefore = 1
        }, {
            Nickname = getPlayerName(source)
        });
    end
end
addEventHandler("onPlayerQuit", getRootElement(), onPlayerDisconnect)
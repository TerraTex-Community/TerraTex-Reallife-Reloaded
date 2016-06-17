ruhezonen = {}

function createAndLoadRuheZonen()
    ruhezonen = {};
    local result = MySql.helper.getSync("objects_restareas", "*");
    for theKey, dasatz in ipairs(result) do
        local area = createRadarArea(dasatz.leftX, dasatz.buttonY, dasatz.sizeX, dasatz.sizeY, 0, 200, 0, 150, getRootElement())
        ruhezonen[dasatz.ID] = area
    end
end
addEventHandler("onResourceStart", getResourceRootElement(getThisResource()), createAndLoadRuheZonen)

function isInRuheZone(thePlayer)
    local x, y, z = getElementPosition(thePlayer)
    for theKey, theArea in pairs(ruhezonen) do
        if (isInsideRadarArea(theArea, x, y)) then
            return true
        end
    end
    return false
end

--- [[ RUHEZONEN ADMIN COMMANDS ]]

function setRZoneCorner_func(thePlayer, cmd, corner)
    if not corner then
        showError(thePlayer, "Spezify Corner with 1 or 2 (/setrzonecorner 1|2)");
    end
    if corner ~= "1" and corner ~= "2" then
        showError(thePlayer, "Spezify Corner with 1 or 2 (/setrzonecorner 1|2)");
    end

    if (isAdminLevel(thePlayer, 3)) then
        local posX, posY, posZ = getElementPosition(thePlayer)
        local posXString = "posX" .. corner;
        local posYString = "posY" .. corner;

        outputChatBox("Position saved!", thePlayer);

        vioSetElementData(thePlayer, posXString, posX);
        vioSetElementData(thePlayer, posYString, posY);
    end
end
addCommandHandler("setRZoneCorner", setRZoneCorner_func, false, false)

function addRuheZone(thePlayer)
    if (isAdminLevel(thePlayer, 3)) then
        if (vioGetElementData(thePlayer, "posX1") and vioGetElementData(thePlayer, "posX2")) then
            local posXA = 0
            local posXB = 0
            local posYA = 0
            local posYB = 0
            if (vioGetElementData(thePlayer, "posX1") < vioGetElementData(thePlayer, "posX2")) then
                posXA = vioGetElementData(thePlayer, "posX1")
                posXB = vioGetElementData(thePlayer, "posX2")
            else
                posXA = vioGetElementData(thePlayer, "posX2")
                posXB = vioGetElementData(thePlayer, "posX1")
            end
            if (vioGetElementData(thePlayer, "posY1") < vioGetElementData(thePlayer, "posY2")) then
                posYA = vioGetElementData(thePlayer, "posY1")
                posYB = vioGetElementData(thePlayer, "posY2")
            else
                posYA = vioGetElementData(thePlayer, "posY2")
                posYB = vioGetElementData(thePlayer, "posY1")
            end

            local sizeX = posXB - posXA
            local sizeY = posYB - posYA

            local ID = MySql.helper.insertSync("objects_restareas", {
                leftX = posXA,
                buttonY = posYA,
                sizeX = sizeX,
                sizeY = sizeY
            });

            outputChatBox("Ruhezone ID " .. ID .. " created", thePlayer, 255, 0, 0)
            local area = createRadarArea(posXA, posYA, sizeX, sizeY, 0, 200, 0, 150, getRootElement())
            ruhezonen[tonumber(ID)] = area

            triggerClientEvent(getRootElement(), "empfangeRuhezonenData", thePlayer, ruhezonen)

        else
            outputChatBox("Sie müssen erst 2 Punkte markieren!", thePlayer, 255, 0, 0)
        end
    end
end
addCommandHandler("addruhe", addRuheZone, false, false)

function destroyRuheZone(thePlayer, cmd, ID)
    if (isAdminLevel(thePlayer, 3)) then
        if tonumber(ID) then
            ID = tonumber(ID);
            if (ruhezonen[ID]) then
                destroyElement(ruhezonen[ID]);
                ruhezonen = table.removeKey(ruhezonen, ID)
                triggerClientEvent(getRootElement(), "empfangeRuhezonenData", thePlayer, ruhezonen)
                MySql.helper.delete("objects_restareas", { ID = ID });
                outputChatBox("Ruhezone gelöscht", thePlayer, 255, 0, 0)
            else
                outputChatBox("ungültige ID", thePlayer, 255, 0, 0)
            end
        end
    end
end
addCommandHandler("delRZone", destroyRuheZone, false, false)
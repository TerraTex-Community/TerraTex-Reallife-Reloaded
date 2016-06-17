ruhezonen = {};
isInRuheZone = false;

addEvent("empfangeRuhezonenData", true)
function empfangeRuhezonenData_func(ruhezonenneu)
    ruhezonen = ruhezonenneu;
    isInRuheZone = false;
end
addEventHandler("empfangeRuhezonenData", getRootElement(), empfangeRuhezonenData_func)


function checkRuheZonenEnter()
    local isNowRuheZone = false
    local idKey = 0
    local x, y, z = getElementPosition(getLocalPlayer())

    for theKey, theZone in pairs(ruhezonen) do

        if (isInsideRadarArea(theZone, x, y)) then
            isNowRuheZone = true
            idKey = theKey
        end
    end

    if (isInRuheZone ~= isNowRuheZone) then
        if (isNowRuheZone) then
            outputChatBox("Du hast eine Ruhezone betreten! Hier gelten besondere Regeln:", 255, 0, 0)
            outputChatBox(" -> KEIN DM", 255, 0, 0)
            outputChatBox(" -> Max. Geschwindigkeit: 30km/h", 255, 0, 0)
            if (isAdminLevel(getLocalPlayer(), 4)) then
                outputChatBox(string.format("RuhezonenID: %s", idKey), 255, 0, 0)
            end
            if not (getPedWeaponSlot(getLocalPlayer()) == 0 or getPedWeaponSlot(getLocalPlayer()) == 11 or getPedWeaponSlot(getLocalPlayer()) == 9) then
                if tonumber(getElementData(getLocalPlayer(), "fraktion")) == 0 or tonumber(getElementData(getLocalPlayer(), "fraktion")) == 3 or tonumber(getElementData(getLocalPlayer(), "fraktion")) == 10 or tonumber(getElementData(getLocalPlayer(), "fraktion")) == 4 then
                    setPedWeaponSlot(getLocalPlayer(), 0)
                end
            end
        else
            outputChatBox("Du hast die Ruhezone verlassen!", 255, 0, 0)
        end
        isInRuheZone = isNowRuheZone
    end
end
addEventHandler("onClientRender", getRootElement(), checkRuheZonenEnter)

function onVehicleExitInRuheZone(playa)
    if (playa == getLocalPlayer()) then
        if (isInRuheZone) then
            if not (getPedWeaponSlot(getLocalPlayer()) == 0 or getPedWeaponSlot(getLocalPlayer()) == 11 or getPedWeaponSlot(getLocalPlayer()) == 9) then
                if tonumber(getElementData(getLocalPlayer(), "fraktion")) == 0 or tonumber(getElementData(getLocalPlayer(), "fraktion")) == 3 or tonumber(getElementData(getLocalPlayer(), "fraktion")) == 10 or tonumber(getElementData(getLocalPlayer(), "fraktion")) == 4 then
                    setPedWeaponSlot(getLocalPlayer(), 0)
                end
            end
        end
    end
end
addEventHandler("onClientVehicleExit", getRootElement(), onVehicleExitInRuheZone)

function player_ruhe_waffen_switch(asd, currentWeaponSlot)
    if (isInRuheZone) then
        if tonumber(getElementData(getLocalPlayer(), "fraktion")) == 0 or tonumber(getElementData(getLocalPlayer(), "fraktion")) == 3 or tonumber(getElementData(getLocalPlayer(), "fraktion")) == 10 or tonumber(getElementData(getLocalPlayer(), "fraktion")) == 4 then

            if (asd > currentWeaponSlot) then
                while (not (currentWeaponSlot == 11 or currentWeaponSlot == 9 or currentWeaponSlot == 0)) do
                    currentWeaponSlot = currentWeaponSlot - 1
                    if (currentWeaponSlot == -1) then
                        currentWeaponSlot = 11
                    end
                end
            else
                while (not (currentWeaponSlot == 11 or currentWeaponSlot == 9 or currentWeaponSlot == 0)) do
                    currentWeaponSlot = currentWeaponSlot + 1
                    if (currentWeaponSlot == 12) then
                        currentWeaponSlot = 0
                    end
                end
            end
            setPedWeaponSlot(getLocalPlayer(), currentWeaponSlot)
        end
    end
end
addEventHandler("onClientPlayerWeaponSwitch", getRootElement(), player_ruhe_waffen_switch)

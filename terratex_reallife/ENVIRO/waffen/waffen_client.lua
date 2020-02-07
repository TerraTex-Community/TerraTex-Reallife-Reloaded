waffenmessage = 0
function controlWeaponsAndWeaponLicense()
    if (isPlayerLoggedIn(getLocalPlayer())) then
        if (tonumber(getElementData(getLocalPlayer(), "waffenLic")) < 1 or (tonumber(getElementData(getLocalPlayer(), "playtime")) / 60 < 25)) then
            local weaponCount = 0
            for n = 1, 12, 1 do
                if (n ~= 11) and (n ~= 10) and (n ~= 9) then
                    local weap = getPedWeapon(getLocalPlayer(), n)
                    if not (weap == 0) then
                        weaponCount = weaponCount + 1
                    end
                end
            end
            if (weaponCount > 0) then
                if not (isPedDead(getLocalPlayer())) then
                    --takeAllWeapons ( getLocalPlayer() )
                    triggerServerEvent("resetPlayerWeapons", getLocalPlayer(), getLocalPlayer())
                    outputChatBox("Da dir der Umgang mit Waffen nicht bewusst ist, wurden deine Waffen entfernt (Kein W-Schein ODER keine 25 Spielstunden)!", 255, 0, 0)
                end
            end
        else
            if (tonumber(getElementData(getLocalPlayer(), "knastzeit")) > 0) then
                toggleControl("fire", false)
                toggleControl("enter_exit", false)
                local weaponCount = 0
                for n = 1, 12, 1 do
                    if (n ~= 11) then
                        local weap = getPedWeapon(getLocalPlayer(), n)
                        if not (weap == 0) then
                            weaponCount = weaponCount + 1
                        end
                    end
                end
                if (weaponCount > 0) then
                    if not (isPedDead(getLocalPlayer())) then
                        --takeAllWeapons ( getLocalPlayer() )
                        triggerServerEvent("resetPlayerWeapons", getLocalPlayer(), getLocalPlayer())
                        outputChatBox("Im Knast werden alle Waffen unschaedlich gemacht!", 255, 0, 0)
                    end
                end
            end
        end
    end
    setTimer(controlWeaponsAndWeaponLicense, 15000, 1)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), controlWeaponsAndWeaponLicense)

function reloadWeaponforPlayer(key, keyState)
    triggerServerEvent("reloadPedWeapon_Event", getLocalPlayer(), getLocalPlayer())
end

function bind_realoadweapon()
    bindKey("r", "down", reloadWeaponforPlayer)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), bind_realoadweapon)

local isHusting = false
local checkHustenTimer = false
function hitbox_client(attacker, weapon, bodypart, loss)
    if (source ~= getLocalPlayer()) then
        return;
    end

    if (getElementData(source, "smode")) then
        return;
    end

    triggerEvent("StopHealingTimer", source)

    if (getElementData(source, "flys_spawner_damage")) then
        cancelEvent()
        return;
    end

    if (weapon == 34 or bodypart == 9) and not cancelCalc then

        local additionalLoss = loss

        if (weapon == 34) then additionalLoss = loss * 3 end
        if (bodypart == 9) then additionalLoss = additionalLoss * 3 end

        local newArmor = getPedArmor(getLocalPlayer()) - additionalLoss
        if (newArmor < 0) then
            local newHealth = getElementHealth(getLocalPlayer()) + newArmor
            setElementHealth(getLocalPlayer(), newHealth);
            setPedArmor(getLocalPlayer(), 0)
        else
            setPedArmor(getLocalPlayer(), newArmor)
        end
    end

    if (not isPedDead(getLocalPlayer())) then
        if (weapon == 41 or weapon == 17) then
            cancelEvent()
            if (getElementsDistance(source, attacker) < 10 and attacker ~= source) then
                if not (isHusting) and not (isTimer(checkHustenTimer)) then
                    isHusting = true
                    checkHustenTimer = setTimer(checkHusten_spc, 250, 1)
                    triggerServerEvent("spc_start_event", getLocalPlayer())
                end
                isHusting = true;
            end
        end
    end
end
addEventHandler("onClientPlayerDamage", getRootElement(), hitbox_client)


local spruehtimer = 0

function checkHusten_spc()
    spruehtimer = spruehtimer + 125
    isHusting = false
    checkHustenTimer = setTimer(checkHusten_again_spc, 250, 1)
end

function checkHusten_again_spc()
    if (isHusting) then
        spruehtimer = spruehtimer + 125
        checkHustenTimer = setTimer(checkHusten_spc, 250, 1)
    else
        triggerServerEvent("spc_stop_event", getLocalPlayer(), spruehtimer)
        spruehtimer = 0
    end
end

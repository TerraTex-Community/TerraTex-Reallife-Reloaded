--Weapon Balance
function setWeaponStats_balanced()
    setWeaponProperty(22, "pro", "flag_type_dual", false)
    setWeaponProperty(22, "std", "flag_type_dual", false)
    setWeaponProperty(22, "poor", "flag_type_dual", false)

    setWeaponProperty(24, "pro", "target_range", 50)
    setWeaponProperty(24, "std", "target_range", 50)
    setWeaponProperty(24, "poor", "target_range", 50)
    setWeaponProperty(24, "pro", "weapon_range", 50)
    setWeaponProperty(24, "std", "weapon_range", 50)
    setWeaponProperty(24, "poor", "weapon_range", 50)

    setWeaponProperty(34, "pro", "target_range", 1000)
    setWeaponProperty(34, "std", "target_range", 1000)
    setWeaponProperty(34, "poor", "target_range", 1000)
    setWeaponProperty(34, "pro", "weapon_range", 1000)
    setWeaponProperty(34, "std", "weapon_range", 1000)
    setWeaponProperty(34, "poor", "weapon_range", 1000)
end
addEventHandler("onResourceStart", getRootElement(), setWeaponStats_balanced)

function onPlayerDamage_func(attacker, attackerweapon, bodypart, loss)
    local health = getElementHealth(getLocalPlayer())

    if (health < 1) then
        if (isPedInVehicle(source)) then
            removePedFromVehicle(source)
        end
    else
        if (isElement(attacker)) then
            local hitTimer = setTimer(resetHitTimer, 30000, 1, source)
            if (isTimer(vioGetElementData(source, "hitTimer"))) then
                killTimer(vioGetElementData(source, "hitTimer"))
            end
            vioSetElementData(source, "hitTimer", hitTimer)
        end
    end
end
addEventHandler("onPlayerDamage", getRootElement(), onPlayerDamage_func)


function resetHitTimer(player)
    if (isElement(player)) then
        vioSetElementData(player, "hitTimer", false)
    end
end

function onPlayerStealthKill_func(targetPlayer)
    --outputChatBox(tostring(vioGetElementData(source,"inArena")))
    if not (vioGetElementData(source, "job") == 7) and not (vioGetElementData(source, "fraktion") == 8) then
        if (not (vioGetElementData(source, "inArena") == 1)) then
            cancelEvent()
        end
    end
end
addEventHandler("onPlayerStealthKill", getRootElement(), onPlayerStealthKill_func)

local restTimer = false
local addSPCSeconds = 0
local dummy = 0

function setPedChocking_server()
    if (isTimer(restTimer)) then
        local a, b, c = getTimerDetails(restTimer)
        addSPCSeconds = a
        killTimer(restTimer)

        -- outputChatBox("rest: "..addSPCSeconds)
    else
        addSPCSeconds = 0
    end
    setPedChoking(source, true)
    -- outputChatBox("started")
end
addEvent("spc_start_event", true)
addEventHandler("spc_start_event", getRootElement(), setPedChocking_server)

function setPedChockingStop_server(spruehtimer)
    spruehtimer = spruehtimer + addSPCSeconds
    -- outputChatBox(spruehtimer)
    restTimer = setTimer(setPedChoking, spruehtimer, 1, source, false)
end
addEvent("spc_stop_event", true)
addEventHandler("spc_stop_event", getRootElement(), setPedChockingStop_server)

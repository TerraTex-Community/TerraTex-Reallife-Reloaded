local maxDistance = 20;
local testEffects = {
    gargle = false,
    compressor = false,
    echo = false,
    i3dl2reverb = false,
    distortion = false,
    chorus = false,
    parameq = false,
    reverb = false,
    flanger = false,
}

function setVoiceVolumeOnDistance()
    local x, y, z = getElementPosition(getLocalPlayer())

    for theKey, thePlayer in ipairs(getElementsByType("player")) do
        local px, py, pz = getElementPosition(thePlayer)
        local distance = getDistanceBetweenPoints3D(x, y, z, px, py, pz);

        if (distance > maxDistance) then
            setSoundVolume(thePlayer, 0)
        else
            local outSoundVolume = 1 - getEasingValue((distance / maxDistance), "InQuad")
            -- Remote to Local
            local hitRtoL, hitRtoLX, hitRtoLY, hitRtoLZ = processLineOfSight(px, py, pz, x, y, z, true, false, false, true, false, true, false, false, nil, false, false)
            -- local to remote
            local hitLtoR, hitLtoRX, hitLtoRY, hitLtoRZ = processLineOfSight(x, y, z, px, py, pz, true, false, false, true, false, true, false, false, nil, false, false)

            if (hitLtoR or hitRtoL) then
                outSoundVolume = outSoundVolume - 0.2

                local interruptedDistance = getDistanceBetweenPoints3D(hitRtoLX, hitRtoLY, hitRtoLZ, hitLtoRX, hitLtoRY, hitLtoRZ)
                if (interruptedDistance > maxDistance / 4) then
                    outSoundVolume = 0
                end
            end

            setSoundVolume(thePlayer, outSoundVolume)

            for theEffectName, state in pairs(testEffects) do
                setSoundEffectEnabled(thePlayer, theEffectName, state)
            end
        end

    end
end
addEventHandler("onClientRender", getRootElement(), setVoiceVolumeOnDistance)

function setTestSoundEffect(cmd, effect, state)
    if (effect == "info") then
        for theEffectName, state in pairs(testEffects) do
            if (state) then
                outputChatBox(theEffectName .. ": on")
            else
                outputChatBox(theEffectName .. ": off")
            end
        end
    elseif (effect == "none") then
        for theEffectName, state in pairs(testEffects) do
            testEffects[theEffectName] = false;
        end
    else
        if (state == "on") then
            testEffects[effect] = true
            outputChatBox("Effect set")
        else
            testEffects[effect] = false
            outputChatBox("Effect set")
        end

    end
end
addCommandHandler("seffects", setTestSoundEffect)



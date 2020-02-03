local maxDistance = 20;

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
                outSoundVolume = outSoundVolume - 0.1

                if (hitLtoR and hitRtoL) then
                    local interruptedDistance = getDistanceBetweenPoints3D(hitRtoLX, hitRtoLY, hitRtoLZ, hitLtoRX, hitLtoRY, hitLtoRZ)
                    if (interruptedDistance > maxDistance / 4) then
                        outSoundVolume = 0
                    end
                end
            end

            setSoundVolume(thePlayer, outSoundVolume)
        end

    end
end
addEventHandler("onClientRender", getRootElement(), setVoiceVolumeOnDistance)




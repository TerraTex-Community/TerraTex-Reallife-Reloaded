--
-- Created by IntelliJ IDEA.
-- User: C5217649
-- Date: 17.10.2016
-- Time: 12:50
-- To change this template use File | Settings | File Templates.
--
function renderFlashingBlips ()
    for theKey, theBlip in ipairs(getElementsByType("blip")) do
        if (getElementData(theBlip, "flashing")) then
            local flashingData = {
                startTime = getTickCount(),
                endTime = getTickCount() + 4000,
                direction = false
            }
            if (getElementData(theBlip, "flashingData")) then
                flashingData = getElementData(theBlip, "flashingData");
            end

            local now = getTickCount();
            local elapsedTime = now - flashingData.startTime;
            local duration = flashingData.endTime - flashingData.startTime;
            local progress = elapsedTime / duration;

            local fAnimationTime = getEasingValue(progress, "InOutQuad");

            local alpha = (1 - fAnimationTime) * 255;
            if (flashingData.direction) then
                alpha = fAnimationTime * 255;
            end

            local r,g,b,a = getBlipColor(theBlip);
            setBlipColor ( theBlip, r,g,b, alpha );

            if now > flashingData.endTime then
                flashingData = {
                    startTime = getTickCount(),
                    endTime = getTickCount() + 4000,
                    direction = flashingData.direction
                }
            end

            setElementData(theBlip, "flashingData", flashingData)
        end
    end
end
addEventHandler ( "onClientRender", getRootElement(), renderFlashingBlips )
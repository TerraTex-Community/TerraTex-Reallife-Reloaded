local drugedTime = 0
local zaehler = 0
drogenGramm = 0
local drugeffekt_new = false
local everyTenDrug = 0

function closeOtherShadersforDrug()
    setWaterShader(false)
    setBloomShader(false)
    switchRoadshine3(false)
    handleOnClientSwitchDetail(false)
end

function refuseDrugedTime()
    if (drogenGramm > 0) then
        closeOtherShadersforDrug()
        if (not (drugeffekt_new)) then
            coloroff(true)
            drugeffekt_new = true
        else
            if (everyTenDrug == 5) then
                colorize()
                everyTenDrug = 1
            end
            everyTenDrug = everyTenDrug + 1
        end

        drogenGramm = drogenGramm - 0.024
    else
        if (drugeffekt_new) then
            coloroff(false)
            executeSettingsGUI()
            drugeffekt_new = false
        end
        drogenGramm = 0
    end
    if (drugedTime > 0) then
        drugedTime = drugedTime - 1
    end
    setElementData(getLocalPlayer(), "DrogenImBlut", drogenGramm);
    setTimer(refuseDrugedTime, 1000, 1)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), refuseDrugedTime)


function addDrugTime()
    drugedTime = drugedTime + 0.3
    drogenGramm = drogenGramm + 0.5
    setElementData(getLocalPlayer(), "DrogenImBlut", drogenGramm);
end
addEvent("addDrugTime_Event", true)
addEventHandler("addDrugTime_Event", getRootElement(), addDrugTime)



function onclientrender_func()
    if (drugedTime > 0) then
        zaehler = zaehler + 1
        if (tonumber(getElementData(getLocalPlayer(), "cuffed")) == 0) then
            if (not (isAnyGuiVisible())) then
                if (zaehler < 5) then
                    toggleAllControls(false)
                elseif (zaehler > 15) then
                    zaehler = 0
                else
                    toggleAllControls(true)
                end
                if (drugedTime < 5) then
                    toggleAllControls(true)
                end
            end
        end
    end
end

addEventHandler("onClientRender", getRootElement(), onclientrender_func)

GUIPremiumColor_Window = {}
GUIPremiumColor_Button = {}
GUIPremiumColor_Label = {}
GUIPremiumColor_Edit = {}
GUIPremiumColor_Progress = {}
GUIPremiumColor_Scrollbar = {}
GUIPremiumColor_Image = {}

addEventHandler("onClientResourceStart", resourceRoot,
    function()

        -- Created: 10/02/2012 14:22

        GUIPremiumColor_Window[1] = guiCreateWindow(532, 159, 414, 613, "Lichter- / Farbänderung", false)
        table.insert(allGuis, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[1] = guiCreateLabel(11, 37, 168, 30, "Farbänderungen:", false, GUIPremiumColor_Window[1])
        guiSetFont(GUIPremiumColor_Label[1], "default-bold-small")
        GUIPremiumColor_Button[1] = guiCreateButton(251, 247, 152, 31, "Farbe ändern (7500$)", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Progress[1] = guiCreateProgressBar(9, 289, 393, 5, false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[2] = guiCreateLabel(14, 307, 132, 24, "Lichterfarbe:", false, GUIPremiumColor_Window[1])
        guiSetFont(GUIPremiumColor_Label[2], "default-bold-small")
        GUIPremiumColor_Scrollbar[1] = guiCreateScrollBar(66, 345, 261, 29, true, false, GUIPremiumColor_Window[1]) --
        GUIPremiumColor_Label[3] = guiCreateLabel(26, 351, 37, 29, "Rot", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Scrollbar[2] = guiCreateScrollBar(68, 389, 261, 29, true, false, GUIPremiumColor_Window[1]) --
        GUIPremiumColor_Scrollbar[3] = guiCreateScrollBar(68, 435, 261, 29, true, false, GUIPremiumColor_Window[1]) --
        GUIPremiumColor_Label[4] = guiCreateLabel(22, 393, 34, 27, "Grün", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[5] = guiCreateLabel(26, 437, 34, 29, "Blau", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[6] = guiCreateLabel(19, 484, 388, 52, "Dieser Schriftzug stellt die Farbe dar, die die Lichter nach dem bestätigen haben werden.", false, GUIPremiumColor_Window[1])
        guiLabelSetHorizontalAlign(GUIPremiumColor_Label[6], "left", true)
        GUIPremiumColor_Button[2] = guiCreateButton(220, 306, 184, 29, "Lichterfarbe ändern (2500$)", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Progress[2] = guiCreateProgressBar(11, 475, 390, 5, false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Button[3] = guiCreateButton(10, 568, 392, 29, "Beenden", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[7] = guiCreateLabel(29, 62, 80, 17, "Rot", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[8] = guiCreateLabel(26, 89, 44, 15, "Grün", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[9] = guiCreateLabel(28, 116, 63, 14, "Blau", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Scrollbar[4] = guiCreateScrollBar(69, 61, 195, 20, true, false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Scrollbar[5] = guiCreateScrollBar(67, 86, 196, 20, true, false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[10] = guiCreateLabel(173, 40, 80, 14, "Farbe 1:", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Scrollbar[6] = guiCreateScrollBar(67, 113, 198, 21, true, false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[11] = guiCreateLabel(290, 59, 98, 76, "Dieser Text stellt dar, wie Farbe 1 des Fahrzeugs aussehen wird.", false, GUIPremiumColor_Window[1])
        guiLabelSetHorizontalAlign(GUIPremiumColor_Label[11], "left", true)
        GUIPremiumColor_Label[12] = guiCreateLabel(166, 144, 88, 18, "Farbe 2:", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Scrollbar[7] = guiCreateScrollBar(81, 165, 198, 21, true, false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Scrollbar[8] = guiCreateScrollBar(83, 193, 198, 21, true, false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Scrollbar[9] = guiCreateScrollBar(85, 219, 198, 21, true, false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[13] = guiCreateLabel(40, 165, 33, 17, "Rot", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[14] = guiCreateLabel(36, 193, 42, 22, "Grün", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[15] = guiCreateLabel(36, 219, 36, 20, "Blau", false, GUIPremiumColor_Window[1])
        GUIPremiumColor_Label[16] = guiCreateLabel(294, 169, 98, 76, "Dieser Text stellt dar, wie Farbe 2 des Fahrzeugs aussehen wird.", false, GUIPremiumColor_Window[1])
        guiLabelSetHorizontalAlign(GUIPremiumColor_Label[16], "left", true)
        GUIPremiumColor_Button[4] = guiCreateButton(10, 529, 392, 29, "Vorschau aktivieren", false, GUIPremiumColor_Window[1])


        addEventHandler("onClientGUIClick", GUIPremiumColor_Button[1], GUIPremiumColor_buyColor, false)
        addEventHandler("onClientGUIClick", GUIPremiumColor_Button[2], GUIPremiumColor_buyLights, false)
        addEventHandler("onClientGUIClick", GUIPremiumColor_Button[3], closeGUIPremiumColor, false)
        addEventHandler("onClientGUIClick", GUIPremiumColor_Button[4], togglePreview, false)
        addEventHandler("onClientGUIScroll", GUIPremiumColor_Scrollbar[1], aktuallizeGUIPremiumColor_Lights, false)
        addEventHandler("onClientGUIScroll", GUIPremiumColor_Scrollbar[2], aktuallizeGUIPremiumColor_Lights, false)
        addEventHandler("onClientGUIScroll", GUIPremiumColor_Scrollbar[3], aktuallizeGUIPremiumColor_Lights, false)


        addEventHandler("onClientGUIScroll", GUIPremiumColor_Scrollbar[4], aktuallizeGUIPremiumColor_Car_1, false)
        addEventHandler("onClientGUIScroll", GUIPremiumColor_Scrollbar[5], aktuallizeGUIPremiumColor_Car_1, false)
        addEventHandler("onClientGUIScroll", GUIPremiumColor_Scrollbar[6], aktuallizeGUIPremiumColor_Car_1, false)


        addEventHandler("onClientGUIScroll", GUIPremiumColor_Scrollbar[7], aktuallizeGUIPremiumColor_Car_2, false)
        addEventHandler("onClientGUIScroll", GUIPremiumColor_Scrollbar[8], aktuallizeGUIPremiumColor_Car_2, false)
        addEventHandler("onClientGUIScroll", GUIPremiumColor_Scrollbar[9], aktuallizeGUIPremiumColor_Car_2, false)
        guiSetVisible(GUIPremiumColor_Window[1], false)
    end)

local previewActivated = false
local previewVehicle, colorBeforePreview_Color1_R, colorBeforePreview_Color1_G, colorBeforePreview_Color1_B, colorBeforePreview_Color2_R, colorBeforePreview_Color2_G, colorBeforePreview_Color2_B, colorBeforePreview_Light_R, colorBeforePreview_Light_G, colorBeforePreview_Light_B
function togglePreview()
    previewActivated = not previewActivated
    if (previewActivated) then
        guiSetText(GUIPremiumColor_Button[4], "Vorschau deaktivieren")
        previewVehicle = getPedOccupiedVehicle(getLocalPlayer())
        colorBeforePreview_Color1_R, colorBeforePreview_Color1_G, colorBeforePreview_Color1_B, colorBeforePreview_Color2_R, colorBeforePreview_Color2_G, colorBeforePreview_Color2_B = getVehicleColor(previewVehicle, true)
        colorBeforePreview_Light_R, colorBeforePreview_Light_G, colorBeforePreview_Light_B = getVehicleHeadLightColor(previewVehicle)
        aktuallizeGUIPremiumColor_Car_1()
        aktuallizeGUIPremiumColor_Car_2()
        aktuallizeGUIPremiumColor_Lights()
    else
        guiSetText(GUIPremiumColor_Button[4], "Vorschau aktivieren")
        setVehicleColor(previewVehicle, colorBeforePreview_Color1_R, colorBeforePreview_Color1_G, colorBeforePreview_Color1_B, colorBeforePreview_Color2_R, colorBeforePreview_Color2_G, colorBeforePreview_Color2_B)
        setVehicleHeadLightColor(previewVehicle, colorBeforePreview_Light_R, colorBeforePreview_Light_G, colorBeforePreview_Light_B)
        previewVehicle = nil
        colorBeforePreview_Color1_R = nil
        colorBeforePreview_Color1_G = nil
        colorBeforePreview_Color1_B = nil
        colorBeforePreview_Color2_R = nil
        colorBeforePreview_Color2_G = nil
        colorBeforePreview_Color2_B = nil
        colorBeforePreview_Light_R = nil
        colorBeforePreview_Light_G = nil
        colorBeforePreview_Light_B = nil
    end
end

function GUIPremiumColor_buyColor()
    local R = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[4])
    local G = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[5])
    local B = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[6])
    local R_2 = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[7])
    local G_2 = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[8])
    local B_2 = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[9])
    local premColorString = R .. "|" .. G .. "|" .. B .. "|" .. R_2 .. "|" .. G_2 .. "|" .. B_2
    triggerServerEvent("setPremiumVehicleColor", getLocalPlayer(), premColorString)
end

addEvent("pColor_Preview_setColorBefore", true)
function Preview_setColorBefore(R, G, B, R_2, G_2, B_2)
    colorBeforePreview_Color1_R = R
    colorBeforePreview_Color1_G = G
    colorBeforePreview_Color1_B = B
    colorBeforePreview_Color2_R = R_2
    colorBeforePreview_Color2_G = G_2
    colorBeforePreview_Color2_B = B_2
end
addEventHandler("pColor_Preview_setColorBefore", getRootElement(), Preview_setColorBefore)

local actualCar1_R = 0
local actualCar1_G = 0
local actualCar1_B = 0
local actualCar2_R = 0
local actualCar2_G = 0
local actualCar2_B = 0
function aktuallizeGUIPremiumColor_Car_1()
    local R = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[4])
    local G = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[5])
    local B = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[6])
    actualCar1_R = R
    actualCar1_G = G
    actualCar1_B = B

    guiLabelSetColor(GUIPremiumColor_Label[11], R, G, B)
    if (previewActivated and previewVehicle) then
        setVehicleColor(previewVehicle, R, G, B, actualCar2_R, actualCar2_G, actualCar2_B)
    end
end

function aktuallizeGUIPremiumColor_Car_2()
    local R = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[7])
    local G = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[8])
    local B = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[9])
    
    actualCar2_R = R
    actualCar2_G = G
    actualCar2_B = B

    guiLabelSetColor(GUIPremiumColor_Label[16], R, G, B)
    if (previewActivated and previewVehicle) then
        setVehicleColor(previewVehicle, actualCar1_R, actualCar1_G, actualCar1_B, R, G, B)
    end
end

function GUIPremiumColor_buyLights()
    local R = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[1])
    local G = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[2])
    local B = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[3])

    local newcolorstring = R .. "|" .. G .. "|" .. B
    triggerServerEvent("setPremiumVehicleLightColor", getLocalPlayer(), newcolorstring)
end

addEvent("pColor_Preview_setLightBefore", true)
function Preview_setLightBefore(R, G, B)
    colorBeforePreview_Light_R = R
    colorBeforePreview_Light_G = G
    colorBeforePreview_Light_B = B
end
addEventHandler("pColor_Preview_setLightBefore", getRootElement(), Preview_setLightBefore)

function onClientVehicleStartExit_onGUIPremiumColor(thePlayer)
    if (thePlayer == getLocalPlayer) then
        if (guiGetVisible(GUIPremiumColor_Window[1])) then
            closeGUIPremiumColor()
        end
    end
end

addEvent("load_PremiumColor_Event", true)
function load_GUIPremiumColor(coloredString, LightString)
    local colors = getStringComponents(coloredString)
    local lights = getStringComponents(LightString)
    if (coloredString ~= "-1") then
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[4], (tonumber(colors[1]) / 2.55))
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[5], (tonumber(colors[2]) / 2.55))
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[6], (tonumber(colors[3]) / 2.55))
        aktuallizeGUIPremiumColor_Car_1()
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[7], (tonumber(colors[4]) / 2.55))
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[8], (tonumber(colors[5]) / 2.55))
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[9], (tonumber(colors[6]) / 2.55))
        aktuallizeGUIPremiumColor_Car_2()
    else
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[4], ((255) / 2.55))
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[5], ((255) / 2.55))
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[6], ((255) / 2.55))
        aktuallizeGUIPremiumColor_Car_1()
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[7], (255 / 2.55))
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[8], (255 / 2.55))
        guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[9], (255 / 2.55))
        aktuallizeGUIPremiumColor_Car_2()
    end
    guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[1], (tonumber(lights[1]) / 2.55))
    guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[2], (tonumber(lights[2]) / 2.55))
    guiScrollBarSetScrollPosition(GUIPremiumColor_Scrollbar[3], (tonumber(lights[3]) / 2.55))
    guiLabelSetColor(GUIPremiumColor_Label[6], tonumber(lights[1]), tonumber(lights[2]), tonumber(lights[3]))
    guiSetVisible(GUIPremiumColor_Window[1], true)
    showCursor(true)
end

addEventHandler("load_PremiumColor_Event", getRootElement(), load_GUIPremiumColor)

function aktuallizeGUIPremiumColor_Lights()
    local R = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[1])
    local G = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[2])
    local B = 2.55 * guiScrollBarGetScrollPosition(GUIPremiumColor_Scrollbar[3])


    guiLabelSetColor(GUIPremiumColor_Label[6], R, G, B)
    if (previewActivated and previewVehicle) then
        setVehicleHeadLightColor(previewVehicle, R, G, B)
    end
end

function closeGUIPremiumColor()
    if (previewActivated) then
        togglePreview()
    end
    showCursor(false)
    guiSetVisible(GUIPremiumColor_Window[1], false)
end

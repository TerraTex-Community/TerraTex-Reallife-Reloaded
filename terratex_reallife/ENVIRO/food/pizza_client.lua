local showPMenu = 1
local pMenuShowing = false
local pMenuObject = false
local pMenu = { { "Kleines Menü", 2218, 0.50, 20 }, { "Mittleres Menü", 2219, 0.80, 40 }, { "Grosses Menü", 2220, 1.20, 90 }, { "Salat", 2355, 1.00, 120 } }


function createPizzaMarker()
    local mark = false
    for i = 0, 20, 1 do
        mark = createMarker(377.288177, -119.057136, 1000.49121, "cylinder", 1)
        setElementInterior(mark, 5)
        setElementDimension(mark, i)
        addEventHandler("onClientMarkerHit", mark, showPizzaMenu)
    end
end

addEventHandler("onClientResourceStart", getRootElement(), createPizzaMarker)

function showPizzaMenu(player, mathchdim)
    if (mathchdim) and not (pMenuShowing) and player == getLocalPlayer() then
        showPMenu = 1
        pMenuShowing = true
        setElementFrozen(getLocalPlayer(), true)
        pMenuObject = createObject(pMenu[1][2], 375.6870, -118.07375, 1001.62158, 349.35421, 19.090972, 262.408386)
        setElementInterior(pMenuObject, 5)
        setElementDimension(pMenuObject, getElementDimension(getLocalPlayer()))
        setCameraMatrix(375.6870, -118.07375, 1002.62158, 375.6870, -118.07375, 1001.62158)
        bindKey("arrow_r", "down", pMenuNext_func)
        bindKey("arrow_l", "down", pMenuBefore_func)
        bindKey("space", "down", pMenuClose_func)
        bindKey("enter", "down", pMenuBuy_func)
    end
end

function showPMenuInfo()
    if (pMenuShowing) then

        local x, y, z = getElementPosition(getLocalPlayer())
        if (30 < getDistanceBetweenPoints3D(x, y, z, getElementPosition(pMenuObject))) then
            pMenuShowing = false;
            pMenuClose_func();
        end

        local scx, scy = guiGetScreenSize()
        dxDrawText("Keys: Enter-Kaufen", 3, scy / 2 - 30, 1, 1, tocolor(0, 0, 255, 255), 1.5, "default-bold")
        dxDrawText("           Leertaste-Beenden", 3, scy / 2 - 30 + 15, 1, 1, tocolor(0, 0, 255, 255), 1.5, "default-bold")
        dxDrawText("           Links-Zurück", 3, scy / 2, 1, 1, tocolor(0, 0, 255, 255), 1.5, "default-bold")
        dxDrawText("           Rechts-Weiter", 3, scy / 2 + 15, 1, 1, tocolor(0, 0, 255, 255), 1.5, "default-bold")
        dxDrawText(string.format("Art: %s", pMenu[showPMenu][1]), 3, scy / 2 + 30, 1, 1, tocolor(0, 0, 255, 255), 1.5, "default-bold")
        local preis = pMenu[showPMenu][3]
        if (isWetterEventID == 1) then
            preis = preis * 3
        elseif (isWetterEventID == 2) then
            preis = preis * 1.5
        elseif (isWetterEventID == 3) then
            preis = preis * 3.5
        elseif (isWetterEventID == 5) then
            preis = preis * 0.7
        elseif (isWetterEventID == 6) then
            preis = preis * 0.9
        end

        dxDrawText(string.format("Preis: %s$", preis), 3, scy / 2 + 45, 1, 1, tocolor(0, 0, 255, 255), 1.5, "default-bold")
    end
end

addEventHandler("onClientRender", getRootElement(), showPMenuInfo)

function pMenuNext_func()
    showPMenu = showPMenu + 1
    if (showPMenu > 4) then showPMenu = 1 end
    setElementModel(pMenuObject, pMenu[showPMenu][2])
end

function pMenuBefore_func()
    showPMenu = showPMenu - 1
    if (showPMenu < 1) then showPMenu = 4 end
    setElementModel(pMenuObject, pMenu[showPMenu][2])
end

function pMenuClose_func()
    destroyElement(pMenuObject)
    pMenuObject = false
    setElementFrozen(getLocalPlayer(), false)
    pMenuShowing = false
    showPMenu = 1
    setCameraTarget(getLocalPlayer())

    unbindKey("arrow_r", "down", pMenuNext_func)
    unbindKey("arrow_l", "down", pMenuBefore_func)
    unbindKey("space", "down", pMenuClose_func)
    unbindKey("enter", "down", pMenuBuy_func)
end

function pMenuBuy_func()
    if (pMenuShowing) then
        if (pMenu[showPMenu][3] < getPlayerMoney(getLocalPlayer()) + 1) then
            triggerEvent("addFood", getLocalPlayer(), pMenu[showPMenu][4], true)
            triggerServerEvent("buyFood_B", getLocalPlayer(), pMenu[showPMenu][3], "pizza")
            showError(getLocalPlayer(), "Du hast dieses Menu erfolgreich gekauft!")
        else
            showError(getLocalPlayer(), "Du hast nicht genügend Geld!")
        end
    end
end

--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 15.02.14
-- Time: 22:47
-- To change this template use File | Settings | File Templates.
--

fahrplanGUI = {
    tab = {},
    tabpanel = {},
    label = {},
    gridlist = {},
    window = {},
    button ={}
}

addEventHandler("onClientResourceStart", getRootElement(),
    function()
        local screenW, screenH = guiGetScreenSize()
        fahrplanGUI.window[1] = guiCreateWindow((screenW - 577) / 2, (screenH - 497) / 2, 577, 497, "Fahrplan", false)
        table.insert(allGuis, fahrplanGUI.window[1])
        guiWindowSetSizable(fahrplanGUI.window[1], false)
        fahrplanGUI.tabpanel[1] = guiCreateTabPanel(9, 24, 558, 404, false, fahrplanGUI.window[1])
        fahrplanGUI.label[1] = guiCreateLabel(10, 434, 557, 53, "Legende:\nGRÜN - Aktuelle Haltestelle (GELB wenn sie angefahren wird gerade)\nROT   - An dieser Haltestelle hält gerade ein Bus ", false, fahrplanGUI.window[1])
        fahrplanGUI.button[1] = guiCreateButton(411, 457, 146, 24, "Beenden", false, fahrplanGUI.window[1])
        triggerServerEvent("giveMeHList",getLocalPlayer())
        addEventHandler ( "onClientGUIClick", fahrplanGUI.button[1], closeFahrplan, false )
        guiSetVisible(fahrplanGUI.window[1], false)
    end
)

local aktualizeTimer=false
local routenListe={}
local haltestellenListe={}
local aktuelleHaltestellenID=0

function aktualizeTimer_func()
    aktualizeColors()
end

function aktualizeColors()
    local haltestellenID=aktuelleHaltestellenID
    local busstations={}
    local busListe={}
    --vioSetElementData(busveh,"isBusVeh",true)
    for theKey, theVehicle in ipairs(getElementsByType('vehicle')) do
        if(getElementData(theVehicle,"isBusVeh"))then
            table.insert(busListe,theVehicle)
        end
    end

    for theKey, theBus in ipairs(busListe)do
        local route=getElementData(theBus,"route")
        local aktualID=routenListe[route][tonumber(getElementData(theBus,"station"))]
        route=string.UpperFirst(route)
        busstations[aktualID]={}
        busstations[aktualID][route]=true
    end

    for theKey, theGridlist in pairs(fahrplanGUI.gridlist)do
        local routenName=guiGetText(theKey)
        local rows = guiGridListGetRowCount ( theGridlist )
        for i=0,rows,1 do
            local rowID=tonumber(guiGridListGetItemText ( theGridlist, i, 1))
            local wirdAngefahren=false
            if(busstations[rowID])then
                if(busstations[rowID][routenName])then
                    guiGridListSetItemColor ( theGridlist, i, 1, 255, 0, 0,255 )
                    guiGridListSetItemColor ( theGridlist, i, 2, 255, 0, 0,255 )
                    wirdAngefahren=true
                end
            end
            if(wirdAngefahren and haltestellenID==rowID)then
                guiGridListSetItemColor ( theGridlist, i, 1, 255, 255, 0,255 )
                guiGridListSetItemColor ( theGridlist, i, 2, 255, 255, 0,255 )
            elseif(haltestellenID==rowID and not(wirdAngefahren))then
                guiGridListSetItemColor ( theGridlist, i, 1, 0, 255, 0,255 )
                guiGridListSetItemColor ( theGridlist, i, 2, 0, 255, 0,255 )
            elseif(not wirdAngefahren)then
                guiGridListSetItemColor ( theGridlist, i, 1, 255,255,255,255 )
                guiGridListSetItemColor ( theGridlist, i, 2, 255,255,255,255 )
            end
        end
    end
end

addEvent("showFahrplan",true)
function showFahrplan_func(haltestellenID, hitRouten, activeBusses)
    aktuelleHaltestellenID=haltestellenID
    createTab( hitRouten )
    --RESET ALL AND HIDE NOT USED TABS
    local firstTabVisible=false
    for theKey, theTab in ipairs(fahrplanGUI.tab)do
        local hasRoute=false
        for theRouteKey, theRoute in ipairs(hitRouten)do
            if(string.UpperFirst(theRoute)==guiGetText(theTab))then
                hasRoute=true
            end
        end
        if(hasRoute)then
            guiSetVisible(fahrplanGUI.tab[theKey],true)
            if(not firstTabVisible)then
                firstTabVisible=true
                guiSetSelectedTab ( fahrplanGUI.tabpanel[1], fahrplanGUI.tab[theKey] )
            end
        else
            guiSetVisible(fahrplanGUI.tab[theKey],false)
        end
    end
    --[[GET ALL ACTIV BUSSTATIONS]]

    --[[SET ALL GRIDLIST COLORS TO WHITE/GREEN/RED ]]
    aktualizeColors()

    guiSetVisible(fahrplanGUI.window[1], true)
    showCursor(true)

    if(isTimer(aktualizeTimer))then
        killTimer(aktualizeTimer)
    end
    aktualizeTimer=setTimer(aktualizeTimer_func,1000,0)
end
addEventHandler("showFahrplan",getRootElement(),showFahrplan_func)

function closeFahrplan()
    guiSetVisible(fahrplanGUI.window[1], false)
    showCursor(false)

    if(isTimer(aktualizeTimer))then
        killTimer(aktualizeTimer)
    end
end

function createTab( TabNamenListe )
    for theKey,theTab in pairs(fahrplanGUI.gridlist)do
        destroyElement(theTab)
    end
    for theKey,theTab in pairs(fahrplanGUI.tab)do
        guiDeleteTab ( theTab, fahrplanGUI.tabpanel[1] )
    end

    fahrplanGUI.tab={}
    fahrplanGUI.gridlist={}
    for routenName, route in pairs(routenListe)do
        local isInTabNamenListe=false
        for theKey, theTabnamen in ipairs(TabNamenListe)do
            if(theTabnamen==routenName)then
                isInTabNamenListe=true
            end
        end
        if(isInTabNamenListe)then
            routenName=string.UpperFirst(routenName)

            local newTab = guiCreateTab(routenName, fahrplanGUI.tabpanel[1])
            table.insert(fahrplanGUI.tab,newTab)

            fahrplanGUI.gridlist[newTab] = guiCreateGridList(10, 10, 538, 359, false, newTab)
            guiGridListAddColumn(fahrplanGUI.gridlist[newTab], "HID", 0.1)
            guiGridListAddColumn(fahrplanGUI.gridlist[newTab], "Haltstellen", 0.8)
            guiGridListSetSortingEnabled ( fahrplanGUI.gridlist[newTab], false )

            for thekey,theHaltestelle in ipairs(route)do
                local row = guiGridListAddRow ( fahrplanGUI.gridlist[newTab] )
                guiGridListSetItemText ( fahrplanGUI.gridlist[newTab] , row, 1, theHaltestelle , false, false )
                guiGridListSetItemText ( fahrplanGUI.gridlist[newTab] , row, 2, haltestellenListe[theHaltestelle][5] , false, false )
            end
        end
    end
end

addEvent("sendHData",true)
function prepareFahrplanAnzeige(FUNCroutenListe, FUNChaltestellenListe)
    routenListe=FUNCroutenListe
    haltestellenListe=FUNChaltestellenListe
    --createTab(FUNCroutenListe, haltestellenListe)
end
addEventHandler("sendHData",getRootElement(),prepareFahrplanAnzeige)













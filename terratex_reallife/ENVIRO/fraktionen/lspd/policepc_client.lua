-- Created: 07/02/2012 18:51

local policeVehicles={}
local PolizeiPC = {
    tab = {},
    staticimage = {},
    edit = {},
    window = {},
    tabpanel = {},
    label = {},
    gridlist = {},
    button = {},
    scrollpane = {},
    memo = {},
    tempLabel={},
    tempBlitzerLabel={}
}



addEventHandler("onClientResourceStart",resourceRoot,
    function()
        --	table.insert(allGuis,policePC_Window[1])

        local screenW, screenH = guiGetScreenSize()


        PolizeiPC.window[1] = guiCreateWindow((screenW - 544)/2, (screenH - 252) / 2 , 634, 484, "Polizeicomputer TerraOS 2012 RV", false)
        guiWindowSetSizable(PolizeiPC.window[1], false)
        table.insert(allGuis,PolizeiPC.window[1])

        PolizeiPC.tabpanel[1] = guiCreateTabPanel(9, 23, 615, 451, false, PolizeiPC.window[1])

        PolizeiPC.tab[1] = guiCreateTab("Wanted und StVO", PolizeiPC.tabpanel[1])

        PolizeiPC.gridlist[1] = guiCreateGridList(7, 7, 368, 380, false, PolizeiPC.tab[1])
        guiGridListAddColumn(PolizeiPC.gridlist[1], "Name", 0.5)
        guiGridListAddColumn(PolizeiPC.gridlist[1], "StVO", 0.2)
        guiGridListAddColumn(PolizeiPC.gridlist[1], "Wanteds", 0.2)
        PolizeiPC.label[1] = guiCreateLabel(385, 7, 44, 20, "Anzahl:", false, PolizeiPC.tab[1])
        guiLabelSetVerticalAlign(PolizeiPC.label[1], "center")
        PolizeiPC.edit[1] = guiCreateEdit(435, 7, 170, 20, "", false, PolizeiPC.tab[1])
        PolizeiPC.label[2] = guiCreateLabel(385, 37, 109, 24, "Grundeingabe:", false, PolizeiPC.tab[1])
        guiLabelSetVerticalAlign(PolizeiPC.label[2], "center")
        PolizeiPC.memo[1] = guiCreateMemo(385, 61, 220, 95, "", false, PolizeiPC.tab[1])
        PolizeiPC.button[1] = guiCreateButton(385, 199, 221, 33, "Wanteds vergeben", false, PolizeiPC.tab[1])
        guiSetProperty(PolizeiPC.button[1], "NormalTextColour", "FFAAAAAA")
        PolizeiPC.label[3] = guiCreateLabel(385, 173, 93, 22, "Wanteds:", false, PolizeiPC.tab[1])
        guiLabelSetVerticalAlign(PolizeiPC.label[3], "center")
        PolizeiPC.button[2] = guiCreateButton(386, 242, 221, 33, "Akte löschen", false, PolizeiPC.tab[1])
        guiSetProperty(PolizeiPC.button[2], "NormalTextColour", "FFAAAAAA")
        PolizeiPC.label[4] = guiCreateLabel(386, 285, 93, 22, "StVO:", false, PolizeiPC.tab[1])
        guiLabelSetVerticalAlign(PolizeiPC.label[4], "center")
        PolizeiPC.button[3] = guiCreateButton(385, 315, 221, 33, "StVO vergeben", false, PolizeiPC.tab[1])
        guiSetProperty(PolizeiPC.button[3], "NormalTextColour", "FFAAAAAA")
        PolizeiPC.button[4] = guiCreateButton(386, 358, 221, 33, "StVO löschen", false, PolizeiPC.tab[1])
        guiSetProperty(PolizeiPC.button[4], "NormalTextColour", "FFAAAAAA")

        PolizeiPC.tab[2] = guiCreateTab("Knastliste", PolizeiPC.tabpanel[1])

        PolizeiPC.gridlist[2] = guiCreateGridList(13, 13, 592, 363, false, PolizeiPC.tab[2])
        guiGridListAddColumn(PolizeiPC.gridlist[2], "Häftlingsname", 0.4)
        guiGridListAddColumn(PolizeiPC.gridlist[2], "Knast", 0.3)
        guiGridListAddColumn(PolizeiPC.gridlist[2], "Restzeit", 0.2)
        PolizeiPC.label[5] = guiCreateLabel(13, 386, 592, 30, "Rot markierte Spieler müssen noch in das Alkatraz überführt werden.", false, PolizeiPC.tab[2])
        guiLabelSetColor(PolizeiPC.label[5], 255,0,0)
        guiLabelSetHorizontalAlign(PolizeiPC.label[5], "center", false)
        guiLabelSetVerticalAlign(PolizeiPC.label[5], "center")

        PolizeiPC.label[7] = guiCreateLabel(13, 386, 592, 30, "Rot markierte Spieler müssen noch in das Alkatraz überführt werden.", false, PolizeiPC.tab[1])
        guiLabelSetColor(PolizeiPC.label[7], 255,0,0)
        guiLabelSetHorizontalAlign(PolizeiPC.label[7], "center", false)
        guiLabelSetVerticalAlign(PolizeiPC.label[7], "center")

        PolizeiPC.tab[3] = guiCreateTab("Blitzer", PolizeiPC.tabpanel[1])

        PolizeiPC.staticimage[1] = guiCreateStaticImage(10, 10, 400, 400, "FILES/IMAGES/radar.jpg", false, PolizeiPC.tab[3])
        PolizeiPC.label[6] = guiCreateLabel(422, 9, 53, 20, "BlitzerNr:", false, PolizeiPC.tab[3])
        guiLabelSetVerticalAlign(PolizeiPC.label[6], "center")
        PolizeiPC.edit[2] = guiCreateEdit(485, 9, 120, 20, "", false, PolizeiPC.tab[3])
        PolizeiPC.button[5] = guiCreateButton(421, 39, 184, 28, "Blitzer abbauen", false, PolizeiPC.tab[3])
        guiSetProperty(PolizeiPC.button[5], "NormalTextColour", "FFAAAAAA")
        PolizeiPC.button[6] = guiCreateButton(421, 109, 184, 28, "ALLE Blitzer abbauen", false, PolizeiPC.tab[3])
        guiSetProperty(PolizeiPC.button[6], "NormalTextColour", "FFAAAAAA")

        PolizeiPC.tab[4] = guiCreateTab("Polizeifahrzeuge", PolizeiPC.tabpanel[1])

        PolizeiPC.staticimage[2] = guiCreateStaticImage(9, 8, 400, 400, "FILES/IMAGES/radar.jpg", false, PolizeiPC.tab[4])
        PolizeiPC.scrollpane[1] = guiCreateScrollPane(418, 8, 187, 350, false, PolizeiPC.tab[4])


        --PolizeiPC.button[7] = guiCreateButton(419, 364, 186, 48, "Sofort Aktualisieren", false, PolizeiPC.tab[4])
        -- guiSetProperty(PolizeiPC.button[7], "NormalTextColour", "FFAAAAAA")


        PolizeiPC.button[8] = guiCreateButton(385, 23, 239, 23, "Herunterfahren", false, PolizeiPC.window[1])
        guiSetProperty(PolizeiPC.button[8], "NormalTextColour", "FFAAAAAA")
        guiSetProperty(PolizeiPC.button[8], "AlwaysOnTop", "True")


        addEventHandler("onClientGUIClick",PolizeiPC.button[8],closePolicePC, false)
        --addEventHandler("onClientGUIClick",PolizeiPC.button[7],aktualizePolizeiPC, false)


        addEventHandler("onClientGUIClick",PolizeiPC.button[1],PolicePC_setWanted, false)
        addEventHandler("onClientGUIClick",PolizeiPC.button[2],PolizeiPC_clearWanted, false)

        addEventHandler("onClientGUIClick",PolizeiPC.button[3],PolicePC_setStVO, false)
        addEventHandler("onClientGUIClick",PolizeiPC.button[4],PolizeiPC_delStVO, false)


        addEventHandler("onClientGUIClick",PolizeiPC.button[5],PolicePC_delBlitzer, false)
        addEventHandler("onClientGUIClick",PolizeiPC.button[6],PolizeiPC_delBlitzerAll, false)



        guiSetVisible ( PolizeiPC.window[1], false )

        for theKey, theGridlist in pairs(PolizeiPC.gridlist) do
            guiGridListSetSelectionMode ( theGridlist, 0)
        end
    end
)

function PolizeiPC_delBlitzerAll()
    triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"dblitzer","all")

end

function PolicePC_delBlitzer()
    local BlitzerNR=guiGetText(PolizeiPC.edit[2])

    if(BlitzerNR~="")then
        triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"dblitzer",BlitzerNR)

    else
        showError(getLocalPlayer(), "Bitte BlitzerNummer eingeben!")
    end
end


function PolicePC_delStVO()
    local selrow,col=guiGridListGetSelectedItem ( PolizeiPC.gridlist[1] )
    local username=nil
    if(selrow~=-1)then
        username=guiGridListGetItemText ( PolizeiPC.gridlist[1], selrow, 1 )
        local WantedAnz=guiGetText(PolizeiPC.edit[1])
        local WantedGrund=guiGetText(PolizeiPC.memo[1])

        if(WantedAnz~="" and WantedGrund~="")then
            triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"delstvo",WantedAnz.." "..username.." "..WantedGrund)

        else
            showError(getLocalPlayer(), "Bitte Grund und Anzahl eingeben!")
        end
    else
        showError(getLocalPlayer(), "Bitte Spieler auswählen!")
    end
end

function PolicePC_setStVO()
    local selrow,col=guiGridListGetSelectedItem ( PolizeiPC.gridlist[1] )
    local username=nil
    if(selrow~=-1)then
        username=guiGridListGetItemText ( PolizeiPC.gridlist[1], selrow, 1 )
        local WantedAnz=guiGetText(PolizeiPC.edit[1])
        local WantedGrund=guiGetText(PolizeiPC.memo[1])

        if(WantedAnz~="" and WantedGrund~="")then
            triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"stvo",WantedAnz.." "..username.." "..WantedGrund)

        else
            showError(getLocalPlayer(), "Bitte Grund und Anzahl eingeben!")
        end
    else
        showError(getLocalPlayer(), "Bitte Spieler auswählen!")
    end
end

function PolizeiPC_clearWanted()
    local selrow,col=guiGridListGetSelectedItem ( PolizeiPC.gridlist[1] )
    local username=nil
    if(selrow~=-1)then
        username=guiGridListGetItemText ( PolizeiPC.gridlist[1], selrow, 1 )
        local WantedGrund=guiGetText(PolizeiPC.memo[1])

        if(WantedGrund~="")then
            triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"clear",username.." "..WantedGrund)

        else
            showError(getLocalPlayer(), "Bitte Grund eingeben!")
        end
    else
        showError(getLocalPlayer(), "Bitte Spieler auswählen!")
    end
end

function PolicePC_setWanted()
    local selrow,col=guiGridListGetSelectedItem ( PolizeiPC.gridlist[1] )
    local username=nil
    if(selrow~=-1)then
        username=guiGridListGetItemText ( PolizeiPC.gridlist[1], selrow, 1 )
        local WantedAnz=guiGetText(PolizeiPC.edit[1])
        local WantedGrund=guiGetText(PolizeiPC.memo[1])

        if(WantedAnz~="" and WantedGrund~="")then
            triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"su",WantedAnz.." "..username.." "..WantedGrund)

        else
            showError(getLocalPlayer(), "Bitte Grund und Anzahl eingeben!")
        end
    else
       showError(getLocalPlayer(), "Bitte Spieler auswählen!")
    end
end



function aktualizePolizeiPCCheck()
    if(guiGetVisible( PolizeiPC.window[1]))then
        setTimer(aktualizePolizeiPCCheck,5000,1)
        aktualizePolizeiPC()
    end
end

addEvent("sendBlitzerPos",true)
addEventHandler("sendBlitzerPos",getRootElement(), function (blitzer)
--tempLabel erstellen und Fahrzeuge auf Karte darstellen
    for theKey, theLabel in ipairs(PolizeiPC.tempBlitzerLabel)do
        if(isElement)then
            destroyElement(theLabel)
        end
    end
    PolizeiPC.tempBlitzerLabel={}
    for theKey, theBlitzer in pairs(blitzer)do
        if(isElement(theBlitzer))then
            local x,y,z=getElementPosition(theBlitzer)

            local px=((x+3000)/6000)*400
            local py=(((-y)+3000)/6000)*400

            local label = guiCreateLabel(px-8+10, py-8+10, 16, 16, theKey, false,  PolizeiPC.tab[3])
            guiLabelSetColor ( label,0,255,0 )
            guiSetProperty(label, "AlwaysOnTop", "True")
            guiSetFont(label, "default-bold-small")
            guiLabelSetHorizontalAlign(label, "center", true)
            table.insert(PolizeiPC.tempBlitzerLabel,label)


            label = guiCreateStaticImage ( px-8+10, py-8+10, 16, 16, "FILES/IMAGES/ziel.png", false, PolizeiPC.tab[3] )
            guiSetProperty(label, "AlwaysOnTop", "True")
            table.insert(PolizeiPC.tempBlitzerLabel,label)
        end

    end

end)

function aktualizePolizeiPC()
    triggerServerEvent("sendMeBlitzerPos",getLocalPlayer())

    --tempLabel erstellen und Fahrzeuge auf Karte darstellen
    for theKey, theLabel in ipairs(PolizeiPC.tempLabel)do
        if(isElement)then
            destroyElement(theLabel)
        end
    end
    PolizeiPC.tempLabel={}
    local StartY=8
    local pos= guiScrollPaneGetVerticalScrollPosition ( PolizeiPC.scrollpane[1] )
    for theKey, theVehicle in ipairs(policeVehicles)do
        if(isAnyOneInVehicle(theVehicle))then
            local occupants=getVehicleOccupants(theVehicle)
            local pnamen={}
            for theOccKey, theOcc in pairs(occupants)do
                table.insert(pnamen,getPlayerName(theOcc))
            end
            local pnamenString=table.concat(pnamen,", ");

            local type=getVehicleNameFromModel ( getElementModel(theVehicle))

            local label = guiCreateLabel(9, StartY, 161, 43, "Fahrzeug: "..theKey.." - "..type.."\nBeamte: "..pnamenString, false, PolizeiPC.scrollpane[1])
            StartY=StartY+46
            guiSetFont(label, "default-bold-small")
            guiLabelSetHorizontalAlign(label, "left", true)
            table.insert(PolizeiPC.tempLabel,label)

            local x,y,z=getElementPosition(theVehicle)

            local px=((x+3000)/6000)*400
            local py=(((-y)+3000)/6000)*400

            local label = guiCreateLabel(px-8+9, py-16+8, 16, 16, theKey, false,  PolizeiPC.tab[4])
            guiLabelSetColor ( label,255,0,0 )
            guiSetProperty(label, "AlwaysOnTop", "True")
            guiSetFont(label, "default-bold-small")
            guiLabelSetHorizontalAlign(label, "left", true)
            table.insert(PolizeiPC.tempLabel,label)


            label = guiCreateStaticImage ( px-4+9, py-4+8, 8, 8, "FILES/IMAGES/ziel.png", false, PolizeiPC.tab[4] )
            guiSetProperty(label, "AlwaysOnTop", "True")
            table.insert(PolizeiPC.tempLabel,label)


        end
    end
    guiScrollPaneSetVerticalScrollPosition (PolizeiPC.scrollpane[1], pos )





    --WantedListe füllen
    local selrow,col=guiGridListGetSelectedItem ( PolizeiPC.gridlist[1] )
    local row=0

    local username=nil
    if(selrow~=-1)then
        username=guiGridListGetItemText ( PolizeiPC.gridlist[1], selrow, 1 )
    end

    guiGridListClear ( PolizeiPC.gridlist[1] )

    for theKey,thePlayer in ipairs(getElementsByType('player'))do
        row = guiGridListAddRow ( PolizeiPC.gridlist[1] )
        guiGridListSetItemText ( PolizeiPC.gridlist[1], row, 1, getPlayerName ( thePlayer ), false, false )
        if(getElementData(thePlayer,"stvo"))then

            guiGridListSetItemText ( PolizeiPC.gridlist[1], row, 2, getElementData(thePlayer,"stvo"), false, false )
            guiGridListSetItemText ( PolizeiPC.gridlist[1], row, 3, getElementData(thePlayer,"wanteds"), false, false )

        end

        if(getElementData(thePlayer,"mussAlka")==1)then
            guiGridListSetItemColor (PolizeiPC.gridlist[1], row, 1, 255, 0,0 )
            guiGridListSetItemColor (PolizeiPC.gridlist[1], row, 2, 255, 0,0 )
            guiGridListSetItemColor (PolizeiPC.gridlist[1], row, 3, 255, 0,0 )
        end

        if(username)then
            if(username==getPlayerName ( thePlayer ))then
                guiGridListSetSelectedItem ( PolizeiPC.gridlist[1], row, 1)
            end
        end
    end

    --KnastLeute Eintragen
    local selrow,col=guiGridListGetSelectedItem ( PolizeiPC.gridlist[2] )
    local row=0

    local username=nil
    if(selrow~=-1)then
        username=guiGridListGetItemText ( PolizeiPC.gridlist[2], selrow, 1 )
    end

    guiGridListClear ( PolizeiPC.gridlist[2] )

    for theKey,thePlayer in ipairs(getElementsByType('player'))do
        if(getElementData(thePlayer,"knastzeit"))then
           if(getElementData(thePlayer,"knastzeit")>0)then
                row = guiGridListAddRow ( PolizeiPC.gridlist[2] )
                guiGridListSetItemText ( PolizeiPC.gridlist[2], row, 1, getPlayerName ( thePlayer ), false, false )
                local knasttext="Los Santos"
                if(getElementData(thePlayer,"alkaknast")==1)then
                    knasttext="Alkatraz"
                elseif(getElementData(thePlayer,"alkaknast")==2)then
                    knasttext="Las Venturas"
                end
                guiGridListSetItemText ( PolizeiPC.gridlist[2], row, 2, knasttext, false, false )
                guiGridListSetItemText ( PolizeiPC.gridlist[2], row, 3, getElementData(thePlayer,"knastzeit").." / "..getElementData(thePlayer,"lastknastzeit"), false, false )

                if(getElementData(thePlayer,"mussAlka")==1)then
                    guiGridListSetItemColor (PolizeiPC.gridlist[2], row, 1, 255, 0,0 )
                    guiGridListSetItemColor (PolizeiPC.gridlist[2], row, 2, 255, 0,0 )
                    guiGridListSetItemColor (PolizeiPC.gridlist[2], row, 3, 255, 0,0 )
                end

                if(username)then
                    if(username==getPlayerName ( thePlayer ))then
                       guiGridListSetSelectedItem ( PolizeiPC.gridlist[2], row, 1)
                    end
                end
           end
       end
    end
end





function closePolicePC()
	guiSetVisible ( PolizeiPC.window[1], false )
	showCursor(false)
	toggleAllControls ( true, true, true )
end

addEvent("onShowPolicePC",true)
function onShowPolicePC_func(policeVehiclesNew)
    policeVehicles=policeVehiclesNew
	toggleAllControls ( false, true, true )
    guiSetVisible ( PolizeiPC.window[1], true )
    setTimer(aktualizePolizeiPCCheck,5000,1)
    aktualizePolizeiPC()
end
addEventHandler("onShowPolicePC",getRootElement(),onShowPolicePC_func)










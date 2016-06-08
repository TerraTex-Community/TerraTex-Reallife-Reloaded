
fraktionbezeichner={}
fraktionsrange={}

addEvent("receiveFrakData", true)
function receiveFrakData_func(frakBez, frakRang)
    fraktionbezeichner = frakBez
    fraktionsrange = frakRang
end
addEventHandler("receiveFrakData", getRootElement(), receiveFrakData_func)



JobName={"Fischer","Drogendealer","Muellmann","Busfahrer","Mechaniker","Detektiv","Hitman","Pizzalieferant","Anwalt","Waffendealer","Trucker","Pilot","Straßenreiniger","Farmer","Bergwerksarbeiter","Nutte","Meeresreiniger","Hotdogverkäufer"}

lastclicked=false

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
    function()
        triggerServerEvent("sendMeFrakData",getLocalPlayer())



        Interaktion_GUI_Window = {}
        Interaktion_GUI_TabPanel = {}
        Interaktion_GUI_Tab = {}
        Interaktion_GUI_Button = {}
        Interaktion_GUI_Label = {}
        Interaktion_GUI_Edit = {}
        Interaktion_GUI_Grid = {}
        Interaktion_GUI_Colum_Gebe={}

        Interaktion_GUI_Window[1] = guiCreateWindow(322,70,381,217,"Interaktion mit: xxxxxxxxx",false)
        table.insert(allGuis,Interaktion_GUI_Window[1])
        Interaktion_GUI_Button[1] = guiCreateButton(9,27,361,18,"Abbrechen!",false,Interaktion_GUI_Window[1])
        Interaktion_GUI_TabPanel[1] = guiCreateTabPanel(10,51,362,157,false,Interaktion_GUI_Window[1])
        Interaktion_GUI_Tab[1] = guiCreateTab("Geld",Interaktion_GUI_TabPanel[1])
        Interaktion_GUI_Button[2] = guiCreateButton(19,77,155,29,"Geben",false,Interaktion_GUI_Tab[1])
        Interaktion_GUI_Button[3] = guiCreateButton(182,77,157,27,"Betteln",false,Interaktion_GUI_Tab[1])
        Interaktion_GUI_Edit[1] = guiCreateEdit(14,36,324,33,"",false,Interaktion_GUI_Tab[1])
        Interaktion_GUI_Label[1] = guiCreateLabel(14,7,321,20,"Geldsumme:",false,Interaktion_GUI_Tab[1])
        guiLabelSetColor(Interaktion_GUI_Label[1],255,255,255)
        guiLabelSetVerticalAlign(Interaktion_GUI_Label[1],"center")
        guiLabelSetHorizontalAlign(Interaktion_GUI_Label[1],"center",false)
        Interaktion_GUI_Tab[2] = guiCreateTab("Geben",Interaktion_GUI_TabPanel[1])
        Interaktion_GUI_Grid[1] = guiCreateGridList(12,11,180,110,false,Interaktion_GUI_Tab[2])
        guiGridListSetSelectionMode(Interaktion_GUI_Grid[1],4)
        Interaktion_GUI_Colum_Gebe[1]=guiGridListAddColumn(Interaktion_GUI_Grid[1],"Was?",0.5)
        Interaktion_GUI_Colum_Gebe[2]=guiGridListAddColumn(Interaktion_GUI_Grid[1],"Menge",0.3)
        Interaktion_GUI_Label[2] = guiCreateLabel(212,24,108,30,"Menge:",false,Interaktion_GUI_Tab[2])
        guiLabelSetColor(Interaktion_GUI_Label[2],255,255,255)
        guiLabelSetVerticalAlign(Interaktion_GUI_Label[2],"top")
        guiLabelSetHorizontalAlign(Interaktion_GUI_Label[2],"left",false)
        Interaktion_GUI_Edit[2] = guiCreateEdit(258,20,78,29,"",false,Interaktion_GUI_Tab[2])
        Interaktion_GUI_Button[4] = guiCreateButton(228,59,106,34,"Geben",false,Interaktion_GUI_Tab[2])

        guiSetVisible(  Interaktion_GUI_Window[1] ,false)
		
        addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[4], geben_test_interaktion_Gui_func,false)
        addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[1], closeInterGuis_func, false )
        addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[2], payMoney_func,false)
        addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[3], bettelGui_func,false)
	

		
    end
)
function geben_test_interaktion_Gui_func()
    local menge=guiGetText(Interaktion_GUI_Edit[2])
    if(menge)then
        if(tonumber(menge))then
            if(tonumber(menge)<0)then
                menge=tonumber(menge)*-1
            end
        else
            menge=tonumber(menge)*-1
        end
    else
        menge=tonumber(menge)*-1
    end
	
    if(menge)then
        local auswahl=guiGridListGetItemText(Interaktion_GUI_Grid[1],guiGridListGetSelectedItem ( Interaktion_GUI_Grid[1]),1)
        triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"give",getPlayerName(lastclicked).." "..auswahl.." "..menge)
        setTimer(aktual_geben_interaktion,2000,1)
    end
end

function aktual_geben_interaktion()
    guiGridListClear ( Interaktion_GUI_Grid[1] )
    if(tonumber(getElementData(getLocalPlayer(),"drogen"))>0)then
        local row=guiGridListAddRow ( Interaktion_GUI_Grid[1] )
        guiGridListSetItemText (Interaktion_GUI_Grid[1] ,row,Interaktion_GUI_Colum_Gebe[1],"Drogen",false,false)
        guiGridListSetItemText (Interaktion_GUI_Grid[1] ,row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"drogen")),false,false)
    end
    if(tonumber(getElementData(getLocalPlayer(),"mats"))>0)then
        local row=guiGridListAddRow ( Interaktion_GUI_Grid[1] )
        guiGridListSetItemText (Interaktion_GUI_Grid[1] ,row,Interaktion_GUI_Colum_Gebe[1],"Materials",false,false)
        guiGridListSetItemText (Interaktion_GUI_Grid[1] ,row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"mats")),false,false)
    end
    if(tonumber(getElementData(getLocalPlayer(),"snack"))>0)then
        row=guiGridListAddRow ( Interaktion_GUI_Grid[1])
        guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[1],"Snack",false,false)
        guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"snack")),false,false)
									
    end
    if(tonumber(getElementData(getLocalPlayer(),"hamburger"))>0)then
        row=guiGridListAddRow ( Interaktion_GUI_Grid[1])
        guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[1],"Hamburger",false,false)
        guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"hamburger")),false,false)
									
    end
    if(tonumber(getElementData(getLocalPlayer(),"fertigessen"))>0)then
        row=guiGridListAddRow ( Interaktion_GUI_Grid[1])
        guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[1],"Fertigessen",false,false)
        guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"fertigessen")),false,false)
									
    end
    if(tonumber(getElementData(getLocalPlayer(),"schnellhilfe"))>0)then
        row=guiGridListAddRow ( Interaktion_GUI_Grid[1])
        guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[1],"Schnellhilfe",false,false)
        guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"schnellhilfe")),false,false)
									
    end

end

function payMoney_func()
    local moneyread=false
    moneyread=guiGetText(Interaktion_GUI_Edit[1])
    if moneyread then
        moneyread=tonumber(moneyread)
    else
        moneyread=false
    end
    if(not(moneyread))then
        showError(getLocalPlayer(),"Falsche Eingabe!")
    else
        triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"pay",getPlayerName(lastclicked).." "..moneyread)
    end
end

function bettelGui_func()
    local money=tonumber(guiGetText(Interaktion_GUI_Edit[1]))
    if(money==false)then
        showError(getLocalPlayer(),"Falsche Eingabe!")
    else
        triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"betteln",getPlayerName(lastclicked).." "..money)
    end
end

function addElementsForCops(bool)
    if(guiGetVisible(Interaktion_GUI_Window[1])==true)then
        if(bool==true)then
            if(not(Interaktion_GUI_Tab[3]))then
                Interaktion_GUI_Tab[3] = guiCreateTab("Fraktion!",Interaktion_GUI_TabPanel[1])
                Interaktion_GUI_Grid[2] = guiCreateGridList(11,10,172,118,false,Interaktion_GUI_Tab[3])
                guiGridListSetSelectionMode(Interaktion_GUI_Grid[2],2)
                local column=guiGridListAddColumn(Interaktion_GUI_Grid[2],"Was?",1.0)
                Interaktion_GUI_Button[5] = guiCreateButton(190,12,162,113,"Abnehmen!",false,Interaktion_GUI_Tab[3])
                local row=guiGridListAddRow ( Interaktion_GUI_Grid[2] )
                guiGridListSetItemText (Interaktion_GUI_Grid[2] ,row,column,"FahrzeugLizensen",false,false)
                local row=guiGridListAddRow ( Interaktion_GUI_Grid[2] )
                guiGridListSetItemText (Interaktion_GUI_Grid[2] ,row,column,"FlugLizensen",false,false)
                local row=guiGridListAddRow ( Interaktion_GUI_Grid[2] )
                guiGridListSetItemText (Interaktion_GUI_Grid[2] ,row,column,"WaffenLizens",false,false)
					
                Interaktion_GUI_Tab[4] = guiCreateTab("Fraktion",Interaktion_GUI_TabPanel[1])
                Interaktion_GUI_Button[6] = guiCreateButton(11,12,117,26,"Entwaffnen",false,Interaktion_GUI_Tab[4])
                Interaktion_GUI_Button[7] = guiCreateButton(9,45,119,25,"Grabben",false,Interaktion_GUI_Tab[4])
                Interaktion_GUI_Button[8] = guiCreateButton(8,77,122,31,"Illegales abnehmen",false,Interaktion_GUI_Tab[4])
                Interaktion_GUI_Button[9] = guiCreateButton(133,12,116,27,"Durchsuchen",false,Interaktion_GUI_Tab[4])
                Interaktion_GUI_Edit[10] = guiCreateEdit(253,14,99,26,"Grund ",false,Interaktion_GUI_Tab[4])
                Interaktion_GUI_Edit[3] = guiCreateEdit(181,44,78,28,"",false,Interaktion_GUI_Tab[4])
                Interaktion_GUI_Label[3] = guiCreateLabel(137,49,36,17,"Preis:",false,Interaktion_GUI_Tab[4])
                guiLabelSetColor(Interaktion_GUI_Label[3],255,255,255)
                guiLabelSetVerticalAlign(Interaktion_GUI_Label[3],"top")
                guiLabelSetHorizontalAlign(Interaktion_GUI_Label[3],"left",false)
                Interaktion_GUI_Button[11] = guiCreateButton(262,46,89,26,"Ticket",false,Interaktion_GUI_Tab[4])
                Interaktion_GUI_Edit[4] = guiCreateEdit(180,80,81,23,"",false,Interaktion_GUI_Tab[4])
                Interaktion_GUI_Edit[5] = guiCreateEdit(180,105,81,23,"",false,Interaktion_GUI_Tab[4])
                Interaktion_GUI_Label[4] = guiCreateLabel(139,81,42,20,"Zeit:",false,Interaktion_GUI_Tab[4])
                guiLabelSetColor(Interaktion_GUI_Label[4],255,255,255)
                guiLabelSetVerticalAlign(Interaktion_GUI_Label[4],"top")
                guiLabelSetHorizontalAlign(Interaktion_GUI_Label[4],"left",false)
                Interaktion_GUI_Label[5] = guiCreateLabel(131,105,45,18,"Kaution:",false,Interaktion_GUI_Tab[4])
                guiLabelSetColor(Interaktion_GUI_Label[5],255,255,255)
                guiLabelSetVerticalAlign(Interaktion_GUI_Label[5],"top")
                guiLabelSetHorizontalAlign(Interaktion_GUI_Label[5],"left",false)
                Interaktion_GUI_Button[12] = guiCreateButton(264,82,85,40,"Arrest",false,Interaktion_GUI_Tab[4])
			
                addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[5], cop_take_sonst_interaktion_Gui_func,false)
                addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[6], cop_take_weapons_interaktion_Gui_func,false)
                addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[7], cop_grab_interaktion_Gui_func,false)
                addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[8], cop_takeilligales_interaktion_Gui_func,false)
                addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[9], cop_frisk_interaktion_Gui_func,false)
                addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[11], cop_ticket_interaktion_Gui_func,false)
                addEventHandler ( "onClientGUIClick", Interaktion_GUI_Button[12], cop_arrest_interaktion_Gui_func,false)
		
            end
        else
            if(Interaktion_GUI_Tab[4])then
                guiDeleteTab(Interaktion_GUI_Tab[4],Interaktion_GUI_TabPanel[1])
                guiDeleteTab(Interaktion_GUI_Tab[3],Interaktion_GUI_TabPanel[1])
                Interaktion_GUI_Tab[3]=nil
                Interaktion_GUI_Tab[4]=nil
            end
        end
    end
end

function cop_take_sonst_interaktion_Gui_func()
    local auswahl=guiGridListGetItemText(Interaktion_GUI_Grid[2],guiGridListGetSelectedItem ( Interaktion_GUI_Grid[2]),1)
    triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"take",auswahl.." "..getPlayerName(lastclicked))



end

function cop_arrest_interaktion_Gui_func()
    local preis=guiGetText(Interaktion_GUI_Edit[3])
    local kaution=guiGetText(Interaktion_GUI_Edit[5])
    local zeit=guiGetText(Interaktion_GUI_Edit[4])
    if(preis)and(kaution)and(zeit)then
        triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"arrest",getPlayerName(lastclicked).." "..preis.." "..zeit.." "..kaution)
    end
end

function cop_ticket_interaktion_Gui_func()
    local reason=guiGetText(Interaktion_GUI_Edit[10])
    local preis=guiGetText(Interaktion_GUI_Edit[3])
    if(reason)and(preis)then
        triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"ticket",getPlayerName(lastclicked).." "..preis.." "..reason)
    end
end

function cop_take_weapons_interaktion_Gui_func()
    if(isElement(lastclicked))then
        triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"take","weapons "..getPlayerName(lastclicked))
    end
end

function cop_frisk_interaktion_Gui_func()

    triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"frisk",getPlayerName(lastclicked))

end

function cop_takeilligales_interaktion_Gui_func()

    triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"take","illegals "..getPlayerName(lastclicked))


end

function cop_grab_interaktion_Gui_func()
    triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"grab",getPlayerName(lastclicked))

end

addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
    function()
        Click_Self_GUI_Window = {}
        Click_Self_GUI_TabPanel = {}
        Click_Self_GUI_Tab = {}
        Click_Self_GUI_Button = {}
        Click_Self_GUI_Label = {}
        Click_Self_GUI_Edit = {}
        Click_Self_GUI_Progress = {}
        Click_Self_GUI_Grid = {}
        Click_Self_GUI_Column={}

        Click_Self_GUI_Window[1] = guiCreateWindow(219,25,500,264,"Click Me Self!",false)
        table.insert(allGuis,Click_Self_GUI_Window[1])
        Click_Self_GUI_Button[1] = guiCreateButton(9,25,482,19,"Abbrechen!",false,Click_Self_GUI_Window[1])
        Click_Self_GUI_TabPanel[1] = guiCreateTabPanel(10,48,479,207,false,Click_Self_GUI_Window[1])
        Click_Self_GUI_Tab[1] = guiCreateTab("Statistik",Click_Self_GUI_TabPanel[1])
        Click_Self_GUI_Grid[1] = guiCreateGridList(14,11,430,162,false,Click_Self_GUI_Tab[1])
        guiGridListSetSelectionMode(Click_Self_GUI_Grid[1],0)
        Click_Self_GUI_Column[1]=guiGridListAddColumn(Click_Self_GUI_Grid[1],"",0.5)
        Click_Self_GUI_Column[2]=guiGridListAddColumn(Click_Self_GUI_Grid[1],"",0.4)

        Click_Self_GUI_Tab[2] = guiCreateTab("Handy",Click_Self_GUI_TabPanel[1])
        Click_Self_GUI_Label[1] = guiCreateLabel(15,13,213,34,"Telefonnummer:",false,Click_Self_GUI_Tab[2])
        guiLabelSetColor(Click_Self_GUI_Label[1],255,255,255)
        guiLabelSetVerticalAlign(Click_Self_GUI_Label[1],"top")
        guiLabelSetHorizontalAlign(Click_Self_GUI_Label[1],"left",false)
        Click_Self_GUI_Edit[1] = guiCreateEdit(115,14,190,27,"",false,Click_Self_GUI_Tab[2])
        Click_Self_GUI_Button[2] = guiCreateButton(16,128,189,34,"Anrufen",false,Click_Self_GUI_Tab[2])
        Click_Self_GUI_Edit[2] = guiCreateEdit(112,51,358,31,"",false,Click_Self_GUI_Tab[2])
        Click_Self_GUI_Label[2] = guiCreateLabel(16,55,82,26,"SMS-Text:",false,Click_Self_GUI_Tab[2])
        guiLabelSetColor(Click_Self_GUI_Label[2],255,255,255)
        guiLabelSetVerticalAlign(Click_Self_GUI_Label[2],"top")
        guiLabelSetHorizontalAlign(Click_Self_GUI_Label[2],"left",false)
        Click_Self_GUI_Button[3] = guiCreateButton(15,89,195,33,"SMS senden!",false,Click_Self_GUI_Tab[2])
        Click_Self_GUI_Button[4] = guiCreateButton(221,95,238,72,"Handy Aus!",false,Click_Self_GUI_Tab[2])
        Click_Self_GUI_Tab[3] = guiCreateTab("Lizenzen",Click_Self_GUI_TabPanel[1])
        Click_Self_GUI_Progress[1] = guiCreateProgressBar(175,245,5,5,false,Click_Self_GUI_Tab[3])
        Click_Self_GUI_Grid[3] = guiCreateGridList(11,10,440,164,false,Click_Self_GUI_Tab[3])
        guiGridListSetSelectionMode(Click_Self_GUI_Grid[3],0)
        Click_Self_GUI_Column[5]=guiGridListAddColumn(Click_Self_GUI_Grid[3],"LizenzenName",0.7)
        Click_Self_GUI_Column[6]=guiGridListAddColumn(Click_Self_GUI_Grid[3],"im Besitz?",0.2)

        Click_Self_GUI_Tab[4] = guiCreateTab("Fahrzeuge",Click_Self_GUI_TabPanel[1])
        Click_Self_GUI_Grid[5] = guiCreateGridList(7,10,462,164,false,Click_Self_GUI_Tab[4])
        guiGridListSetSelectionMode(Click_Self_GUI_Grid[5],0)
        Click_Self_GUI_Column[9]=guiGridListAddColumn(Click_Self_GUI_Grid[5],"SlotID",0.1)
        Click_Self_GUI_Column[10]=guiGridListAddColumn(Click_Self_GUI_Grid[5],"Fahrzeugname",0.4)
        Click_Self_GUI_Column[11]=guiGridListAddColumn(Click_Self_GUI_Grid[5],"Aufenthaltsort",0.4)
        Click_Self_GUI_Tab[6] = guiCreateTab("Inventar",Click_Self_GUI_TabPanel[1])
        Click_Self_GUI_Grid[6] = guiCreateGridList(11,9,280,165,false,Click_Self_GUI_Tab[6])
        guiGridListSetSelectionMode(Click_Self_GUI_Grid[6],4)
        Click_Self_GUI_Column[12]=guiGridListAddColumn(Click_Self_GUI_Grid[6],"Was?",0.7)
        Click_Self_GUI_Column[13]=guiGridListAddColumn(Click_Self_GUI_Grid[6],"Menge?",0.2)
        Click_Self_GUI_Button[6] = guiCreateButton(303,21,157,32,"Wegwerfen!",false,Click_Self_GUI_Tab[6])
        Click_Self_GUI_Button[7] = guiCreateButton(302,61,160,31,"Nutzen",false,Click_Self_GUI_Tab[6])
        guiSetVisible(Click_Self_GUI_Window[1],false)
		
        addEventHandler ( "onClientGUIClick", Click_Self_GUI_Button[1], closeInterGuis_func, false )
        addEventHandler ( "onClientGUIClick", Click_Self_GUI_Button[2], call_Self_Gui_func,false)
        addEventHandler ( "onClientGUIClick", Click_Self_GUI_Button[3], sms_Self_Gui_func,false)
        addEventHandler ( "onClientGUIClick", Click_Self_GUI_Button[4], tog_Self_Gui_func,false)
        addEventHandler ( "onClientGUIClick", Click_Self_GUI_Button[6], drop_Self_Gui_func,false)
        addEventHandler ( "onClientGUIClick", Click_Self_GUI_Button[7], use_Self_Gui_func,false)
			
		
    end
)
function drop_Self_Gui_func()
    local auswahl=guiGridListGetItemText(Click_Self_GUI_Grid[6],guiGridListGetSelectedItem ( Click_Self_GUI_Grid[6]),1)
    triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"drop",auswahl)


end

function use_Self_Gui_func()
    local auswahl=guiGridListGetItemText(Click_Self_GUI_Grid[6],guiGridListGetSelectedItem ( Click_Self_GUI_Grid[6]),1)
    triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"use",auswahl)
    setTimer(aktual_using,2000,1)

end

function aktual_using()
    guiGridListClear( Click_Self_GUI_Grid[6])
    if(tonumber(getElementData(getLocalPlayer(),"drogen"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Drogen",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"drogen")),false,false)
								
    end
    if(tonumber(getElementData(getLocalPlayer(),"mats"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Materials",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"mats")),false,false)
								
    end
    if(tonumber(getElementData(getLocalPlayer(),"kanister"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Benzinkanister",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"kanister")),false,false)
						
    end
    if(tonumber(getElementData(getLocalPlayer(),"lottoschein"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Lottoscheine",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"lottoschein")),false,false)
							
    end
    if(tonumber(getElementData(getLocalPlayer(),"rubbellos"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Rubbellose",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"rubbellos")),false,false)
						
    end
    if(tonumber(getElementData(getLocalPlayer(),"snack"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Snack",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"snack")),false,false)
									
    end
    if(tonumber(getElementData(getLocalPlayer(),"hamburger"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Hamburger",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"hamburger")),false,false)
									
    end
    if(tonumber(getElementData(getLocalPlayer(),"fertigessen"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Fertigessen",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"fertigessen")),false,false)
							
    end
    if(tonumber(getElementData(getLocalPlayer(),"schnellhilfe"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Schnellhilfe",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"schnellhilfe")),false,false)
								
    end
    if(tonumber(getElementData(getLocalPlayer(),"carfinder"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Carfinder",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"carfinder")),false,false)
    end
    if(tonumber(getElementData(getLocalPlayer(),"terralapptapp"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"TerraLappTapp",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"terralapptapp")),false,false)
									
    end
    if(tonumber(getElementData(getLocalPlayer(),"adgutscheine"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"AD-Gutscheine",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"adgutscheine")),false,false)
    end
    if(tonumber(getElementData(getLocalPlayer(),"dice"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Würfel",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"dice")),false,false)
    end

    if(tonumber(getElementData(getLocalPlayer(),"Kondome"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Kondome",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"Kondome")),false,false)
    end


    if(tonumber(getElementData(getLocalPlayer(),"blutmesser"))>0)then
        row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Blutteststreifen",false,false)
        guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"blutmesser")),false,false)
    end
end

function tog_Self_Gui_func()
    triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"togglephone")

end

function sms_Self_Gui_func()
    local telenr=guiGetText(Click_Self_GUI_Edit[1])
    local smstext=guiGetText(Click_Self_GUI_Edit[2])
    if(telenr)and(smstext)then
        triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"sms",telenr.." "..smstext)
    end
end

function call_Self_Gui_func()
    local telenr=guiGetText(Click_Self_GUI_Edit[1])
    if(telenr)then
        triggerServerEvent("executeServerCommandHandler",getLocalPlayer(),"call",telenr)
        closeInterGuis_func()
    end
end

function addTabForAdmins(bool)
    if(guiGetVisible(Click_Self_GUI_Window[1])==true)then
        if(bool==true)then
            if(not(Click_Self_GUI_Tab[5]))then
                Click_Self_GUI_Tab[5] = guiCreateTab("Admin",Click_Self_GUI_TabPanel[1])
                Click_Self_GUI_Button[5] = guiCreateButton(11,12,454,161,"AdminGUI Oeffnen!",false,Click_Self_GUI_Tab[5])
                addEventHandler("onClientGUIClick", Click_Self_GUI_Button[5], pressAdminButton,false)
            end
        else
            if(Click_Self_GUI_Tab[5])then
                guiDeleteTab(Click_Self_GUI_Tab[5],Click_Self_GUI_TabPanel[1])
                Click_Self_GUI_Tab[5]=nil
            end
        end
    end
end

function pressAdminButton()
    triggerEvent("showAdminGui_Event",getLocalPlayer(),getLocalPlayer())
end

function closeInterGuis_func()
    if(guiGetVisible(Interaktion_GUI_Window[1])==true)then
        addElementsForCops(false)
    end
    addTabForAdmins(false)
    guiSetVisible(  Interaktion_GUI_Window[1] ,false)
    guiSetVisible(  Click_Self_GUI_Window[1],false)
    toggleAllControls(true)
    lastclicked=false
    showCursor(false)
end

function openInventar()
    if not(isAnyGuiVisible()) then
        onClientInterClick_func("left", "down", 0, 0, 0, 0, 0, getLocalPlayer())
        guiSetSelectedTab ( Click_Self_GUI_TabPanel[1],Click_Self_GUI_Tab[6] )
    end
end

function onClientInterClick_func(button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement)
    if(clickedElement) and (button=="left") and (state=="down")then
        local elementtype=getElementType(clickedElement)
        if not(isAnyGuiVisible())then
            if(elementtype=="player")then
                local x,y,z=getElementPosition(getLocalPlayer())
                local ex,ey,ez=getElementPosition(clickedElement)
                local dis=getDistanceBetweenPoints3D(x,y,z,ex,ey,ez)
                if(dis<8)then
                    toggleAllControls(false)
                    if(clickedElement==getLocalPlayer())then
                        guiSetVisible(Click_Self_GUI_Window[1],true)
                        showCursor(true)
                        lastclicked=clickedElement
                        guiGridListClear(Click_Self_GUI_Grid[1])
                        guiGridListClear(Click_Self_GUI_Grid[3])
                        guiGridListClear(Click_Self_GUI_Grid[5])
                        guiGridListClear(Click_Self_GUI_Grid[6])
                        --Statistik GridList
                        local row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Name:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],getPlayerName(getLocalPlayer()),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Geld:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],getPlayerMoney(getLocalPlayer()),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Bankkonto:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getPlayerBank(getLocalPlayer())),false,false)
                        if(tonumber(getElementData(getLocalPlayer(),"fraktion"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Fraktion:",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],fraktionbezeichner[tonumber(getElementData(getLocalPlayer(),"fraktion"))],false,false)
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Fraktionsrang:",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],fraktionsrange[tonumber(getElementData(getLocalPlayer(),"fraktion"))][tonumber(getElementData(getLocalPlayer(),"fraktionsrang"))],false,false)
                        else
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Fraktion:",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],"Zivilist",false,false)
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"job"))==0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Job:",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],"Keiner",false,false)
                        else
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Job:",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],JobName[tonumber(getElementData(getLocalPlayer(),"job"))],false,false)
                        end
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Telefonnummer:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"telefon")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"TelefonStatus:",false,false)
                        local teletext="ausgeschaltet"
                        if(tonumber(getElementData(getLocalPlayer(),"telefontoggle"))==0)then
                            teletext="angeschaltet"
                        end
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],teletext,false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Spielzeit in Minuten:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"playtime")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Spielzeit in Stunden:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(math.round(tonumber(getElementData(getLocalPlayer(),"playtime"))/60,1)),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Gestorben gesamt:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"tode")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Gestorben letzte Stunde :",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"todelast")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Warns:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"warns")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"StVO:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"stvo")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Wanteds:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"wanteds")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Max. VehicleSlots:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"maxslots")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"SkinID:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"skinid")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Verheiratet:",false,false)
                        verheiratetstring=""
                        if(tonumber(getElementData(getLocalPlayer(),"verheiratet"))==0)then
                            verheiratetstring="Nein"
                        else
                            verheiratetstring=tostring(getElementData(getLocalPlayer(),"verheiratetMitName"))
                        end
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],verheiratetstring,false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Hufeisen:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],tostring(getElementData(getLocalPlayer(),"Hufeisen")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"JobSkills:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],"Nutze /skill",false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[1])
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[1],"Pokale:",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[1],row,Click_Self_GUI_Column[2],"Nutze /pokal",false,false)
                        --Lizensengridlist
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Autoführerschein",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"autoLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Truckerlizenz",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"truckLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Flugzeuglizenz",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"planeLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Motorradführerschein",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"bikeLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Bootslizenz",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"boatLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Helikopterlizenz",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"heliLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Quadlizenz",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"quadLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Spezialfahrzeuglizenz",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"sonstigeLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Angelschein",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"angelLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Waffenschein",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"waffenLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Personalausweis",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"persoLic")),false,false)
                        row=guiGridListAddRow ( Click_Self_GUI_Grid[3])
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[5],"Reisepass",false,false)
                        guiGridListSetItemText(Click_Self_GUI_Grid[3],row,Click_Self_GUI_Column[6],changeJaNein_Interaktion(getElementData(getLocalPlayer(),"reiseLic")),false,false)
                        --FahrzeugGridlist
                        local maxslots=tonumber(getElementData(getLocalPlayer(),"maxslots"))
                        for n=1,maxslots,1 do
                            local vehele=getElementData(getLocalPlayer(),"slot"..n)
                            if(vehele~=-1)then
                                if(vehele~=-2)then
                                    if not(tonumber(vehele))then
                                        local vehname=getVehicleNameFromModel (getElementModel(vehele))
                                        --local zone=getElementZoneName(vehele)
                                        row=guiGridListAddRow ( Click_Self_GUI_Grid[5])
                                        triggerServerEvent("getZoneForClientGui",getLocalPlayer(),n,row)
                                        guiGridListSetItemText(Click_Self_GUI_Grid[5],row,Click_Self_GUI_Column[9],tostring(n),false,false)
                                        guiGridListSetItemText(Click_Self_GUI_Grid[5],row,Click_Self_GUI_Column[10],vehname,false,false)
                                        --guiGridListSetItemText(Click_Self_GUI_Grid[5],row,Click_Self_GUI_Column[11],zone,false,false)
                                    end
                                else
                                    row=guiGridListAddRow ( Click_Self_GUI_Grid[5])
                                    guiGridListSetItemText(Click_Self_GUI_Grid[5],row,Click_Self_GUI_Column[9],tostring(n),false,false)
                                    guiGridListSetItemText(Click_Self_GUI_Grid[5],row,Click_Self_GUI_Column[10],"Abgeschleppt",false,false)
									
                                end
                            end
                        end
                        --interaktionsgridlist
                        if(tonumber(getElementData(getLocalPlayer(),"drogen"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Drogen",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"drogen")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"mats"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Materials",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"mats")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"kanister"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Benzinkanister",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"kanister")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"lottoschein"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Lottoscheine",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"lottoschein")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"rubbellos"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Rubbellose",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"rubbellos")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"snack"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Snack",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"snack")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"hamburger"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Hamburger",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"hamburger")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"fertigessen"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Fertigessen",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"fertigessen")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"schnellhilfe"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Schnellhilfe",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"schnellhilfe")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"carfinder"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Carfinder",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"carfinder")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"Hufeisenhelfer"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Hufeisenhelfer",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"Hufeisenhelfer")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"terralapptapp"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"TerraLappTapp",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"terralapptapp")),false,false)
									
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"adgutscheine"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"AD-Gutscheine",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"adgutscheine")),false,false)
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"dice"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Würfel",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"dice")),false,false)
                        end

                        if(tonumber(getElementData(getLocalPlayer(),"Kondome"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Kondome",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"Kondome")),false,false)
                        end

                        if(tonumber(getElementData(getLocalPlayer(),"blutmesser"))>0)then
                            row=guiGridListAddRow ( Click_Self_GUI_Grid[6])
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[12],"Blutteststreifen",false,false)
                            guiGridListSetItemText(Click_Self_GUI_Grid[6],row,Click_Self_GUI_Column[13],tostring(getElementData(getLocalPlayer(),"blutmesser")),false,false)
                        end
		
                        --addAdmin
                        if(isAdminLevel(getLocalPlayer(),0))then
                            addTabForAdmins(true)
                        else
                            addTabForAdmins(false)
                        end
                    else
                        guiSetVisible(Interaktion_GUI_Window[1],true)
                        guiGridListClear ( Interaktion_GUI_Grid[1] )
                        if(tonumber(getElementData(getLocalPlayer(),"drogen"))>0)then
                            local row=guiGridListAddRow ( Interaktion_GUI_Grid[1] )
                            guiGridListSetItemText (Interaktion_GUI_Grid[1] ,row,Interaktion_GUI_Colum_Gebe[1],"Drogen",false,false)
                            guiGridListSetItemText (Interaktion_GUI_Grid[1] ,row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"drogen")),false,false)
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"mats"))>0)then
                            local row=guiGridListAddRow ( Interaktion_GUI_Grid[1] )
                            guiGridListSetItemText (Interaktion_GUI_Grid[1] ,row,Interaktion_GUI_Colum_Gebe[1],"Materials",false,false)
                            guiGridListSetItemText (Interaktion_GUI_Grid[1] ,row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"mats")),false,false)
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"snack"))>0)then
                            row=guiGridListAddRow ( Interaktion_GUI_Grid[1])
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[1],"Snack",false,false)
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"snack")),false,false)
														
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"hamburger"))>0)then
                            row=guiGridListAddRow ( Interaktion_GUI_Grid[1])
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[1],"Hamburger",false,false)
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"hamburger")),false,false)
														
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"fertigessen"))>0)then
                            row=guiGridListAddRow ( Interaktion_GUI_Grid[1])
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[1],"Fertigessen",false,false)
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"fertigessen")),false,false)
														
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"schnellhilfe"))>0)then
                            row=guiGridListAddRow ( Interaktion_GUI_Grid[1])
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[1],"Schnellhilfe",false,false)
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"schnellhilfe")),false,false)
														
                        end
                        if(tonumber(getElementData(getLocalPlayer(),"kanister"))>0)then
                            row=guiGridListAddRow ( Interaktion_GUI_Grid[1])
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[1],"Benzinkanister",false,false)
                            guiGridListSetItemText(Interaktion_GUI_Grid[1],row,Interaktion_GUI_Colum_Gebe[2],tostring(getElementData(getLocalPlayer(),"kanister")),false,false)
														
                        end
					
					
					
					
					
					
					
					
					
                        showCursor(true)
                        lastclicked=clickedElement
                        local playerName=getPlayerName(lastclicked)
                        guiSetText(Interaktion_GUI_Window[1],string.format("Interaktion mit %s", playerName))
                        if(tonumber(getElementData(getLocalPlayer(),"fraktion"))==1) or (tonumber(getElementData(getLocalPlayer(),"fraktion"))==5)or (tonumber(getElementData(getLocalPlayer(),"fraktion"))==7)or (tonumber(getElementData(getLocalPlayer(),"fraktion"))==9)then
                            addElementsForCops(true)
                        else
                            addElementsForCops(false)
                            if(isAdminLevel(getLocalPlayer(),1))then
                                addElementsForCops(true)
                                guiDeleteTab(Interaktion_GUI_Tab[4],Interaktion_GUI_TabPanel[1])
                            end
                        end
					
                    end
                end
            end
        end
    end
end
addEventHandler ( "onClientClick", getRootElement(), onClientInterClick_func )
addEvent("openInterGui",true)
addEventHandler("openInterGui",getRootElement(),onClientInterClick_func)

function setZoneNameForGui_func(row,zonename)
    if(zonename)then
        guiGridListSetItemText(Click_Self_GUI_Grid[5],row,Click_Self_GUI_Column[11],zonename,false,false)
    else
        guiGridListSetItemText(Click_Self_GUI_Grid[5],row,Click_Self_GUI_Column[11],"unbekannt",false,false)
    end
end
addEvent("setZoneNameForGui",true)
addEventHandler("setZoneNameForGui",getRootElement(),setZoneNameForGui_func)

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function changeJaNein_Interaktion(number)
    if(tonumber(number)==1)then
        return "Ja"
    else
        return "Nein"
    end
end









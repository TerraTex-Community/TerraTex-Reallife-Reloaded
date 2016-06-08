Social = {
    window = {},
    gridlist = {},
    button = {},
    label = {},
	column={}
}

addEvent("showsocial_event",true)

function showsocial_event_func(status, statustable)
	guiSetVisible(Social.window[1],true)
	showCursor(true)
	guiSetText(Social.label[2],tostring(status))
	guiGridListClear ( Social.gridlist[1] )
	
	for theKey, theTable in ipairs(statustable) do
		row=guiGridListAddRow ( Social.gridlist[1] )
		guiGridListSetItemText ( Social.gridlist[1], row, Social.column[1], theTable[1], false,false)
		guiGridListSetItemText ( Social.gridlist[1], row, Social.column[2], theTable[2], false,false)
		
		if(theTable[3]=="red")then
			guiGridListSetItemColor ( Social.gridlist[1], row, Social.column[1], 255,0,0)
			guiGridListSetItemColor ( Social.gridlist[1], row, Social.column[2], 255,0,0)
		elseif(theTable[3]=="green")then
			guiGridListSetItemColor ( Social.gridlist[1], row, Social.column[1], 0,255,0 )
			guiGridListSetItemColor ( Social.gridlist[1], row, Social.column[2], 0,255,0)
		else
			guiGridListSetItemColor ( Social.gridlist[1], row, Social.column[1], 255,255,0 )
			guiGridListSetItemColor ( Social.gridlist[1], row, Social.column[2], 255,255,0)		
		end
	end
	
end
addEventHandler("showsocial_event",getRootElement(),showsocial_event_func)

addEventHandler("onClientResourceStart", resourceRoot,
    function()
	local dx,dy=guiGetScreenSize()
		dx=644/1920*dx
		dy=319/1080*dy
		
        Social.window[1] = guiCreateWindow(dx, dy, 602, 425, "Dein Sozialstatus", false)
		table.insert(allGuis,Social.window[1])
        guiWindowSetSizable(Social.window[1], false)

        Social.label[1] = guiCreateLabel(26, 37, 143, 19, "Dein Sozialstatus beträgt: ", false, Social.window[1])
        Social.label[2] = guiCreateLabel(174, 37, 93, 18, "0", false, Social.window[1])
        Social.label[3] = guiCreateLabel(26, 56, 556, 48, "Dein Sozialstatus ist in der folgenden Tabelle aufgeschlüsselt. Rot, sind Punkte bei dennen du keinen Sozialstatus hast. Gelb kann noch verbessert werden. Grün bedeutet, du hast den Maximalen Sozialstatus erreicht.", false, Social.window[1])
        guiLabelSetHorizontalAlign(Social.label[3], "left", true)
        Social.button[1] = guiCreateButton(26, 381, 556, 26, "Beenden", false, Social.window[1])
        Social.gridlist[1] = guiCreateGridList(26, 112, 556, 259, false, Social.window[1])
        Social.column[1]=guiGridListAddColumn(Social.gridlist[1], "Name / Beschreibung", 0.4)
        Social.column[2]=guiGridListAddColumn(Social.gridlist[1], "Wert", 0.4)    
		addEventHandler ( "onClientGUIClick", Social.button[1], SozialBeendenButtonClick, false )
		guiSetVisible(Social.window[1],false)
    end
)
function SozialBeendenButtonClick()
	guiSetVisible(Social.window[1],false)
end









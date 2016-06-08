

function createStadthallenGui()

Stadthalle_Window = {}
Stadthalle_TabPanel = {}
Stadthalle_Tab = {}
Stadthalle_Label = {}
Stadthalle_Grid = {}
Stadthalle_Button = {}


Stadthalle_Window[1] = guiCreateWindow(365,242,400,358,"Stadthallen Infocenter",false)
table.insert(allGuis,Stadthalle_Window[1])
Stadthalle_Label[1] = guiCreateLabel(18,46,354,66,"Willkommen in der Stadthalle! \nWir sind schlicht aber versuchen fuer Sie da zu sein! \nWas wollen Sie tun?",false,Stadthalle_Window[1])
guiLabelSetColor(Stadthalle_Label[1],255,255,255)
guiLabelSetVerticalAlign(Stadthalle_Label[1],"top")
guiLabelSetHorizontalAlign(Stadthalle_Label[1],"left",false)
Stadthalle_TabPanel[1] = guiCreateTabPanel(9,103,380,244,false,Stadthalle_Window[1])
Stadthalle_Tab[1] = guiCreateTab("Lizensenkaufen",Stadthalle_TabPanel[1])
Stadthalle_Grid[1] = guiCreateGridList(19,16,222,191,false,Stadthalle_Tab[1])
guiGridListSetSortingEnabled (Stadthalle_Grid[1],false )
guiGridListSetSelectionMode(Stadthalle_Grid[1],0)
guiGridListAddColumn(Stadthalle_Grid[1],"Lizens",0.7)
guiGridListAddColumn(Stadthalle_Grid[1],"Preis",0.2)
Stadthalle_Button[1] = guiCreateButton(262,31,107,30,"Kaufen!",false,Stadthalle_Tab[1])
Stadthalle_Tab[2] = guiCreateTab("Credits",Stadthalle_TabPanel[1])
local credits="Dieses Reallife Script basiert auf dem TerraTex Reallife Script."
credits=credits.." TerraTex Reallife Script von Colin Weber (terratex.eu) ist lizenziert unter einer Creative Commons Namensnennung-Nicht kommerziell 4.0 International Lizenz."
credits=credits.."\nMeldet Bugs bitte unter"..config["bugdomain"]
credits=credits.."\nFuer Hilfestellungen nutze /report\nEine Adminliste erhälst du mit /admins"
	
Stadthalle_Label[2] = guiCreateLabel(12,21,356,184,credits,false,Stadthalle_Tab[2])
guiLabelSetColor(Stadthalle_Label[2],255,255,255)
guiLabelSetVerticalAlign(Stadthalle_Label[2],"top")
guiLabelSetHorizontalAlign(Stadthalle_Label[2],"left",true)


Stadthalle_Button[2] = guiCreateButton(208,20,177,31,"Beenden",false,Stadthalle_Window[1])

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Autofuehrerschein", false,false)
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "150", false,true)

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Trucklizens", false,false)
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "300", false,true)

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Fluglizens", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "20000", false,true )

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Motorradfuehrerschein", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "500", false,true )

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Helicopterlizens", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "10000", false,true )

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Bootslizens", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "3000", false,true )

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Quadlizens", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "100", false,true )

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Spezialfuehrerschein", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "150", false,true )

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Waffenschein", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "5000", false,true )

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Angellizens", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "25", false,true )

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Personalausweis", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "350", false,true )

rows=guiGridListAddRow(Stadthalle_Grid[1])
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 1, "Reisepass", false,false )
guiGridListSetItemText ( Stadthalle_Grid[1], rows, 2, "1500", false,true )


guiSetVisible(Stadthalle_Window[1],false)

addEventHandler( "onClientGUIClick", Stadthalle_Button[1], scheinkaufen, false )
addEventHandler( "onClientGUIClick", Stadthalle_Button[2], stadthallebeenden, false )



end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),createStadthallenGui)


function scheinkaufen()
	if(guiGridListGetSelectedCount ( Stadthalle_Grid[1]) >0) then
		local selectedlizense,selctedcount=guiGridListGetSelectedItem(Stadthalle_Grid[1])
		selectedlizense=selectedlizense+1
		triggerServerEvent("buyLic",getLocalPlayer(),selectedlizense)
	
		

	else
        showError(getLocalPlayer(),"Du hast keine Lizens Ausgewaehlt!")
	end

end




function stadthallebeenden()
	guiSetVisible(Stadthalle_Window[1],false)
	showCursor(false)
	toggleAllControls(true)

end

function stadthalle_Gui()
	guiSetVisible(Stadthalle_Window[1],true)
	showCursor(true)
	toggleAllControls(false)
end
addEvent("openStadthalleGui",true)
addEventHandler("openStadthalleGui",getRootElement(),stadthalle_Gui)















        MuneGUI_Window = {}
        MuneGUI_Button = {}
        MuneGUI_Label = {}
        MuneGUI_Edit = {}
        MuneGUI_Grid = {}
		MuneGUI_Colums={}

addEventHandler("onClientResourceStart",resourceRoot,
    function()

        MuneGUI_Window[1] = guiCreateWindow(0.3344,0.2567,0.24,0.3744,"Munitionsentnahme",true)
        table.insert(allGuis,MuneGUI_Window[1])
		MuneGUI_Label[1] = guiCreateLabel(0.0703,0.1098,0.4818,0.1039,"Aktuell im Munitionsdepot:",true,MuneGUI_Window[1])
			guiLabelSetColor(MuneGUI_Label[1],255,255,255)
			guiLabelSetVerticalAlign(MuneGUI_Label[1],"top")
			guiLabelSetHorizontalAlign(MuneGUI_Label[1],"left",false)
        MuneGUI_Label[2] = guiCreateLabel(0.4922,0.1068,0.3073,0.0772,"0",true,MuneGUI_Window[1])
			guiLabelSetColor(MuneGUI_Label[2],255,255,255)
			guiLabelSetVerticalAlign(MuneGUI_Label[2],"top")
			guiLabelSetHorizontalAlign(MuneGUI_Label[2],"left",false)
        MuneGUI_Label[3] = guiCreateLabel(0.0833,0.2493,0.8568,0.1662,"Wähle deine Waffe und Wieviel Munition du dafuer entnehmen willst!",true,MuneGUI_Window[1])
			guiLabelSetColor(MuneGUI_Label[3],255,255,255)
			guiLabelSetVerticalAlign(MuneGUI_Label[3],"top")
			guiLabelSetHorizontalAlign(MuneGUI_Label[3],"left",true)
        MuneGUI_Grid[1] = guiCreateGridList(0.0547,0.4036,0.401,0.5312,true,MuneGUI_Window[1])
			guiGridListSetSelectionMode(MuneGUI_Grid[1],4)
			MuneGUI_Colums[1]=guiGridListAddColumn(MuneGUI_Grid[1],"ID",0.2)
			MuneGUI_Colums[2]=guiGridListAddColumn(MuneGUI_Grid[1],"Waffe",0.5)
        MuneGUI_Edit[1] = guiCreateEdit(0.4922,0.4451,0.4271,0.1068,"",true,MuneGUI_Window[1])
        MuneGUI_Label[4] = guiCreateLabel(0.513,0.3917,0.4609,0.0801,"Wieviel?",true,MuneGUI_Window[1])
			guiLabelSetColor(MuneGUI_Label[4],255,255,255)
			guiLabelSetVerticalAlign(MuneGUI_Label[4],"top")
			guiLabelSetHorizontalAlign(MuneGUI_Label[4],"left",false)
        MuneGUI_Button[1] = guiCreateButton(0.4974,0.5846,0.4375,0.07,"Entnehmen!",true,MuneGUI_Window[1])
		MuneGUI_Button[3] = guiCreateButton(0.4974,0.67655,0.4375,0.07,"Ausrüsten!",true,MuneGUI_Window[1])
		MuneGUI_Button[2] = guiCreateButton(0.4922,0.7685,0.4375,0.07,"Beenden",true,MuneGUI_Window[1] )
		
		--MuneGUI_Button[3] = guiCreateButton(0.4974,0.5846,0.4375,0.1424,"Entnehmen!",true,MuneGUI_Window[1])
		guiSetVisible(MuneGUI_Window[1],false)
		addEventHandler("onClientGUIClick",MuneGUI_Button[2],closeWTruckEntnahmeGUI)
		addEventHandler("onClientGUIClick",MuneGUI_Button[1],getoutWTruckEntnahmeGUI)
		addEventHandler("onClientGUIClick",MuneGUI_Button[3],ausrustenWTruckEntnahmeGUI)
	end
)

function closeWTruckEntnahmeGUI()
	guiSetVisible(MuneGUI_Window[1],false)
	showCursor(false)
end

function ausrustenWTruckEntnahmeGUI()
	triggerServerEvent("giveMeStandardAusrustung",getLocalPlayer())
end

function getoutWTruckEntnahmeGUI()
	local row,colo=guiGridListGetSelectedItem ( MuneGUI_Grid[1]  )
	if(row~=-1)then
		local id=tonumber(guiGridListGetItemText ( MuneGUI_Grid[1] , row, colo ))
		local howMayText=guiGetText(MuneGUI_Edit[1])
		if(howMayText~="")then
			local howMay=tonumber(howMayText)
			if(howMay)then
				triggerServerEvent("GetMunOutOfFrakMun",getLocalPlayer(),howMay,id)
			else
				showError(getLocalPlayer(),"Du hast nicht angegeben Wie Viel!")
			end		
		else
			showError(getLocalPlayer(),"Du hast nicht angegeben Wie Viel!")
		end
	else
		showError(getLocalPlayer(),"Du hast keine Waffe ausgewählt!")
	end
end


addEvent("aktualizeMunDepotGUI",true)
addEvent("showMunTruckEntnahmeGUI",true)
function showMunTruckEntnahmeGUI_func(restmun)
	guiSetText(MuneGUI_Label[2],tostring(restmun))
	guiSetVisible(MuneGUI_Window[1],true)
	showCursor(true)
	guiGridListClear(MuneGUI_Grid[1])
	id=false
	row=false
	for coun=1,12,1 do
		id=getPedWeapon (getLocalPlayer(), coun)--0-13
		if(id~=0 and id~=false)then
			row=guiGridListAddRow ( MuneGUI_Grid[1])			
			guiGridListSetItemText ( MuneGUI_Grid[1], row, MuneGUI_Colums[1], tostring(id), false, true)
			guiGridListSetItemText ( MuneGUI_Grid[1], row, MuneGUI_Colums[2], getWeaponNameFromID ( id ), false, false)
		end
	end
end
addEventHandler("showMunTruckEntnahmeGUI",getRootElement(),showMunTruckEntnahmeGUI_func)
addEventHandler("aktualizeMunDepotGUI",getRootElement(),showMunTruckEntnahmeGUI_func)














local newcolorstring="0|0|0|0"
local newtuningstring="0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0|0"
local pricing=0
local hitElement=false
local newpaintjob=0
local UpgradeNames={}
local lastElement=false
local wasColorChanged=false
local UpSlotPrice={4000,4500,6500,4000,6000,6000,2000,4500,15000,9000,1000,4000,8000,4000,8000,6000,4000}
function loadupgradenames()
 
 UpgradeNames[1000]="Pro" 
 UpgradeNames[1001]="Win" 
 UpgradeNames[1002]="Drag" 
 UpgradeNames[1003]="Alpha" 
 UpgradeNames[1004]="Champ Scoop" 
 UpgradeNames[1005]="Fury Scoop" 
 UpgradeNames[1006]="Roof Scoop" 
 UpgradeNames[1007]="Right Sideskirt" 
 UpgradeNames[1008]="5 times"
 UpgradeNames[1009]="2 times" 
 UpgradeNames[1010]="10 times" 
 UpgradeNames[1011]="Race Scoop" 
 UpgradeNames[1012]="Worx Scoop" 
 UpgradeNames[1013]="Round Fog" 
 UpgradeNames[1014]="Champ" 
 UpgradeNames[1015]="Race" 
 UpgradeNames[1016]="Worx" 
 UpgradeNames[1017]="Left Sideskirt" 
 UpgradeNames[1018]="Upswept" 
 UpgradeNames[1019]="Twin" 
 UpgradeNames[1020]="Large" 
 UpgradeNames[1021]="Medium" 
 UpgradeNames[1022]="Small" 
 UpgradeNames[1023]="Fury" 
 UpgradeNames[1024]="Square Fog" 
 UpgradeNames[1025]="Offroad" 
 UpgradeNames[1026]="Right Alien Sideskirt" 
 UpgradeNames[1027]="Left Alien Sideskirt" 
 UpgradeNames[1028]="Alien" 
 UpgradeNames[1029]="X-Flow" 
 UpgradeNames[1030]="Left X-Flow Sideskirt" 
 UpgradeNames[1031]="Right X-Flow Sideskirt" 
 UpgradeNames[1032]="Alien Roof Vent" 
 UpgradeNames[1033]="X-Flow Roof Vent" 
 UpgradeNames[1034]="Alien" 
 UpgradeNames[1035]="X-Flow Roof Vent" 
 UpgradeNames[1036]="Right Alien Sideskirt" 
 UpgradeNames[1037]="X-Flow" 
 UpgradeNames[1038]="Alien Roof Vent" 
 UpgradeNames[1039]="Left X-Flow Sideskirt" 
 UpgradeNames[1040]="Left Alien Sideskirt" 
 UpgradeNames[1041]="Right X-Flow Sideskirt" 
 UpgradeNames[1042]="Right Chrome Sideskirt" 
 UpgradeNames[1043]="Slamin"
 UpgradeNames[1044]="Chrome" 
 UpgradeNames[1045]="X-Flow" 
 UpgradeNames[1046]="Alien" 
 UpgradeNames[1047]="Right Alien Sideskirt" 
 UpgradeNames[1048]="Right X-Flow Sideskirt" 
 UpgradeNames[1049]="Alien" 
 UpgradeNames[1050]="X-Flow" 
 UpgradeNames[1051]="Left Alien Sideskirt" 
 UpgradeNames[1052]="Left X-Flow Sideskirt" 
 UpgradeNames[1053]="X-Flow" 
 UpgradeNames[1054]="Alien" 
 UpgradeNames[1055]="Alien" 
 UpgradeNames[1056]="Right Alien Sideskirt"
 UpgradeNames[1057]="Right X-Flow Sideskirt" 
 UpgradeNames[1058]="Alien" 
 UpgradeNames[1059]="X-Flow" 
 UpgradeNames[1060]="X-Flow" 
 UpgradeNames[1061]="X-Flow" 
 UpgradeNames[1062]="Left Alien Sideskirt" 
 UpgradeNames[1063]="Left X-Flow Sideskirt" 
 UpgradeNames[1064]="Alien" 
 UpgradeNames[1065]="Alien" 
 UpgradeNames[1066]="X-Flow" 
 UpgradeNames[1067]="Alien" 
 UpgradeNames[1068]="X-Flow" 
 UpgradeNames[1069]="Right Alien Sideskirt" 
 UpgradeNames[1070]="Right X-Flow Sideskirt" 
 UpgradeNames[1071]="Left Alien Sideskirt" 
 UpgradeNames[1072]="Left X-Flow Sideskirt" 
 UpgradeNames[1073]="Shadow" 
 UpgradeNames[1074]="Mega" 
 UpgradeNames[1075]="Rimshine" 
 UpgradeNames[1076]="Wires" 
 UpgradeNames[1077]="Classic" 
 UpgradeNames[1078]="Twist" 
 UpgradeNames[1079]="Cutter" 
 UpgradeNames[1080]="Switch" 
 UpgradeNames[1081]="Grove" 
 UpgradeNames[1082]="Import" 
 UpgradeNames[1083]="Dollar" 
 UpgradeNames[1084]="Trance" 
 UpgradeNames[1085]="Atomic" 
 UpgradeNames[1086]="Stereo"
 UpgradeNames[1087]="Hydraulics" 
 UpgradeNames[1088]="Alien" 
 UpgradeNames[1089]="X-Flow" 
 UpgradeNames[1090]="Right Alien Sideskirt" 
 UpgradeNames[1091]="X-Flow" 
 UpgradeNames[1092]="Alien" 
 UpgradeNames[1093]="Right X-Flow Sideskirt" 
 UpgradeNames[1094]="Left Alien Sideskirt" 
 UpgradeNames[1095]="Right X-Flow Sideskirt" 
 UpgradeNames[1096]="Ahab" 
 UpgradeNames[1097]="Virtual" 
 UpgradeNames[1098]="Access" 
 UpgradeNames[1099]="Left Chrome Sideskirt" 
 UpgradeNames[1100]="Chrome Grill" 
 UpgradeNames[1101]="Left `Chrome Flames` Sideskirt" 
 UpgradeNames[1102]="Left `Chrome Strip` Sideskirt" 
 UpgradeNames[1103]="Covertible" 
 UpgradeNames[1104]="Chrome" 
 UpgradeNames[1105]="Slamin" 
 UpgradeNames[1106]="Right `Chrome Arches`" 
 UpgradeNames[1107]="Left `Chrome Strip` Sideskirt"
 UpgradeNames[1108]="Right `Chrome Strip` Sideskirt" 
 UpgradeNames[1109]="Chrome"
 UpgradeNames[1110]="Slamin" 
 UpgradeNames[1111]="Little Sign?" 
 UpgradeNames[1112]="Little Sign?" 
 UpgradeNames[1113]="Chrome" 
 UpgradeNames[1114]="Slamin" 
 UpgradeNames[1115]="Chrome" 
 UpgradeNames[1116]="Slamin" 
 UpgradeNames[1117]="Chrome" 
 UpgradeNames[1118]="Right `Chrome Trim` Sideskirt" 
 UpgradeNames[1119]="Right `Wheelcovers` Sideskirt" 
 UpgradeNames[1120]="Left `Chrome Trim` Sideskirt" 
 UpgradeNames[1121]="Left `Wheelcovers` Sideskirt" 
 UpgradeNames[1122]="Right `Chrome Flames` Sideskirt" 
 UpgradeNames[1123]="Bullbar Chrome Bars" 
 UpgradeNames[1124]="Left `Chrome Arches` Sideskirt" 
 UpgradeNames[1125]="Bullbar Chrome Lights" 
 UpgradeNames[1126]="Chrome Exhaust" 
 UpgradeNames[1127]="Slamin Exhaust" 
 UpgradeNames[1128]="Vinyl Hardtop" 
 UpgradeNames[1129]="Chrome" 
 UpgradeNames[1130]="Hardtop" 
 UpgradeNames[1131]="Softtop" 
 UpgradeNames[1132]="Slamin" 
 UpgradeNames[1133]="Right `Chrome Strip` Sideskirt" 
 UpgradeNames[1134]="Right `Chrome Strip` Sideskirt" 
 UpgradeNames[1135]="Slamin" 
 UpgradeNames[1136]="Chrome" 
 UpgradeNames[1137]="Left `Chrome Strip` Sideskirt" 
 UpgradeNames[1138]="Alien" 
 UpgradeNames[1139]="X-Flow" 
 UpgradeNames[1140]="X-Flow" 
 UpgradeNames[1141]="Alien" 
 UpgradeNames[1142]="Left Oval Vents" 
 UpgradeNames[1143]="Right Oval Vents" 
 UpgradeNames[1144]="Left Square Vents" 
 UpgradeNames[1145]="Right Square Vents" 
 UpgradeNames[1146]="X-Flow" 
 UpgradeNames[1147]="Alien" 
 UpgradeNames[1148]="X-Flow" 
 UpgradeNames[1149]="Alien"
 UpgradeNames[1150]="Alien" 
 UpgradeNames[1151]="X-Flow" 
 UpgradeNames[1152]="X-Flow" 
 UpgradeNames[1153]="Alien" 
 UpgradeNames[1154]="Alien" 
 UpgradeNames[1155]="Alien" 
 UpgradeNames[1156]="X-Flow" 
 UpgradeNames[1157]="X-Flow" 
 UpgradeNames[1158]="X-Flow" 
 UpgradeNames[1159]="Alien" 
 UpgradeNames[1160]="Alien" 
 UpgradeNames[1161]="X-Flow" 
 UpgradeNames[1162]="Alien" 
 UpgradeNames[1163]="X-Flow"
 UpgradeNames[1164]="Alien"
 UpgradeNames[1165]="X-Flow"
 UpgradeNames[1166]="Alien"
 UpgradeNames[1167]="X-Flow"
 UpgradeNames[1168]="Alien"
 UpgradeNames[1169]="Alien"
 UpgradeNames[1170]="X-Flow"
 UpgradeNames[1171]="Alien"
 UpgradeNames[1172]="X-Flow"
 UpgradeNames[1173]="X-Flow"
 UpgradeNames[1174]="Chrome"
 UpgradeNames[1175]="Slamin"
 UpgradeNames[1176]="Chrome"
 UpgradeNames[1177]="Slamin" 
 UpgradeNames[1178]="Slamin" 
 UpgradeNames[1179]="Chrome" 
 UpgradeNames[1180]="Chrome" 
 UpgradeNames[1181]="Slamin" 
 UpgradeNames[1182]="Chrome" 
 UpgradeNames[1183]="Slamin" 
 UpgradeNames[1184]="Chrome" 
 UpgradeNames[1185]="Slamin" 
 UpgradeNames[1186]="Slamin" 
 UpgradeNames[1187]="Chrome" 
 UpgradeNames[1188]="Slamin" 
 UpgradeNames[1189]="Chrome" 
 UpgradeNames[1190]="Slamin" 
 UpgradeNames[1191]="Chrome" 
 UpgradeNames[1192]="Chrome"
 UpgradeNames[1193]="Slamin"

end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),loadupgradenames)



addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),
    function()
        TuningGUI_Window = {}
        TuningGUI_Button = {}
        TuningGUI_Label = {}
        TuningGUI_Edit = {}
        TuningGUI_Grid = {}
        TuningGUI_Image = {}
		TuningGUI_Row={}
		TuningGUI_Column={}

		TuningGUI_Window[1] = guiCreateWindow(645,36,345,395,"Tuning",false)
		table.insert(allGuis,TuningGUI_Window[1])
		TuningGUI_Button[1] = guiCreateButton(219,32,104,27,"Einbauen",false,TuningGUI_Window[1])
		TuningGUI_Button[2] = guiCreateButton(221,68,105,28,"Ausbauen",false,TuningGUI_Window[1])
		--TuningGUI_Edit[1] = guiCreateEdit(253,413,5,0,"",false,TuningGUI_Window[1])
		TuningGUI_Grid[1] = guiCreateGridList(10,31,205,325,false,TuningGUI_Window[1])
			guiGridListSetSelectionMode(TuningGUI_Grid[1],4)
			TuningGUI_Column[1]=guiGridListAddColumn(TuningGUI_Grid[1],"ID",0.3)
			TuningGUI_Column[2]=guiGridListAddColumn(TuningGUI_Grid[1],"Element",0.4)			
			TuningGUI_Column[3]=guiGridListAddColumn(TuningGUI_Grid[1],"im F.",0.2)
		TuningGUI_Label[1] = guiCreateLabel(224,105,99,22,"Farben (25):",false,TuningGUI_Window[1])
			guiLabelSetColor(TuningGUI_Label[1],255,0,0)
			guiLabelSetVerticalAlign(TuningGUI_Label[1],"top")
			guiLabelSetHorizontalAlign(TuningGUI_Label[1],"left",false)
		TuningGUI_Edit[2] = guiCreateEdit(274,124,52,22,"0",false,TuningGUI_Window[1])
		TuningGUI_Edit[3] = guiCreateEdit(273,150,53,23,"0",false,TuningGUI_Window[1])
		TuningGUI_Edit[4] = guiCreateEdit(273,177,51,22,"0",false,TuningGUI_Window[1])
		TuningGUI_Edit[5] = guiCreateEdit(272,204,50,22,"0",false,TuningGUI_Window[1])
		TuningGUI_Label[2] = guiCreateLabel(225,126,45,22,"Color 1:",false,TuningGUI_Window[1])
			guiLabelSetColor(TuningGUI_Label[2],255,255,255)
			guiLabelSetVerticalAlign(TuningGUI_Label[2],"top")
			guiLabelSetHorizontalAlign(TuningGUI_Label[2],"left",false)
		TuningGUI_Label[3] = guiCreateLabel(225,153,52,18,"Color 2:",false,TuningGUI_Window[1])
			guiLabelSetColor(TuningGUI_Label[3],255,255,255)
			guiLabelSetVerticalAlign(TuningGUI_Label[3],"top")
			guiLabelSetHorizontalAlign(TuningGUI_Label[3],"left",false)
		TuningGUI_Label[4] = guiCreateLabel(225,179,45,16,"Color 3:",false,TuningGUI_Window[1])
			guiLabelSetColor(TuningGUI_Label[4],255,255,255)
			guiLabelSetVerticalAlign(TuningGUI_Label[4],"top")
			guiLabelSetHorizontalAlign(TuningGUI_Label[4],"left",false)
		TuningGUI_Label[5] = guiCreateLabel(226,207,47,14,"Color 4:",false,TuningGUI_Window[1])
			guiLabelSetColor(TuningGUI_Label[5],255,255,255)
			guiLabelSetVerticalAlign(TuningGUI_Label[5],"top")
			guiLabelSetHorizontalAlign(TuningGUI_Label[5],"left",false)
		TuningGUI_Button[3] = guiCreateButton(226,277,103,23,"Vorschau",false,TuningGUI_Window[1])
		TuningGUI_Button[4] = guiCreateButton(224,305,99,24,"Lackieren (500$)",false,TuningGUI_Window[1])
		TuningGUI_Button[5] = guiCreateButton(221,332,109,20,"Farbtabelle",false,TuningGUI_Window[1])
		TuningGUI_Button[6] = guiCreateButton(13,361,320,25,"Tuning Beenden!",false,TuningGUI_Window[1])
		TuningGUI_Label[6] = guiCreateLabel(227,240,105,14,"PJ (3000$):",false,TuningGUI_Window[1])
			guiLabelSetColor(TuningGUI_Label[6],255,255,255)
			guiLabelSetVerticalAlign(TuningGUI_Label[6],"top")
			guiLabelSetHorizontalAlign(TuningGUI_Label[6],"left",false)
		TuningGUI_Edit[6] = guiCreateEdit(281,236,46,23,"",false,TuningGUI_Window[1])

		TuningGUI_Window[2] = guiCreateWindow(13,57,625,400,"Farbtabelle",false)
		TuningGUI_Image[1] = guiCreateStaticImage(9,30,607,361,"FILES/IMAGES/Carcolours_All.jpg",false,TuningGUI_Window[2])
		guiSetVisible(TuningGUI_Window[2],false)
		guiSetVisible(TuningGUI_Window[1],false)
		
		addEventHandler ( "onClientGUIClick", TuningGUI_Button[5], activateColorTable, false )
		addEventHandler ( "onClientGUIClick", TuningGUI_Button[6], cancelTuningGarage, false )
		addEventHandler ( "onClientGUIClick", TuningGUI_Button[3], tuning_color_vorschau, false )
		addEventHandler ( "onClientGUIClick", TuningGUI_Button[4], tuning_color_save, false )
		addEventHandler ( "onClientGUIClick", TuningGUI_Grid[1], clickedonTuningList,false)
		
		addEventHandler ( "onClientGUIClick", TuningGUI_Button[2], tuning_ausbauen, false )
		addEventHandler ( "onClientGUIClick", TuningGUI_Button[1], tuning_einbauen, false )
		guiSetVisible(TuningGUI_Button[1],false)
		guiSetVisible(TuningGUI_Button[2],false)
		
	end
)


function tuning_ausbauen()

	local row,colo=guiGridListGetSelectedItem ( TuningGUI_Grid[1] )
	if(row~=-1 and colo~=-1)then
		local upg=tonumber(guiGridListGetItemText ( TuningGUI_Grid[1], row, colo ))
		local isinveh=false
		local slotnr=-1
		local upgs=getVehicleUpgrades(hitElement)
		for theKey,theUpgrade in ipairs(upgs) do
			if(theUpgrade==upg)then
				slotnr=theKey
			end		
		end
		local upgs=getStringComponents(newtuningstring)
		for theKey,theUpgrade in ipairs(upgs) do
			if(tonumber(theUpgrade)==tonumber(upg))then
				isinveh=true
			end		
		end
		if(isinveh)then
			removeVehicleUpgrade(hitElement,upg)
			lastElement=false		
			pricing=pricing-(UpSlotPrice[slotnr+1]/2)
			
			newtuningstring=""
			for n=0,15,1 do					
				newtuningstring=newtuningstring..getVehicleUpgradeOnSlot (hitElement, n ).."|"
			end		
			newtuningstring=newtuningstring..getVehicleUpgradeOnSlot(hitElement, 16 )
			playSoundFrontEnd ( 46 )

			guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[3],"", false, false)
			guiSetVisible(TuningGUI_Button[1],true)
			guiSetVisible(TuningGUI_Button[2],false)					
		
		
		end
	end
end

function tuning_einbauen()

	local row,colo=guiGridListGetSelectedItem ( TuningGUI_Grid[1] )
	if(row~=-1 and colo~=-1)then
		local upg=tonumber(guiGridListGetItemText ( TuningGUI_Grid[1], row, colo ))
		local isinveh=false
		local slotnr=-1
		local upgs=getVehicleUpgrades(hitElement)
		for theKey,theUpgrade in ipairs(upgs) do
			if(tonumber(theUpgrade)==tonumber(upg))then
				slotnr=theKey
			end		
		end
		local upgs=getStringComponents(newtuningstring)
		for theKey,theUpgrade in ipairs(upgs) do
			if(theUpgrade==upg)then
				isinveh=true
			end		
		end
		if not(isinveh)then
			if(getPlayerMoney(getLocalPlayer())<pricing+UpSlotPrice[slotnr])then
				showError(getLocalPlayer(),string.format("Ihnen fehlen %s$ um das einzubauen!", UpSlotPrice[slotnr]))
			else
				addVehicleUpgrade(hitElement,upg)
				pricing=pricing+UpSlotPrice[slotnr+1]
				lastElement=false	
				newtuningstring=""
				for n=0,15,1 do					
					newtuningstring=newtuningstring..getVehicleUpgradeOnSlot (hitElement, n ).."|"
				end		
				newtuningstring=newtuningstring..getVehicleUpgradeOnSlot (hitElement, 16 )
				guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[3],"X", false, false)
	
				guiSetVisible(TuningGUI_Button[1],false)
				guiSetVisible(TuningGUI_Button[2],false)		
				playSoundFrontEnd ( 46 )
					local comUpTab={}
					local slnam=""
					local row=false
					local slotnr=0
					guiGridListClear ( TuningGUI_Grid[1] )
					for sl=0,16,1 do		
						comUpTab=getVehicleCompatibleUpgrades(hitElement,sl)
						if(table.getn(comUpTab)>0)then
							slnam=getVehicleUpgradeSlotName(sl)
							row=guiGridListAddRow(TuningGUI_Grid[1])
							guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[2], slnam.." ("..UpSlotPrice[sl+1]..")", false, false)
							guiGridListSetItemColor (TuningGUI_Grid[1],row, TuningGUI_Column[2],0,0,255,255)
							
							for theKey,theUpgrade in ipairs (comUpTab) do
								row=guiGridListAddRow(TuningGUI_Grid[1])
								guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[1], tostring(theUpgrade), false, false)
								
								
								guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[2],UpgradeNames[tonumber(theUpgrade)], false, false)
								
								
								
								slotnr=getVehicleUpgradeOnSlot(hitElement,sl)
								if(slotnr~=0)and(slotnr==theUpgrade)then
								guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[3],"X", false, false)
								end
							
							end
						
						end
					end
			end
		end
	end
end



function clickedonTuningList()	
	if(lastElement)then
		removeVehicleUpgrade ( hitElement, lastElement )
		lastElement=false
	end
	local row,colo=guiGridListGetSelectedItem ( TuningGUI_Grid[1] )
	if(row~=-1 and colo~=-1)then
		local upg=tonumber(guiGridListGetItemText ( TuningGUI_Grid[1], row, colo ))
		addVehicleUpgrade(hitElement,upg)
		lastElement=upg
		local isinveh=false
		local upgs=getStringComponents(newtuningstring)
		for theKey,theUpgrade in ipairs(upgs) do
			if(tonumber(theUpgrade)==tonumber(lastElement))then
				isinveh=true
			end		
		end
		if(isinveh)then
			guiSetVisible(TuningGUI_Button[1],false)
			guiSetVisible(TuningGUI_Button[2],true)		
		else
			guiSetVisible(TuningGUI_Button[1],true)
			guiSetVisible(TuningGUI_Button[2],false)		
		end	
	else
		guiSetVisible(TuningGUI_Button[1],false)
		guiSetVisible(TuningGUI_Button[2],false)	
	end
end





function tuning_color_save()
	local colorA=tonumber(guiGetText(TuningGUI_Edit[2]))
	local colorB=tonumber(guiGetText(TuningGUI_Edit[3]))
	wasColorChanged=true
	local colorC=tonumber(guiGetText(TuningGUI_Edit[4]))
	local colorD=tonumber(guiGetText(TuningGUI_Edit[5]))	
	local paintjob=tonumber(guiGetText(TuningGUI_Edit[6]))
	if not(getPlayerMoney(getLocalPlayer())<3400)then
		if(colorA and colorB and colorC and colorD and paintjob)then
		if(colorA>-1 and colorA<256) and(colorB>-1 and colorB<256) and(colorC>-1 and colorC<256) and(colorD>-1 and colorD<256) then
			local newnewcolorstring=colorA.."|"..colorB.."|"..colorC.."|"..colorD
			if(newnewcolorstring~=newcolorstring)then
				newcolorstring=newnewcolorstring
				setVehicleColor(hitElement,colorA,colorB,colorC,colorD)
				pricing=pricing+500
			end
			if(paintjob>-1 and paintjob<4)then
				if(paintjob~=newpaintjob)then
					setVehiclePaintjob(hitElement,paintjob)
					newpaintjob=paintjob
					pricing=pricing+2900
				end
			else
				showError(getLocalPlayer(),"Der Paintjob muss zwischen 0 und 3 liegen!")
			end
			
			showError(getLocalPlayer(),"Dein Fahrzeug wurde erfolgreich lackiert!")
			
		else
			showError(getLocalPlayer(),"Mindestens eine der eingegeben Farben hat einen falschen Wert! Die Farben muessen zwischen 0 und 255 liegen und der Paintjob zwischen 0 und 3!")
			
		end
		else
			showError(getLocalPlayer(),"Mindestens eine der eingegeben Farben hat einen falschen Wert! Die Farben muessen zwischen 0 und 255 liegen!")	
		end
	else
			showError(getLocalPlayer(),"Sie haben zuwenig Geld dafuer!")
	end

end


function tuning_color_vorschau()
	local colorA=tonumber(guiGetText(TuningGUI_Edit[2]))
	local colorB=tonumber(guiGetText(TuningGUI_Edit[3]))
	local colorC=tonumber(guiGetText(TuningGUI_Edit[4]))
	local colorD=tonumber(guiGetText(TuningGUI_Edit[5]))
	local paintjob=tonumber(guiGetText(TuningGUI_Edit[6]))
	if(colorA and colorB and colorC and colorD and paintjob)then
	if(colorA>-1 and colorA<256) and(colorB>-1 and colorB<256) and(colorC>-1 and colorC<256) and(colorD>-1 and colorD<256) and (paintjob>-1 and paintjob<4) then
		setVehiclePaintjob(hitElement,paintjob)
		setVehicleColor(hitElement,colorA,colorB,colorC,colorD)
	else
		showError(getLocalPlayer(),"Mindestens eine der eingegeben Farben hat einen falschen Wert! Die Farben muessen zwischen 0 und 255 liegen und der Paintjob zwischen 0 und 3!")
		
	end
	else
		showError(getLocalPlayer(),"Mindestens eine der eingegeben Farben hat einen falschen Wert! Die Farben muessen zwischen 0 und 255 liegen und der Paintjob zwischen 0 und 3!")	
	end
end

function activateColorTable()
	guiSetVisible(TuningGUI_Window[2],not guiGetVisible(TuningGUI_Window[2]))

end


function cancelTuningGarage()
	if(lastElement)then
		removeVehicleUpgrade ( hitElement, lastElement )
		lastElement=false
	end

	guiSetVisible(TuningGUI_Window[2],false)
	guiSetVisible(TuningGUI_Window[1],false)	
	triggerServerEvent("exitFromTuning",getLocalPlayer(),newcolorstring,wasColorChanged,newtuningstring,pricing,newpaintjob)
end

addEvent("showTuningGarage",true)
function showTuningGarage_func(color,paint,tuning)
		hitElement=source
		wasColorChanged=false
		newtuningstring=tuning
		newcolorstring=color
		newpaintjob=paint
		--newcolorstring=getElementData(hitElement,"colors")
		--newpaintjob=getElementData(hitElement,"paintjob")
		local colors=getStringComponents(newcolorstring)
		guiSetText(TuningGUI_Edit[2],colors[1])
		guiSetText(TuningGUI_Edit[3],colors[2])
		guiSetText(TuningGUI_Edit[4],colors[3])
		guiSetText(TuningGUI_Edit[5],colors[4])
		guiSetText(TuningGUI_Edit[6],tostring(newpaintjob))
		
		
		--newtuningstring=getElementData(hitElement,"tuning")
		pricing=0
		local comUpTab={}
		local slnam=""
		local row=false
		local slotnr=0
		guiGridListClear ( TuningGUI_Grid[1] )
		for sl=0,16,1 do		
			comUpTab=getVehicleCompatibleUpgrades(source,sl)
			if(comUpTab)then
				if(table.getn(comUpTab)>0)then
					slnam=getVehicleUpgradeSlotName(sl)
					row=guiGridListAddRow(TuningGUI_Grid[1])
					guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[2], slnam.." ("..UpSlotPrice[sl+1]..")", false, false)
					guiGridListSetItemColor (TuningGUI_Grid[1],row, TuningGUI_Column[2],0,0,255,255)
					
					for theKey,theUpgrade in ipairs (comUpTab) do
						row=guiGridListAddRow(TuningGUI_Grid[1])
						guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[1], tostring(theUpgrade), false, false)
						
						
						guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[2],UpgradeNames[tonumber(theUpgrade)], false, false)
						
						
						
						slotnr=getVehicleUpgradeOnSlot(hitElement,sl)
						if(slotnr~=0)and(slotnr==theUpgrade)then
						guiGridListSetItemText (TuningGUI_Grid[1], row, TuningGUI_Column[3],"X", false, false)
						end
					
					end
				
				end
			end
		end
		
		--	guiGridListAutoSizeColumn ( TuningGUI_Grid[1],TuningGUI_Column[1])
		--	guiGridListAutoSizeColumn ( TuningGUI_Grid[1],TuningGUI_Column[2])
		--	guiGridListAutoSizeColumn ( TuningGUI_Grid[1],TuningGUI_Column[3])		
		
		
		
		
		
		
		
		
		guiSetVisible(TuningGUI_Window[1],true)

end
addEventHandler("showTuningGarage",getRootElement(),showTuningGarage_func)









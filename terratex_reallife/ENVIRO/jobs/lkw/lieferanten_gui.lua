lks_typ_1_punkte={
	{"Arena",2726.6259765625,-1839.7021484375,10.162282943726,169.51336669922}, -- Lieferrantenjob Arenamarker 
	{"Pizza Stack",2095.8955078125,-1807.0537109375,13.552013397217,8.8193969726562}, -- lieferantenjob -pizza 
	{"Cluckin' Bell",2422.74609375,-1500.20703125,23.992208480835,182.79057312012}, -- lieferantenjob - cluckinbell 
	{"Sprunk",2855.7607421875,-1532.8828125,11.09375,1.7715759277344}, -- lieferantenjob sprunk 
	{"24/7",1322.9599609375,-864.576171875,39.578125,69.129791259766}, -- lieferantenjob 24/7 
	{"Burgershot",1206.2890625,-922.822265625,42.952297210693,275.87915039062}, -- lieferantenjob Burgershot 
	{"Tunning",1050.427734375,-1032.38671875,32.040351867676,87.411315917969}, -- lieferantenjob tunning 
	{"Pay'n'Spray",1015.5322265625,-1033.81640625,31.652410507202,84.274658203125}, -- lieferantenjob Pay'n'Spray 
	{"Tankstelle",1005.7216796875,-940.5537109375,42.1796875,99.161376953125}, -- lieferantenjob tankstelle 
	{"Unitel",1575.71484375,-1852.8134765625,13.539115905762,182.64775085449}, -- lieferantenjob unitel 
	{"Bar & Strip Industries",1827.283203125,-1685.068359375,13.546875,5.9024963378906} -- lieferantenjob barnstrip industries
}
lks_typ_2_punkte={
	{"Star",-79.099998474121,-1126.1999511719,0},
	{"Fleischfabrik",61.400001525879,-243.80000305176,0.60000002384186},
	{"Bioanlage",1352.3000488281,356.10000610352,19.10000038147},
	{"Kagawa Industry",1410.5999755859,1041.6999511719,10.800000190735},
	{"Schafted Industy",1693.4000244141,929.79998779297,10.800000190735},
	{"Farmer Industry2",2849.8999023438,915.90002441406,9.6999998092651},
	{"KACC",2494.3999023438,2773.1999511719,9.8000001907349},
	{"Car Industrys",1615,2358.3999023438,10},
	{"Corgen Industry and Co.",-1490,2649.5,55.799999237061},
	{"Old Grandmas Diner",-1931.8000488281,2385.8000488281,49.5},
	{"Bayside Industry",-2270.3999023438,2327.1000976563,4.8000001907349},
	{"Garden Center",-2589.6000976563,312,4.8000001907349},
	{"Hippy Schopper",-2597.6000976563,55.099998474121,3.2000000476837},
	{"Energy and Co.",-2520.3999023438,-617.90002441406,131.19999694824},
	{"WoodIndustry",-2025.4000244141,-2406.6000976563,29.39999961853},
	{"Trash and Co. KG.",-1901.3000488281,-1728,21.799999237061},
	{"Farming Lobby",-1047.0999755859,-1189.0999755859,127.90000152588},
	{"Ag. Co .",-492.70001220703,-554.59997558594,25.5}
}

lkw_typ_1_fahrzeuge={414,440,456,498,499,609}
lkw_typ_2_fahrzeuge={403,514,515}
lkw_trailer={450,584,591,435}

--{minSicher,maxSicher,minGewinn,maxGewinn,Fahrzeugtyp(1,2, beides=3),Ziele(1,2, beides=3)}
lkw_auftragstypen_skilllevel={
[0]={125,750,100,300,1,1},
    {250,2000,400,800,1,1},
    {500,2500,800,1200,1,3},
    {2000,4000,4000,4800,3,2},
    {5000,10000,5000,6000,2,2},
    {12500,25000,10000,12000,2,2}
}

lkw_last_auftrage={}
lkw_has_no_auftrage=true
can_see_truck_gui=false
TruckbehindyTimer=false

-- Created: 26/11/2011 14:56
addEventHandler("onClientResourceStart",resourceRoot,
    function()
        GUILkwJob_Window = {}
        GUILkwJob_Button = {}
        GUILkwJob_Label = {}
        GUILkwJob_Grid = {}
		GUILkwJob_Colum = {}
		local sx,sy=guiGetScreenSize ()
		sx=(478/1600)*sx
		sy=(270/800)*sy
        GUILkwJob_Window[1] = guiCreateWindow(sx,sy,542,421,"Truckerjob - Aufträge",false)
		table.insert(allGuis,GUILkwJob_Window[1] )
        GUILkwJob_Button[1] = guiCreateButton(0.0258,0.0855,0.3173,0.0665,"Auftrag annehmen!",true,GUILkwJob_Window[1])
        GUILkwJob_Button[2] = guiCreateButton(0.5683,0.0903,0.2768,0.0618,"Beenden!",true,GUILkwJob_Window[1])
        GUILkwJob_Label[1] = guiCreateLabel(0.0295,0.1995,0.9446,0.1116,"Die Anzahl der Aufträge ist abhängig von deinen Skilllevel, dass du mit /skill truck ansehen kannst! Wähle einen Auftrag! Die Kaution muss beim Fahrtantritt abgegeben werden und wird bei erfolgreicher Beendigung des Jobs zurückgezahlt!",true,GUILkwJob_Window[1])
        guiLabelSetHorizontalAlign(GUILkwJob_Label[1],"left",true)
        GUILkwJob_Grid[1] = guiCreateGridList(0.0314,0.323,0.9428,0.6366,true,GUILkwJob_Window[1])
        guiGridListSetSelectionMode(GUILkwJob_Grid[1],0)
		guiGridListSetSortingEnabled ( GUILkwJob_Grid[1], false )
        GUILkwJob_Colum[1]=guiGridListAddColumn(GUILkwJob_Grid[1],"ID",0.1)
        GUILkwJob_Colum[2]=guiGridListAddColumn(GUILkwJob_Grid[1],"Ziel",0.2)
        GUILkwJob_Colum[3]=guiGridListAddColumn(GUILkwJob_Grid[1],"Kaution",0.2)
        GUILkwJob_Colum[4]=guiGridListAddColumn(GUILkwJob_Grid[1],"Gehalt",0.2)
        GUILkwJob_Colum[5]=guiGridListAddColumn(GUILkwJob_Grid[1],"Fahrzeug",0.2)
		guiSetVisible(GUILkwJob_Window[1],false)
		addEventHandler ( "onClientGUIClick", GUILkwJob_Button[2], closeTruckerGui, false )
		addEventHandler ( "onClientGUIClick", GUILkwJob_Button[1], getTruckerGui, false )
		setTimer(cancelTruckBehindyTimer,300000,1)
    end
)

function closeTruckerGui()
	guiSetVisible(GUILkwJob_Window[1],false)
	showCursor(false)
	guiGridListClear ( GUILkwJob_Grid[1]) 
end

function getTruckerGui()
	--outputChatBox("yes")
	local x,y,z=getElementPosition(getLocalPlayer())
    local dis=getDistanceBetweenPoints3D(x,y,z,2770.587890625,-2447.2724609375,12.64318561554)
    if(dis<5)then
        local row,colu=guiGridListGetSelectedItem ( GUILkwJob_Grid[1] )
        if(row==-1)then
        else
            row=row+1
            triggerServerEvent("goTruckAuftrag_Event",getLocalPlayer(),lkw_last_auftrage[row])
            can_see_truck_gui=false
            TruckbehindyTimer=setTimer(can_see_truck_gui_delete,300000,1)
            closeTruckerGui()
        end
    end
end

addEvent("cancelBehindyTruckTimer",true)
function cancelTruckBehindyTimer()
	if(isTimer(TruckbehindyTimer))then
		killTimer(TruckbehindyTimer)
	end
		can_see_truck_gui=true
end
addEventHandler("cancelBehindyTruckTimer",getRootElement(),cancelTruckBehindyTimer)

function can_see_truck_gui_delete()
	can_see_truck_gui=true
end

addEvent("giveNewAutraege",true)
function giveNewAutraege_func()
	lkw_new_auftrage()
end
addEventHandler("giveNewAutraege",getRootElement(),giveNewAutraege_func)

function lkw_new_auftrage()
	lkw_last_auftrage={}
	for n=0,5,1 do
		if(tonumber(getElementData(getLocalPlayer(),"truckSkill"))>=n)then
			local sicherheit=math.random(lkw_auftragstypen_skilllevel[n][1],lkw_auftragstypen_skilllevel[n][2])
			local gewinn=math.random(lkw_auftragstypen_skilllevel[n][3],lkw_auftragstypen_skilllevel[n][4])
			faktor=1
			if(isWetterEventID==1)then
				faktor=1.5
			elseif(isWetterEventID==2)then
				faktor=1.1
			elseif(isWetterEventID==3)then
				faktor=1.7
			elseif(isWetterEventID==5)then
				faktor=1.05
			elseif(isWetterEventID==8)then
				faktor=0.8
			end
			gewinn=gewinn*faktor
			local vehicle=0
			local vehicletyp=0
			local vehicletrailer=0
				if(lkw_auftragstypen_skilllevel[n][5]==1)then
					vehicle=lkw_typ_1_fahrzeuge[math.random(1,6)]
					vehicletyp=1
				elseif(lkw_auftragstypen_skilllevel[n][5]==2)then
					vehicle=lkw_typ_2_fahrzeuge[math.random(1,3)]
					vehicletyp=2
					vehicletrailer=lkw_trailer[math.random(1,4)]
				else
					if(math.random(1,2)==1)then
						vehicle=lkw_typ_1_fahrzeuge[math.random(1,6)]
						vehicletyp=1
					else
						vehicle=lkw_typ_2_fahrzeuge[math.random(1,3)]
						vehicletyp=2
						vehicletrailer=lkw_trailer[math.random(1,4)]
					end
				end
			local ziel=0
			local zieltyp=0
				if(lkw_auftragstypen_skilllevel[n][6]==1)then
					ziel=math.random(1,11)
					zieltyp=1
				elseif(lkw_auftragstypen_skilllevel[n][6]==2)then
					ziel=math.random(1,18)
					zieltyp=2
				else
					if(math.random(1,2)==1)then
						ziel=math.random(1,11)
						zieltyp=1
					else
						ziel=math.random(1,18)
						zieltyp=2
					end
				end
			--|sicherheit|gewinn|vehicle|vehicletyp|vehicletrailer|ziel|zieltyp|
			table.insert(lkw_last_auftrage,{sicherheit,gewinn,vehicle,vehicletyp,vehicletrailer,ziel,zieltyp})
		end
	end
end

addEvent("openLKWJobGui",true)
function showLKWJob_func()
	if(can_see_truck_gui)then
        if(not getElementData(getLocalPlayer(),"lkw_auftrag"))then
            guiSetVisible(GUILkwJob_Window[1],true)
            showCursor(true)
            guiGridListClear ( GUILkwJob_Grid[1])
            if(lkw_has_no_auftrage)then
                lkw_new_auftrage()
                lkw_has_no_auftrage=false
            end
            for theKey,theTable in ipairs(lkw_last_auftrage) do
                row=guiGridListAddRow(GUILkwJob_Grid[1])
                    guiGridListSetItemText ( GUILkwJob_Grid[1], row, GUILkwJob_Colum[1], tostring(theKey), false, true )
                    local zielstring=" "
                    --outputChatBox(tostring(theTable[6]))
                        if(theTable[7]==1)then
                            zielstring=lks_typ_1_punkte[theTable[6]][1]
                        else
                            zielstring=lks_typ_2_punkte[theTable[6]][1]
                        end
                    guiGridListSetItemText ( GUILkwJob_Grid[1], row, GUILkwJob_Colum[2],zielstring, false, true )
                    guiGridListSetItemText ( GUILkwJob_Grid[1], row, GUILkwJob_Colum[3],toprice(theTable[1]), false, true )
                    guiGridListSetItemText ( GUILkwJob_Grid[1], row, GUILkwJob_Colum[4],toprice(theTable[2]), false, true )
                    local vehiclestring=getVehicleNameFromModel(theTable[3])
                        if(theTable[4]==2)then
                            vehiclestring=vehiclestring.." mit Anhänger"
                        end
                    guiGridListSetItemText ( GUILkwJob_Grid[1], row, GUILkwJob_Colum[5],vehiclestring, false, true )
            end
        else
            showError(getLocalPlayer(),"Du hast bereits einen Auftrag. Beenden mit /cancellkw.")
        end
	else
		outputChatBox("Du kannst nur alle 5 Minuten einen Truck starten!",255,0,0)--       vioSetElementData(source,"lkw_auftrag",true)
	end
end
addEventHandler("openLKWJobGui",getRootElement(),showLKWJob_func)









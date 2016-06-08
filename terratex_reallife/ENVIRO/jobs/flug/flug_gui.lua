fly_typ_1_punkte={--für helis
   {"StarTower",1545.0999755859,-1353.5,329.5},
    {"The White House",1117.5999755859,-2037.8000488281,78.199996948},
    {"Filmstudio",891.5,-1224.0999755859,17},
    {"Farmer Lobby",-1055.1999511719,-1227.5,128.8999938964},
    {"Angel Pie Medical Center",-2215.5,-2322.8000488281,30.6000003814},
    {"SF Airport",-1652.6999511719,-160.19999694824,14.10000038147},
    {"SF Policedepartment",-1680.0999755859,704.90002441406,30.1000003814},
    {"SF Medical Center",-2654.6000976563,632,66.9000015258},
    {"Jizzys StripClub",-2631,1417.5,23.700000762939},
    {"Bayside Industrys",-2227,2324.6000976563,7.5},
    {"Old Grandmas Dinner",-1925.5999755859,2381.8000488281,49.5},
    {"Medical Center El Quebrados",-1517.1999511719,2538.8999023438,55.700000762939},
    {"SOS Human",-1473.5,1490.4000244141,8.3000001907349},
    {"Old Airport",363.79998779297,2535.5,16.700000762939},
    {"Chemie Industry",2620.3000488281,2719.3000488281,36.5},
    {"Emerald Isle",2095.5,2416.8999023438,74.599998474121},
    {"LS Airport",1765.3000488281,-2288.8000488281,26.799999237061}
}
fly_typ_2_punkte={--für große flugzeuge
    {"LS Airport",2004.1999511719,-2493.6000976563,13.5},
    {"SF Aiport",-1652.6999511719,-160.19999694824,14.10000038147},
    {"Alter Flughafen",343.89999389648,2500.3000488281,16.5}
}

flys_typ_1_fahrzeuge={548,417,487,563,469}--helis
flys_typ_2_fahrzeuge={592,511,553,577,519}--flugzeuge

--{minSicher,maxSicher,minGewinn,maxGewinn,Fahrzeugtyp(1,2, beides=3),Ziele(1,2, beides=3)}
flys_auftragstypen_skilllevel = {
	[0] = { 250, 1500, 100, 250, 1, 1},
	{500, 4000, 480, 672, 1, 1},
	{1000, 5000, 1200, 1680, 1, 3},
	{4000, 8000, 2000, 2800, 3, 2},
	{10000, 20000, 2500, 3500, 2, 2},
	{25000, 50000, 5000, 7000, 2, 2}
	}
	
flys_last_auftrage = {}
flys_has_no_auftrage = true
can_see_flugy_gui = false
FlybehindyTimer = false

-- Created: 26/11/2011 14:56
addEventHandler("onClientResourceStart",resourceRoot,
    function()
        GUIflysJob_Window = {}
        GUIflysJob_Button = {}
        GUIflysJob_Label = {}
        GUIflysJob_Grid = {}
		GUIflysJob_Colum = {}
		local sx,sy=guiGetScreenSize ()
		sx=(478/1600)*sx
		sy=(270/800)*sy
        GUIflysJob_Window[1] = guiCreateWindow(sx,sy,542,421,"Flugjob - Aufträge",false)
		table.insert(allGuis,GUIflysJob_Window[1] )
        GUIflysJob_Button[1] = guiCreateButton(0.0258,0.0855,0.3173,0.0665,"Auftrag annehmen!",true,GUIflysJob_Window[1])
        GUIflysJob_Button[2] = guiCreateButton(0.5683,0.0903,0.2768,0.0618,"Beenden!",true,GUIflysJob_Window[1])
        GUIflysJob_Label[1] = guiCreateLabel(0.0295,0.1995,0.9446,0.1116,"Die Anzahl der Aufträge ist abhängig von deinen Skilllevel, dass du mit /skill fly ansehen kannst! Wähle einen Auftrag! Die Kaution muss beim Fahrtantritt abgegeben werden und wird bei erfolgreicher Beendigung des Jobs zurückgezahlt!",true,GUIflysJob_Window[1])
        guiLabelSetHorizontalAlign(GUIflysJob_Label[1],"left",true)
        GUIflysJob_Grid[1] = guiCreateGridList(0.0314,0.323,0.9428,0.6366,true,GUIflysJob_Window[1])
        guiGridListSetSelectionMode(GUIflysJob_Grid[1],0)
		guiGridListSetSortingEnabled ( GUIflysJob_Grid[1], false )
        GUIflysJob_Colum[1]=guiGridListAddColumn(GUIflysJob_Grid[1],"ID",0.1)
        GUIflysJob_Colum[2]=guiGridListAddColumn(GUIflysJob_Grid[1],"Ziel",0.2)
        GUIflysJob_Colum[3]=guiGridListAddColumn(GUIflysJob_Grid[1],"Kaution",0.2)
        GUIflysJob_Colum[4]=guiGridListAddColumn(GUIflysJob_Grid[1],"Gehalt",0.2)
        GUIflysJob_Colum[5]=guiGridListAddColumn(GUIflysJob_Grid[1],"Fahrzeug",0.2)
		guiSetVisible(GUIflysJob_Window[1],false)
		addEventHandler ( "onClientGUIClick", GUIflysJob_Button[2], closeflugyerGui, false )
		addEventHandler ( "onClientGUIClick", GUIflysJob_Button[1], getflugyerGui, false )
		setTimer(cancelFlyBehindyTimer,300000,1)
    end
)

function closeflugyerGui()
	guiSetVisible(GUIflysJob_Window[1],false)
	showCursor(false)
	guiGridListClear ( GUIflysJob_Grid[1]) 
end

function getflugyerGui()
	--outputChatBox("yes")
    local x,y,z=getElementPosition(getLocalPlayer())
    local dis=getDistanceBetweenPoints3D(x,y,z,1495.814453125,1682.54296875,10.8125)
    if(dis<5)then
        local row,colu=guiGridListGetSelectedItem ( GUIflysJob_Grid[1] )
        if(row==-1)then
        else
            row=row+1
            if (getPlayerMoney(getLocalPlayer())>=flys_last_auftrage[row][1])then
                triggerServerEvent("goflugyAuftrag_Event",getLocalPlayer(),flys_last_auftrage[row])
                can_see_flugy_gui=false
                FlybehindyTimer=setTimer(can_see_flugy_gui_delete,300000,1)
                closeflugyerGui()
            else
                outputChatBox("Du kannst die Sicherheiten nicht bezahlen!",255,0,0)
            end
        end
    end
end

addEvent("cancelFlyBehindyTimer",true)
function cancelFlyBehindyTimer()
	if(isTimer(FlybehindyTimer))then
		killTimer(FlybehindyTimer)		
	end
	can_see_flugy_gui=true
end
addEventHandler("cancelFlyBehindyTimer",getRootElement(),cancelFlyBehindyTimer)

function can_see_flugy_gui_delete()
	can_see_flugy_gui=true
end

addEvent("giveNewFlugAutraege",true)
function giveNewFlugAutraege_func()
	flys_new_auftrage()
end
addEventHandler("giveNewFlugAutraege",getRootElement(),giveNewFlugAutraege_func)

function flys_new_auftrage()
	flys_last_auftrage={}
	for n=0,5,1 do
		if(tonumber(getElementData(getLocalPlayer(),"flyersSkill"))>=n)then
			local sicherheit=math.random(flys_auftragstypen_skilllevel[n][1],flys_auftragstypen_skilllevel[n][2])
			local gewinn=math.random(flys_auftragstypen_skilllevel[n][3],flys_auftragstypen_skilllevel[n][4])
			faktor=1
			if(isWetterEventID==1)then
				faktor=1.1
			elseif(isWetterEventID==2)then
				faktor=1.1
			elseif(isWetterEventID==3)then
				faktor=1.4
			elseif(isWetterEventID==5)then
				faktor=1.05
			elseif(isWetterEventID==8)then
				faktor=0.8
			end
			gewinn=gewinn*faktor
			local vehicle=0
			local vehicletyp=0
				if(flys_auftragstypen_skilllevel[n][5]==1)then
					vehicle=flys_typ_1_fahrzeuge[math.random(1,5)]
					vehicletyp=1
				elseif(flys_auftragstypen_skilllevel[n][5]==2)then
					vehicle=flys_typ_2_fahrzeuge[math.random(1,5)]
					vehicletyp=2
				else
					if(math.random(1,2)==1)then
						vehicle=flys_typ_1_fahrzeuge[math.random(1,5)]
						vehicletyp=1
					else
						vehicle=flys_typ_2_fahrzeuge[math.random(1,5)]
						vehicletyp=2
					end
				end
			local ziel=0
			local zieltyp=0
				if(flys_auftragstypen_skilllevel[n][6]==1)then
					ziel=math.random(1,table.getn(fly_typ_1_punkte))
					zieltyp=1
				elseif(flys_auftragstypen_skilllevel[n][6]==2)then
					ziel=math.random(1,table.getn(fly_typ_2_punkte))
					zieltyp=2
				else
					if(math.random(1,2)==1)then
						ziel=math.random(1,table.getn(fly_typ_1_punkte))
						zieltyp=1
					else
						ziel=math.random(1,table.getn(fly_typ_2_punkte))
						zieltyp=2
					end
				end
			--|sicherheit|gewinn|vehicle|vehicletyp|vehicletrailer|ziel|zieltyp|
			table.insert(flys_last_auftrage,{sicherheit,gewinn,vehicle,vehicletyp,2,ziel,zieltyp})
		end
	end
end

addEvent("openflysJobGui",true)
function showflysJob_func()
	if(can_see_flugy_gui)then
		guiSetVisible(GUIflysJob_Window[1],true)
		showCursor(true)
		guiGridListClear ( GUIflysJob_Grid[1]) 
		if(flys_has_no_auftrage)then		
			flys_new_auftrage()
			flys_has_no_auftrage=false
		end
		for theKey,theTable in ipairs(flys_last_auftrage) do
			row=guiGridListAddRow(GUIflysJob_Grid[1])
				guiGridListSetItemText ( GUIflysJob_Grid[1], row, GUIflysJob_Colum[1], tostring(theKey), false, true )
				local zielstring=" "
				--outputChatBox(tostring(theTable[6]))
					if(theTable[7]==1)then					
						zielstring=fly_typ_1_punkte[theTable[6]][1]
					else
						zielstring=fly_typ_2_punkte[theTable[6]][1]
					end
				guiGridListSetItemText ( GUIflysJob_Grid[1], row, GUIflysJob_Colum[2],zielstring, false, true )
				guiGridListSetItemText ( GUIflysJob_Grid[1], row, GUIflysJob_Colum[3],toprice(theTable[1]), false, true )
				guiGridListSetItemText ( GUIflysJob_Grid[1], row, GUIflysJob_Colum[4],toprice(theTable[2]), false, true )
				local vehiclestring=getVehicleNameFromModel(theTable[3])		
				guiGridListSetItemText ( GUIflysJob_Grid[1], row, GUIflysJob_Colum[5],vehiclestring, false, true )	
		end
	else
		outputChatBox("Du kannst nur alle 5 Minuten einen Flug starten!",255,0,0)
	end
end
addEventHandler("openflysJobGui",getRootElement(),showflysJob_func)

function isPlane(vehid)
		if( getVehicleType ( vehid)=="Plane" or getVehicleType ( vehid)=="Helicopter")then
			return true
		else
			return false
		end
end

addEventHandler("onClientRender", root,
    function()
		if(isPedInVehicle(getLocalPlayer()))then
			local veh=getPedOccupiedVehicle ( getLocalPlayer())
			if(veh)then
				if(isPlane(getElementModel(veh)))then
					local screenW, screenH = guiGetScreenSize()    
					local px,py,pz=getElementPosition(getLocalPlayer())
					local textstring=""
					if isElement(veh)then
						px,py,pz=getElementPosition ( veh )
						textstring=math.round(pz,1)
					end		
					dxDrawRectangle(screenW - 220 - 10, (screenH - 90) / 2, 220, 90, tocolor(0, 13, 71, 220), false)
					dxDrawText(string.format("Höhe: %s", textstring), screenW - 201 - 10, (screenH - 90) / 2 -5, (screenW - 201 - 10) + 201, ( (screenH - 46) / 2) + 46, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)

                    local hitt,nxx,nyy,nzz=testLineAgainstWater ( px,py,pz+10, px,py,-300 )
                    local hit,nx,ny,nz=processLineOfSight ( px,py,pz+10, px,py,-300, true,  false, false,true,false,  false, false,false,veh)

                    if(hitt and hit)then
                        if(nzz>nz)then
                            hit,nx,ny,nz=hitt,nxx,nyy,nzz
                        end
                    elseif(hitt and not hit)then
                        hit,nx,ny,nz=hitt,nxx,nyy,nzz
                    end

                    if(hit)then
                        local realHeight=pz-nz

                        dxDrawText(string.format("über Boden: %s", math.round(realHeight,1)), screenW - 201 - 10, (screenH - 90) / 2 + 50, (screenW - 201 - 10) + 201, ( (screenH - 46) / 2) + 46, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)

                    else
                        dxDrawText(string.format("über Boden: 0", math.round(realHeight,1)), screenW - 201 - 10, (screenH - 90) / 2 + 50, (screenW - 201 - 10) + 201, ( (screenH - 46) / 2) + 46, tocolor(255, 255, 255, 255), 1.00, "pricedown", "left", "center", false, false, false, false, false)
                    end
                end
			end
		end
	end
)










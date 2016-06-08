
AmmuFenster=false
ammoWasPorted=false
local ammoBots={}
local isFiring=false
local colums={}
function createAmmoGui()
	AmmuFenster = guiCreateWindow(0.3024,0.1829,0.314,0.6333,"Ammu Nation",true)
	table.insert(allGuis,AmmuFenster)
	guiSetAlpha(AmmuFenster,1)
	AmmuPicture = guiCreateStaticImage(0.0182,0.0256,0.9656,0.2722,"FILES/IMAGES/ammu.jpg",true,AmmuFenster)
	CloseButton = guiCreateButton(0.9308,0.0276,0.065,0.1713,"X",true,AmmuPicture)
	guiSetAlpha(CloseButton,1)
	guiSetFont(CloseButton,"clear-normal")
	AmmuGridList = guiCreateGridList(0.0182,0.3308,0.5688,0.6556,true,AmmuFenster)
	guiGridListSetSelectionMode(AmmuGridList,4)
    guiGridListSetSortingEnabled ( AmmuGridList,false )
	
	colums[1]=guiGridListAddColumn(AmmuGridList,"ID",0.2)
	colums[2]=guiGridListAddColumn(AmmuGridList,"Waffe",0.2)
	colums[3]=guiGridListAddColumn(AmmuGridList,"W-Preis",0.2)	
	colums[4]=guiGridListAddColumn(AmmuGridList,"M-Preis",0.2)
	
	local row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "1", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "Golfschläger", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "15", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "-", false, false )
		
	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "2", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "Messer", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "30", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "-", false, false )
		
	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "3", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "Baseballschläger", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "30", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "-", false, false )

	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "4", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "Kartana", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "225", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "-", false, false )	
	
	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "5", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "9mm", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "450$", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "15$", false, false )	
	
	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "6", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "9mm Schallgedämpft", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "750$", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "15$", false, false )	

	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "7", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "Deagle", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "1050", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "30$", false, false )
		
	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "8", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "Schrottflinte", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "1500", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "45", false, false )

	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "9", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "MP5", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "4500", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "15$", false, false )
		
	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "10", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "AK47", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "12000", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "120$", false, false )
		
	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "11", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "M4A1", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "15000", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "150$", false, false )

	row = guiGridListAddRow ( AmmuGridList )
        guiGridListSetItemText ( AmmuGridList, row, colums[1], "12", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[2], "Country Rifle", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[3], "30000$", false, false )
		guiGridListSetItemText ( AmmuGridList, row, colums[4], "600$", false, false )
	
	guiSetAlpha(AmmuGridList,1)
	guiSetVisible(AmmuFenster,false)

	
	MunitionsLabel = guiCreateLabel(0.6073,0.4722,0.3603,0.0301,"Wie viel Munition?",true,AmmuFenster)
	guiLabelSetColor(MunitionsLabel,255,255,255)
	guiLabelSetVerticalAlign(MunitionsLabel,"top")
	guiLabelSetHorizontalAlign(MunitionsLabel,"left",false)
	MunitionsEdit = guiCreateEdit(0.6478,0.5173,0.247,0.0481,"",true,AmmuFenster)
	KaufButton = guiCreateButton(0.67,0.3308,0.2247,0.0782,"Kaufen",true,AmmuFenster)
	SchutzWesteLabel = guiCreateLabel(0.6073,0.6692,0.3884,0.0241,"Moechten Sie eine Schutzweste?",true,AmmuFenster)
	guiLabelSetColor(SchutzWesteLabel,255,255,255)
	guiLabelSetVerticalAlign(SchutzWesteLabel,"top")
	guiLabelSetHorizontalAlign(SchutzWesteLabel,"left",false)
	LeightArmorRadioButton = guiCreateRadioButton(0.6073,0.7263,0.3845,0.0331,"Leichte Weste (15$)",true,AmmuFenster)
	HeavyArmorRadioButton = guiCreateRadioButton(0.6073,0.7594,0.3845,0.0451,"Schwere Weste (25$)",true,AmmuFenster)
	guiRadioButtonSetSelected(HeavyArmorRadioButton,true)
	RuestungKaufenButton = guiCreateButton(0.6255,0.8301,0.2692,0.0707,"Ruestung\nKaufen",true,AmmuFenster)
	MunitionKaufenButton = guiCreateButton(0.6478,0.5805,0.247,0.0556,"Munition\nKaufen",true,AmmuFenster)
	
	addEventHandler("onClientGUIClick",CloseButton,closeAmmoGui,false)
	addEventHandler("onClientGUIClick",RuestungKaufenButton,ammoBuyWeste,false)	
	addEventHandler("onClientGUIClick",KaufButton,ammoBuyWeapon,false)
	addEventHandler("onClientGUIClick",MunitionKaufenButton,ammoBuyMuni,false)

	createAmmoBots()
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),createAmmoGui)

local lastOpenX,lastOpenY,lastOpenZ=0,0,0
function checkAmmoOkay()
    local x,y,z=getElementPosition(getLocalPlayer())
    if(getDistanceBetweenPoints3D(x,y,z,lastOpenX,lastOpenY,lastOpenZ)>5)then
        closeAmmoGui()
        return false
    end
    return true
end

function ammoBuyWeapon()
    if(not checkAmmoOkay())then return false end
	local row,colu=guiGridListGetSelectedItem ( AmmuGridList )
	if(row~=-1)then
		local selectedID=tonumber(guiGridListGetItemText ( AmmuGridList, row, colu ))
		triggerServerEvent("ammoBuyWeapon_Event",getLocalPlayer(),selectedID)
	else
            showError(getLocalPlayer(),"Sie haben keine gültige Waffe aus der Liste gewählt!")
	end
end

function ammoBuyMuni()
    if(not checkAmmoOkay())then return false end
	local row,colu=guiGridListGetSelectedItem ( AmmuGridList )
	local howmany=guiGetText ( MunitionsEdit )
	
	if(howmany~="")then
		local howmanynum=tonumber(howmany)
		if(howmanynum>0)then
			if(row~=-1)then
				local selectedID=tonumber(guiGridListGetItemText ( AmmuGridList, row, colu ))
				triggerServerEvent("ammoBuyMuni_Event",getLocalPlayer(),selectedID,howmanynum)
			else
				showError(getLocalPlayer(),"Sie haben keine gültige Waffe aus der Liste gewählt!")
			end
		else
			showError(getLocalPlayer(),"Sie haben vergessen mir zu sagen, wieviel Munition sie möchten!")
		end
	else
		showError(getLocalPlayer(),"Sie haben vergessen mir zu sagen, wieviel Munition sie möchten!")
	end
end

function ammoBuyWeste()
    if(not checkAmmoOkay())then return false end
	if(guiRadioButtonGetSelected( LeightArmorRadioButton )) then
		if(getPlayerMoney(getLocalPlayer())<15)then
			showError(getLocalPlayer(),"Sie haben nicht genug Geld!")
		else
			triggerServerEvent("ammoBuyWeste_Event",getLocalPlayer(),"leicht")
		end
	elseif(guiRadioButtonGetSelected( HeavyArmorRadioButton))then
		if(getPlayerMoney(getLocalPlayer())<25)then
			showError(getLocalPlayer(),"Sie haben nicht genug Geld!")
		else
			triggerServerEvent("ammoBuyWeste_Event",getLocalPlayer(),"schwer")
		end	
	else
		showError(getLocalPlayer(),"Sie müssen eine Weste auswählen!")
	end
end





function closeAmmoGui()
		guiSetVisible(AmmuFenster,false)
		showCursor(false)
end

function showAmmoGui()

	guiSetVisible(AmmuFenster,true)
	showCursor(true)


end

function onClientMarkerHit(thePl,theDim)
	if(thePl==getLocalPlayer())then
		ammoWasPorted=false
		isFiring=false		
		setPedControlState (ammoBots[8],"fire",false)
	end
end


function AmmoBotAimOn()
	if(isFiring==true)then
		setPedControlState (ammoBots[8],"fire",true)
		setTimer("AmmoBotAimOn",500,1)
	end
	
end


ammoPedCoords={
{1368.541015625,-1281.1591796875,13.546875,35.071655273438,0},
{1368.48828125,-1278.3701171875,13.546875,144.11260986328,0},
{316.111328125,-133.859375,999.6015625,95.041442871094,7 },
{316.20703125,-130.1484375,1004.0625,182.46096801758 ,7},
{315.5,-129.9892578125,1004.0625,179.64294433594,7},
{314.78515625,-129.9658203125,1004.0625,179.64294433594,7},
{314.181640625,-130.0751953125,1004.0625,179.01672363281,7},
{314.8359375,-138.41796875,1005.1328125,46.162506103516,7}

}

function createAmmoBots()

 --ammoBots[1]=createPed(166, 316.111328125,-133.859375,999.6015625,95.041442871094  )
 --ammoBots[4]=createPed(166, 316.20703125,-130.1484375,1004.0625,182.46096801758  )
 --ammoBots[5]=createPed(166, 315.5,-129.9892578125,1004.0625,179.64294433594  )
 --ammoBots[6]=createPed(166, 314.78515625,-129.9658203125,1004.0625,179.64294433594 ) 
 --ammoBots[7]=createPed(166, 314.181640625,-130.0751953125,1004.0625,179.01672363281  ) 
 --ammoBots[8]=createPed(166, 314.8359375,-138.41796875,1005.1328125,46.162506103516 )
 
 for theKey,thePed in ipairs(ammoBots) do
	setElementRotation(thePed,0,0,ammoPedCoords[theKey][4])
	setElementInterior(thePed,ammoPedCoords[theKey][5])
	addEventHandler("onClientPedWasted",thePed,respawnAmmoBot)
 end
 
 
end

addEvent("setTriggeredBotAmmonation_Event",true)
function setTriggeredBotAmmonation()
	ammoBots[1]=source

end
addEventHandler("setTriggeredBotAmmonation_Event",getRootElement(),setTriggeredBotAmmonation)

function respawnAmmoBot()
		setTimer(respawnShootAmmoBot, 20000, 1 ,source )

end

function respawnShootAmmoBot(bot)
	local theKey=0
	for newKey,thePed in ipairs(ammoBots)do
		if(bot==thePed)then
			theKey=newKey
		end
	end
	destroyElement(bot)
	ammoBots[theKey]=createPed(166,ammoPedCoords[theKey][1],ammoPedCoords[theKey][2],ammoPedCoords[theKey][3],ammoPedCoords[theKey][4])	
	setElementInterior(ammoBots[theKey],ammoPedCoords[theKey][5])		
	setElementRotation(ammoBots[theKey],0,0,ammoPedCoords[theKey][4])
end

addEvent("onAmmoChangeDim",true)
function changedimammo(dim,ped)
	setElementDimension(ped,dim)
	--outputChatBox(tostring(ped).." "..tostring(dim))
	setTimer(setNewDim_ammo_again,2000,1,ped,dim)
end
addEventHandler("onAmmoChangeDim",getRootElement(),changedimammo)

function setNewDim_ammo_again(ped,dim)
	if(isElement(ped))then
		setElementDimension(ped,dim)
	end
end

function clickAmmoBot(button, state,  absoluteX,  absoluteY,  worldX,  worldY,  worldZ,  clickedWorld)
	if(clickedWorld==ammoBots[1])then
		local x,y,z=getElementPosition(getLocalPlayer())
		local sx,sy,sz=getElementPosition(ammoBots[1])
		local dis=getDistanceBetweenPoints3D(x,y,z,sx,sy,sz)


		if(dis<5)then
			showAmmoGui()
            lastOpenX,lastOpenY,lastOpenZ=x,y,z
		end
	end
end
addEventHandler("onClientClick",getRootElement(),clickAmmoBot)









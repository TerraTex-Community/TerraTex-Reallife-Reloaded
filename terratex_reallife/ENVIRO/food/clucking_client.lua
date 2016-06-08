
local showCMenu=1
local cMenuShowing=false
local cMenuObject=false
local cMenu={{"Kleines Menue",2215,0.50,20},{"Mittleres Menu",2216,0.80,40},{"Grosses Menu",2217,1.20,90},{"Salat",2353,1.00,120}}

function createCluckingMarker()
	local mark=false
	for i=0,20,1 do
		mark=createMarker(368.35324,-6.286423,1000.8515625,"cylinder",1)
		setElementInterior(mark,9)
		setElementDimension(mark,i)
		addEventHandler("onClientMarkerHit",mark,showCluckingMenu)	
	end
	
end
addEventHandler ( "onClientResourceStart", getRootElement(), createCluckingMarker )

function showCluckingMenu(player,mathchdim)
	if(mathchdim) and not(cMenuShowing) and player==getLocalPlayer() then
		showCMenu=1
		cMenuShowing=true
		setElementFrozen(getLocalPlayer(),true)
		cMenuObject=createObject(cMenu[1][2],368.97998,-5.31222,1002.06665,346.7604,47.6447,79.85122)
		setElementInterior(cMenuObject,9)
		setElementDimension(cMenuObject,getElementDimension(getLocalPlayer()))
		setCameraMatrix(368.97998,-5.31222,1003.06665,368.97998,-5.31222,1002.06665)
		bindKey ( "arrow_r", "down", cMenunext_func )
		bindKey ( "arrow_l", "down", cMenubefore_func )
		bindKey ( "space", "down", cMenuclose_func  )
		bindKey ( "enter", "down", cMenubuy_func)
	end
end

function showCMenuInfo()
	if(cMenuShowing)then
		local scx,scy=guiGetScreenSize()
		dxDrawText("Keys: Enter-Kaufen",3,scy/2-30,1,1,tocolor(0,0,255,255),1.5,"default-bold")
		dxDrawText("           Leertaste-Beenden",3,scy/2-30+15,1,1,tocolor(0,0,255,255),1.5,"default-bold")
		dxDrawText("           Links-Zurück",3,scy/2,1,1,tocolor(0,0,255,255),1.5,"default-bold")
		dxDrawText("           Rechts-Weiter",3,scy/2+15     ,1,1,tocolor(0,0,255,255),1.5,"default-bold")		  
		dxDrawText(string.format("Art: %s", cMenu[showCMenu][1]),3,scy/2+30,1,1,tocolor(0,0,255,255),1.5,"default-bold")
		preis=bMenu[showCMenu][3]
		if(isWetterEventID==1)then
			preis=preis*3
		elseif(isWetterEventID==2)then
			preis=preis*1.5
		elseif(isWetterEventID==3)then
			preis=preis*3.5
		elseif(isWetterEventID==5)then
			preis=preis*0.7
		elseif(isWetterEventID==6)then
			preis=preis*0.9
		end
		
		dxDrawText(string.format("Preis: %s$", preis),3,scy/2+45,1,1,tocolor(0,0,255,255),1.5,"default-bold")
	
	end
end
addEventHandler("onClientRender",getRootElement(),showCMenuInfo)

function cMenunext_func()
	showCMenu=showCMenu+1
	if(showCMenu>4)then showCMenu=1 end
	setElementModel(cMenuObject,cMenu[showCMenu][2])
	--destroyElement(cMenuObject)
	--cMenuObject=createObject(cMenu[showCMenu][2],375.886352,-66.486213,1001.70416,345.498107,54.48303222,97.5831298)
end

function cMenubefore_func()
	showCMenu=showCMenu-1
	if(showCMenu<1)then showCMenu=4 end	
	setElementModel(cMenuObject,cMenu[showCMenu][2])
	--destroyElement(cMenuObject)
	--cMenuObject=createObject(cMenu[showCMenu][2],375.886352,-66.486213,1001.70416,345.498107,54.48303222,97.5831298)	
end


function cMenuclose_func()
	destroyElement(cMenuObject)
	cMenuObject=false
	setElementFrozen(getLocalPlayer(),false)
	cMenuShowing=false
	showCMenu=1
	setCameraTarget(getLocalPlayer())
	
	unbindKey ( "arrow_r", "down", cMenunext_func )
	unbindKey ( "arrow_l", "down", cMenubefore_func )
	unbindKey ( "space", "down", cMenuclose_func  )
	unbindKey ( "enter", "down", cMenubuy_func)
end

function cMenubuy_func()
	if(cMenu[showCMenu][3]<getPlayerMoney(getLocalPlayer())+1)then
		triggerEvent("addFood",getLocalPlayer(),cMenu[showCMenu][4])
		triggerServerEvent("buyFood_B",getLocalPlayer(),cMenu[showCMenu][3],"huhn")
        showError(getLocalPlayer(),"Du hast dieses Menu erfolgreich gekauft!")
	else
        showError(getLocalPlayer(),"Du hast nicht genuegend Geld!")
	end
end










local showBMenu=1
local bMenuShowing=false
local bMenuObject=false
local bMenu={{"Kleines Menue",2213,0.50,20},{"Mittleres Menu",2214,0.80,40},{"Grosses Menu",2212,1.20,90},{"Salat",2354,1.00,120}}


function createBurgerMarker()
	local mark=false
	for i=0,20,1 do
		mark=createMarker(376.134155,-67.880355,1000.4818115,"cylinder",1)
		setElementInterior(mark,10)		
		setElementDimension(mark,i)
		addEventHandler("onClientMarkerHit",mark,showBurgerMenu)	
	end
	
end
addEventHandler ( "onClientResourceStart", getRootElement(), createBurgerMarker )



function showBurgerMenu(player,mathchdim)
	if(mathchdim) and not(bMenuShowing) and player==getLocalPlayer() then
		showBMenu=1
		bMenuShowing=true
		setElementFrozen(getLocalPlayer(),true)
		bMenuObject=createObject(bMenu[1][2],375.886352,-66.486213,1001.70416,345.498107,54.48303222,97.5831298)
		setElementInterior(bMenuObject,10)
		setCameraMatrix(375.886352,-66.486213,1002.70416,375.886352,-66.486213,1001.70416)
		setElementDimension(bMenuObject,getElementDimension(getLocalPlayer()))
		bindKey ( "arrow_r", "down", bmenunext_func )
		bindKey ( "arrow_l", "down", bmenubefore_func )
		bindKey ( "space", "down", bmenuclose_func  )
		bindKey ( "enter", "down", bmenubuy_func)
	end
	
end

function showBMenuInfo()
	if(bMenuShowing)then
		local scx,scy=guiGetScreenSize()
		dxDrawText("Keys: Enter-Kaufen",3,scy/2-30,1,1,tocolor(0,0,255,255),1.5,"default-bold")
		dxDrawText("           Leertaste-Beenden",3,scy/2-30+15,1,1,tocolor(0,0,255,255),1.5,"default-bold")
		dxDrawText("           Links-Zurück",3,scy/2,1,1,tocolor(0,0,255,255),1.5,"default-bold")
		dxDrawText("           Rechts-Weiter",3,scy/2+15     ,1,1,tocolor(0,0,255,255),1.5,"default-bold")		  
		dxDrawText(string.format("Art: %s", bMenu[showBMenu][1]),3,scy/2+30,1,1,tocolor(0,0,255,255),1.5,"default-bold")
		preis=bMenu[showBMenu][3]
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
addEventHandler("onClientRender",getRootElement(),showBMenuInfo)

function bmenunext_func()
	showBMenu=showBMenu+1
	if(showBMenu>4)then showBMenu=1 end
	setElementModel(bMenuObject,bMenu[showBMenu][2])
	--destroyElement(bMenuObject)
	--bMenuObject=createObject(bMenu[showBMenu][2],375.886352,-66.486213,1001.70416,345.498107,54.48303222,97.5831298)
end

function bmenubefore_func()
	showBMenu=showBMenu-1
	if(showBMenu<1)then showBMenu=4 end	
	setElementModel(bMenuObject,bMenu[showBMenu][2])
	--destroyElement(bMenuObject)
	--bMenuObject=createObject(bMenu[showBMenu][2],375.886352,-66.486213,1001.70416,345.498107,54.48303222,97.5831298)	
end


function bmenuclose_func()
	destroyElement(bMenuObject)
	bMenuObject=false
	setElementFrozen(getLocalPlayer(),false)
	bMenuShowing=false
	showBMenu=1
	setCameraTarget(getLocalPlayer())
	
	unbindKey ( "arrow_r", "down", bmenunext_func )
	unbindKey ( "arrow_l", "down", bmenubefore_func )
	unbindKey ( "space", "down", bmenuclose_func  )
	unbindKey ( "enter", "down", bmenubuy_func)
end

function bmenubuy_func()
	if(bMenu[showBMenu][3]<getPlayerMoney(getLocalPlayer())+1)then
		triggerEvent("addFood",getLocalPlayer(),bMenu[showBMenu][4])
		triggerServerEvent("buyFood_B",getLocalPlayer(),bMenu[showBMenu][3],"burger")
		showError(getLocalPlayer(),"Du hast dieses Menu erfolgreich gekauft!")
	else
        showError(getLocalPlayer(),"Du hast nicht genuegend Geld!")
	end
end









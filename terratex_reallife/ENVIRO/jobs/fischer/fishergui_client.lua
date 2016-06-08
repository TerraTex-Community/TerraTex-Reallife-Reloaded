
local fishtimer=false
local entkommentimer=false
local isFisherBoat=false
local sendfishpoints=0
local lastFishingFaktor=1
local sendfishes=0
local sendmoney=0
local fish=0
local isFishing=false


local FischerGUI_Window = {}
local FischerGUI_Button = {}
local FischerGUI_Label = {}
local randfishes={
    {"Alaska-Seelachs",0.8},     {"Buttermakrele",30},    {"Conger",47},      {"Doggerscharbe",1.5},     {"Flügelbutt",0.5},     {"Franzosendorsch",0.5},    {"Glasbutt",0.2},     {"Glattrochen",115},
    {"Goldbrasse",2},       {"Goldmaid",0.5},    {"atlantischer Heilbutt",300},    {"Hornhecht",1.5},    {"Kleinäugiger Rochen",5},      {"Kliesche",1.2},    {"Köhler",5},      {"roter Knurrhahn",2},
    {"Kuckucksrochen",1.5},    {"Kurzschwanzrochen",17},    {"gestreifter Leierfisch",0.15},   {"Leng",5},    {"Lingcod",10},     {"Lippfisch",3.5},    {"Kleinmäuliger Lippfisch",0.8},    {"Lumb",17},    {"Marmorrochen",11},     {"Meeräsche",5.5},    {"Meerbarbe",0.5},    {"Meerengel",10},
    {"Muräne",5},      {"Nagelrochen",7},    {"Petermännchen",0.45},{"Pollack",2.5},   {"Schellfisch",3.5},{"Sardelle",0.1},    {"Sandaal",0.2},{"Rotbarsch",1.5},    {"Schweinsdrückerfisch",6},{"Seehase",9},    {"Seehecht",20},{"Seekarpfen",3},    {"Seeskorpion",1},{"Seequappe",0.3},
    {"Seeteufel",9},{"Seewolf",20},    {"Seezunge",2},{"Sprotte",0.05},    {"Stechrochen",10},{"Steinbutt",2},    {"Steinpicker",5.5},{"Sterlet",7},    {"Stint",0.2},{"Stintdorsch",0.25},    {"Stöcker",0.5},{"atlantischer Stör",30},    {"kleiner weißer Stör",150},{"großer weißer Stör",300},    {"Streifenbrassen",4.0},{"Streifenlippfisch",1.2},    {"Wittling",3.0},{"Zackenbarsch",1.1},  {"Hornhecht",2.5},{"Dorsch",3.25}, {"Flunder",1.5},{"Goldbarsch",11},
    {"einen Heilbutt",3},{"einen Kabeljau",4}, {"einen 2kg-Wolfsbarsch",10},{"einen Aal",2},    {"einen 05kg-Wolfsbarsch",3},{"eine Meeresforelle",5}, {"eine Flunder",7},{"eine Makrele",0.5},
    {"einen Lachs",4}}
local randmuell={
    "einen dreckigen alten Schuh","einen alten Handschuh","einen Gummireifen","eine alte vergammelte Hose","eine alte Damentasche","eine Socke mit Würmern","ein Stück Schimmelpilz","eine alte Dose","eine alte FastFood Verpackung"
}-- 8 mal adden
local canFishVehicle={[484]=true,[453]=true,[454]=true}

addEventHandler("onClientResourceStart",resourceRoot,
    function()
       local tmprand={}
       for theKey,theTable in ipairs(randmuell)do
           for k=1,7,1 do
                table.insert(tmprand,theTable)
           end
        end

       randmuell= tmprand

        FischerGUI_Window[1] = guiCreateWindow(425,100,375,139,"Angel",false)
		table.insert(allGuis,FischerGUI_Window[1])
        FischerGUI_Label[1] = guiCreateLabel(13,29,351,46,"Die Angel wurde noch nicht ausgeworfen!",false,FischerGUI_Window[1])
			guiLabelSetColor(FischerGUI_Label[1],0,255,0)
			guiLabelSetVerticalAlign(FischerGUI_Label[1],"top")
			guiLabelSetHorizontalAlign(FischerGUI_Label[1],"center",true)
        FischerGUI_Button[1] = guiCreateButton(11,87,125,42,"Auswerfen",false,FischerGUI_Window[1])
			guiSetFont(FischerGUI_Button[1],"default-bold-small")
        FischerGUI_Button[2] = guiCreateButton(141,86,114,42,"Beenden",false,FischerGUI_Window[1])
			guiSetFont(FischerGUI_Button[2],"default-bold-small")
        FischerGUI_Button[3] = guiCreateButton(259,86,107,41,"Einziehen",false,FischerGUI_Window[1])
			guiSetFont(FischerGUI_Button[3],"default-bold-small")
		guiSetVisible(FischerGUI_Window[1],false)
		
		addEventHandler ( "onClientGUIClick", FischerGUI_Button[3], einziehenFischGui, false )
		addEventHandler ( "onClientGUIClick", FischerGUI_Button[2], closeFishGui, false )
		addEventHandler ( "onClientGUIClick", FischerGUI_Button[1], auswerfenFishGui, false )
    end
)

function einziehenFischGui()
	if(fish>0)then
		if(entkommentimer)then
			killTimer(entkommentimer)
			entkommentimer=false
        end
		if(fish<table.getSize(randfishes)+1)then
			if not(isFisherBoat)then
				guiSetText(FischerGUI_Label[1],string.format("Du hast %s gefangen!\nDu kannst die Angel wieder auswerfen!", randfishes[fish][1]))
				sendfishpoints=sendfishpoints+(randfishes[fish][2]*lastFishingFaktor)
				sendfishes=sendfishes+1
			else
				local firstFish=randfishes[fish][1]
				sendfishpoints=sendfishpoints+(randfishes[fish][2]*lastFishingFaktor)
				sendfishes=sendfishes+1
				local rand=math.random(1,4)
				if(rand==1)then
					local money=math.random(2,5)
					sendmoney=sendmoney+money
					guiSetText(FischerGUI_Label[1],string.format("Du hast %s und einen Geldbeutel gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", firstFish, money))
				else
					local fishTwo=math.random(1,table.getn(randfishes))
					sendfishpoints=sendfishpoints+(randfishes[fishTwo][2]*lastFishingFaktor)
					guiSetText(FischerGUI_Label[1],string.format("Du hast %s und %s gefangen! Du kannst die Angel wieder auswerfen!", firstFish, randfishes[fishTwo][1]))
				end			
			end
		elseif(fish==table.getSize(randfishes)+1)then
			if not(isFisherBoat)then
				guiSetText(FischerGUI_Label[1],"Du hast einen Geldbeutel geangelt und findest 2$! Du kannst die Angel wieder auswerfen!")
				sendmoney=sendmoney+2
			else
				local firstMoney=2
				sendmoney=sendmoney+2
				local rand=math.random(1,4)
				if(rand==1)then
					local money=math.random(2,5)
					sendmoney=sendmoney+money
					guiSetText(FischerGUI_Label[1],string.format("Du hast einen Geldbeutel und einen Geldbeutel gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", (money + firstMoney)))
				else
					local fishTwo=math.random(1,table.getn(randfishes))
					sendfishpoints=sendfishpoints+(randfishes[fishTwo][2]*lastFishingFaktor)
					guiSetText(FischerGUI_Label[1],string.format("Du hast Geldbeutel und %s gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", randfishes[fishTwo][1], firstMoney))
					sendfishes=sendfishes+1
				end
			end
		elseif(fish==table.getSize(randfishes)+2)then
			if not(isFisherBoat)then
				guiSetText(FischerGUI_Label[1],"Du hast einen Geldbeutel geangelt und findest 4$! Du kannst die Angel wieder auswerfen!")
				sendmoney=sendmoney+4	
			else
				local firstMoney=4
				sendmoney=sendmoney+firstMoney
				local rand=math.random(1,4)
				if(rand==1)then
					local money=math.random(2,500)
					sendmoney=sendmoney+money
					guiSetText(FischerGUI_Label[1],string.format("Du hast einen Geldbeutel und einen Geldbeutel gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", (money + firstMoney)))
				else
					local fishTwo=math.random(1,table.getn(randfishes))
					sendfishpoints=sendfishpoints+(randfishes[fishTwo][2]*lastFishingFaktor)
					guiSetText(FischerGUI_Label[1],string.format("Du hast Geldbeutel und %s gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", randfishes[fishTwo][1], firstMoney))
					sendfishes=sendfishes+1
				end
			end
		elseif(fish==table.getSize(randfishes)+3)then
			if not(isFisherBoat)then
				guiSetText(FischerGUI_Label[1],"Du hast einen Geldbeutel geangelt und findest 10$! Du kannst die Angel wieder auswerfen!")
				sendmoney=sendmoney+10	
			else
				local firstMoney=10
				sendmoney=sendmoney+firstMoney
				local rand=math.random(1,4)
				if(rand==1)then
					local money=math.random(2,500)
					sendmoney=sendmoney+money
					guiSetText(FischerGUI_Label[1],string.format("Du hast einen Geldbeutel und einen Geldbeutel gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", (money + firstMoney)))
				else
					local fishTwo=math.random(1,table.getn(randfishes))
					sendfishpoints=sendfishpoints+(randfishes[fishTwo][2]*lastFishingFaktor)
					guiSetText(FischerGUI_Label[1],string.format("Du hast Geldbeutel und %s gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", randfishes[fishTwo][1], firstMoney))
					sendfishes=sendfishes+1
				end
			end			
		elseif(fish == table.getSize(randfishes) + 4)then
			if not(isFisherBoat)then
				local money = math.random(10,500)
				guiSetText(FischerGUI_Label[1],string.format("Du hast einen Geldbeutel geangelt und findest %s $! Du kannst die Angel wieder auswerfen!", money))
				sendmoney = sendmoney + money
			else
				local firstMoney=math.random(10,50)
				sendmoney=sendmoney+firstMoney
				local rand=math.random(1,4)
				if(rand==1)then
					local money=math.random(2,50)
					sendmoney=sendmoney+money
					guiSetText(FischerGUI_Label[1],string.format("Du hast einen Geldbeutel und einen Geldbeutel gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", (money + firstMoney)))
				else
					local fishTwo=math.random(1,table.getn(randfishes))
					sendfishpoints=sendfishpoints+(randfishes[fishTwo][2]*lastFishingFaktor)
					guiSetText(FischerGUI_Label[1],string.format("Du hast Geldbeutel und %s gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", randfishes[fishTwo][1], firstMoney))
					sendfishes = sendfishes + 1
				end
			end
		elseif(fish==table.getSize(randfishes)+5)then
			if not(isFisherBoat)then
				local money=math.random(20,50)
				guiSetText(FischerGUI_Label[1],string.format("Du hast einen Geldbeutel geangelt und findest %s $! Du kannst die Angel wieder auswerfen!", money))
				sendmoney=sendmoney+money
			else
				local firstMoney=math.random(20,50)
				sendmoney=sendmoney+firstMoney
				local rand=math.random(1,4)
				if(rand==1)then
					local money=math.random(2,500)
					sendmoney=sendmoney+money
					guiSetText(FischerGUI_Label[1],string.format("Du hast einen Geldbeutel und einen Geldbeutel gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", (money + firstMoney)))
				else
					local fishTwo=math.random(1,table.getn(randfishes))
					sendfishpoints=sendfishpoints+(randfishes[fishTwo][2]*lastFishingFaktor)
					guiSetText(FischerGUI_Label[1],string.format("Du hast Geldbeutel und %s gefangen und findest %s $! Du kannst die Angel wieder auswerfen!", randfishes[fishTwo][1], firstMoney))
					sendfishes=sendfishes+1
				end
			end
		else
			--guiSetText(FischerGUI_Label[1],"Du hast "..randmuell[(fish-(table.getn(randfishes)+6))].." geangelt! Wirf besser die Angel neu aus!")
           -- outputChatBox("FishID: "..fish)
           -- outputChatBox("- "..(table.getSize(randfishes)+5))
           -- outputChatBox(fish-((table.getSize(randfishes)+5))..randmuell[(fish-(table.getSize(randfishes)+5))] )
            --outputChatBox("----------------------------------")
			guiSetText(FischerGUI_Label[1],string.format("Du hast %s geangelt! Wirf besser die Angel neu aus!", randmuell[(fish-(table.getSize(randfishes)+5))]))
		end
		fish=0
	else
		if(fishtimer)then
            killTimer(fishtimer)
            fishtimer=false
			showError(getLocalPlayer(),"Die Angel wurde leer eingezogen")
		else
			showError(getLocalPlayer(),"Die Angel ist nicht ausgeworfen!")
		end
	end
	
end
--
function isOnFisherBoat(player)
	local veh=getPedContactElement ( player)
	if(isPedInVehicle(player))then
		veh=getPedOccupiedVehicle(player)
	end
	--outputDebugString(tostring(veh).." "..getElementModel(veh))
	if(veh)then
		if(getVehicleType(veh)=="Boat")then
			if(getElementData(veh,"locked")=="false" or not(getElementData(veh,"locked")))then			
				if(canFishVehicle[getElementModel(veh)] or tonumber(getElementData(player,"premium"))>0)then				
					return true
				else
					return false
				end
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end	
end

function auswerfenFishGui()
	local x,y,z=getElementPosition(getLocalPlayer())
	if(getDistanceBetweenPoints3D(364.40338134766,-2060.6716308594,8.8381404876709,x,y,z)>50)and not(isOnFisherBoat(getLocalPlayer()))then
		closeFishGui()
	else
		if (isTimer(fishtimer)) then
			killTimer(fishtimer)
			fishtimer = false
		end
		fish=-1
		if((tonumber(getElementData(getLocalPlayer(),"fisheslasthour"))+sendfishes)>80)then
			showError(getLocalPlayer(),"Du kannst nur 80 Fische pro Stunde fangen!")
		else
			local timer=math.random(1,60)*1000
			--debug
			-- timer=1000
			guiSetText(FischerGUI_Label[1],"Du hast die Angel ausgeworfen! Warte darauf das ein Fisch anbeißt.....")
			fishtimer=setTimer(getFish,timer,1)
		end
	end
end

function getFish()
	fishtimer=false
	guiSetText(FischerGUI_Label[1],"Ein Fisch hat angebissen! Los zieh ihn rein bevor er loslaesst.....!")
  --  outputChatBox("max: "..(table.getSize(randfishes)+table.getSize(randmuell)+5)) --132  (168)
  --  outputChatBox("maxmuell: "..table.getSize(randmuell))--54
  --  outputChatBox("Rest: "..table.getSize(randfishes)+5)--54

	fish=math.random(1,(table.getSize(randfishes)+table.getSize(randmuell)+5))
	entkommentimer=setTimer(fishOut,5000,1)
end

function fishOut()
	entkommentimer=false
	local zwitch=math.random(1,3)
	if(zwitch==1)then
		guiSetText(FischerGUI_Label[1],"Der Fisch ist entkommen! Wirf die Angel neu aus!")
		fish=0
	else
		entkommentimer=setTimer(fishOut,5000,1)		
	end
end

function closeFishGui()
	if (guiGetVisible(FischerGUI_Label[1])) then
		if(fishtimer)then
			killTimer(fishtimer)
		end
		fishtimer=false
		if(entkommentimer)then
			killTimer(entkommentimer)
		end

		triggerServerEvent("transferFish",getLocalPlayer(),sendfishes,sendmoney,sendfishpoints)
		fishtimer=false
		guiSetText(FischerGUI_Label[1],"Die Angel wurde noch nicht ausgeworfen!")
		entkommentimer=false
		sendfishpoints=0
		sendfishes=0
		sendmoney=0
		isFishing=false
		fish=0
		entkommentimer=false
		toggleAllControls(true)
		showCursor(false)
		guiSetVisible(FischerGUI_Window[1],false)
	end
end
addEvent("closeFishing", true)
addEventHandler("closeFishing", getRootElement(), closeFishGui)

function showfishgui(bootBool,faktor)
    if(bootBool)then
        local veh=getPedContactElement ( getLocalPlayer())
        if(isPedInVehicle(getLocalPlayer()))then
            veh=getPedOccupiedVehicle(getLocalPlayer())
        end

        local px,py,pz=getElementPosition(getLocalPlayer())
        local textstring=""
        if isElement(veh)then
            px,py,pz=getElementPosition ( veh )

            local hit,nx,ny,nz=processLineOfSight ( px,py,pz+10, px,py,-300, true,  false, false,true,false,  false, false,false,veh)



            if(hit)then
                if(nz>-7)then
                    showError(getLocalPlayer(),"Hier ist das Wasser zu flach zum Angeln.")
                    return false
                end
            end
        else
            return false;
        end
    end
    lastFishingFaktor=faktor
    isFisherBoat=bootBool
    toggleAllControls(false)
    showCursor(true)
    guiSetVisible(FischerGUI_Window[1],true)
    fishtimer=false
    entkommentimer=false
    isFishing=true
    sendfishpoints=0
    sendmoney=0
end
addEvent("showFishing",true)
addEventHandler("showFishing",getRootElement(),showfishgui)

--FISCHANZEIGE
addEventHandler("onClientRender", root,
    function()
		if (isFishing) then
			local fisheshave = sendfishes + tonumber(getElementData(getLocalPlayer(), "last_fishes"))
			local fishesrest = 80 - (tonumber(getElementData(getLocalPlayer(), "fisheslasthour")) - tonumber(getElementData(getLocalPlayer(), "last_fishes")))
			local screenW, screenH = guiGetScreenSize()
			dxDrawRectangle(screenW - 250 - 10, (screenH - 92) / 2, 250, 92, tocolor(0, 13, 71, 220), false)
			if (isPedInVehicle(getLocalPlayer())) then
                dxDrawText("Fische: " .. fisheshave * 2 .. "/" .. fishesrest * 2 .. "\nGeld: " .. sendmoney .. " $", screenW - 251 - 10, (screenH - 92) / 2, (screenW - 251 - 10) + 251, ( (screenH - 92) / 2) + 92, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
            else
                dxDrawText("Fische: " .. fisheshave .. "/" .. fishesrest .. "\nGeld: " .. sendmoney .. " $", screenW - 251 - 10, (screenH - 92) / 2, (screenW - 251 - 10) + 251, ( (screenH - 92) / 2) + 92, tocolor(255, 255, 255, 255), 1.00, "pricedown", "center", "center", false, false, false, false, false)
            end
		end
	end
)












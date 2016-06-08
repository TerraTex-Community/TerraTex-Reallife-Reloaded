
 function createPferdeJackMarker()
	local marker=createMarker(2274.630859375,1603.9794921875,1005.1796875,"cylinder",1)
	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterPferdeMarker_new)	
	marker=createMarker(2274.400390625,1608.8916015625,1005.1796875,"cylinder",1)
	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterPferdeMarker_new)	
	marker=createMarker(2270.3603515625,1603.9365234375,1005.1796875,"cylinder",1)
	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterPferdeMarker_new)	
	marker=createMarker(2270.3603515625,1609.4052734375,1005.1796875,"cylinder",1)
	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterPferdeMarker_new)	
	marker=createMarker(2268.423828125,1609.1015625,1005.1796875,"cylinder",1)
	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterPferdeMarker_new)	
	marker=createMarker(2268.357421875,1603.9140625,1005.1796875,"cylinder",1)
	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterPferdeMarker_new)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),createPferdeJackMarker)
 
PferdeGUI_Window = {}
PferdeGUI_Button = {}
PferdeGUI_Checkbox = {}
PferdeGUI_Label = {}
PferdeGUI_Edit = {}
PferdeGUI_Image = {}

addEventHandler("onClientResourceStart",resourceRoot,
    function()
		local dx,dy=guiGetScreenSize()
		dx=578/1600*dx
		dy=271/900*dy
        PferdeGUI_Window[1] = guiCreateWindow(dx,dy,500,359,"Pferderace",false)
		table.insert(allGuis,PferdeGUI_Window[1])
        PferdeGUI_Image[1] = guiCreateStaticImage(51,30,54,41,"FILES/IMAGES/BlauPferd.png",false,PferdeGUI_Window[1])
        PferdeGUI_Image[2] = guiCreateStaticImage(51,70,54,41,"FILES/IMAGES/GruenPferd.png",false,PferdeGUI_Window[1])
        PferdeGUI_Image[3] = guiCreateStaticImage(51,110,54,41,"FILES/IMAGES/GelbPferd.png",false,PferdeGUI_Window[1])
        PferdeGUI_Image[4] = guiCreateStaticImage(51,150,54,41,"FILES/IMAGES/RotPferd.png",false,PferdeGUI_Window[1])
        PferdeGUI_Edit[1] = guiCreateEdit(401,29,5,170,"",false,PferdeGUI_Window[1])
        PferdeGUI_Edit[2] = guiCreateEdit(43,67,364,5,"",false,PferdeGUI_Window[1])
        PferdeGUI_Edit[3] = guiCreateEdit(43,106,364,5,"",false,PferdeGUI_Window[1])
        PferdeGUI_Edit[4] = guiCreateEdit(43,145,364,5,"",false,PferdeGUI_Window[1])
        PferdeGUI_Label[1] = guiCreateLabel(418,40,63,19,"0. Platz",false,PferdeGUI_Window[1])
        PferdeGUI_Label[2] = guiCreateLabel(418,77,63,19,"0. Platz",false,PferdeGUI_Window[1])
        PferdeGUI_Label[3] = guiCreateLabel(418,116,63,19,"0. Platz",false,PferdeGUI_Window[1])
        PferdeGUI_Label[4] = guiCreateLabel(418,158,63,19,"0. Platz",false,PferdeGUI_Window[1])
        PferdeGUI_Checkbox[1] = guiCreateCheckBox(20,39,21,21,"",false,false,PferdeGUI_Window[1])
        PferdeGUI_Checkbox[2] = guiCreateCheckBox(20,77,21,21,"",false,false,PferdeGUI_Window[1])
        PferdeGUI_Checkbox[3] = guiCreateCheckBox(20,115,21,21,"",false,false,PferdeGUI_Window[1])
        PferdeGUI_Checkbox[4] = guiCreateCheckBox(20,154,21,21,"",false,false,PferdeGUI_Window[1])
        PferdeGUI_Label[5] = guiCreateLabel(24,197,148,19,"Einsatz: ",false,PferdeGUI_Window[1])
        PferdeGUI_Button[1] = guiCreateButton(24,219,136,17,"+ 10",false,PferdeGUI_Window[1])
        PferdeGUI_Button[2] = guiCreateButton(24,239,136,17,"+ 50",false,PferdeGUI_Window[1])
        PferdeGUI_Button[3] = guiCreateButton(24,260,136,17,"+ 100",false,PferdeGUI_Window[1])
        PferdeGUI_Button[4] = guiCreateButton(24,280,136,17,"+ 1.000",false,PferdeGUI_Window[1])
        PferdeGUI_Button[5] = guiCreateButton(218,216,258,21,"Race Starten!",false,PferdeGUI_Window[1])
        PferdeGUI_Button[6] = guiCreateButton(218,242,258,21,"Neues Race!",false,PferdeGUI_Window[1])
		PferdeGUI_Button[7] = guiCreateButton(218,268,258,21,"Beenden!",false,PferdeGUI_Window[1])
        PferdeGUI_Label[6] = guiCreateLabel(21,302,466,43,"Regeln:\n- Hacken auf das Pferd setzen, auf das gewettet wird!\n- Gewinn: Pferd wird 1.Platz: 2:1",false,PferdeGUI_Window[1])
		guiSetVisible(PferdeGUI_Window[1],false)
		addEventHandler("onClientGUIClick",PferdeGUI_Button[1],addTausendToPferdeRennen,false)
		addEventHandler("onClientGUIClick",PferdeGUI_Button[2],addfiveTausendToPferdeRennen,false)
		addEventHandler("onClientGUIClick",PferdeGUI_Button[3],addTenTausendToPferdeRennen,false)
		addEventHandler("onClientGUIClick",PferdeGUI_Button[4],addHundertTausendToPferdeRennen,false)
		addEventHandler("onClientGUIClick",PferdeGUI_Button[5],startPferdeRennen,false)		
		addEventHandler("onClientGUIClick",PferdeGUI_Button[6],resetPferdeRennenGui,false)		
		addEventHandler("onClientGUIClick",PferdeGUI_Button[7],cancelPferdeRennen,false)
		
		addEventHandler("onClientGUIClick",PferdeGUI_Checkbox[1],clickHorseA,false)
		addEventHandler("onClientGUIClick",PferdeGUI_Checkbox[2],clickHorseB,false)
		addEventHandler("onClientGUIClick",PferdeGUI_Checkbox[3],clickHorseC,false)
		addEventHandler("onClientGUIClick",PferdeGUI_Checkbox[4],clickHorseD,false)
		
		
		
	end
)
--ziellinie=351
local einsatz=0
local selectedHorse=0
local weiteHorse={0,0,0,0}
local isPferdeRaceInAction=false

function clickHorseA()
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[1],true)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[2],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[3],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[4],false)
	if isPferdeRaceInAction then setLastHorseState() end
end
function clickHorseB()

	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[1],false)	
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[2],true)	
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[3],false)	
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[4],false)
	if isPferdeRaceInAction then setLastHorseState() end

end
function clickHorseC()
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[1],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[2],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[3],true)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[4],false)
	if isPferdeRaceInAction then setLastHorseState() end
end
function clickHorseD()
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[1],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[2],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[3],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[4],true)
	if isPferdeRaceInAction then setLastHorseState() end
end

function setLastHorseState()
	if(selectedHorse==1)then
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[1],true)
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[2],false)
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[3],false)
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[4],false)
	elseif(selectedHorse==2)then
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[1],false)	
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[2],true)	
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[3],false)	
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[4],false)
	elseif(selectedHorse==3)then
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[1],false)
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[2],false)
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[3],true)
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[4],false)
	else
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[1],false)
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[2],false)
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[3],false)
		guiCheckBoxSetSelected ( PferdeGUI_Checkbox[4],true)
	end
end



function cancelPferdeRennen()
	showCursor(false)
	guiSetVisible(PferdeGUI_Window[1],false)
	setElementFrozen(getLocalPlayer(),false)
end

function isAnyPferdeCheckBoxSelected()
	if(guiCheckBoxGetSelected(PferdeGUI_Checkbox[1])or guiCheckBoxGetSelected(PferdeGUI_Checkbox[2])or guiCheckBoxGetSelected(PferdeGUI_Checkbox[3])or guiCheckBoxGetSelected(PferdeGUI_Checkbox[4]))then
		return true		
	else
		return false
	end
end
	local noWinner=true
	local winHorse=0
	local secondHorse=0
function MoveTheHorse()
	noWinner=true
	winHorse=0
	secondHorse=0
	setNextStepHorses()
	

end
function setNextStepHorses()
	if noWinner then
		local horse=math.random(1,4)
		while(winHorse==horse)do
			horse=math.random(1,4)
		end
		local weite=math.random(1,10)
		weiteHorse[horse]=weiteHorse[horse]+weite
		if(winHorse==0)then
			if(weiteHorse[horse]>300)then
				weiteHorse[horse]=301
				winHorse=horse
			end	
		elseif(secondHorse==0)then
			if(weiteHorse[horse]>300)then
				weiteHorse[horse]=301
				secondHorse=horse
				noWinner=false
			end	
		end
		guiSetPosition (  PferdeGUI_Image[1],  51+weiteHorse[1],  30, false )
		guiSetPosition (  PferdeGUI_Image[2],  51+weiteHorse[2],  70, false )
		guiSetPosition (  PferdeGUI_Image[3],  51+weiteHorse[3],  110, false )
		guiSetPosition (  PferdeGUI_Image[4],  51+weiteHorse[4],  150, false )	
		if winHorse>0 then			
			guiSetText(PferdeGUI_Label[winHorse],"1. Platz")
		end
		if secondHorse>0 then			
			for theKey,theWide in ipairs(weiteHorse)do
				if(theKey==winHorse)then
					guiSetText(PferdeGUI_Label[theKey],"1. Platz")
				elseif(theKey==secondHorse)then
					guiSetText(PferdeGUI_Label[theKey],"2. Platz")
				else
					guiSetText(PferdeGUI_Label[theKey],"3. Platz")		
				end				
			end		
		end
		setTimer(setNextStepHorses,100,1)
	else
		if(selectedHorse==winHorse)then
			outputChatBox(string.format("Dein Pferd hat den Ersten Platz erreicht! Du gewinnst: %s", toprice(einsatz)),0,255,0)
			einsatz=einsatz*2
			triggerServerEvent("payOut_Bj",getLocalPlayer(),einsatz,"Pferderennen")
		elseif(selectedHorse==secondHorse)then
			outputChatBox("Dein Pferd hat den Zweiten Platz erreicht! Kanpp vorbei ist dennoch vorbei",255,0,0)
			--einsatz=einsatz*1.5
			--triggerServerEvent("payOut_Bj",getLocalPlayer(),einsatz)
		else
			outputChatBox("Dein Pferd hat leider den 3. oder 4. Platz belegt, daher hast du keinen Gewinn!",255,0,0)
		end
		guiSetVisible(PferdeGUI_Button[6],true)
		einsatz=0
		selectedHorse=0
		weiteHorse={0,0,0,0}
		isPferdeRaceInAction=false
	end
end

function startPferdeRennen()
	if(isAnyPferdeCheckBoxSelected())and(einsatz>0)then
		guiSetVisible(PferdeGUI_Button[1],false)
		guiSetVisible(PferdeGUI_Button[2],false)
		guiSetVisible(PferdeGUI_Button[3],false)
		guiSetVisible(PferdeGUI_Button[4],false)
		guiSetVisible(PferdeGUI_Button[5],false)	
		guiSetVisible(PferdeGUI_Button[6],false)
		isPferdeRaceInAction=true
		if(guiCheckBoxGetSelected(PferdeGUI_Checkbox[1]))then
			selectedHorse=1
		elseif(guiCheckBoxGetSelected(PferdeGUI_Checkbox[2]))then
			selectedHorse=2
		elseif(guiCheckBoxGetSelected(PferdeGUI_Checkbox[3]))then
			selectedHorse=3
		else
			selectedHorse=4
		end	
		--outputChatBox(tostring(selectedHorse))
		if(selectedHorse==1)then
			clickHorseA()
		elseif(selectedHorse==2)then
			clickHorseB()
		elseif(selectedHorse==3)then
			clickHorseC()
		else
			clickHorseD()
		end	
		setTimer(MoveTheHorse,500,1)
	else
		outputChatBox("Wähle ein Pferd und setze einen Einsatz!",255,0,0)
	end
end

function addfiveTausendToPferdeRennen()
	if not isPferdeRaceInAction then
		if(guiGetVisible(PferdeGUI_Button[2] ))then
			if(getPlayerMoney(getLocalPlayer())>49.99)then
				if(einsatz+50>10000)then			
					outputChatBox( "Das würde den maximalen Einsatz von 10,000$ überschreiten!",255,0,0)
				else
					einsatz=einsatz+50.00
					guiSetText(	PferdeGUI_Label[5],"Einsatz: "..einsatz)
					triggerServerEvent("reduceBlackJackHandMoney",getLocalPlayer(),50.00,"Pferderennen")			
				end		
			else
				outputChatBox("Für einen solchen Einsatz hast du nicht genug Geld!",255,0,0)
			end
		end
end
end
function addTausendToPferdeRennen()

	if not isPferdeRaceInAction then
	if(guiGetVisible(PferdeGUI_Button[1] ))then
		if(getPlayerMoney(getLocalPlayer())>9.99)then
			if(einsatz+10.00>10000.00)then			
				outputChatBox("Das würde den maximalen Einsatz von 10,000$ überschreiten!",255,0,0)
			else
				einsatz=einsatz+10.00
				guiSetText(	PferdeGUI_Label[5],"Einsatz: "..einsatz)
				triggerServerEvent("reduceBlackJackHandMoney",getLocalPlayer(),10.00,"Pferderennen")			
			end		
		else
			outputChatBox("Für einen solchen Einsatz hast du nicht genug Geld!",255,0,0)
		end
	end
end
end
function addHundertTausendToPferdeRennen()

	if not isPferdeRaceInAction then
	if(guiGetVisible(PferdeGUI_Button[4] ))then
		if(getPlayerMoney(getLocalPlayer())>999.99)then
			if(einsatz+1000.00>10000.00)then			
				outputChatBox("Das würde den maximalen Einsatz von 10,000$ überschreiten!",255,0,0)
			else
				einsatz=einsatz+1000.00
				guiSetText(	PferdeGUI_Label[5],"Einsatz: "..einsatz)
				triggerServerEvent("reduceBlackJackHandMoney",getLocalPlayer(),1000.00,"Pferderennen")			
			end		
		else
			outputChatBox("Für einen solchen Einsatz hast du nicht genug Geld!",255,0,0)
		end
	end
end
end

function addTenTausendToPferdeRennen()

	if not isPferdeRaceInAction then
	if(guiGetVisible(PferdeGUI_Button[3] ))then
		if(getPlayerMoney(getLocalPlayer())>99.99)then
			if(einsatz+100.00>10000.00)then			
				outputChatBox("Das würde den maximalen Einsatz von 10,000$ überschreiten!",255,0,0)
			else
				einsatz=einsatz+100.00
				guiSetText(	PferdeGUI_Label[5],"Einsatz: "..einsatz)
				triggerServerEvent("reduceBlackJackHandMoney",getLocalPlayer(),100.00,"Pferderennen")			
			end		
		else
			outputChatBox("Für einen solchen Einsatz hast du nicht genug Geld!",255,0,0)
		end
	end
end
end



function resetPferdeRennenGui()
	einsatz=0
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[1],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[2],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[3],false)
	guiCheckBoxSetSelected ( PferdeGUI_Checkbox[4],false)
	guiSetText(PferdeGUI_Label[5],"Einsatz: 0$")
	guiSetText(PferdeGUI_Label[1],"0. Platz")
	guiSetText(PferdeGUI_Label[2],"0. Platz")
	guiSetText(PferdeGUI_Label[3],"0. Platz")
	guiSetText(PferdeGUI_Label[4],"0. Platz")
	guiSetPosition (  PferdeGUI_Image[1],  51,  30, false )
	guiSetPosition (  PferdeGUI_Image[2],  51,  70, false )
	guiSetPosition (  PferdeGUI_Image[3],  51,  110, false )
	guiSetPosition (  PferdeGUI_Image[4],  51,  150, false )	
	guiSetVisible(PferdeGUI_Button[5],true)
	guiSetVisible(PferdeGUI_Button[1],true)
	guiSetVisible(PferdeGUI_Button[2],true)
	guiSetVisible(PferdeGUI_Button[3],true)
	guiSetVisible(PferdeGUI_Button[4],true)
	guiSetVisible(PferdeGUI_Button[6],false)
	
end


function enterPferdeMarker_new(thePlayer)
	if(thePlayer==getLocalPlayer())then
		if(getElementInterior(thePlayer)==getElementInterior(source))then
			guiSetVisible(PferdeGUI_Window[1],true)
			showCursor(true)			
			setElementFrozen(getLocalPlayer(),true)
			resetPferdeRennenGui()	
		end
	end
end









function createBlackJackMarker()
	local marker=createMarker(2226.6689453125,1604.0654296875,1005.4796875,"cylinder",1)
		setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterBJMarker_new)
marker=createMarker( 2230.26171875,1607.9033203125,1005.4796875,"cylinder",1)
	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterBJMarker_new)
marker=createMarker( 2233.818359375,1604.4130859375,1005.4796875,"cylinder",1)
	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterBJMarker_new)
 marker=createMarker( 2230.0478515625,1601.1201171875,1005.4796875,"cylinder",1)
 	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterBJMarker_new)
 marker=createMarker( 2237.7978515625,1604.7861328125,1005.4796875,"cylinder",1)
 	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterBJMarker_new)
 marker=createMarker( 2240.9931640625,1601.0263671875,1005.4796875,"cylinder",1)
 	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterBJMarker_new)
 marker=createMarker( 2244.75390625,1604.36328125,1005.4796875,"cylinder",1)
 	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterBJMarker_new)
 marker=createMarker( 2240.919921875,1607.9453125,1005.4796875,"cylinder",1)
	setElementInterior(marker,1)
	addEventHandler("onClientMarkerHit",marker,enterBJMarker_new)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),createBlackJackMarker)


GUIBlackjack_Window = {}
GUIBlackjack_Button = {}
GUIBlackjack_Label = {}
GUIBlackjack_Image = {}

addEventHandler("onClientResourceStart",resourceRoot,
    function()
		local dx,dy=guiGetScreenSize()
		dx=503/1600*dx
		dy=139/900*dy

        GUIBlackjack_Window[1] = guiCreateWindow(dx,dy,646,645,"BlackJack -Against the Dealer",false)
		
		table.insert(allGuis,GUIBlackjack_Window[1])
        GUIBlackjack_Label[1] = guiCreateLabel(16,34,258,18,"Dealerkarter: (werden erst am Ende gezogen)",false,GUIBlackjack_Window[1])
        GUIBlackjack_Label[2] = guiCreateLabel(301,35,198,18,"Kartengesamtwert:",false,GUIBlackjack_Window[1])
        GUIBlackjack_Label[3] = guiCreateLabel(13,209,232,19,"Spielerkarten:",false,GUIBlackjack_Window[1])
        GUIBlackjack_Label[4] = guiCreateLabel(151,209,169,18,"Kartengesamtwert:",false,GUIBlackjack_Window[1])
        GUIBlackjack_Label[5] = guiCreateLabel(19,551,613,77,"Regeln:\n-3x7 oder Blackjack gewinnen immer! Auszahlung 3:2\nÜber 21 verliert\nUnter Dealer verliert\nNormale Auszahlung: 1:1",false,GUIBlackjack_Window[1])
        GUIBlackjack_Label[6] = guiCreateLabel(14,373,211,23,"Einsatz:",false,GUIBlackjack_Window[1])
        GUIBlackjack_Button[1] = guiCreateButton(16,399,88,25,"+10$",false,GUIBlackjack_Window[1])
        GUIBlackjack_Button[2] = guiCreateButton(15,428,93,24,"+50$",false,GUIBlackjack_Window[1])
        GUIBlackjack_Button[3] = guiCreateButton(16,457,95,24,"+100$",false,GUIBlackjack_Window[1])
        GUIBlackjack_Button[4] = guiCreateButton(172,400,193,33,"Verdoppeln!",false,GUIBlackjack_Window[1])
        GUIBlackjack_Button[5] = guiCreateButton(406,401,197,33,"Karten abgeben! (Dealer start)",false,GUIBlackjack_Window[1])
        GUIBlackjack_Button[6] = guiCreateButton(406,439,210,35,"Beenden!",false,GUIBlackjack_Window[1])
        GUIBlackjack_Button[7] = guiCreateButton(171,439,197,34,"Eine weitere Karte!",false,GUIBlackjack_Window[1])
        GUIBlackjack_Button[8] = guiCreateButton(405,362,197,32,"Runde Starten!",false,GUIBlackjack_Window[1])
		
		addEventHandler("onClientGUIClick",GUIBlackjack_Button[1],addTausenToBlackjack,false)
		addEventHandler("onClientGUIClick",GUIBlackjack_Button[2],addfiveTausenToBlackjack,false)
		addEventHandler("onClientGUIClick",GUIBlackjack_Button[3],addTenTausendToBlackjack,false)
		addEventHandler("onClientGUIClick",GUIBlackjack_Button[4],double_bj,false)
		addEventHandler("onClientGUIClick",GUIBlackjack_Button[5],startDealer_bj,false)
		addEventHandler("onClientGUIClick",GUIBlackjack_Button[6],closeMrBlackjack,false)
		addEventHandler("onClientGUIClick",GUIBlackjack_Button[7],addACard_bj,false)
		addEventHandler("onClientGUIClick",GUIBlackjack_Button[8],startMrBlackjack,false)
		
		
		guiSetVisible(GUIBlackjack_Window[1],false)
    end
)
--DealerCard: 34,73,96,120
--eigene: 34,239,96,120

local allBlackJackCards={
{"kreuz-2.png",2},
{"kreuz-3.png",3},
{"kreuz-4.png",4},
{"kreuz-5.png",5},
{"kreuz-6.png",6},
{"kreuz-7.png",7},
{"kreuz-8.png",8},
{"kreuz-9.png",9},
{"kreuz-10.png",10},
{"kreuz-bube.png",10},
{"kreuz-dame.png",10},
{"kreuz-koenig.png",10},
{"kreuz-ass.png",11},
{"pik-2.png",2},
{"pik-3.png",3},
{"pik-4.png",4},
{"pik-5.png",5},
{"pik-6.png",6},
{"pik-7.png",7},
{"pik-8.png",8},
{"pik-9.png",9},
{"pik-10.png",10},
{"pik-bube.png",10},
{"pik-dame.png",10},
{"pik-koenig.png",10},
{"pik-ass.png",11},
{"herz-2.png",2},
{"herz-3.png",3},
{"herz-4.png",4},
{"herz-5.png",5},
{"herz-6.png",6},
{"herz-7.png",7},
{"herz-8.png",8},
{"herz-9.png",9},
{"herz-10.png",10},
{"herz-bube.png",10},
{"herz-dame.png",10},
{"herz-koenig.png",10},
{"herz-ass.png",11},
{"karo-2.png",2},
{"karo-3.png",3},
{"karo-4.png",4},
{"karo-5.png",5},
{"karo-6.png",6},
{"karo-7.png",7},
{"karo-8.png",8},
{"karo-9.png",9},
{"karo-10.png",10},
{"karo-bube.png",10},
{"karo-dame.png",10},
{"karo-koenig.png",10},
{"karo-ass.png",11}
}

local einsatz=0
local yourCards={}
local dealerCards={}
local usedCards={}
local userSumme=0
local dealerSumme=0

function startDealer_bj()
	if(GUIBlackjack_Button[5] )then
		local cardOne=math.random(1,52)
		local isCardInUsedCards=true
		while (isCardInUsedCards) do
			isCardInUsedCards=false
			for theKey,cardnr in ipairs(usedCards)do
				if(cardnr==cardOne)then
					isCardInUsedCards=true
				end
			end
			if(isCardInUsedCards)then
				cardOne=math.random(1,52)
			end		
		end	
		table.insert(dealerCards,cardOne)		
		table.insert(usedCards,cardOne)
		cardTwo=math.random(1,52)
		isCardInUsedCards=true
		while (isCardInUsedCards) do
			isCardInUsedCards=false
			for theKey,cardnr in ipairs(usedCards)do
				if(cardnr==cardTwo)then
					isCardInUsedCards=true
				end
			end
			if(isCardInUsedCards)then
				cardTwo=math.random(1,52)
			end		
		end	
		table.insert(dealerCards,cardTwo)
		table.insert(usedCards,cardTwo)
		
		local image=guiCreateStaticImage ( 34, 73, 96, 120, "FILES/IMAGES/karten/"..allBlackJackCards[cardOne][1], false, GUIBlackjack_Window[1])
		table.insert(GUIBlackjack_Image,image)
		image=guiCreateStaticImage ( 134, 73, 96, 120, "FILES/IMAGES/karten/"..allBlackJackCards[cardTwo][1], false, GUIBlackjack_Window[1] )
		table.insert(GUIBlackjack_Image,image)
		
		
		
		showBJKartenWert_dealer()
	end
end

function dealerTakeACard()
	local newCard=math.random(1,52)
	local isCardInUsedCards=true
	while (isCardInUsedCards) do
		isCardInUsedCards=false
		for theKey,cardnr in ipairs(usedCards)do
			if(cardnr==newCard)then
				isCardInUsedCards=true
			end
		end
		if(isCardInUsedCards)then
			newCard=math.random(1,52)
		end		
	end
	table.insert(usedCards,newCard)
	table.insert(dealerCards,newCard)
	local image=guiCreateStaticImage ( (34+(table.getn(dealerCards)-1)*100), 73, 96, 120, "FILES/IMAGES/karten/"..allBlackJackCards[newCard][1], false, GUIBlackjack_Window[1])
	table.insert(GUIBlackjack_Image,image)
	showBJKartenWert_dealer()
end



function showBJKartenWert_dealer()
	local asse=0
	dealerSumme=0
	for theKey,theCardNr in ipairs(dealerCards)do
		if(allBlackJackCards[theCardNr][2]==11)then
			asse=asse+1
		else
			dealerSumme=dealerSumme+allBlackJackCards[theCardNr][2]
		end	
	end
	local addedElf=0
	rechnet=0
	while(rechnet<asse)do
		if(dealerSumme+11>21)then
			dealerSumme=dealerSumme+1
			if(dealerSumme>21)and(addedElf>0)then
				dealerSumme=dealerSumme-11
				asse=asse+1
				addedElf=addedElf-1
			end
		else
			dealerSumme=dealerSumme+11
			addedElf=addedElf+1
		end
		rechnet=rechnet+1
	end
	if(dealerSumme==21)then
		if((table.getn(dealerCards)==2) or (allBlackJackCards[dealerCards[1]][2]==allBlackJackCards[dealerCards[2]][2]) and (allBlackJackCards[dealerCards[1]][2]==allBlackJackCards[dealerCards[3]][2]))then
			outputChatBox("Der Dealer gewinnt mit einen BlackJack oder einen Tripple7!",255,0,0)
			outputChatBox("Du hast daher leider verloren!",255,0,0)
			showError(getLocalPlayer(),"LOOSE!!!")
			enterBlackJackerMarker()			
		else
			if(dealerSumme==userSumme)then
				outputChatBox("Es wurde ein Unentschieden erreicht! Du erhälst deinen Einsatz zurück!",0,255,0)				
				triggerServerEvent("payOut_Bj",getLocalPlayer(),einsatz,"Blackjack")				
				showError(getLocalPlayer(),"Unentschieden!!!")
				enterBlackJackerMarker()				
			
			else
				outputChatBox("Der Dealer gewinnt, da er eine höhere Kartensumme hat!",255,0,0)
				outputChatBox("Du hast daher leider verloren!",255,0,0)
				showError(getLocalPlayer(),"LOOSE!!!")
				enterBlackJackerMarker()
			end			
		end		
	elseif(dealerSumme>21)then
		outputChatBox("Du hast gewonnen, da der Dealer über 21 ist!",0,255,0)		
		showError(getLocalPlayer(),"WIN!!!")
		einsatz=einsatz*2
		triggerServerEvent("payOut_Bj",getLocalPlayer(),einsatz,"Blackjack")	
		enterBlackJackerMarker()
	else
		guiSetText(GUIBlackjack_Label[4],string.format("Kartengesamtwert: %s", dealerSumme))
		if(table.getn(yourCards)>2)then
			guiSetVisible(GUIBlackjack_Button[4] ,false)
		end
		if(dealerSumme>16)then
			if(dealerSumme==userSumme)then
				outputChatBox("Es wurde ein Unentschieden erreicht! Du erhälst deinen Einsatz zurück!",0,255,0)				
				triggerServerEvent("payOut_Bj",getLocalPlayer(),einsatz,"Blackjack")				
				showError(getLocalPlayer(),"Unentschieden!!!")
				enterBlackJackerMarker()	
			elseif(dealerSumme>userSumme)then
				outputChatBox("Der Dealer gewinnt, da er eine höhere Kartensumme hat!",255,0,0)
				outputChatBox("Du hast daher leider verloren!",255,0,0)
				showError(getLocalPlayer(),"LOOSE!!!")
				enterBlackJackerMarker()
			else
				outputChatBox("Du hast gewonnen, da der Dealer eine kleinere Summe hat!",0,255,0)		
				showError(getLocalPlayer(),"WIN!!!")
				einsatz=einsatz*2
				triggerServerEvent("payOut_Bj",getLocalPlayer(),einsatz,"Blackjack")	
				enterBlackJackerMarker()			
			end			
		else
			dealerTakeACard()
		end		
	end
end



function addACard_bj()
	if(guiGetVisible(GUIBlackjack_Button[7] ))then
		local newCard=math.random(1,52)
		local isCardInUsedCards=true
		while (isCardInUsedCards) do
			isCardInUsedCards=false
			for theKey,cardnr in ipairs(usedCards)do
				if(cardnr==newCard)then
					isCardInUsedCards=true
					--outputChatBox(tostring(cardnr).."="..tostring(newCard))
				end
			end
			if(isCardInUsedCards)then
				newCard=math.random(1,52)
			end		
		end
		table.insert(usedCards,newCard)
		table.insert(yourCards,newCard)
		local image=guiCreateStaticImage ( (34+(table.getn(yourCards)-1)*100), 239, 96, 120, "FILES/IMAGES/karten/"..allBlackJackCards[newCard][1], false, GUIBlackjack_Window[1])
		table.insert(GUIBlackjack_Image,image)
		showBJKartenWert_you()
	end
end


function double_bj()
	if(guiGetVisible(GUIBlackjack_Button[4] ))then
		local cardTwo=math.random(1,52)
		while (usedCards[1]==cardTwo or usedCards[2]==cardTwo )do		
			cardTwo=math.random(1,52)
		end
		if(getPlayerMoney(getLocalPlayer())>(einsatz-1))then
			triggerServerEvent("reduceBlackJackHandMoney",getLocalPlayer(),einsatz,"Blackjack")
			einsatz=einsatz*2
			guiSetText(	GUIBlackjack_Label[6],"Einsatz:"..einsatz)			
			table.insert(usedCards,cardTwo)
			table.insert(yourCards,cardTwo)
			local image=guiCreateStaticImage ( 234, 239, 96, 120, "FILES/IMAGES/karten/"..allBlackJackCards[cardTwo][1], false, GUIBlackjack_Window[1])
			table.insert(GUIBlackjack_Image,image)
			showBJKartenWert_you(true)			
		else
			outputChatBox("Für einen solchen Einsatz hast du nicht genug Geld!",255,0,0)
		end
	end
end

function showBJKartenWert_you(double)
	local asse=0
	userSumme=0
	for theKey,theCardNr in ipairs(yourCards)do
		if(allBlackJackCards[theCardNr][2]==11)then
			asse=asse+1
		else
			userSumme=userSumme+allBlackJackCards[theCardNr][2]
		end	
	end
	local addedElf=0
	local rechnet=0
	while(rechnet<asse)do
		--outputChatBox("1")
		if(userSumme+11>21)then
			userSumme=userSumme+1
			if(userSumme>21)and(addedElf>0)then
				userSumme=userSumme-11
				asse=asse+1
				addedElf=addedElf-1
			end
		else
			userSumme=userSumme+11
			addedElf=addedElf+1
		end
		rechnet=rechnet+1
	end
	if(userSumme==21)then
		if((table.getn(yourCards)==2) or (allBlackJackCards[yourCards[1]][2]==allBlackJackCards[yourCards[2]][2]) and (allBlackJackCards[yourCards[1]][2]==allBlackJackCards[yourCards[3]][2]))then
			gewinneinsatz=einsatz*1.5
			outputChatBox(string.format("Du gewinnst %s mit einen BlackJack oder einen Tripple7!", gewinneinsatz),0,255,0)
			showError(getLocalPlayer(),"WIN!!!")
			einsatz=gewinneinsatz+einsatz
			triggerServerEvent("payOut_Bj",getLocalPlayer(),einsatz,"Blackjack")	
			enterBlackJackerMarker()			
		else
			startDealer_bj()
		end		
	elseif(userSumme>21)then
		outputChatBox("Du hast leider verloren, da die Summe deiner Karten über 21 ist!",255,0,0)
		showError(getLocalPlayer(),"LOOSE!!!")
		enterBlackJackerMarker()
	else
		guiSetText(GUIBlackjack_Label[4],string.format("Kartengesamtwert: %s", userSumme))
		if(table.getn(yourCards)>2)then
			guiSetVisible(GUIBlackjack_Button[4] ,false)
		end
		if(double)then
			startDealer_bj()
		end
	end


end

function startMrBlackjack()
	if(guiGetVisible(GUIBlackjack_Button[8] ))then
		if(einsatz==0)then
			outputChatBox("Du musst voher einen Einsatz machen!",255,0,0)
		else
			for theKey,theImage in ipairs(GUIBlackjack_Image)do
				destroyElement(GUIBlackjack_Image[theKey])
			end
			GUIBlackjack_Image={}
		
			guiSetVisible(GUIBlackjack_Button[1],false)
			guiSetVisible(GUIBlackjack_Button[2],false)
			guiSetVisible(GUIBlackjack_Button[3],false)
			guiSetVisible(GUIBlackjack_Button[4],true)	
			guiSetVisible(GUIBlackjack_Button[5],true)
			guiSetVisible(GUIBlackjack_Button[7],true)		
			guiSetVisible(GUIBlackjack_Button[8],false)			
			local cardOne=math.random(1,52)
			local cardTwo=math.random(1,52)
			while (cardTwo==cardOne)do		
				cardTwo=math.random(1,52)
			end
			table.insert(yourCards,cardOne)
			table.insert(yourCards,cardTwo)		
			table.insert(usedCards,cardOne)
			table.insert(usedCards,cardTwo)
			
			local image=guiCreateStaticImage ( 34, 239, 96, 120, "FILES/IMAGES/karten/"..allBlackJackCards[cardOne][1], false, GUIBlackjack_Window[1])
			table.insert(GUIBlackjack_Image,image)
			image=guiCreateStaticImage ( 134, 239, 96, 120, "FILES/IMAGES/karten/"..allBlackJackCards[cardTwo][1], false, GUIBlackjack_Window[1] )
			table.insert(GUIBlackjack_Image,image)
			
			showBJKartenWert_you()		
		
		end
	end
end









function addTausenToBlackjack()
	if(guiGetVisible(GUIBlackjack_Button[1] ))then
		if(getPlayerMoney(getLocalPlayer())>9.99)then
			if(einsatz+10>1000)then			
				outputChatBox("Das würde den maximalen Einsatz von 100,000$ überschreiten!",255,0,0)
			else
				einsatz=einsatz+10.00
				guiSetText(	GUIBlackjack_Label[6],"Einsatz:"..einsatz)
				triggerServerEvent("reduceBlackJackHandMoney",getLocalPlayer(),10.00,"Blackjack")			
			end		
		else
			outputChatBox("Für einen solchen Einsatz hast du nicht genug Geld!",255,0,0)
		end
	end
end

function addfiveTausenToBlackjack()
	if(guiGetVisible(GUIBlackjack_Button[2] ))then
		if(getPlayerMoney(getLocalPlayer())>49.99)then
			if(einsatz+50.00>1000.00)then			
				outputChatBox("Das würde den maximalen Einsatz von 100,000$ überschreiten!",255,0,0)
			else
				einsatz=einsatz+50.00
				guiSetText(	GUIBlackjack_Label[6],"Einsatz:"..einsatz)
				triggerServerEvent("reduceBlackJackHandMoney",getLocalPlayer(),50.00,"Blackjack")			
			end		
		else
			outputChatBox("Für einen solchen Einsatz hast du nicht genug Geld!",255,0,0)
		end
	end
end

function addTenTausendToBlackjack()
	if(guiGetVisible(GUIBlackjack_Button[3] ))then
		if(getPlayerMoney(getLocalPlayer())>99.99)then
			if(einsatz+100.00>1000.00)then			
				outputChatBox("Das würde den maximalen Einsatz von 100,000$ überschreiten!",255,0,0)
			else
				einsatz=einsatz+100.00
				guiSetText(	GUIBlackjack_Label[6],"Einsatz:"..einsatz)
				triggerServerEvent("reduceBlackJackHandMoney",getLocalPlayer(),100.00,"Blackjack")			
			end		
		else
			outputChatBox("Für einen solchen Einsatz hast du nicht genug Geld!",255,0,0)
		end
	end
end







function closeMrBlackjack()
	setElementPosition(getLocalPlayer(),2228.6689453125,1604.0654296875,1005.6796875)
	guiSetVisible(GUIBlackjack_Window[1],false)
	setElementFrozen(getLocalPlayer(),false)
end


function enterBJMarker_new(thePlayer)
	if not(guiGetVisible(GUIBlackjack_Window[1])) and thePlayer==getLocalPlayer() and (getElementInterior(thePlayer)==getElementInterior(source)) then
		--[[for theKey,theImage in ipairs(GUIBlackjack_Image)do
			destroyElement(theImage)
		end]]
		setElementFrozen(thePlayer,true)
		guiSetVisible(GUIBlackjack_Window[1],true)
		showCursor(true)
		guiSetText(GUIBlackjack_Label[2],"Kartengesamtwert:")
		guiSetText(GUIBlackjack_Label[4],"Kartengesamtwert:")	
		guiSetText(GUIBlackjack_Label[6],"Einsatz:")	
		guiSetVisible(GUIBlackjack_Button[1],true)
		guiSetVisible(GUIBlackjack_Button[2],true)
		guiSetVisible(GUIBlackjack_Button[3],true)
		guiSetVisible(GUIBlackjack_Button[4],false)	
		guiSetVisible(GUIBlackjack_Button[5],false)
		guiSetVisible(GUIBlackjack_Button[7],false)		
		guiSetVisible(GUIBlackjack_Button[8],true)	
		einsatz=0
		guiSetText(	GUIBlackjack_Label[6],"Einsatz:"..einsatz)
		yourCards={}
		dealerCards={}
		usedCards={}
	end
	
	

end


function enterBlackJackerMarker()
	
		--[[for theKey,theImage in ipairs(GUIBlackjack_Image)do
			destroyElement(theImage)
		end]]
		guiSetVisible(GUIBlackjack_Window[1],true)
		showCursor(true)
		guiSetText(GUIBlackjack_Label[2],"Kartengesamtwert:")
		guiSetText(GUIBlackjack_Label[4],"Kartengesamtwert:")	
		guiSetText(GUIBlackjack_Label[6],"Einsatz:")	
		guiSetVisible(GUIBlackjack_Button[1],true)
		guiSetVisible(GUIBlackjack_Button[2],true)
		guiSetVisible(GUIBlackjack_Button[3],true)
		guiSetVisible(GUIBlackjack_Button[4],false)	
		guiSetVisible(GUIBlackjack_Button[5],false)
		guiSetVisible(GUIBlackjack_Button[7],false)		
		guiSetVisible(GUIBlackjack_Button[8],true)	
		einsatz=0
		guiSetText(	GUIBlackjack_Label[6],"Einsatz:"..einsatz)
		yourCards={}
		dealerCards={}
		usedCards={}
end









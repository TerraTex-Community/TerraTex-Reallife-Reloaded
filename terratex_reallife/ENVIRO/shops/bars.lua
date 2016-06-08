local barbot={}--id 11
local stripperbot={}
local stripperSkinID={63,87,92,138,140,139,152,178,237,238,246,244,245,256}

function barbots()
	--Bar Frauen
	barbot[1]=createPed ( 11,501.8388671875,-19.0673828125,1000.671875,89.916229248047)--alhambra
	setElementInterior(barbot[1],17)
	addEventHandler("onPedWasted",barbot[1],respawnbarbots)
	
	barbot[2]=createPed(11,499.775390625,-77.802734375,998.7578125,354.44357299805)--green bottels
	setElementInterior(barbot[2],11)
	addEventHandler("onPedWasted",barbot[2],respawnbarbots)
	
	barbot[3]=createPed(11,1214.1318359375,-15.2646484375,1000.921875,353.83383178711)--gPigPen
	setElementInterior(barbot[3],2)
	addEventHandler("onPedWasted",barbot[3],respawnbarbots)

	--stripper
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[1]=createPed(randid,1208.376953125,-6.9892578125,1001.328125,6.6825256347656)--gPigPen stripper 1
	setElementInterior(stripperbot[1],2)
	addEventHandler("onPedWasted",stripperbot[1],stripperbots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[2]=createPed(randid,1214.048828125,-4.3095703125,1001.328125,50.238494873047)--gPigPen stripper 2
	setElementInterior(stripperbot[2],2)
	addEventHandler("onPedWasted",stripperbot[2],stripperbots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[3]=createPed(randid,1221.134765625,8.7587890625,1001.3356323242,127.63287353516)--gPigPen stripper 3
	setElementInterior(stripperbot[3],2)
	addEventHandler("onPedWasted",stripperbot[3],stripperbots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[4]=createPed(randid,1223.09765625,-2.9375,1001.328125,23.942321777344)--gPigPen stripper 4
	setElementInterior(stripperbot[4],2)
	addEventHandler("onPedWasted",stripperbot[4],stripperbots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[5]=createPed(randid,1223.09765625,-9.8310546875,1001.328125,164.00366210938)--gPigPen stripper 5
	setElementInterior(stripperbot[5],2)
	addEventHandler("onPedWasted",stripperbot[5],stripperbots)	

	
	setPedDancingQueen()
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),barbots)

function respawnbarbots()
	destroyElement(barbot[1])
	destroyElement(barbot[2])
	destroyElement(barbot[3])
	--Bar Frauen
	barbot[1]=createPed ( 11,501.8388671875,-19.0673828125,1000.671875,89.916229248047)--alhambra
	setElementInterior(barbot[1],17)
	addEventHandler("onPedWasted",barbot[1],respawnbarbots)
	
	barbot[2]=createPed(11,499.775390625,-77.802734375,998.7578125,354.44357299805)--green bottels
	setElementInterior(barbot[2],11)
	addEventHandler("onPedWasted",barbot[2],respawnbarbots)
	
	barbot[3]=createPed(11,1214.1318359375,-15.2646484375,1000.921875,353.83383178711)--gPigPen
	setElementInterior(barbot[3],2)
	addEventHandler("onPedWasted",barbot[3],respawnbarbots)	

end


function stripperbots()
	destroyElement(stripperbot[1])
	destroyElement(stripperbot[2])
	destroyElement(stripperbot[3])
	destroyElement(stripperbot[4])
	destroyElement(stripperbot[5])
	--stripper
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[1]=createPed(randid,1208.376953125,-6.9892578125,1001.328125,6.6825256347656)--gPigPen stripper 1
	setElementInterior(stripperbot[1],2)
	addEventHandler("onPedWasted",stripperbot[1],stripperbots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[2]=createPed(randid,1214.048828125,-4.3095703125,1001.328125,50.238494873047)--gPigPen stripper 2
	setElementInterior(stripperbot[2],2)
	addEventHandler("onPedWasted",stripperbot[2],stripperbots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[3]=createPed(randid,1221.134765625,8.7587890625,1001.3356323242,127.63287353516)--gPigPen stripper 3
	setElementInterior(stripperbot[3],2)
	addEventHandler("onPedWasted",stripperbot[3],stripperbots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[4]=createPed(randid,1223.09765625,-2.9375,1001.328125,23.942321777344)--gPigPen stripper 4
	setElementInterior(stripperbot[4],2)
	addEventHandler("onPedWasted",stripperbot[4],stripperbots)
	
	randid=stripperSkinID[math.random(1,table.getn(stripperSkinID))]
	stripperbot[5]=createPed(randid,1223.09765625,-9.8310546875,1001.328125,164.00366210938)--gPigPen stripper 5
	setElementInterior(stripperbot[5],2)
	addEventHandler("onPedWasted",stripperbot[5],stripperbots)

end





local dances={"STR_Loop_A","STR_Loop_B","STR_Loop_C","strip_A","strip_B","strip_C","strip_D","strip_E","strip_F","strip_G" }
function setPedDancingQueen()

	setPedAnimation ( stripperbot[1], "STRIP", dances[math.random(1,table.getn(dances))], -1, true, true, false, false )
	setPedAnimation ( stripperbot[2], "STRIP", dances[math.random(1,table.getn(dances))], -1, true, true, false, false )
	setPedAnimation ( stripperbot[3], "STRIP", dances[math.random(1,table.getn(dances))], -1, true, true, false, false )
	setPedAnimation ( stripperbot[4], "STRIP", dances[math.random(1,table.getn(dances))], -1, true, true, false, false )
	setPedAnimation ( stripperbot[5], "STRIP", dances[math.random(1,table.getn(dances))], -1, true, true, false, false )
					
	setTimer(setPedDancingQueen,5000,1)
end


function onPlayerClickOnBarTusse(mouseButton, buttonState, clickedElement)
	if(clickedElement==barbot[1] or clickedElement==barbot[2] or clickedElement==barbot[3])then
		outputChatBox("Hey Süßer! Kauf dir doch was zu trinken mit /drink",source,135,237,225)	
	end

end
addEventHandler("onPlayerClick",getRootElement(),onPlayerClickOnBarTusse)


function drink_func(thePlayer,cmd,text)
	local px,py,pz=getElementPosition(thePlayer)
	local bx,by,bz=getElementPosition(barbot[1])
	local disa=getDistanceBetweenPoints3D(bx,by,bz,px,py,pz)
	bx,by,bz=getElementPosition(barbot[2])
	local disb=getDistanceBetweenPoints3D(bx,by,bz,px,py,pz)
	bx,by,bz=getElementPosition(barbot[3])
	local disc=getDistanceBetweenPoints3D(bx,by,bz,px,py,pz)
	if not(text)then
		text="lala"
	end
	if(disa<10 or disb<10 or disc<10)then

		if (string.lower( text)=="bier")then
			if(getPlayerMoney(thePlayer)>0.49)then
				triggerClientEvent(thePlayer,"addFood",thePlayer,20)
                changePlayerMoney(thePlayer,-0.5,"sonstiges","Einkauf in einer Bar")
                changeBizKasse(9, 0.50, "Einkauf")
                triggerClientEvent(thePlayer,"addAlkohol",thePlayer,0.4)
				outputChatBox("Du hast ein Bier getrunken!",thePlayer,135,237,225)
			else
				outputChatBox("Du hast zu wenig Geld süßer!",thePlayer, 135,237,225)
			end	
		elseif(string.lower( text)=="martini")then
			if(getPlayerMoney(thePlayer)>1.49)then
				triggerClientEvent(thePlayer,"addFood",thePlayer,30)
                changePlayerMoney(thePlayer,-1.5,"sonstiges","Einkauf in einer Bar")
                changeBizKasse(9, 1.50, "Einkauf")
				triggerClientEvent(thePlayer,"addAlkohol",thePlayer,0.3)
				outputChatBox("Du hast ein Martini getrunken!",thePlayer,135,237,225)
			else
				outputChatBox("Du hast zu wenig Geld süßer!",thePlayer, 135,237,225)
			end	
		
		elseif(string.lower( text)=="wodka")then
			if(getPlayerMoney(thePlayer)>2.99)then
				triggerClientEvent(thePlayer,"addFood",thePlayer,60)
                changePlayerMoney(thePlayer,-3,"sonstiges","Einkauf in einer Bar")
                changeBizKasse(9, 3, "Einkauf")
				triggerClientEvent(thePlayer,"addAlkohol",thePlayer,0.6)
				outputChatBox("Du hast ein Wodka getrunken!",thePlayer,135,237,225)
			else
				outputChatBox("Du hast zu wenig Geld süßer!",thePlayer, 135,237,225)
			end	
		elseif(string.lower( text)=="mix")then
			if(getPlayerMoney(thePlayer)>4.99)then
				triggerClientEvent(thePlayer,"addFood",thePlayer,100)
                changePlayerMoney(thePlayer,-5,"sonstiges","Einkauf in einer Bar")
                changeBizKasse(9, 5, "Einkauf")
				triggerClientEvent(thePlayer,"addAlkohol",thePlayer,0.5)
				outputChatBox("Du hast ein Mixgetränk getrunken!",thePlayer,135,237,225)
			else
				outputChatBox("Du hast zu wenig Geld süßer!",thePlayer, 135,237,225)
			end	
		else
			outputChatBox("Du kannst folgendes kaufen: Bier(0.50$), Martini(1.50$), Wodka(3.00$), Mix(5.00$)",thePlayer,135,237,225)
			outputChatBox("Getränk kaufen mit: /drink [Getränkename]",thePlayer,135,237,225)
		end
	else
		outputChatBox("Du bist bei keiner Bartusse!",thePlayer,135,237,225)
	end
end
addCommandHandler("drink",drink_func,false,false)


addEvent("setAlkholAnimation_Event",true)
function setPlayerAlkholAnim()
setPedAnimation ( source, "ped", "WALK_drunk", 7000, true, true, false, false )



end
addEventHandler("setAlkholAnimation_Event",getRootElement(),setPlayerAlkholAnim)














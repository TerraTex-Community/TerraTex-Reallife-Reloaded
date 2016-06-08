local intakt_maut=2
local schranken_maut_model_id=968
local schranke_open_time=5000
local maut_price=1

left_side_maut={
--{markerx,markery,markerz,schrankex,schrankey,schrankez,schrankerx,schrankeoffenry,schrankerz,schrankezury(10),aktiv(11),markerelement(12),schrankenelement(13)}
{2795.7,-261,	9.7,	2799,	-256.7,	10.1,	0,0,192.5,95,true,false,false},
{2723,	-266.9,	28,		2728.4,	-259.7,	28,		0,0,161.7,92.75,true,false,false},
{1860,	-131.8,	36,		1864.5,	-128.4,	35.4,	0,0,161.7,90,true,false,false},
{1664.4,-64,	36.1,	1659.4,	-59.4,	35.9,	0,0,19.24,90,true,false,false},
{1196.8,-158.7,	40.4,	1205.3,	-158.2,	39.9,	0,0,307.7,-90,true,false,false},
{764.2,	-161.7,	18.5,	761.4,	-158.2,	18.4,	0,0,223.7,90,true,false,false},
{498.1,	-308,	40.3,	502.4,	-303.1,	41,		0,0,166.5,90,true,false,false},
{304.6,	-381.1,	8.7,	296.5,	-375.3,	8.9,	0,0,85.5,-90,true,false,false},
{353.3,	-571.4,	40.2,	346.7,	-565.7,	40.2,	0,0,86.98,-90,true,false,false},
{73.5,	-1527.5,5.1,	64.6,	-1529,	4.8,	0,0,85.2,90,true,false,false},
{636.2,-1196,17.1,638,-1190.7,17.8,0,0,29.73,-90,true,false,false}
}
right_side_maut={
{2790.9,-256.3,9.7,2786.3,-261,9.2,0,0,200,-90,true,false,false},
{2704.6,-247.6,29.7,2699.3,-251.2,29.3,0,0,161.7,-90,true,false,false},
{1856.5,-121.8,35.3,1851.7,-123.8,35.4,0,0,161.7,-90,true,false,false},
{1650.2,-56.9,36.3,1654.7,-60.8,35.9,0,0,15,-90,true,false,false},
{1201.4,-150.5,39.5,1196.7,-147.5,39.5,0,0,307.7,90,true,false,false},
{744.7802734375,-165.173828125,18.942090988159,750.6,-167.8,18.4,0,0,215,-90,true,false,false},
{494.5,-297.4,40.9,488.9,-299.7,41,0,0,166.5,-90,true,false,false},
{288.7,-382.8,8.4,293.8,-388.6,8.7,0,0,85.5,90,true,false,false},
{342.1,-573.8,40.4,344.3,-579.1,40.2,0,0,73.73,90,true,false,false},
{60.5,-1539.3,5.1,64.1,-1537.4,4.8,0,0,85.2,-90,true,false,false},
{605.2,-1195.8,19,604.8,-1204.4,17.8,0,0,20,90,true,false,false}
}




function onMautCreate()
	for n=1,intakt_maut,1 do
		local inaktiv=math.random(1,table.getn(left_side_maut))
		left_side_maut[inaktiv][11]=false
		right_side_maut[inaktiv][11]=false
	end
	
	
	for theKey,theFirstTable in ipairs(left_side_maut)do
		theFirstTable[13]=createObject(schranken_maut_model_id,theFirstTable[4],theFirstTable[5],theFirstTable[6],theFirstTable[7],theFirstTable[8],theFirstTable[9])
		if(theFirstTable[11])then
			moveObject(theFirstTable[13],2000,theFirstTable[4],theFirstTable[5],theFirstTable[6],0,theFirstTable[10],0)
			theFirstTable[12]=createMarker(theFirstTable[1],theFirstTable[2],theFirstTable[3],"corona")
			vioSetElementData(theFirstTable[12],"mautID",theKey)
			vioSetElementData(theFirstTable[12],"mautSide","left")			
			vioSetElementData(theFirstTable[12],"canUse",true)
			addEventHandler("onMarkerHit",theFirstTable[12],onOpenMautStelle,false)		
		end	
	end
	
	for theKey,theFirstTable in ipairs(right_side_maut)do
		theFirstTable[13]=createObject(schranken_maut_model_id,theFirstTable[4],theFirstTable[5],theFirstTable[6],theFirstTable[7],theFirstTable[8],theFirstTable[9])
		if(theFirstTable[11])then
			moveObject(theFirstTable[13],2000,theFirstTable[4],theFirstTable[5],theFirstTable[6],0,theFirstTable[10],0)
			theFirstTable[12]=createMarker(theFirstTable[1],theFirstTable[2],theFirstTable[3],"corona")
			vioSetElementData(theFirstTable[12],"mautID",theKey)
			vioSetElementData(theFirstTable[12],"mautSide","right")
			vioSetElementData(theFirstTable[12],"canUse",true)
			addEventHandler("onMarkerHit",theFirstTable[12],onOpenMautStelle,false)		
		end	
	end

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),onMautCreate)

--local schranke_open_time=5000
--local maut_price=50
function onOpenMautStelle(thePlayer)
	if(getElementType(thePlayer)=="player")then
		
		if(isPedInVehicle(thePlayer))then
			if(getPedOccupiedVehicleSeat ( thePlayer )==0)then
				local mautID=vioGetElementData(source,"mautID")
				local side=vioGetElementData(source,"mautSide")
				local usage=vioGetElementData(source,"canUse")
				if(usage)then
					if(getPlayerMoney(thePlayer)>(maut_price-0.01))then
                        changePlayerMoney(thePlayer,-maut_price,"sonstiges","Maut")
                        changeBizKasse(14, maut_price/10, "Bezinkauf")
						outputChatBox("vielen Dank, dass Sie unsere Grenzstation verwenden!",thePlayer,255,0,0)
						outputChatBox(string.format("Es wurden ihnen %s$ Mautgebühren abgezogen!", maut_price),thePlayer,255,0,0)
						outputChatBox("Einen schönen Tag noch!",thePlayer,255,0,0)
						
						if(side=="left")then
							moveObject(left_side_maut[mautID][13],2000,left_side_maut[mautID][4],left_side_maut[mautID][5],left_side_maut[mautID][6],0,-(left_side_maut[mautID][10]),0)
							vioSetElementData(source,"canUse",false)
							setTimer(closeMautStelle,schranke_open_time,1,source)
						else
							moveObject(right_side_maut[mautID][13],2000,right_side_maut[mautID][4],right_side_maut[mautID][5],right_side_maut[mautID][6],0,-(right_side_maut[mautID][10]),0)
							vioSetElementData(source,"canUse",false)
							setTimer(closeMautStelle,schranke_open_time,1,source)
						end
						
					else
						outputChatBox(string.format("Sie benötigen %s$ um den Grenzübergang zu passieren!", maut_price),thePlayer,255,0,0)
					end
				else
					outputChatBox("Bitte warten Sie bis die Mautstelle wieder frei ist, bevor sie den Marker passieren!",thePlayer,255,0,0)
				end			
			end
		end
	
	end
end

function closeMautStelle (mautMarker)
	local mautID=vioGetElementData(mautMarker,"mautID")
	local side=vioGetElementData(mautMarker,"mautSide")
	local usage=vioGetElementData(mautMarker,"canUse")

	if(side=="left")then
		moveObject(left_side_maut[mautID][13],2000,left_side_maut[mautID][4],left_side_maut[mautID][5],left_side_maut[mautID][6],0,(left_side_maut[mautID][10]),0)
		vioSetElementData(mautMarker,"canUse",false)
		setTimer(finalclose_maut,2000,1,mautMarker)
	else
		moveObject(right_side_maut[mautID][13],2000,right_side_maut[mautID][4],right_side_maut[mautID][5],right_side_maut[mautID][6],0,(right_side_maut[mautID][10]),0)
		vioSetElementData(mautMarker,"canUse",false)
		setTimer(finalclose_maut,2000,1,mautMarker)
	end


end

function finalclose_maut(marker)
vioSetElementData(marker,"canUse",true)

end























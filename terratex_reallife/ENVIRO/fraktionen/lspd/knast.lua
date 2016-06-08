function knastTimer()
	for theKey,thePlayer in ipairs(getElementsByType("player")) do
		if(isPlayerLoggedIn(thePlayer))then
			if(vioGetElementData(thePlayer,"knastzeit")>0)then
				vioSetElementData(thePlayer,"knastzeit",vioGetElementData(thePlayer,"knastzeit")-1)
				toggleControl ( thePlayer, "fire", false )
				triggerClientEvent(thePlayer,"addFood",thePlayer,2.8)
				if(vioGetElementData(thePlayer,"knastzeit")==0)then
					setElementInterior(thePlayer,0)
					if(vioGetElementData(thePlayer,"alkaknast")==2)then
						setElementPosition(thePlayer,2290.5244140625,2422.5546875,10.8203125)
					elseif(vioGetElementData(thePlayer,"alkaknast")==1)then
						setElementPosition(thePlayer,2866.173828125,42.822265625,19.252059936523)
					else
						setElementPosition(thePlayer,1543.9755859375,-1676.669921875,13.557506561279)
					end
					vioSetElementData(thePlayer,"kaution",0)
					vioSetElementData(thePlayer,"alkaknast",0)	
					vioSetElementData(thePlayer,"knastzeit",0)
					toggleControl ( thePlayer, "enter_exit", true )
					toggleControl ( thePlayer, "fire", true )
					if(vioGetElementData(thePlayer,"fraktion")>0)then
						setPedSkin(thePlayer,vioGetElementData(thePlayer,"FrakSkin"))
					else					
						setPedSkin(thePlayer,vioGetElementData(thePlayer,"skinid"))
					end
				end		
			end	
		end
	end
	setTimer(knastTimer,60000,1)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),knastTimer)


function bail_func(thePlayer)
	if(vioGetElementData(thePlayer,"knastzeit")>0)then
		if(vioGetElementData(thePlayer,"kaution")>0)then
			if(getPlayerMoney(thePlayer)>=vioGetElementData(thePlayer,"kaution"))then
                    changePlayerMoney(thePlayer,-vioGetElementData(thePlayer,"kaution"),"sonstiges","Kaution bezahlt")
					setElementInterior(thePlayer,0)
					if(vioGetElementData(thePlayer,"alkaknast")==2)then
						setElementPosition(thePlayer,2290.5244140625,2422.5546875,10.8203125)
					else
						setElementPosition(thePlayer,1543.9755859375,-1676.669921875,13.557506561279)
					end
					toggleControl ( thePlayer, "fire", true )
					vioSetElementData(thePlayer,"kaution",0)
					vioSetElementData(thePlayer,"knastzeit",0)
					vioSetElementData(thePlayer,"alkaknast",0)
					setPlayerWantedLevel(thePlayer,0)				
					setPedSkin(thePlayer,vioGetElementData(thePlayer,"skinid"))
			else
				outputChatBox("Du hast nicht genügend Geld!",thePlayer,255,0,0)
			end
		else
		
			outputChatBox("Du hast keine Kaution",thePlayer,255,0,0)
		
		end
	end
end
addCommandHandler("bail",bail_func,false,false)


function jailtime_func(thePlayer)
	outputChatBox(string.format("Du musst noch %s Minuten sitzen!", vioGetElementData(thePlayer,"knastzeit")),thePlayer)
end
addCommandHandler("jailtime",jailtime_func,false,false)

local knaststring={[0]="LSPD Knast","Alkatraz","LVPD Knast"}
function checkjailtime_func(thePlayer,theCommand,vonNamePart)
	if(vonNamePart)then
		if(isBeamter(thePlayer))then
			local realPName=getPlayerFromIncompleteName(vonNamePart)
			if(realPName)then
				if(vioGetElementData(realPName,"knastzeit")>0)then
					outputChatBox(string.format("Der Spieler %s muss noch %s von %s Minuten im %s sitzen!", getPlayerName(realPName), vioGetElementData(realPName,"knastzeit"), vioGetElementData(realPName,"lastknastzeit"), knaststring[vioGetElementData(realPName,"alkaknast")]),thePlayer)					
				else
					showError(thePlayer,"Dieser Spieler sitzt nicht im Knast!")
				end
			else
				showError(thePlayer,"Dieser Spieler existiert nicht!")
			end
		end
	else
		showError(thePlayer,"Nutzung: /checkjailtime [Name]")
	end
end
addCommandHandler("checkjailtime",checkjailtime_func,false,false)

function getNearestKnastID(thePlayer)
    local x,y,z=getElementPosition(thePlayer)
    if(getElementsDistanceToPoint(thePlayer,1552.186,-1672.38,16.67)<=getElementsDistanceToPoint(thePlayer,2301.05,2437.11,10.82))then
        return 0
    else
        return 2
    end
end

local knastPos={

    [0]={
        {215.5673828125,110.8466796875,999.015625,183.71893310547},
        {219.66796875,110.984375,999.015625,5.5729064941406},
        {223.3544921875,110.962890625,999.015625,2.1506042480469},
        {227.61328125,110.927734375,999.015625,8.4183959960938}
    },
    [1]={
        {3369.1467285156,62.868698120117,700.97637939453,270},
        {3369.1467285156,71.868698120117,700.97637939453,270},
        {3369.1467285156,80.868698120117,700.97637939453,270},
        {3369.1467285156,89.868698120117,700.97637939453,270},
        {3369.1467285156,98.868698120117,700.97637939453,270},
        {3369.1467285156,107.868698120117,700.97637939453,270},
        {3369.1467285156,116.868698120117,700.97637939453,270},
        {3369.1467285156,125.868698120117,700.97637939453,270},
        {3369.1467285156,134.868698120117,700.97637939453,270},
        {3369.1467285156,62.868698120117,704.67059326172,270},
        {3369.1467285156,71.868698120117,704.67059326172,270},
        {3369.1467285156,80.868698120117,704.67059326172,270},
        {3369.1467285156,89.868698120117,704.67059326172,270},
        {3369.1467285156,98.868698120117,704.67059326172,270},
        {3369.1467285156,107.868698120117,704.67059326172,270},
        {3369.1467285156,116.868698120117,704.67059326172,270},
        {3369.1467285156,125.868698120117,704.67059326172,270},
        {3369.1467285156,134.868698120117,704.67059326172,270},
        {3369.1467285156,62.868698120117,708.07739257813,270},
        {3369.1467285156,71.868698120117,708.07739257813,270},
        {3369.1467285156,80.868698120117,708.07739257813,270},
        {3369.1467285156,89.868698120117,708.07739257813,270},
        {3369.1467285156,98.868698120117,708.07739257813,270},
        {3369.1467285156,107.868698120117,708.07739257813,270},
        {3369.1467285156,116.868698120117,708.07739257813,270},
        {3369.1467285156,125.868698120117,708.07739257813,270},
        {3369.1467285156,134.868698120117,708.07739257813,270},
    },
    [2]={
        {198.0234375,161.9658203125,1003.0299682617 ,183.71893310547},
        {197.8955078125,175.126953125,1003.023437 ,183.71893310547},
        {193.51953125,174.9072265625,1003.0234375 ,183.71893310547}
    },
}
local knastPosInt={10,2,3}
function getKnastKoordinaten(thePlayer, KnastID)
    if(not KnastID)then KnastID = vioGetElementData(thePlayer,"alkaknast")end

    local rand=math.random(1, table.getSize(knastPos[KnastID]))
    return knastPos[KnastID][rand][1],knastPos[KnastID][rand][2],knastPos[KnastID][rand][3]
end

function getKnastInterior(thePlayer, KnastID)
    if(not KnastID)then KnastID = vioGetElementData(thePlayer,"alkaknast")end

    return knastPosInt[(KnastID+1)]
end











--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 00:45
-- To change this template use File | Settings | File Templates.
--

local money=0
local moneyChanged=false
local moneyTimer=false
local moneyLines={false,false,false,false,false}
local moneyLinesTimer={false,false,false,false,false}

function aktualizeMoneyLines()
    moneyLines[1]=moneyLines[2]
    moneyLines[2]=moneyLines[3]
    moneyLines[3]=moneyLines[4]
    moneyLines[4]=moneyLines[5]
    moneyLines[5]=false

    if(isTimer(moneyLinesTimer[1])) then
        killTimer(moneyLinesTimer[1])
    end
    moneyLinesTimer[1]=moneyLinesTimer[2]
    moneyLinesTimer[2]=moneyLinesTimer[3]
    moneyLinesTimer[3]=moneyLinesTimer[4]
    moneyLinesTimer[4]=moneyLinesTimer[5]
    moneyLinesTimer[5]=false

end

function setNewMoneyLine(dif)
    --dif=toprice(dif)
    local wasSet=false
    for i=1,5,1 do
        if(moneyLines[i]==false)and not(wasSet)then
            moneyLines[i]=dif
            moneyLinesTimer[i]=setTimer(aktualizeMoneyLines,5000,1)
            wasSet=true
        end
    end
    if not wasSet then
        aktualizeMoneyLines()
        moneyLines[5]=dif
        moneyLinesTimer[5]=setTimer(aktualizeMoneyLines,5000,1)
    end
end

addEvent("setPlayerNewMoney",true)
function setPlayerNewMoney_func(betrag)
    local dif=betrag-money
    setNewMoneyLine(dif)
    --setTimer(aktualizeMoneyLines,5000,1)
    money=betrag
    moneyChanged=true
    if(isTimer(moneyTimer))then
        killTimer(moneyTimer)
    end
    moneyTimer=setTimer(resetMoneyChangedColor,5000,1)
end
addEventHandler("setPlayerNewMoney",getRootElement(),setPlayerNewMoney_func)

function resetMoneyChangedColor()
    --aktualizeMoneyLines()
    moneyChanged=false
end

-- Direct X Drawing
addEventHandler("onClientRender",getRootElement(),
    function()
        if not(isPlayerMapVisible ()) and not(isAllHudHiding)then
            local sx,sy=guiGetScreenSize ()
            if(money>=0)then
                if(money>999999999.99)then
                    money=999999999.99
                end
                --outputChatBox("1")
                local output=string.format("%.2f", money)
                while (string.len(output)<12) do
                    output="0"..output
                end
                output=string.sub(output,0,6)..","..string.sub(output,7)
                output=string.sub(output,0,3)..","..string.sub(output,4)
                showPlayerHudComponent ( "money", false )
                local sx,sy=guiGetScreenSize ()
                dxDrawRectangle(1234.0/1600*sx,156.0/900*sy,310/1600*sx,39.0/900*sy,tocolor(0,0,0,200),false)
                if(moneyChanged)then
                    dxDrawText(output.." $",1236.0/1600*sx,154.0/900*sy,1533.0/1600*sx,203.0/900*sy,tocolor(230,230,0,255),3/1600*sx,"sans","left","top",false,false,false)
                else
                    dxDrawText(output.." $",1236.0/1600*sx,154.0/900*sy,1533.0/1600*sx,203.0/900*sy,tocolor(0,180,0,255),3/1600*sx,"sans","left","top",false,false,false)
                end
            else
                if(money<-99999999.99)then
                    money=-99999999.99
                end
                local output=string.format("%.2f", -money)
                while (string.len(output)<11) do
                    output="0"..output
                end
                output="-"..output
                output=string.sub(output,0,6)..","..string.sub(output,7)
                output=string.sub(output,0,3)..","..string.sub(output,4)
                showPlayerHudComponent ( "money", false )

                dxDrawRectangle(1234.0/1600*sx,156.0/900*sy,310/1600*sx,39.0/900*sy,tocolor(0,0,0,200),false)
                if(moneyChanged)then
                    dxDrawText(output.." $",1236.0/1600*sx,154.0/900*sy,1533.0/1600*sx,203.0/900*sy,tocolor(230,230,0,255),3/1600*sx,"sans","left","top",false,false,false)
                else
                    dxDrawText(output.." $",1236.0/1600*sx,154.0/900*sy,1533.0/1600*sx,203.0/900*sy,tocolor(180,0,0,255),3/1600*sx,"sans","left","top",false,false,false)
                end
            end
            for i=1,5,1 do
                local ny=203+i*5+(i-1)*24.5
                if(moneyLines[i])then
                    if(moneyLines[i]<0)then
                        --rot mit Minus
                        local output=toprice(moneyLines[i])
                        dxDrawText(output,1236.0/1600*sx,ny/900*sy,1533.0/1600*sx,(ny+24.5)/900*sy,tocolor(180,0,0,255),1.5/1600*sx,"sans","right","top",false,false,false)
                    else
                        --grün mit Plus
                        local output="+"..toprice(moneyLines[i])
                        dxDrawText(output,1236.0/1600*sx,ny/900*sy,1533.0/1600*sx,(ny+24.5)/900*sy,tocolor(0,180,0,255),1.5/1600*sx,"sans","right","top",false,false,false)
                    end
                end
            end
        end
    end
)















local hwunsche={}

function inWunschSystemStart()
    local result = MySql.helper.getSync("objects_houses_wishes", "*");

    for theKey, dasatz in ipairs(result) do
        local wunsch={
            ["ID"]=tonumber(dasatz["ID"]),
            ["x"]=tonumber(dasatz["x"]),
            ["y"]=tonumber(dasatz["y"]),
            ["z"]=tonumber(dasatz["z"]),
            ["nickname"]=dasatz["Nickname"],
            ["timestamp"]=tonumber(dasatz["unixtimestamp"])
        }
        table.insert(hwunsche,wunsch)

        outputDebugString("# "..zahler.." Houses loaded!")
    end

end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),inWunschSystemStart)

function setNewWunsch(thePlayer)
    local isNearOtherWunsch=false
    local hasWunschSinceTime=false
    local time=getRealTime()
    local x,y,z=getElementPosition(thePlayer)
    for theKey,theWunsch in ipairs(hwunsche)do
       if(getDistanceBetweenPoints3D(x,y,z,theWunsch["x"],theWunsch["y"],theWunsch["z"])<10)then
           showError(thePlayer,"An diesem haus wurde bereits ein Wunsch nach dem Haus geäußert.")
           isNearOtherWunsch=true
       else
            if(getPlayerName(thePlayer)==theWunsch["nickname"] and (time.timestamp)<(theWunsch["timestamp"]+30*24*60*60))then
               showError(thePlayer,"Du hast im letzten Monat bereits ein Hauswunsch geäußert.")
               hasWunschSinceTime=true
            end
       end
    end
    if(not hasWunschSinceTime and not isNearOtherWunsch )then
        local id = MySql.helper.insertSync("objects_houses_wishes", {
            Nickname = getPlayerName(thePlayer),
            x = x,
            y = y,
            z = z,
            unixtimestamp = time.timestamp
        });

        showError(thePlayer,"Dein Wunsch wurde registriert. Er wird beim nächsten Einfügen von Häusern berücksichtigt (sofern möglich).")

        table.insert(hwunsche,{
            ["ID"]=id,
            ["x"]=x,
            ["y"]=y,
            ["z"]=z,
            ["nickname"]=getPlayerName(thePlayer),
            ["timestamp"]=time.timestamp
        })
    end
end
addCommandHandler("hwunsch",setNewWunsch,false,false)

function gotowunsch_func(thePlayer,cmd,id)
    id=tonumber(id)
    if(isAdminLevel(thePlayer,4))then
        vioSetElementData(thePlayer,"lastHWunsch",id)
        setElementPosition(thePlayer,hwunsche[id]["x"],hwunsche[id]["y"],hwunsche[id]["z"])
        outputChatBox("Von "..hwunsche[id]["nickname"],thePlayer)
        outputChatBox("ID "..hwunsche[id]["ID"],thePlayer)
    end
end
addCommandHandler("gotoWunsch",gotowunsch_func,false,false)

function deletewunsch_func(thePlayer,cmd,id)
    id=tonumber(id)
    MySql.helper.delete("objects_houses_wishes", {ID = hwunsche[id]["ID"]});
    hwunsche=table.removeKey(hwunsche,id,true)
end
addCommandHandler("deletewunsch",deletewunsch_func,false,false)

function deletelastwunsch(thePlayer)
    local id= vioGetElementData(thePlayer,"lastHWunsch");
    MySql.helper.delete("objects_houses_wishes", {ID = hwunsche[id]["ID"]});
    hwunsche=table.removeKey(hwunsche,id,true)
end
addCommandHandler("deletelastwunsch",deletelastwunsch,false,false)

function gotonextwunsch_func(thePlayer)
    local id=vioGetElementData(thePlayer,"lastHWunsch") + 1
    if(isAdminLevel(thePlayer,4))then
        setElementPosition(thePlayer,hwunsche[id]["x"],hwunsche[id]["y"],hwunsche[id]["z"])
        outputChatBox("Von "..hwunsche[id]["nickname"],thePlayer)
        outputChatBox("ID "..hwunsche[id]["ID"],thePlayer)
        vioSetElementData(thePlayer,"lastHWunsch",id)
    end
end
addCommandHandler("gotonextWunsch",gotonextwunsch_func,false,false)
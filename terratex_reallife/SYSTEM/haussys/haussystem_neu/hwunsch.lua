

local hwunsche={}

function inWunschSystemStart()
    local query="Select * From haussys_wunsch"
    local result=mysql_query(handler,query)
    local zahler=0
    if(not result) then
        outputDebugString("Error executing the query: (" .. mysql_errno(handler) .. ") " .. mysql_error(handler))
    else
        zahler=0
        while (mysql_num_rows(result)>zahler) do
            local dasatz = mysql_fetch_assoc(result)
            local wunsch={
                ["ID"]=tonumber(dasatz["ID"]),
                ["x"]=tonumber(dasatz["x"]),
                ["y"]=tonumber(dasatz["y"]),
                ["z"]=tonumber(dasatz["z"]),
                ["nickname"]=dasatz["Nickname"],
                ["timestamp"]=tonumber(dasatz["unixtimestamp"])
            }
            table.insert(hwunsche,wunsch)
            zahler=zahler+1
        end

        outputDebugString("# "..zahler.." Houses loaded!")
        mysql_free_result(result)
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
       local query="INSERT INTO haussys_wunsch (Nickname,x,y,z,unixtimestamp) VALUES ('%s','%s','%s','%s','%s')"
        query=string.format(query,getPlayerName(thePlayer),x,y,z,time.timestamp)
        mysql_query(handler,query)
        showError(thePlayer,"Dein Wunsch wurde registriert. Er wird beim nächsten Einfügen von Häusern berücksichtigt (sofern möglich).")

        local id=mysql_insert_id(handler)

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
    local query="DELETE FROM haussys_wunsch WHERE ID='"..hwunsche[id]["ID"].."'"
    mysql_query(handler,query)
    hwunsche=table.removeKey(hwunsche,id,true)
end
addCommandHandler("deletewunsch",deletewunsch_func,false,false)

function deletelastwunsch(thePlayer)
    local id= vioGetElementData(thePlayer,"lastHWunsch")
    local query="DELETE FROM haussys_wunsch WHERE ID='"..hwunsche[id]["ID"].."'"
    mysql_query(handler,query)
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






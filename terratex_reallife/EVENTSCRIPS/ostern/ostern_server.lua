--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 16.04.14
-- Time: 11:48
-- To change this template use File | Settings | File Templates.
--

--[[Ostereier auslesen]]
local eiID=1241
local maxEier=45 --pro Spawn
local eier={}
local respawntime=60 --in Minuten
local lastTimer = false
local minEier = 15

function ostern_init()
    local timer=getRealTime()
    --vom 18.04.2014 - 21.04.2014
    if((timer.monthday>=5 and timer.monthday<=7) and (timer.month+1)==4 and (timer.year+1900)==2015)then
        local query="SELECT * FROM ostereier WHERE State='0' AND event='ostern' ORDER BY RAND() LIMIT 0,"..maxEier
        local result=mysql_query(handler,query)
        local zahl=0
        while(mysql_num_rows(result) > zahl) do
            local dsatz = mysql_fetch_assoc(result)
            local ei=createPickup(dsatz["X"],dsatz["Y"],dsatz["Z"], 3, eiID )
            setElementDimension(ei, tonumber(dsatz["Dim"]))
            setElementInterior(ei, tonumber(dsatz["Inte"]))
            vioSetElementData(ei,"isEi",true)
            vioSetElementData(ei,"eiID",tonumber(dsatz["ID"]))
            addEventHandler("onPickupHit",ei,eiHit)
            table.insert(eier,ei)
            zahl=zahl+1
        end
        mysql_free_result(result)

        lastTimer = setTimer(respawnEier,respawntime*60*1000,1)
    end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),ostern_init)

function respawnEier()
   for theKey, theEi in ipairs(eier)do
       if(isElement(theEi))then
            destroyElement(theEi)
       end
   end
   eier={}
   local query="SELECT * FROM ostereier WHERE State='0' AND event='ostern' ORDER BY RAND() LIMIT 0,"..maxEier
   local result=mysql_query(handler,query)
   local zahl=0
   while(mysql_num_rows(result) > zahl) do
       local dsatz = mysql_fetch_assoc(result)
       local ei=createPickup(dsatz["X"],dsatz["Y"],dsatz["Z"], 3, eiID )
       setElementDimension(ei, tonumber(dsatz["Dim"]))
       setElementInterior(ei, tonumber(dsatz["Inte"]))
       vioSetElementData(ei,"isEi",true)
       vioSetElementData(ei,"eiID",tonumber(dsatz["ID"]))
       addEventHandler("onPickupHit",ei,eiHit)
       table.insert(eier,ei)
       zahl=zahl+1
   end
   mysql_free_result(result)

   lastTimer = setTimer(respawnEier,respawntime*60*1000,1)
end

function eiHit(thePlayer)
    if(vioGetElementData(source,"isEi"))then
        local id=vioGetElementData(source,"eiID")
        destroyElement(source)
        local pName=getPlayerName(thePlayer)

        MySql.helper.update("ostereier", { State = 1 }, { ID = id});
        MySql.helper.update("ostereier", { gefundenVon = pName }, { ID = id});

        local anzGefunden = MySql.helper.getValueSync("ostereier", "count(*)", {gefundenVon = pName, event = "ostern"});

        outputChatBox("Osterhase: Glückwunsch, du hast jetzt schon "..anzGefunden.." Ostereier gefunden",thePlayer,math.random(1,255),math.random(1,255),math.random(1,255))

        local thereAreEier = 0
        for theKey, theEi in ipairs(eier)do
            if(isElement(theEi))then
                thereAreEier = thereAreEier + 1
            end
        end
        if (thereAreEier < minEier) then
            killTimer(lastTimer)
            respawnEier()
        end
    end
end

function addEi_func(thePlayer,cmd,comment,...)
    if(isAdminLevel(thePlayer,4))then
        local commentar=''
        if(comment)then
            commentar=comment.." "..table.concat({...}," ")
        end


        local int=getElementInterior(thePlayer)
        local dim=getElementDimension(thePlayer)
        local x,y,z=getElementPosition(thePlayer)

        local insertQuery="INSERT INTO ostereier (x,y,z,inte,dim,comment) VALUES ('%s','%s','%s','%s','%s','%s')"
        insertQuery=string.format(insertQuery,x,y,z,int,dim,commentar)

        mysql_query(handler,insertQuery)

        local ei=createPickup(x,y,z, 3, eiID, 200 )
        setElementDimension(ei, dim)
        setElementInterior(ei,int)

    end
end
addCommandHandler("addei",addEi_func,false,false)












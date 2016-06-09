--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 16.04.14
-- Time: 11:48
-- To change this template use File | Settings | File Templates.
--

--[[Ostereier auslesen]]
local eiID=1241
local maxEier=30 --pro Spawn
local eier={}
local respawntime=180 --in Minuten

function halloween_init()
    local timer=getRealTime()
    --vom 18.04.2014 - 21.04.2014
    if((((timer.monthday>=1 and timer.monthday<=3) and (timer.month+1)==11) or ((timer.monthday>=28 and timer.monthday<=32) and (timer.month+1)==10)) and (timer.year+1900)==2014)then
        local query="SELECT * FROM ostereier WHERE State='0' AND event='halloween' ORDER BY RAND() LIMIT 0,"..maxEier
        local result=mysql_query(handler,query)
        local zahl=0
        while(mysql_num_rows(result) > zahl) do
            local dsatz = mysql_fetch_assoc(result)
            local ei=createPickup(dsatz["X"],dsatz["Y"],dsatz["Z"], 3, eiID )
            setElementDimension(ei, tonumber(dsatz["Dim"]))
            setElementInterior(ei, tonumber(dsatz["Inte"]))
            vioSetElementData(ei,"isEi",true)
            vioSetElementData(ei,"eiID",tonumber(dsatz["ID"]))
            addEventHandler("onPickupHit",ei,kurbissHit)
            table.insert(eier,ei)
            zahl=zahl+1
        end
        mysql_free_result(result)

        setTimer(respawnKurbisse,respawntime*60*1000,1)
    end
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),halloween_init)

function respawnKurbisse()
   for theKey, theEi in ipairs(eier)do
       if(isElement(theEi))then
            destroyElement(theEi)
       end
   end
   eier={}
   local query="SELECT * FROM ostereier WHERE State='0' AND  event='halloween' ORDER BY RAND() LIMIT 0,"..maxEier
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

   setTimer(respawnKurbisse,respawntime*60*1000,1)
end

function kurbissHit(thePlayer)
    if(vioGetElementData(source,"isEi"))then
        local id=vioGetElementData(source,"eiID")
        destroyElement(source)
        local pName=getPlayerName(thePlayer)

        MySQL_SetVar("ostereier","State",1,"ID='"..id.."'")
        MySQL_SetVar("ostereier","gefundenVon",pName,"ID='"..id.."'")

        local anzGefunden = MySql.helper.getFieldValueSync("ostereier", "count(*)", {gefundenVon = pName, event = "halloween"});

        outputChatBox("General BliZarD: Glückwunsch, du hast jetzt schon "..anzGefunden.." der gefährlichen Kürbisse gefunden",thePlayer,math.random(1,255),math.random(1,255),math.random(1,255))

    end
end

function addKurbiss_func(thePlayer,cmd,comment,...)
    if(isAdminLevel(thePlayer,4))then
        local commentar=''
        if(comment)then
            commentar=comment.." "..table.concat({...}," ")
        end


        local int=getElementInterior(thePlayer)
        local dim=getElementDimension(thePlayer)
        local x,y,z=getElementPosition(thePlayer)

        local insertQuery="INSERT INTO ostereier (x,y,z,inte,dim,comment,event) VALUES ('%s','%s','%s','%s','%s','%s','halloween')"
        insertQuery=string.format(insertQuery,x,y,z,int,dim,commentar)

        mysql_query(handler,insertQuery)

        local ei=createPickup(x,y,z, 3, eiID, 200 )
        setElementDimension(ei, dim)
        setElementInterior(ei,int)

    end
end
addCommandHandler("addkuerbis",addKurbiss_func,false,false)












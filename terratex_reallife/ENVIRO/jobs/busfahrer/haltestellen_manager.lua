--
-- Created by IntelliJ IDEA.
-- User: geramy
-- Date: 09.02.14
-- Time: 14:49
-- To change this template use File | Settings | File Templates.
-- @Description: Diese Datei ist zur Generierung von Haltestellen und Routen von Grund auf NEU



--@Scriptbeginn
local aktuelleRoute=false

function addRoute(thePlayer,cmd,RName)
    routenListe[RName]={}
    aktuelleRoute=RName
    showError(thePlayer,"Route hinzugefügt und gesetzt")
end
addCommandHandler("addRoute",addRoute,false,false)

function setRoute(thePlayer,cmd,RName)
    if(routenListe[RName])then
        aktuelleRoute=RName
        showError(thePlayer,"Route gesetzt")
    else
        showError(thePlayer,"Route existiert nicht")
    end
end
addCommandHandler("setRoute",setRoute,false,false)

local validRichtungen={["N"]=true,["NW"]=true,["W"]=true,["SW"]=true,["S"]=true,["SO"]=true,["O"]=true,["NO"]=true}
function addHaltestelle(thePlayer,cmd,Richtung)
    if( not validRichtungen[Richtung])then
        showError(thePlayer,"Fehlerhafte Richtung")
        return 0
    end
    local x,y,z=getElementPosition(thePlayer)
    if(isPedInVehicle(thePlayer))then
        x,y,z=getElementPosition(getPedOccupiedVehicle(thePlayer))
    end
    z=z-0.5
    local HID=false
    local HIDR=false
    if(aktuelleRoute)then
        for theKey,theHaltestelle in ipairs(haltestellenTabelle)do
            if(getDistanceBetweenPoints3D(theHaltestelle[1],theHaltestelle[2],theHaltestelle[3],x,y,z)< 20)then
                if(Richtung==theHaltestelle[4])then
                    HID=theKey
                else
                    HIDR=theKey
                end
            end
        end
        if(HID)then
            table.insert(routenListe[aktuelleRoute],HID)
            outputChatBox("Haltestelle wurde hinzugefügt!",thePlayer,255,0,0)
        else
            if(HIDR)then
                table.insert(haltestellenTabelle,{x,y,z,Richtung,haltestellenTabelle[HIDR][5]})
                local newID=table.maxn(haltestellenTabelle)
                table.insert(routenListe[aktuelleRoute],newID)
                outputChatBox("Haltestelle wurde hinzugefügt!",thePlayer,255,0,0)
            else
                table.insert(haltestellenTabelle,{x,y,z,Richtung,"dummy"})
                local newID=table.maxn(haltestellenTabelle)
                table.insert(routenListe[aktuelleRoute],newID)
                outputChatBox(string.format("Eine neue Haltestelle wurde angelegt... Name kann mit '/Hsetname %s' gesetzt werden!", newID),thePlayer,255,0,0)
            end
        end
    else
        showError(thePlayer,"Es ist keine Route gewählt!")
    end
end
addCommandHandler("Hadd",addHaltestelle,false,false)

function HsetName(thePlayer,cmd,HID,name,...)
    if(name)then
        local name=name.." "..table.concat({...}," ")
        haltestellenTabelle[tonumber(HID)][5]=name
    else
        showError(thePlayer,"bitte geben sie einen namen an!")
    end
end
addCommandHandler("HsetName",HsetName,false,false)

function printHaltestellenInFile(thePlayer)
    local genContent=""
    local timer=getRealTime()
    genContent=genContent.."--[[\n"
    genContent=genContent.."//\n"
    genContent=genContent.."// HaltestellenListe generiert am\n"
    genContent=genContent.."// "..timer.monthday.."."..(timer.month+1).."."..(timer.year+1900).." "..timer.hour..":"..timer.minute..":"..timer.second.."\n"
    genContent=genContent.."//\n"
    genContent=genContent.."]]\n\n\n"
    genContent=genContent.."local haltestellenTable={}\n"
    for theKey, theHaltestelle  in ipairs(haltestellenTabelle)do
        genContent=genContent.."haltestellenTable["..theKey.."]={"..theHaltestelle[1]..","..theHaltestelle[2]..","..theHaltestelle[3]..",\""..theHaltestelle[4].."\",\""..theHaltestelle[5].."\"}\n"
    end
    genContent=genContent.."\n\n"
    genContent=genContent.."local routenListe={}\n"
    for theKey,theRoute in pairs(routenListe)do
        genContent=genContent.."routenListe[\""..theKey.."\"]={"..table.concat(theRoute,",").."}\n"
    end
    if(fileExists(":"..getResourceName(getThisResource()).."/LOGS/Haltestellen.lua"))then
        fileDelete (":"..getResourceName(getThisResource()).."/LOGS/Haltestellen.lua")
    end
    local newFile = fileCreate(":"..getResourceName(getThisResource()).."/LOGS/Haltestellen.lua")
    if (newFile) then
        fileWrite(newFile, genContent)
        fileClose(newFile)
    end
end
addCommandHandler("Hprint",printHaltestellenInFile,false,false)










--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 24.04.2014
-- Time: 16:57
-- To change this template use File | Settings | File Templates.
--
--ram
function ram_cmdfunc(thePlayer)
   if(isBeamter(thePlayer))then
       local hausid, dis=getNearestHouseByPlayer(thePlayer)
       local haus=haeuser[hausid]
       if(dis<10)then
           showError(thePlayer,"Du hast begonnen das Schloss der Haustüre gewaltsam zu öffnen... Dies kann einige Zeit dauern.")
           setTimer(ram_open,5000,1,hausid,thePlayer)
       end
   end
end
addCommandHandler("ram",ram_cmdfunc,false,false)

function ram_open(hausid,thePlayer)
    outputDebugString(hausid)
    local haus=haeuser[hausid]
    haus:setLock(false)
    showError(thePlayer,"Du hast das Schloss geknackt. Die Haustüre ist jetzt offen.")
end

--in
function in_cmdfunc(thePlayer)
    local hausid, dis=getNearestHouseByPlayer(thePlayer)
    local haus=haeuser[hausid]
    if(dis<10)then
        if(not haus:isLocked())then
            if(haus:getIRaum()~=0)then
                haus:setPlayerIn(thePlayer)
            else
                showError(thePlayer,"Dieses Haus hat keinen Innenraum.")
            end
        else
            showError(thePlayer,"Dieses Haus ist abgeschlossen.")
        end
    end
end
addCommandHandler("in",in_cmdfunc,false,false)

--out
function out_cmdfunc(thePlayer)
    local dimension=getElementDimension(thePlayer)
    if(haeuser[dimension])then
       local haus=haeuser[dimension]
       if(haus:isPlayerInHouse(thePlayer))then
            if(haus:isPlayerInHouse(thePlayer,10))then
                if(not haus:isLocked())then
                    haus:setPlayerOut(thePlayer)
                else
                    showError(thePlayer,"Dieses Haus ist abgeschlossen.")
                end
            else
                showError(thePlayer,"Du bist nicht an der Haustüre.")
            end
        else
            showError(thePlayer,"Du bist in keinem Haus.")
       end
    end
end
addCommandHandler("out",out_cmdfunc,false,false)

--givehouse
function givehouse_cmdfunc(thePlayer,cmd,toPlayerNamePart)
    if(vioGetElementData(thePlayer,"hkey")>0)then
        local hID=vioGetElementData(thePlayer,"hkey")
        local haus=haeuser[hID]
        if(haus:getCity()~=3)then
            if(haus:isPlayerInHouse(thePlayer) or haus:getPlayerDistance(thePlayer))then
                if(toPlayerNamePart)then
                    local toPlayer=getPlayerFromIncompleteName(toPlayerNamePart)
                    if(toPlayer)then
                        if(vioGetElementData(toPlayer,"hkey")==0)then
                            haus:setBesitzer(toPlayer)
                            vioSetElementData(toPlayer,"hkey",hID)
                            vioSetElementData(thePlayer,"hkey",0)
                            showError(thePlayer,string.format("Du hast dein Haus an %s übergeben.",getPlayerName(toPlayer)))
                            showError(thePlayer,string.format("%s hat sein Haus an dich übergeben.",getPlayerName(thePlayer)))
                        else
                            showError(thePlayer,"Der Spieler hat noch einen gültigen Mietvertrag oder besitzt ein Haus.")
                        end
                    else
                        showError(thePlayer,"Dieser Spieler existiert nicht.")
                    end
                else
                    showError(thePlayer,"Befehlssytanx: /givehouse [Spielername]")
                end
            else
                showError(thePlayer,"Du bist nicht in der Nähe von einem Haus")
            end
        else
            showError(thePlayer,"Dieses Haus ist nicht für den freien Handel freigegeben.")
        end
    end
end
addCommandHandler("givehouse",givehouse_cmdfunc,false,false)

--sellhouse
function sellhouse_cmdfunc(thePlayer)
    if(vioGetElementData(thePlayer,"hkey")>0)then
        local hID=vioGetElementData(thePlayer,"hkey")
        local haus=haeuser[hID]
        if(haus:isPlayerInHouse(thePlayer) or haus:getPlayerDistance(thePlayer))then
            local backValue=haus:getPreis()*0.75
            haus:setIRaum(0)
            changePlayerBank(thePlayer,backValue,"sonstiges","Hauskauf")
            haus:setBesitzer(false)
            vioSetElementData(thePlayer,"hkey",0)
            showError(thePlayer,string.format("Du hast dein Haus ans System verkauft. Du erhälst %s zurück.",toprice(backValue)))
        else
            showError(thePlayer,"Du bist nicht in der Nähe von einem Haus")
        end
    end
end
addCommandHandler("sellhouse",sellhouse_cmdfunc,false,false)



--hlock
function hlock_cmdfunc(thePlayer)
    if(vioGetElementData(thePlayer,"hkey")~=0)then
        local hID=math.abs(vioGetElementData(thePlayer,"hkey"))
        local haus=haeuser[hID]
        if(haus:isPlayerInHouse(thePlayer) or haus:getPlayerDistance(thePlayer))then
            if(haus:isLocked())then
                haus:setLock(false)
                showError(thePlayer,"Das Haus wurde aufgeschlossen.")
            else
                haus:setLock(true)
                showError(thePlayer,"Das Haus wurde abgeschlossen.")
            end
        else
            showError(thePlayer,"Du bist nicht in der Nähe von deinem Haus / deiner Wohnung.")
        end
    end
end
addCommandHandler("hlock",hlock_cmdfunc,false,false)


--buyhouse
function buyhouse_cmdfunc(thePlayer)
    if(vioGetElementData(thePlayer,"hkey")==0)then
        local hausid, dis=getNearestHouseByPlayer(thePlayer)
        local haus=haeuser[hausid]
        if(dis<10)then
            if(not haus:getBesitzer())then
                if(haus:getPreis()<=getPlayerBank(thePlayer))then
                    changePlayerBank(thePlayer,-haus:getPreis(),"sonstiges","Hauskauf")
                    haus:setBesitzer(thePlayer)
                    vioSetElementData(thePlayer,"hkey",hausid)
                    showError(thePlayer,"Glückwunsch! Du hast das Haus gekauft.")
                else
                    showError(thePlayer,string.format("Du hast nicht genug Geld auf dein Bankkonto. (%s)",toprice(haus:getPreis())))
                end
            else
                showError(thePlayer,"Dieses Haus gehört bereits jemanden.")
            end
        else
            showError(thePlayer,"Du bist nicht in der Nähe von einem Haus")
        end
    else
        showError(thePlayer,"Sie wohnen in einem Haus oder besitzen bereits ein Haus.")
    end
end
addCommandHandler("buyhouse",buyhouse_cmdfunc,false,false)



--hmoney
function hkasse_cmdfunc(thePlayer, cmd, betrag)
    if(vioGetElementData(thePlayer,"hkey")>0)then
        local hID=vioGetElementData(thePlayer,"hkey")
        local haus=haeuser[hID]
        if(haus:isPlayerInHouse(thePlayer) or haus:getPlayerDistance(thePlayer))then
            if(betrag)then
                if(tonumber(betrag))then
                    betrag=tonumber(betrag)
                    if(betrag>0)then
                        if(haus:getKasse()>=betrag)then
                            changePlayerMoney(thePlayer,betrag,"sonstiges","Auszahlung Hauskasse")
                            haus:changeKasse(-betrag)
                        else
                            showError(thePlayer,"In der Hauskasse befindet sich nicht genug Geld um so viel abzuheben.")
                        end
                    else
                        showError(thePlayer,"Der Betrag muss größer als 0 sein")
                    end
                else
                    showError(thePlayer,"Befehlssyntax: /hkasse [betrag]")
                end
            else
                showError(thePlayer,"Befehlssyntax: /hkasse [betrag]")
            end
        else
            showError(thePlayer,"Du bist nicht in der Nähe deines Hauses.")
        end
    end
end
addCommandHandler("hmoney",hkasse_cmdfunc,false,false)
addCommandHandler("hkasse",hkasse_cmdfunc,false,false)

function hausgleich_func(thePlayer)
    if(vioGetElementData(thePlayer,"hkey")>0)then
        local hID=vioGetElementData(thePlayer,"hkey")
        local haus=haeuser[hID]
        if(haus:isPlayerInHouse(thePlayer) or haus:getPlayerDistance(thePlayer)<10)then
            local money=haus:getKasse()
            if(money<0)then
                if(getPlayerMoney(thePlayer)>(-money))then
                    changePlayerMoney(thePlayer,money,"sonstiges","Hausausgleich")
                    haus:setKasse(0)
                else
                    showError(thePlayer,"Du hast nicht genügend Geld bei dir um deine Hauskasse auszugleichen!")
                end
            else
                showError(thePlayer,"An deinem Haus gibt es nichts auszugleichen!")
            end
        else
            showError(thePlayer,"Du bist nicht in der Nähe deines Hauses.")
        end
    end
end
addCommandHandler("hausgleich",hausgleich_func,false,false)


-- Mietfunktionen
function rent_cmdfunc(thePlayer)
    local hausid, dis=getNearestHouseByPlayer(thePlayer)
    local haus=haeuser[hausid]
    if(dis<10)then
        if(vioGetElementData(thePlayer,"hkey")==0)then
            if(haus:getIRaum()~=0 and haus:getKasse()>=0)then
                local miete=haus:getMiete()
                if(miete<=getPlayerBank(thePlayer))then
                    changePlayerBank(thePlayer,-miete,"sonstiges","Erste Miete")
                    vioSetElementData(thePlayer,"hkey",-hausid)
                    showError(thePlayer,"Du hast dich erfolgreich in dieses Haus eingemietet.")
                else
                    if(miete<=getPlayerMoney(thePlayer))then
                        changePlayerMoney(thePlayer,-miete,"sonstiges","Erste Miete")
                        haus:changeKasse(miete)
                        vioSetElementData(thePlayer,"hkey",-hausid)
                        showError(thePlayer,"Du hast dich erfolgreich in dieses Haus eingemietet.")
                    else
                        showError(thePlayer,"Du kannst dir die Miete nicht leisten!")
                    end
                end
            else
                showError(thePlayer,"Der Besitzer des Hauses ist nicht in der Lage Räume zur Miete anzubieten.")
            end
        else
            if(vioGetElementData(thePlayer,"hkey")<0)then
                showError(thePlayer,"Du wohnst bereits in einem Haus. Ausmieten mit /unrent.")
            else
                showError(thePlayer,"Du wohnst bereits in einem Haus. Verkaufen mit /sellhouse")
            end
        end
    else
        showError(thePlayer,"Du bist nicht in der Nähe eines Hauses.")
    end
end
addCommandHandler("rent",rent_cmdfunc,false,false)

function unrent_cmdfunc(thePlayer)
    if(vioGetElementData(thePlayer,"hkey")<0)then
        local hID=-vioGetElementData(thePlayer,"hkey")
        local haus=haeuser[hID]
        if(haus:isPlayerInHouse(thePlayer) or haus:getPlayerDistance(thePlayer))then
            vioSetElementData(thePlayer,"hkey",0)
            showError(thePlayer,"Du hast den Mietvertrag gekündigt.")
        else
          showError(thePlayer,"Du bist nicht in der Nähe deiner Wohnung, um deine Sachen mitzunehmen.")
        end
    else
        showError(thePlayer,"Du bist in keinem Haus eingemietet.")
    end
end
addCommandHandler("unrent", unrent_cmdfunc,false,false)

function setrent_cmdfunc(thePlayer,cmd,miete)
    if(vioGetElementData(thePlayer,"hkey")>0)then
        local hID=vioGetElementData(thePlayer,"hkey")
        local haus=haeuser[hID]
        if(haus:isPlayerInHouse(thePlayer) or haus:getPlayerDistance(thePlayer)<10)then
            if(haus:getIRaum()>0)then
                if(miete)then
                    if(tonumber(miete))then
                        local miete=tonumber(miete)
                        if(miete>=0 and miete<=40000)then
                            haus:setMiete(miete)
                            showError(thePlayer,string.format("Du hast die Miete auf %s gesetzt!",toprice(miete)))
                        else
                            showError(thePlayer,"Befehlssyntax: /setrent [Betrag]\nWenn der Betrag 0 ist, gibt es keine Mietmöglichkeit.")
                        end
                    else
                        showError(thePlayer,"Befehlssyntax: /setrent [Betrag]\nWenn der Betrag 0 ist, gibt es keine Mietmöglichkeit.")
                    end
                else
                    showError(thePlayer,"Befehlssyntax: /setrent [Betrag]\nWenn der Betrag 0 ist, gibt es keine Mietmöglichkeit.")
                end
            else
                showError(thePlayer,"Dein Haus hat keine Räume, die man vermieten könnte. Du musst erst einen Innenraum kaufen.")
            end
        else
            showError(thePlayer,"Du bist nicht in der Nähe deines Hauses.")
        end
    end
end
addCommandHandler("setrent",setrent_cmdfunc,false,false)









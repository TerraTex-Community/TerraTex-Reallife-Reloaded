--
-- Created by IntelliJ IDEA.
-- User: accow
-- Date: 24.04.2014
-- Time: 13:21
-- To change this template use File | Settings | File Templates.
--

function showanimlist(playerSource)
    outputChatBox("Animationen:",playerSource, 0, 200, 0 )
    outputChatBox("/handsup,/phoneout,/phonein,/drunk,/robman",playerSource, 200, 200, 0 )
    outputChatBox("/bomb,/getarrested,/laugh,/lookout,/crossarms",playerSource, 200, 200, 0 )
    outputChatBox("/lay,/hide,/vomit,/eat,/wave,/slapass",playerSource, 200, 200, 0 )
    outputChatBox("/deal,/crack,/smoke,/ground,/fucku",playerSource, 200, 200, 0 )
    outputChatBox("/chat,/taichi,/chairsit,/dance [1-7],/piss,/wank",playerSource, 200, 200, 0 )
    outputChatBox("/smokef,/smokem",playerSource, 200, 200, 0 )
    outputChatBox("Zum Abbrechen einer Animation: /stopanim oder Leertaste",playerSource, 0, 0, 200 )
end
addCommandHandler("anims",showanimlist,false,false)
addCommandHandler("animlist",showanimlist,false,false)

local animarray={
    --["cmd"]={block, anim, loop, updatePosition, lastframe}
    ["phoneout"]={"ped", "phone_out",false,true,false},
    ["phonein"]={"ped", "phone_in",false,true,true},
    ["drunk"]={"ped", "WALK_drunk",true,true,false},
    ["robman"]={"shop", "ROB_Loop_Threat",true,false,false},
    ["getarrested"]={"ped", "ARRESTgun",false,false,true},
    ["laugh"]={"rapping", "Laugh_01",false,false,false},
    ["lookout"]={"shop", "ROB_Shifty",false,false,false},
    ["crossarms"]={"cop_ambient", "Coplook_loop",true,false,false},
    ["lay"]={"beach", "bather",true,false,false},
    ["hide"]={"ped", "cower",true,false,false},
    ["wave"]={"ON_LOOKERS", "wave_loop",true,false,false},
    ["slapass"]={"sweet", "sweet_ass_slap",false,false,false},
    ["deal"]={"dealer", "dealer_deal",false,false,false},
    ["crack"]={"crack", "crckdeth2",true,true,false},
    ["ground"]={"beach", "ParkSit_M_loop",true,false,false},
    ["fucku"]={"ped", "fucku",false,true,false},
    ["chat"]={ "ped", "IDLE_chat",true,true,false},
    ["taichi"]={  "park", "Tai_Chi_Loop",true,true,false},
    ["chairsit"]={ "BEACH", "SitnWait_loop_W",true,false,false},
    ["wank"]={ "PAULNMAC", "wank_loop",true,false,false},
    ["eat"]={"VENDING", "vend_eat1_P",false,false,false},

    --[[specials]]
    ["handsup"]={"shop", "SHP_HandsUp_Scr",false,true,false},
    ["bomb"]={ "bomber", "BOM_Plant_In",false,true,false},
    ["piss"]={ "PAULNMAC", "Piss_loop",false,true,false},
    ["vomit"]={"food", "EAT_Vomit_P",false,true,false},
    ["smokef"]={"smoking", "F_smklean_loop",true,false,false},
    ["smokem"]={"smoking", "M_smklean_loop",true,false,false},
    ["smoke"]={"smoking", "M_smkstnd_loop",true,false,false},


}




function setAnimation(thePlayer,cmd)
    -- setPedAnimation(playerSource, "ped", "phone_out",-1,false,true,true)
    if(animarray[cmd])then
        vioSetElementData(thePlayer,"anim", 1)
        vioSetElementData(thePlayer,"lastAnim",cmd)
        setPedAnimation(thePlayer, animarray[cmd][1], animarray[cmd][2],-1,animarray[cmd][3],animarray[cmd][4],true,animarray[cmd][5])
        bindKey ( thePlayer, "space", "down", stopanima )
        showanimtext(thePlayer)

        --[[specials]]
        if(cmd=="handsup")then
            setTimer(handb,500,1,thePlayer)
        elseif(cmd=="bomb")then
            setTimer(bombb,500,1,thePlayer)
        elseif(cmd=="piss")then
            local x,y,z=getElementPosition(thePlayer)
            local r=getPedRotation(thePlayer)
            local obj=createObject(2052,x,y,z,0,0,r)
            attachElements ( obj, thePlayer)
            vioSetElementData(thePlayer,"animObj",obj)
            local int=getElementInterior(thePlayer)
            local dim=getElementDimension(thePlayer)
            setElementInterior(obj,int)
            setElementDimension(obj,dim)
            setTimer(killPissObj,60000,1,obj)
        elseif(cmd=="vomit")then
            setTimer(createvomit,4100,1,thePlayer)
        elseif(cmd=="smoke" or cmd=="smokef" or cmd=="smokem")then
            triggerClientEvent(getRootElement(),"addZigarre",thePlayer,cmd)
        end

    else
        showError(thePlayer,"Diese Animation funktioniert derzeit nicht.")
    end
end


function createvomit(playerSource)
    triggerClientEvent(getRootElement(),"playVomit",playerSource,playerSource)
end
function killPissObj(obj)
    if(isElement(obj))then
        destroyElement(obj)
    end
end
function handb(thePlayer)
    setPedAnimation(thePlayer,"shop","SHP_Rob_HandsUp",-1,true,false)
end
function bombb(thePlayer)
    setPedAnimation(thePlayer, "bomber", "BOM_Plant",-1,false,false,false)
end


addCommandHandler("handsup",setAnimation,false,false)
addCommandHandler("wank",setAnimation,false,false)
addCommandHandler("piss",setAnimation,false,false)
addCommandHandler("handsup",setAnimation,false,false)
addCommandHandler("ground",setAnimation,false,false)
addCommandHandler("fucku",setAnimation,false,false)
addCommandHandler("chat",setAnimation,false,false)
addCommandHandler("taichi",setAnimation,false,false)
addCommandHandler("phoneout",setAnimation,false,false)
addCommandHandler("phonein",setAnimation,false,false)
addCommandHandler("drunk",setAnimation,false,false)
addCommandHandler("robman",setAnimation,false,false)
addCommandHandler("bomb",setAnimation,false,false)
addCommandHandler("getarrested",setAnimation,false,false)
addCommandHandler("laugh",setAnimation,false,false)
addCommandHandler("lookout",setAnimation,false,false)
addCommandHandler("crossarms",setAnimation,false,false)
addCommandHandler("lay",setAnimation,false,false)
addCommandHandler("hide",setAnimation,false,false)
addCommandHandler("vomit",setAnimation,false,false)
addCommandHandler("eat",setAnimation,false,false)
addCommandHandler("wave",setAnimation,false,false)
addCommandHandler("slapass",setAnimation,false,false)
addCommandHandler("deal",setAnimation,false,false)
addCommandHandler("chairsit",setAnimation,false,false)
addCommandHandler("crack",setAnimation,false,false)
addCommandHandler("smoke",setAnimation,false,false)
addCommandHandler("smokef",setAnimation,false,false)
addCommandHandler("smokem",setAnimation,false,false)


function stopanima(playerSource)
    if vioGetElementData(playerSource,"anim")==1 then
        if isElement(vioGetElementData(playerSource,"animObj"))then
            destroyElement(vioGetElementData(playerSource,"animObj"))
            vioSetElementData(playerSource,"animObj",nil)
        end
        setPedAnimation(playerSource)
        vioSetElementData(playerSource,"anim", 0)

        local lastAnim=vioGetElementData(playerSource,"lastAnim")
        if(lastAnim=="smoke" or lastAnim=="smokef" or lastAnim=="smokem")then
            triggerClientEvent(getRootElement(),"deleteZigarre",playerSource)
        end
    end
end
addCommandHandler("stopanim",stopanima,false,false)

function showanimtext(playerSource)
    outputChatBox("/stopanim oder Leertaste zum Beenden der Animation",playerSource)
end


--dancing

function dance_func ( player, cmd, style )

    if style then
        local style = tonumber ( style )
        if style == 1 then
            setPedAnimation ( player, "DANCING", "dnce_M_a",-1,true,false,false )
        elseif style == 2 then
            setPedAnimation ( player, "DANCING", "dnce_M_b",-1,true,false,false )
        elseif style == 3 then
            setPedAnimation ( player, "DANCING", "dnce_M_c",-1,true,false,false )
        elseif style == 4 then
            setPedAnimation ( player, "DANCING", "dnce_M_d",-1,true,false,false )
        elseif style == 5 then
            setPedAnimation ( player, "DANCING", "dnce_M_e",-1,true,false,false )
        elseif style == 6 then
            setPedAnimation ( player, "DANCING", "dance_loop",-1,true,false,false )
        else
            local rnd = math.random ( 1, 4 )
            if rnd == 1 then
                setPedAnimation ( player, "STRIP", "STR_Loop_A",-1,true,false,false )
            elseif rnd == 2 then
                setPedAnimation ( player, "STRIP", "STR_Loop_B",-1,true,false,false )
            elseif rnd == 3 then
                setPedAnimation ( player, "STRIP", "STR_Loop_C",-1,true,false,false )
            else
                setPedAnimation ( player, "STRIP", "STR_Loop_A",-1,true,false,false )
            end
        end
        vioSetElementData( player, "anim", 1)
        bindKey ( player, "space", "down", stopanima )
        showanimtext( player )
    else
        outputChatBox ("FEHLER: /dance [1-7]", player, 125, 0, 0 )
    end
end
addCommandHandler("dance",dance_func,false,false)


function anim_test(thePlayer,cmd,block,anim)
    setPedAnimation ( thePlayer, block, anim,-1,false,false,false )
end
addCommandHandler("animtest",anim_test,false,false)









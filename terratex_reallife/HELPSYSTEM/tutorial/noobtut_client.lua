local x,y=guiGetScreenSize()
local facX=x/1920
local facY=y/1080

local picPosTable={
{0,0,(640*facX),(360*facY)},
{(1280*facX),0,(640*facX),(360*facY)},
{0,(720*facY),(640*facX),(360*facY)},
{(1280*facX),(720*facY),(640*facX),(360*facY)}
}
local picElements={false,false,false,false}
local picPfad="FILES/IMAGES/tutorial/"

local matrixtable={
 { 1537.6953125,-1696.1962890625,58.551567077637,1480.98046875,-1767.736328125,17.741710662842,0,70 ,0,0 },--stadthalleaußen ok
 { 1493.814453125,-1666.8203125,42.985389709473,1586.5263671875,-1680.4345703125,8.0690994262695,0,70 ,0,0 },--PD ok
 { 1330.48046875,-937.4697265625,56.787254333496,1302.140625,-852.3974609375,12.519222259521,0,70 ,0,0 },--24/7 ok
 { 1243.7744140625,-967.32421875,59.380855560303,1187.1640625,-887.1083984375,40.38920211792,0,70 ,0,0 },--burgershot ok 
 { 2122.2919921875,-1099.265625,36.495029449463,2135.240234375,-1194.3798828125,8.4646072387695,0,70 ,0 ,0 },--ok
 { 2751.19921875,-1882.84765625,30.427167892456,2758.529296875,-1787.1376953125,2.3967533111572,0,70 ,0 ,0 },--ok
  { 1658.783203125,1894.716796875,27.757402420044,1597.6884765625,1818.62890625,5.8935871124268,0,70 ,0 ,0 },--Fraktionen Medics, News, Gangs,taxi,mafia
{2743.154296875,-2435.8955078125,21.916435241699,2826.2353515625,-2486.1259765625,-2.0511016845703,0,70,0,0} --> ALLGEMEINE HILFE (Bankautomaten mit Klicksys, Jobs,Telefon,Weitere Informationen mit F1) 
}

local soundpath="/FILES/SOUNDS/tutsounds/"
local stepper=0
local soundelement=false


function renderPic(step)
	if(step==1)then
		picElements={picPfad.."stadthalle_innen.png",false,false,false}
	elseif(step==2)then
		picElements={picPfad.."lvpd.png",picPfad.."innendienst.png",picPfad.."knast.png",picPfad.."alka.png"}
	elseif(step==3)then
		picElements={false,picPfad.."tanke.png",false,false}
	elseif(step==4)then
		picElements={false,picPfad.."automaten.png",picPfad.."cb.png",picPfad.."Pizza.png"}
	elseif(step==5)then
		picElements={false,false,false,false}
	elseif(step==6)then
		picElements={picPfad.."alhambra.png",picPfad.."kirche.png",false,false}
	elseif(step==7)then
		picElements={picPfad.."taxi.png",picPfad.."mafia.png",false,picPfad.."news.png"}
	elseif(step==8)then
		picElements={false,false,false,false}
	elseif(step==9)then
		picElements={false,false,false,false}
	end
	
end

function noob_tutsetStep(step)
	if(step==0)then
		soundelement=playSound(soundpath.."einleitung.mp3",false)	
		lenght=7000
		stepper=1
	elseif(step==1)then
		setCameraMatrix(matrixtable[1][1],matrixtable[1][2],matrixtable[1][3],matrixtable[1][4],matrixtable[1][5],matrixtable[1][6],matrixtable[1][7],matrixtable[1][8])			
		soundelement=playSound(soundpath.."stadthalle.mp3",false)	
		lenght=30000
		setTimer(renderPic,1000,1,1)	
		stepper=2
	elseif(step==2)then
		setCameraMatrix(matrixtable[2][1],matrixtable[2][2],matrixtable[2][3],matrixtable[2][4],matrixtable[2][5],matrixtable[2][6],matrixtable[2][7],matrixtable[2][8])			
		soundelement=playSound(soundpath.."pd.mp3",false)	
		lenght=69000
		picElements={false,false,false,false}
		setTimer(renderPic,1000,1,2)	
		stepper=3
	elseif(step==3)then
		setCameraMatrix(matrixtable[step][1],matrixtable[step][2],matrixtable[step][3],matrixtable[step][4],matrixtable[step][5],matrixtable[step][6],matrixtable[step][7],matrixtable[step][8])			
		soundelement=playSound(soundpath.."247.mp3",false)	
		lenght=54000
		picElements={false,false,false,false}
		setTimer(renderPic,1000,1,step)	
		stepper=4
	elseif(step==4)then
		setCameraMatrix(matrixtable[step][1],matrixtable[step][2],matrixtable[step][3],matrixtable[step][4],matrixtable[step][5],matrixtable[step][6],matrixtable[step][7],matrixtable[step][8])			
		soundelement=playSound(soundpath.."essen.mp3",false)	
		lenght=61000
		picElements={false,false,false,false}
		setTimer(renderPic,1000,1,step)	
		stepper=5
	elseif(step==5)then
		setCameraMatrix(matrixtable[step][1],matrixtable[step][2],matrixtable[step][3],matrixtable[step][4],matrixtable[step][5],matrixtable[step][6],matrixtable[step][7],matrixtable[step][8])			
		soundelement=playSound(soundpath.."auto.mp3",false)	
		lenght=72000
		picElements={false,false,false,false}
		setTimer(renderPic,1000,1,step)	
		stepper=6
	elseif(step==6)then
		setCameraMatrix(matrixtable[step][1],matrixtable[step][2],matrixtable[step][3],matrixtable[step][4],matrixtable[step][5],matrixtable[step][6],matrixtable[step][7],matrixtable[step][8])			
		soundelement=playSound(soundpath.."freizeit.mp3",false)	
		lenght=25000
		picElements={false,false,false,false}
		setTimer(renderPic,1000,1,step)	
		stepper=7
	elseif(step==7)then
		setCameraMatrix(matrixtable[step][1],matrixtable[step][2],matrixtable[step][3],matrixtable[step][4],matrixtable[step][5],matrixtable[step][6],matrixtable[step][7],matrixtable[step][8])			
		soundelement=playSound(soundpath.."fraktion.mp3",false)	
		lenght=45000
		picElements={false,false,false,false}
		setTimer(renderPic,1000,1,step)	
		stepper=8
	elseif(step==8)then
		setCameraMatrix(matrixtable[step][1],matrixtable[step][2],matrixtable[step][3],matrixtable[step][4],matrixtable[step][5],matrixtable[step][6],matrixtable[step][7],matrixtable[step][8])			
		soundelement=playSound(soundpath.."infor.mp3",false)	
		lenght=122000
		picElements={false,false,false,false}
		setTimer(renderPic,1000,1,step)	
		stepper=9
	elseif(step==9)then
		setCameraTarget(getLocalPlayer())
		setTimer(unfreezemenoobtut,2500,1)
        stepper=0
	end
	if(step~=9)then
		setTimer(setNextNoobTutStep,lenght,1,soundelement)
	end
end

function unfreezemenoobtut()
setElementFrozen(getLocalPlayer(),false)
stepper=0
end

function setNextNoobTutStep(source)
	noob_tutsetStep(stepper)
end
--addEventHandler ( "onClientSoundStopped", getRootElement(), setNextNoobTutStep )

local pickele=createPickup(1728.5966796875,-1862.3056640625,13.576456069946,3,1239,5000)
function showTutorialInfo(hitten)
	if(source==pickele)then
		if(hitten==getLocalPlayer())then
			outputChatBox("RookieGuide! Um alle Informationen des RookieGuide hören zu können, stellen",255,0,0)
			outputChatBox("Sie sicher, dass ihr Sound lautgenug und aktiviert ist! Starten des RookieGuides mit /snt",255,0,0)
		end
	end
end
addEventHandler("onClientPickupHit",getRootElement(),showTutorialInfo)

function start_Noob_tut()
	local x,y,z=getElementPosition(getLocalPlayer())
	local dis=getDistanceBetweenPoints3D(x,y,z,1728.5966796875,-1862.3056640625,13.576456069946)
	if(dis<10)then
        if(stepper==0)then
		    noob_tutsetStep(0)
		    setElementFrozen(getLocalPlayer(),true)
        else
            outputChatBox("Du hast bereits ein Tutorial gestartet.",255,0,0)
        end
	else
		outputChatBox("Du bist nicht in der nähe des RookieGuidePunktes!",255,0,0)
	end
end
addCommandHandler("snt",start_Noob_tut,false,false)


function onClientTutRender()
	if(picElements[1])then
		dxDrawImage(picPosTable[1][1],picPosTable[1][2],picPosTable[1][3],picPosTable[1][4],picElements[1])
	end
	if(picElements[2])then
		dxDrawImage(picPosTable[2][1],picPosTable[2][2],picPosTable[2][3],picPosTable[2][4],picElements[2])
	end
	if(picElements[3])then
		dxDrawImage(picPosTable[3][1],picPosTable[3][2],picPosTable[3][3],picPosTable[3][4],picElements[3])
	end
	if(picElements[4])then
		dxDrawImage(picPosTable[4][1],picPosTable[4][2],picPosTable[4][3],picPosTable[4][4],picElements[4])
	end
end
addEventHandler("onClientRender",getRootElement(),onClientTutRender)










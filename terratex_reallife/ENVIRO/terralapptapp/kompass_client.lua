local EntfernungRESET=0
local SpeedRESET=0
local SpeedCounterRESET=0

local filename="kompass_save.xml"
-- Created: 16/08/2012 09:12
addEventHandler("onClientResourceStart",resourceRoot,
    function()
        kompassgui_Window = {}
        kompassgui_Button = {}
        kompassgui_Label = {}
		local dx,dy=guiGetScreenSize()
		dx=600/1600*dx
		dy=245/900*dy	
        kompassgui_Window[1] = guiCreateWindow(dx,dy,528,408,"Kompass",false)
		table.insert(allGuis,kompassgui_Window[1])
        kompassgui_Button[1] = guiCreateButton(300,277,175,28,"Close",false,kompassgui_Window[1])
        kompassgui_Label[1] = guiCreateLabel(108,37,192,15,"Himmelsrichtung:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[1],"right",false)
        kompassgui_Label[2] = guiCreateLabel(109,55,192,15,"Rotation zu Norden:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[2],"right",false)
        kompassgui_Label[3] = guiCreateLabel(110,73,192,15,"Position Koordinate x:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[3],"right",false)
        kompassgui_Label[4] = guiCreateLabel(110,90,192,15,"Position Koordinate y:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[4],"right",false)
        kompassgui_Label[5] = guiCreateLabel(110,108,192,15,"Position Koordinate z:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[5],"right",false)
        kompassgui_Label[6] = guiCreateLabel(18,127,285,15,"Geschwindigkeit X-Achse:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[6],"right",false)
        kompassgui_Label[7] = guiCreateLabel(22,142,281,16,"Geschwindigkeit Y-Achse:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[7],"right",false)
        kompassgui_Label[8] = guiCreateLabel(18,158,285,15,"Geschwindigkeit Z-Achse:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[8],"right",false)
        kompassgui_Label[9] = guiCreateLabel(20,174,283,15,"Geschwindigkeit Gesamt:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[9],"right",false)
        kompassgui_Label[10] = guiCreateLabel(20,193,283,15,"Entfernung zum Nullpunkt:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[10],"right",false)
        kompassgui_Label[11] = guiCreateLabel(20,206,291,17,"Durchschnittsgeschwindigkeit seit letztem Connect:",false,kompassgui_Window[1])
        kompassgui_Label[12] = guiCreateLabel(20,221,283,15,"Zurückgelegte Entfernung seit letztem Connect:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[12],"right",false)
        kompassgui_Label[13] = guiCreateLabel(20,237,283,15,"Zurückgelegte Entfernung seit letztem RESET:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[13],"right",false)
        kompassgui_Button[2] = guiCreateButton(26,278,148,29,"RESET",false,kompassgui_Window[1])
        kompassgui_Label[14] = guiCreateLabel(20,252,283,15,"Durschnittliche geschwindigkeit seit letztem RESET:",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[14],"right",false)
        kompassgui_Label[15] = guiCreateLabel(29,319,442,75,"Information: Die angegebenen Entfernungen und Geschwindigkeiten seit letztem RESET von den tatsächlichen Werten leicht abweichen!\nErklärung: m => Meter | km => Kilometer(bei "..config["communityname"].." mit Faktor 10) \nC => Koordinatenpunkte | s => Sekunden | h => Stunden",false,kompassgui_Window[1])
        guiLabelSetHorizontalAlign(kompassgui_Label[15],"left",true)
		
        kompassgui_Label[16] = guiCreateLabel(305,38,164,15,"Himmelsrichtungwert",false,kompassgui_Window[1])
        kompassgui_Label[17] = guiCreateLabel(305,73,164,15,"Xwert",false,kompassgui_Window[1])
        kompassgui_Label[18] = guiCreateLabel(305,55,164,15,"RotationzuNwert",false,kompassgui_Window[1])
        kompassgui_Label[19] = guiCreateLabel(305,158,164,15,"ZVwert",false,kompassgui_Window[1])
        kompassgui_Label[20] = guiCreateLabel(305,142,164,15,"YVwert",false,kompassgui_Window[1])
        kompassgui_Label[21] = guiCreateLabel(305,127,164,15,"XVwert",false,kompassgui_Window[1])
        kompassgui_Label[22] = guiCreateLabel(305,109,164,15,"Zwert",false,kompassgui_Window[1])
        kompassgui_Label[23] = guiCreateLabel(305,91,164,15,"Ywert",false,kompassgui_Window[1])
        kompassgui_Label[24] = guiCreateLabel(305,174,164,15,"VGwert",false,kompassgui_Window[1])
        kompassgui_Label[25] = guiCreateLabel(305,252,213,15,"DVRESET",false,kompassgui_Window[1])
        kompassgui_Label[26] = guiCreateLabel(305,236,213,15,"ERESETkm",false,kompassgui_Window[1])
        kompassgui_Label[27] = guiCreateLabel(305,221,213,15,"EConnectkmwert",false,kompassgui_Window[1])
        kompassgui_Label[28] = guiCreateLabel(305,207,213,15,"DVConnectwert",false,kompassgui_Window[1])
        kompassgui_Label[29] = guiCreateLabel(305,193,164,15,"ENkmwert",false,kompassgui_Window[1])
		
		guiSetVisible(kompassgui_Window[1],false)
		addEventHandler ( "onClientGUIClick", kompassgui_Button[1], pressKompassClose, false )
		addEventHandler ( "onClientGUIClick", kompassgui_Button[2], pressKompassReset, false )
		
		
		local filehandler
		if not(fileExists ( filename ))then
			filehandler=fileCreate ( filename)
			fileClose ( filehandler)
			local node=xmlCreateFile ( filename, "kompass" )			
			local childnode=xmlCreateChild ( node, "km" )
			xmlNodeSetValue ( childnode, tostring(0) )
            local childnode=xmlCreateChild ( node, "v" )
            xmlNodeSetValue ( childnode, tostring(0) )
            local childnode=xmlCreateChild ( node, "c" )
            xmlNodeSetValue ( childnode, tostring(0) )
            xmlSaveFile ( node )
			xmlUnloadFile(node)
		else
			local node=xmlLoadFile(filename)
			EntfernungRESET=tonumber(xmlNodeGetValue (xmlFindChild ( node, "km", 0 ) ))
			SpeedRESET=tonumber(xmlNodeGetValue (xmlFindChild ( node, "v", 0 ) ))
			SpeedCounterRESET=tonumber(xmlNodeGetValue (xmlFindChild ( node, "c", 0 ) ))
			xmlUnloadFile(node)
		end
		setTimer(aktualizeKompass,250,0)
		setTimer(save_new_km_v,20000,0)
		
    end
)
local oldx,oldy,oldz=false,false,false
--SpeedRESET => Zeit in Sekunden
--EntfernungRESET => Zurückgelegte Koordinaten
-- Bei Tappkauf WERTERESET

function showKompass()
	guiSetVisible(kompassgui_Window[1],true)
end

local SpeedConnect=0
local EntfernungConnect=0
local SpeedCounterConnect=0
function pressKompassClose()
	guiSetVisible(kompassgui_Window[1],false)
end

function pressKompassReset()
	SpeedRESET=0
	EntfernungRESET=0
    SpeedCounterRESET=0
	save_new_km_v()
end

local rotToNHimmel={"Nord","Nord-Nord-West","Nord-West","West-Nord-West","West","West-Süd-West","Süd-West","Süd-Süd-West","Süd","Süd-Süd-Ost","Süd-Ost","Ost-Süd-Ost","Ost","Ost-Nord-Ost","Nord-Ost","Nord-Nord-Ost","Nord"}

function aktualizeKompass()
	if not(oldx)then
		oldx,oldy,oldz=getElementPosition(getLocalPlayer())
	end
	local rotx,roty,rotz=getElementRotation(getLocalPlayer())
	
	guiSetText(kompassgui_Label[18],tostring(rotz))	
	local x,y,z=getElementPosition(getLocalPlayer())
	guiSetText(kompassgui_Label[17],tostring(x))
	guiSetText(kompassgui_Label[23],tostring(y))
	guiSetText(kompassgui_Label[22],tostring(z))
	if(rotz)then
		local rotcounter=0
		--rotter=11.25
		rotter=-11.25
		while(rotz>rotter)do
			--outputDebugString(tostring(rotz).." "..tostring(rotter))
			rotcounter=rotcounter+1
			rotter=rotter+22.5
		end
		guiSetText(kompassgui_Label[16],tostring(rotToNHimmel[rotcounter]))
	end
	
	local vx,vy,vz=getElementVelocity(getLocalPlayer())
	if(isPedInVehicle(getLocalPlayer()))then
		local veh=getPedOccupiedVehicle(getLocalPlayer())		
		if(isElement(veh))then
			vx,vy,vz=getElementVelocity(veh)
		end
	end
	if(not(vx))then
		vx=0
		vy=0
		vz=0
	end	
	local gv=math.sqrt(vx*vx+vy*vy+vz*vz)
	vx=vx*50
	vy=vy*50
	vz=vz*50
	gv=gv*50
	local vxk,vyk,vzk,gvk=vx*3.6,vy*3.6,vz*3.6,gv*3.6
	guiSetText(kompassgui_Label[21],math.round(vx,2).." m/s | "..math.round(vxk,2).." km/h")
	guiSetText(kompassgui_Label[20],math.round(vy,2).." m/s | "..math.round(vyk,2).." km/h")
	guiSetText(kompassgui_Label[19],math.round(vz,2).." m/s | "..math.round(vzk,2).." km/h")
	guiSetText(kompassgui_Label[24],math.round(gv,2).." m/s | "..math.round(gvk,2).." km/h")
	local disN=getDistanceBetweenPoints3D(0,0,0,x,y,z)
	guiSetText(kompassgui_Label[29],math.round(disN/100,3).." km | "..math.round(disN,1).." C")
	if not SpeedConnect then SpeedConnect=0 end
	if not SpeedCounterConnect then SpeedCounterConnect=0 end

    if(gv>0)then
        SpeedConnect=SpeedConnect+gv
        SpeedCounterConnect=SpeedCounterConnect+1
    end
    local speedDVC=SpeedConnect/SpeedCounterConnect

	local disToOld=getDistanceBetweenPoints3D(oldx,oldy,oldz,x,y,z)
    if not EntfernungConnect then EntfernungConnect=0 end
	EntfernungConnect=EntfernungConnect+disToOld
	
	guiSetText(kompassgui_Label[27],math.round(EntfernungConnect/100,3).." km | "..math.round(EntfernungConnect,1).." C")
    if(speedDVC)then
	    guiSetText(kompassgui_Label[28],tostring(math.round(speedDVC,2)).." m/s | "..tostring(math.round((speedDVC*3.6),2)).." km/h")
    end


    if not SpeedRESET then SpeedRESET=0 end
    if not SpeedRESET then SpeedCounterRESET=0 end
	local disToOld=getDistanceBetweenPoints3D(oldx,oldy,oldz,x,y,z)
    if not EntfernungRESET then EntfernungRESET=0 end
	EntfernungRESET=EntfernungRESET+disToOld

    if(gv>0)then
        SpeedRESET=SpeedRESET+gv
        SpeedCounterRESET=SpeedCounterRESET+1
    end


    local speedDVC=SpeedRESET/SpeedCounterRESET
	guiSetText(kompassgui_Label[26],math.round(EntfernungRESET/100,3).." km | "..math.round(EntfernungRESET,1).." C")

    if not speedDVC then speedDVC = 0 end
	guiSetText(kompassgui_Label[25],math.round(speedDVC,2).." m/s | "..math.round(speedDVC*3.6,2).." km/h")
	
	oldx,oldy,oldz=x,y,z
	--save_new_km_v()
	
end


function save_new_km_v()
    local filehandler
    local node
    if not(fileExists ( filename ))then
        filehandler=fileCreate ( filename)
        fileClose ( filehandler)
        node=xmlCreateFile ( filename, "kompass" )
        local childnode=xmlCreateChild ( node, "km" )
        xmlNodeSetValue ( childnode, tostring(0) )
        local childnode=xmlCreateChild ( node, "v" )
        xmlNodeSetValue ( childnode, tostring(0) )
        local childnode=xmlCreateChild ( node, "c" )
        xmlNodeSetValue ( childnode, tostring(0) )
        xmlSaveFile ( node )
    end
    if not node then
	    local node=xmlLoadFile(filename)
    end
    if not node then
        fileDelete ( filename )
    else

        local childnode=xmlFindChild ( node, "km" ,0)
        xmlNodeSetValue ( childnode,tostring(EntfernungRESET) )
        local childnode=xmlFindChild ( node, "v" ,0)
        xmlNodeSetValue ( childnode, tostring(SpeedRESET) )
        local childnode=xmlFindChild ( node, "c" ,0)
        xmlNodeSetValue ( childnode, tostring(SpeedCounterRESET) )
        xmlSaveFile ( node )
        xmlUnloadFile(node)

    end
end











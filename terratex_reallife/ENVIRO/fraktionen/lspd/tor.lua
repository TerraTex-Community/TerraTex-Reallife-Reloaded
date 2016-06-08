lspdschranke=createObject(968,1544.7264404297,-1630.7701416016,13.145315170288,0,-89.516113281,268.48498535156)
lspdschrankestatus=false
lspdschranketurnable=true

function openPDSchranke(thePlayer)
	if(isBeamter(thePlayer))then
		local x,y,z=getElementPosition(thePlayer)
		local dis=getDistanceBetweenPoints3D(x,y,z,1544.7264404297,-1630.7701416016,13.145315170288)
		if(dis<10)then
			if(lspdschranketurnable)then
				if(lspdschrankestatus)then
					moveObject(lspdschranke,3000,1544.7264404297,-1630.7701416016,13.145315170288,0,-89.516113281,0)
					lspdschrankestatus=false
					lspdschranketurnable=false
					setTimer(setLSPDSchrankeMoveAble,3500,1)
				else
					moveObject(lspdschranke,3000,1544.7255859375,-1630.76953125,13.145315170288,0,89.516113281,0 )				
					lspdschrankestatus=true				
					lspdschranketurnable=false					
					setTimer(setLSPDSchrankeMoveAble,3500,1)
				end	
			end
		end	
	end
end
addCommandHandler("mv",openPDSchranke,false,false)

function setLSPDSchrankeMoveAble()
	lspdschranketurnable=true
end

lspdtor={}
lspdtor[1]=createObject(969,1584.6666259766,-1638.1644287109,12.51545715332,0,359,0)
lspdtor[2]=createObject(2930,253.10000610352,109.59999847412,1004.9000244141,0,0,0)
setElementInterior(lspdtor[2],10)   
lspdtor[3]=createObject(2930,239.5,118.80000305176,1004.9000244141,0,0,0)
setElementInterior(lspdtor[3],10)   
lspdtor[4]=createObject(2930,3366.57,136.2922,17.2532,0,0,0)
lspdtor[5]=createObject(2930,3366.5,136.2998,17.2532,0,0,179.995)
 lspdtorstatus={}
lspdtorstatus[1]=false
lspdtorstatus[2]=false
lspdtorstatus[3]=false
lspdtorstatus[4]=false


function openPDDoor(thePlayer)
	if(isBeamter(thePlayer))then
		local x,y,z=getElementPosition(thePlayer)
		--alkator
		local dis=getDistanceBetweenPoints3D(x,y,z,3366.57,136.2922,17.2532)
		if(dis<10)then
			if(lspdtorstatus[4])then
				moveObject(lspdtor[4],3000,3366.57,136.2922,17.2532)
				moveObject(lspdtor[5],3000,3366.5,136.2998,17.2532)
				lspdtorstatus[4]=false
			else
				moveObject(lspdtor[4],3000,3366.5, 137.8385925293, 17.253200531006)
                moveObject(lspdtor[5],3000,3366.5703125, 134.76600646973, 17.253200531006)
				lspdtorstatus[4]=true
			end		
		end	
		--garagentor
		local dis=getDistanceBetweenPoints3D(x,y,z,1586.1364,-1635.38098,9.390505)
		if(dis<10)then
			if(lspdtorstatus[1])then
				moveObject(lspdtor[1],3000,1584.6666259766,-1638.1644287109,12.51545715332)
				lspdtorstatus[1]=false
			else
				moveObject(lspdtor[1],3000,1584.6666259766,-1638.1644287109,5.0655)				
				lspdtorstatus[1]=true
			end		
		end	
		--Tor 1	
		dis=getDistanceBetweenPoints3D(x,y,z,253.10000610352,107.80000305176,1004.9000244141)
		if(dis<10)then
			if(lspdtorstatus[2])then
				moveObject(lspdtor[2],3000,253.10000610352,109.59999847412,1004.9000244141)
				lspdtorstatus[2]=false
			else
				moveObject(lspdtor[2],3000,253.10000610352,107.80000305176,1004.9000244141)				
				lspdtorstatus[2]=true
			end		
		end
		--Tor 2	
		dis=getDistanceBetweenPoints3D(x,y,z,239.39999389648,120.5,1004.9000244141)
		if(dis<10)then
			if(lspdtorstatus[3])then
				moveObject(lspdtor[3],3000,239.5,118.80000305176,1004.9000244141)
				lspdtorstatus[3]=false
			else
				moveObject(lspdtor[3],3000,239.39999389648,120.5,1004.9000244141)				
				lspdtorstatus[3]=true
			end		
		end
	end
end
addCommandHandler("mv",openPDDoor,false,false)

function loadPDAbhoerMarker()
	local marker=createMarker(214.8681640625,125.986328125,1002.71875,"cylinder",1.0)
	addEventHandler("onMarkerHit",marker,setDown_pd)
	setElementInterior(marker,10)
	marker=createMarker(3549.1000976563,2181.3999023438,823.79998779297,"cylinder",1.0)
	addEventHandler("onMarkerHit",marker,setUp_pd)
	setElementInterior(marker,10)
	
	local marker=createMarker(1524.6279296875,-1678.0078125,5.71875,"cylinder",1.0)
	addEventHandler("onMarkerHit",marker,PDsetUpToHeli)	
	local marker=createMarker(1572.4404296875,-1671.181640625,27.895606994629,"cylinder",1.0)
	addEventHandler("onMarkerHit",marker,PDsetDownToHeli)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),loadPDAbhoerMarker)

local enteredPDHeliForceMarker=false
function resetPDheliTimerMarker()
	enteredPDHeliForceMarker=false
end

function PDsetUpToHeli(player)
    if(getElementType ( player ) == "player")then
	    if not(enteredPDHeliForceMarker) then
            if(not(isPedInVehicle(player)))then
                enteredPDHeliForceMarker=true
                setElementPosition(player,1572.4404296875,-1671.181640625,28.395606994629)
                setTimer(resetPDheliTimerMarker,1500,1)
            end
        end
	end
end  

function PDsetDownToHeli(player)
    if(getElementType ( player ) == "player")then
	    if not(enteredPDHeliForceMarker) then
            if(not(isPedInVehicle(player)))then
                enteredPDHeliForceMarker=true
                setElementPosition(player,1524.6279296875,-1678.0078125,6.21875)
                setTimer(resetPDheliTimerMarker,1500,1)
            end
        end
	end
end  

local enteredPDForceMarker=false
function resetPDTimerMarker()
	enteredPDForceMarker=false
end

function setDown_pd(player)
    if(getElementType ( player ) == "player")then
	    if not(enteredPDForceMarker) then

            if(not(isPedInVehicle(player)))then
                enteredPDForceMarker=true
                setElementPosition(player,3549.1000976563,2181.3999023438,824.29998779297)
                setTimer(resetPDTimerMarker,1500,1)
            end
        end
	end
end  

function setUp_pd(player)
    if(getElementType ( player ) == "player")then
	    if not(enteredPDForceMarker) then
            if(not(isPedInVehicle(player)))then
                enteredPDForceMarker=true
                setElementPosition(player,214.8681640625,125.986328125,1003.21875)
                setTimer(resetPDTimerMarker,1500,1)
            end
        end
	end
end  










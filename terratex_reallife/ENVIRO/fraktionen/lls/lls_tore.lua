
	
	lls_tore={}
	lls_tore[1]=createObject(976,715.9,-1579.099,-0.5,0,0,0)
	lls_tore[2]=createObject(976,733.4,-1579.099,-0.5,0,0,180)
	lls_tore[3]=createObject(976,704.0999,-1422.400878,12.5,0,0,0)
	lls_tore[4]=createObject(976,653.399,-1436.399,13.8,0,0,90)
	lls_torstatus={false,false,false}
	
    
	
 function open_lls_tor_A(thePlayer)
 --outputChatBox("lala")
	if(vioGetElementData(thePlayer,"fraktion")==6)then
		local px,py,pz=getElementPosition(thePlayer)
		local disA=getDistanceBetweenPoints3D(px,py,pz,715.9,-1579.099,-0.5)
		local disB=getDistanceBetweenPoints3D(px,py,pz,702.5,-1421.2,12.5)
		local disC=getDistanceBetweenPoints3D(px,py,pz,653.399,-1436.399,12.5)
		if(disA<20)then
			stopObject(lls_tore[1])
			local rotx,roty,rotzA=getElementRotation(lls_tore[1])	
			stopObject(lls_tore[2])
			local rotxB,roty,rotzB=getElementRotation(lls_tore[2])	
			if(lls_torstatus[1])then	
				--tor 1: 90 offen 0 zu
				-- tor 2: 90 offen 180 zu				
				--if(rotzA==0)then rotzA=360 end
				local restRot=360-rotzA	--nachaußen
			--	local restRot=90-rotzA	--nachinnen
				--outputChatBox(restRot.." "..rotzA)
				moveObject(lls_tore[1],5000,715.9,-1579.099,-0.5,0,0,restRot)
				
				restRot=180-rotzB--nachinnen
				--restRot=90-rotzB--nachaußen
				
				moveObject(lls_tore[2],5000,733.4,-1579.099,-0.5,0,0,restRot)
				lls_torstatus[1]=false
			else
				--local restRot=90-rotzA--nachinnen
				local restRot=rotzA-90
				--outputChatBox(restRot.." "..rotzA)
				moveObject(lls_tore[1],5000,715.9,-1579.099,-0.5,0,0,restRot)
				
				--restRot=90-rotzB--nachinnen
				restRot=rotzB-90--nachaußen
				moveObject(lls_tore[2],5000,733.4,-1579.099,-0.5,0,0,restRot)			
			
				lls_torstatus[1]=true
			end				
		elseif(disB<20)then		
			stopObject(lls_tore[3])
			local rotx,roty,rotz=getElementRotation(lls_tore[3])	
						
			if(lls_torstatus[2])then				
				local restRot=360-rotz
			--	outputChatBox(restRot.." "..rotz)
				moveObject(lls_tore[3],5000,704.0999,-1422.400878,12.5,0,0,restRot)
				lls_torstatus[2]=false
			else
				if(rotz==0)then rotz=360 end
				local restRot=270-rotz
			--	outputChatBox(restRot.." "..rotz)
				moveObject(lls_tore[3],5000,704.0999,-1422.400878,12.5,0,0,restRot)
				lls_torstatus[2]=true
			end	
		elseif(disC<20)then
			if(lls_torstatus[3])then
				moveObject(lls_tore[4],2000,653.399,-1436.399,13.8)
				lls_torstatus[3]=false
			else
				moveObject(lls_tore[4],2000,653.399,-1436.399,10.5)
				lls_torstatus[3]=true
			end
		end
		
		
		
		
	end
 end
 addCommandHandler("mv",open_lls_tor_A)









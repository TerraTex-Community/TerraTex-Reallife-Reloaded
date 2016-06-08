createObject(9241,1005.09002686,1018.02001953,48.84999847,0.00000000,0.00000000,306.00000000)-- //object(copbits_sfn) (1)
createObject(9241,1056.70996094,980.15917969,40.59999847,0.00000000,0.00000000,274.99877930)--//object(copbits_sfn) (2)


-- local newsTor={}
-- local newsTorStatus={false,false}
-- newsTor[1]=createObject(988,780.5060,-1330.00476,13.546875,0,0,179.5)
-- newsTor[2]=createObject(988,775.079,-1329.8559,13.57515,0,0,177.749)
-- newsTor[3]=createObject(988,775.167144,-1385.11022,13.81525,0,0,0)
-- newsTor[4]=createObject(988,780.64569,-1385.171142,13.871575,0,0,0)



-- function mv_news_func(thePlayer)
	-- local px,py,pz=getElementPosition(thePlayer)
	-- local distA=getDistanceBetweenPoints3D(px,py,pz,780.5060,-1330.00476,13.546875)
	-- local distB=getDistanceBetweenPoints3D(px,py,pz,775.167144,-1385.11022,13.81525)
	
	-- if(vioGetElementData(thePlayer,"fraktion")==3)then
		-- if(distA<15)then
			-- if(newsTorStatus[1])then
				-- moveObject(newsTor[1],2000,780.5060,-1330.00476,13.546875)
				-- moveObject(newsTor[2],2000,775.079,-1329.8559,13.57515)
				-- newsTorStatus[1]=false
			-- else
				-- moveObject(newsTor[1],2000,783.3269,-1330.07373,13.546873)
				-- moveObject(newsTor[2],2000,772.4831,-1329.79248,13.57515)
				-- newsTorStatus[1]=true
			-- end		
		-- elseif(distB<15)then
			-- if(newsTorStatus[2])then
				-- moveObject(newsTor[3],2000,775.167144,-1385.11022,13.81525)
				-- moveObject(newsTor[4],2000,780.64569,-1385.171142,13.871575)
				-- newsTorStatus[2]=false
			-- else
				-- moveObject(newsTor[3],2000,772.1671,-1385.1014,13.815)
				-- moveObject(newsTor[4],2000,783.8956,-1385.1806,13.8715)
				-- newsTorStatus[2]=true
			-- end				
		-- end	
	-- end
-- end
-- addCommandHandler("mv",mv_news_func,false,false)




local newsMarkerA=false
local newsMarkerB=false
local newsPortStatus=false

    
function onResourceStartCreateNewsMarker()

	newsMarkerA=createMarker(1029.6300048828,1009.29998779,47.630001068115,"cylinder",2)
	addEventHandler("onMarkerHit",newsMarkerA,hitNewsMarker)
    newsMarkerB=createMarker(1039.8100585938,1014.4199829102,10.5,"cylinder",2)
	addEventHandler("onMarkerHit",newsMarkerB,hitNewsMarker)
end
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),	onResourceStartCreateNewsMarker)
	
function hitNewsMarker(thePlayer)
	if not(newsPortStatus) then
		if(source==newsMarkerA)then
			setElementPosition(thePlayer,1039.8100585938,1014.4199829102,11)
			newsPortStatus=true
			setTimer(resetnewsPortStatus,250,1)
		elseif(source==newsMarkerB)then
			setElementPosition(thePlayer,1029.6300048828,1009.29998779,48.130001068115)
			newsPortStatus=true
			setTimer(resetnewsPortStatus,250,1)
		end	
	end
end

function resetnewsPortStatus()
	newsPortStatus=false
end









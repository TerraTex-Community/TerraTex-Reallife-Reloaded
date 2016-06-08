--
-- c_uv_scripted.lua
--
local werbetafel={
{"bobo_1","werbung1.png",false,false},
{"bobo_2","werbung2.png",false,false},
{"bobo_3","werbung3.png",false,false},
{"bobo_4","werbung4.png",false,false},
{"bobo_5","werbung5.png",false,false},

{"prolaps01","werbung6.png",false,false},
{"prolaps02","werbung7.png",false,false},
{"homies_2","werbung8.png",false,false},
{"homies_1","werbung9.png",false,false},

{"diderSachs01","werbung10.png",false,false},

{"eris_1","werbung11.png",false,false},
{"hardon_1","werbung12.png",false,false},
{"eris_2","werbung13.png",false,false},
{"cokopops_1","werbung14.png",false,false},
{"cokopops_1","werbung15.png",false,false},

{"semi1Dirty","werbung16.png",false,false},
{"semi3Dirty","werbung17.png",false,false},
{"bobobillboard1","werbung18.png",false,false},
{"semi2Dirty","werbung19.png",false,false}
}
--texturename,bildname,shader,animation

--onClientLoadWerbung
--		triggerClientEvent(client, "onClientLoadWerbung", getRootElement(), data,ID,animation)

function loadWerbePic(id)
	if isElement(werbetafel[id][3]) then
		engineRemoveShaderFromWorldTexture ( werbetafel[id][3], werbetafel[id][1])
	end
	werbetafel[id][3], tec = dxCreateShader ( "ADDONS/werbung/uv_scripted.fx" )
	local myTexture = dxCreateTexture (werbetafel[id][2])
	dxSetShaderValue ( werbetafel[id][3], "CUSTOMTEX0", myTexture );
	local returnm = engineApplyShaderToWorldTexture ( werbetafel[id][3], werbetafel[id][1] )	
	-- outputChatBox("und eingefügt!"..id)
end

addEvent("onClientLoadWerbung",true)
function onClientLoadWerbung_func(data,ID,animation)
	-- outputChatBox("geladen")
	local id=ID
	werbetafel[id][4]=false
	if(tonumber(animation)==1)then
		werbetafel[id][3]=true
	end
	
	local filename=werbetafel[id][2]
	local fh = fileExists(filename) and fileOpen(filename) or fileCreate(filename)
	fileWrite(fh, data)
	fileClose(fh)

	setTimer(loadWerbePic,5000,1,ID)
	
end
addEventHandler("onClientLoadWerbung",getRootElement(),onClientLoadWerbung_func)

function loadPlayerOfTheMonthPicture()	
	shader, tec = dxCreateShader ( "ADDONS/werbung/uv_scripted.fx" )
	local myTexture = dxCreateTexture ("playerOfMonth.png")
	dxSetShaderValue ( shader, "CUSTOMTEX0", myTexture );
	local returnm = engineApplyShaderToWorldTexture ( shader, "SunBillB07" )	
	
	shader, tec = dxCreateShader ( "ADDONS/werbung/uv_scripted.fx" )
	local myTexture = dxCreateTexture ("playerOfMonth.png")
	dxSetShaderValue ( shader, "CUSTOMTEX0", myTexture );
	local returnm = engineApplyShaderToWorldTexture ( shader, "SunBillB08" )
	-- outputChatBox("loaded")
end

addEvent("onClientLoadPlayerOfTheMonth", true)
function loadPicturesOfMonth(data)
		
		-- outputChatBox("joinCreate")
		-- Datei Speichern
		local filename="playerOfMonth.png"
		local fh = fileExists(filename) and fileOpen(filename) or fileCreate(filename)
		fileWrite(fh, data)
		fileClose(fh)
		
		setTimer(loadPlayerOfTheMonthPicture,5000,1)
end
addEventHandler("onClientLoadPlayerOfTheMonth", getRootElement(),loadPicturesOfMonth)




function startResourcePlayerOfMonth()
	triggerServerEvent("requestPlayerOfMonth",getLocalPlayer())
	
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),startResourcePlayerOfMonth)



--local myShader
local startTickCount

addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Create shader

		-- Create texture and add to shader
		--local myTexture = dxCreateTexture ( "images/env3.bmp" );
		--dxSetShaderValue ( myShader, "CUSTOMTEX0", myTexture );
		
		--local myTexture = dxCreateTexture ( "ADDONS/werbung/images/images.jpeg" );
		--dxSetShaderValue ( myShader, "CUSTOMTEX0", myTexture );

		
		
		--if not myShader then
		--	outputChatBox( "Could not create shader. Please use debugscript 3" )
		--else
			--outputChatBox( "Using technique " .. tec )

			-- Apply to world texture
			--engineApplyShaderToWorldTexture ( myShader, "bobo_2" )

			-- Create object with model 4729 (billboard)
			

			-- Begin updates for UV animation
			startTickCount = getTickCount()
			addEventHandler( "onClientRender", root, updateUVs )
		--end
	end
)


------------------------------------------------------
-- Update
------------------------------------------------------
function updateUVs()
	for theKey,theTable in ipairs(werbetafel)do
		if(theTable[3]and theTable[4])then
			local myShader=theTable[3]
			-- Valide shader to save bazillions of warnings
			if not isElement( myShader ) then return end

			-- Calc how many seconds have passed since uv anim started
			local secondsElapsed = ( getTickCount() - startTickCount ) / 1500

			-- Calc section (0-6) and time (0-1) within the section
			local timeLooped = ( secondsElapsed / 2 ) % 8
			local section = math.floor ( timeLooped )
			local time = timeLooped % 1

			-- Figure out what uv anims to do
			local bScrollLeft = section == 0 or section == 3 or section == 4 or section == 6
			local bWobbleRotate = section == 1 or section == 3 or section == 5 or section == 6
			local bGoneAllZoomy = section == 2 or section == 4 or section == 5 or section == 6

			local u,v = 0, 0
			local angle = 0
			local scale = 1

			-- Do uv anims
			if bScrollLeft then
				u = time
			end
			if bWobbleRotate then
				angle = math.sin(time/2*6.28)/4
			end
			if bGoneAllZoomy then
				scale = math.cos(time*6.28) * 0.5 + 0.5
			end

			-- Apply uv anims
			dxSetShaderValue ( myShader, "gUVPosition", u,v );
			dxSetShaderValue ( myShader, "gUVRotAngle", angle );
			dxSetShaderValue ( myShader, "gUVScale", scale, scale );
		end
	end
end


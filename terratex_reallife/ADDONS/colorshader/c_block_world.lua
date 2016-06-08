--
-- c_block_world.lua
--

local shaderList = {}
local colorizeOff = false
local allShaders={}

addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Create shader to test for any errors

	end
)


----------------------------------------------------------------
-- Do change
----------------------------------------------------------------
function colorize()
	--colorizeOff = not colorizeOff
	for _,shader in ipairs(shaderList) do
		local r,g,b = 0,0,0
		while r+g+b < 2 do
			r,g,b = math.random(0.01,3.00),math.random(0.01,3.00),math.random(0.01,3.00)
		end
		-- if colorizeOff then
			-- r,g,b = 1,1,1
		-- end
		dxSetShaderValue ( shader, "COLORIZE", r,g,b )
	end
end

--bindKey("k", "down", colorize )

on=false
function coloroff(setter)	
	if(not(setter))then
		for theKey,theShader in ipairs(allShaders)do
			destroyElement(theShader)
		end
		on=false
	else
	
		local testShader, tec = dxCreateShader ( "ADDONS/colorshader/block_world.fx" )
		table.insert(allShaders,testShader)
		if not testShader then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
			--outputChatBox( "Using technique " .. tec )

			-- Create 26 shaders and apply each one to some world textures
			for c=65,96 do
				local clone = dxCreateShader ( "ADDONS/colorshader/block_world.fx" )
				table.insert(allShaders,clone)
				engineApplyShaderToWorldTexture ( clone, string.format( "%c*", c + 32 )  )
				--engineRemoveShaderFromWorldTexture ( clone, "tx*" )	-- Skip doing the grass
				shaderList[#shaderList+1] = clone
			end

			-- Initial colors
			colorize()

			--outputChatBox( "Press 'k' to colorize" )
		end
		on=true
	end
end
--addCommandHandler("effekt",coloroff)


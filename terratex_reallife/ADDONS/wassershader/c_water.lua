--
-- c_water.lua
--
local wassershader=false
addEventHandler( "onClientResourceStart", resourceRoot,
	function()

		-- Version check
		if getVersion ().sortable < "1.1.0" then
			outputChatBox( "Resource is not compatible with this client." )
			return
		end

		-- Create shader
		local myShader, tec = dxCreateShader ( "ADDONS/wassershader/water.fx" )
		wassershader=myShader
		if not myShader then
			outputChatBox( "Could not create shader. Please use debugscript 3" )
		else
			--outputChatBox( "Using technique " .. tec )

			-- Set textures
			local textureVol = dxCreateTexture ( "ADDONS/wassershader/images/smallnoise3d.dds" );
			local textureCube = dxCreateTexture ( "ADDONS/wassershader/images/cube_env256.dds" );
			dxSetShaderValue ( myShader, "sRandomTexture", textureVol );
			dxSetShaderValue ( myShader, "sReflectionTexture", textureCube );

			-- Apply to global txd 13
			--engineApplyShaderToWorldTexture ( myShader, "waterclear256" )

			-- Update water color incase it gets changed by persons unknown
			setTimer(	function()
							if myShader then
								local r,g,b,a = getWaterColor()
								dxSetShaderValue ( myShader, "sWaterColor", r/255, g/255, b/255, a/255 );
							end
						end
						,100,0 )
		end
	end
)
function setWaterShader(bool)
	if(bool)then
		engineApplyShaderToWorldTexture ( wassershader, "waterclear256" )
	else
		engineRemoveShaderFromWorldTexture ( wassershader, "waterclear256" )
	end
end

--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchCarPaintReflectLite", root, true )
--
--	To switch off:
--			triggerEvent( "switchCarPaintReflectLite", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------
--addEventHandler( "onClientResourceStart", getResourceRootElement( getThisResource()),
--	function()
--		outputDebugString('/sCarReflectLite to switch the effect')
--		triggerEvent( "switchCarPaintReflectLite", resourceRoot, true )
--		addCommandHandler( "sCarReflectLite",
--			function()
--				triggerEvent( "switchCarPaintReflectLite", resourceRoot, not cprlEffectEnabled )
--			end
--		)
--	end
--)
--

--------------------------------
-- Switch effect on or off
--------------------------------
function switchCarPaintReflectLite( cprlOn )
	outputDebugString( "switchCarPaintReflectLite: " .. tostring(cprlOn) )
	if cprlOn then
		startCarPaintReflectLite()
	else
		stopCarPaintReflectLite()
	end
end

addEvent( "switchCarPaintReflectLite", true )
addEventHandler( "switchCarPaintReflectLite", resourceRoot, switchCarPaintReflectLite )

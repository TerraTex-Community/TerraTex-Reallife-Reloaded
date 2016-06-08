--
-- c_switch.lua
--

----------------------------------------------------------------
----------------------------------------------------------------
-- Effect switching on and off
--
--	To switch on:
--			triggerEvent( "switchRadialBlur", root, true )
--
--	To switch off:
--			triggerEvent( "switchRadialBlur", root, false )
--
----------------------------------------------------------------
----------------------------------------------------------------

--------------------------------
-- onClientResourceStart
--		Auto switch on at start
--------------------------------
--[[
addEventHandler( "onClientResourceStart", resourceRoot,
	function()
		triggerEvent( "switchRadialBlur", resourceRoot, true )
	end


--------------------------------
-- Command handler
--		Toggle via command
--------------------------------
addCommandHandler( "radialblur",
	function()
		triggerEvent( "switchRadialBlur", resourceRoot, not bEffectEnabled )
	end
)

]]
--------------------------------
-- Switch effect on or off
--------------------------------
function switchRadialBlur( bOn , bValue)
	--outputDebugString( "switchRadialBlur: " .. tostring(bOn) )
	if bOn then
		disableRadialBlur()
		enableRadialBlur(bValue)
	else
		disableRadialBlur()
	end
end

addEvent( "switchRadialBlur", true )
addEventHandler( "switchRadialBlur", resourceRoot, switchRadialBlur )

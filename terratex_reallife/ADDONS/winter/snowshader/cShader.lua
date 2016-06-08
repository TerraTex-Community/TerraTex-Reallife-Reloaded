--[[*******************************************************************
*	Ground snow shader
*
*	@author:	John Lillis <JohnMichaelFFS@gmail.com>
*				ccw <>
*	@license:	See INFO.rtf in the main resource directory.
*********************************************************************]]
local isEffectEnabled, maxEffectDistance, updateTimer = false, getFarClipDistance()
local snowShader, treeShader, naughtyTreeShader, noiseTexture

--List of textures to apply the shader to
local snowApplyList = {
	"*",				-- Everything!
}

--List of textures to remove the shader from
local snowRemoveList = {
	"",												-- unnamed

	"vehicle*", "?emap*", "?hite*",					-- vehicles
	"*92*", "*wheel*", "*interior*",				-- vehicles
	"*handle*", "*body*", "*decal*",				-- vehicles
	"*8bit*", "*logos*", "*badge*",					-- vehicles
	"*plate*", "*sign*",							-- vehicles
	"headlight", "headlight1",						-- vehicles

	"shad*",										-- shadows
	"coronastar",									-- coronas
	"tx*",											-- grass effect
	"lod*",											-- lod models
	"cj_w_grad",									-- checkpoint texture
	"*cloud*",										-- clouds
	"*smoke*",										-- smoke
	"sphere_cj",									-- nitro heat haze mask
	"particle*",								-- particle skid and maybe others
	"bobo*",
	"prolaps*",
	"homies*",
	"diderSachs*",
	"eris*",
	"hardon*",
	"cokopops*",
	"semi1Dirty",
	"semi2Dirty",
	"semi3Dirty",
	"bobobillboard*",
	"SunBillB*",
	"*water*"
	--"*water*", "sw_sand", "coral",					-- sea
}

--Special tree texture lists
local treeApplyList = {
	"sm_des_bush*", "*tree*", "*ivy*", "*pine*",	-- trees and shrubs
	"veg_*", "*largefur*", "hazelbr*", "weeelm",
	"*branch*", "cypress*",
	"*bark*", "gen_log", "trunk5",
	"bchamae", "vegaspalm01_128",
}
local naughtyTreeApplyList = {
	"planta256", "sm_josh_leaf", "kbtree4_test", "trunk3",					-- naughty trees and shrubs
	"newtreeleaves128", "ashbrnch", "pinelo128", "tree19mi",
	"lod_largefurs07", "veg_largefurs05","veg_largefurs06",
	"fuzzyplant256", "foliage256", "cypress1", "cypress2",
}

--This function enables the shader. Returns true if successfull, false otherwise.
local function enableShader()
	if isEffectEnabled then
		return false
	end
	
	if tonumber(dxGetStatus().VideoCardPSVersion) < 2.0 then
		return false
	end
	
	--Create shaders
	snowShader = dxCreateShader ("ADDONS/winter/snowshader/snow_ground.fx", 0, maxEffectDistance)
	treeShader = dxCreateShader("ADDONS/winter/snowshader/snow_trees.fx" )
	naughtyTreeShader = dxCreateShader("ADDONS/winter/snowshader/snow_naughty_trees.fx")
	noiseTexture = dxCreateTexture("ADDONS/winter/snowshader/smallnoise3d.dds")
	
	if not snowShader or not treeShader or not naughtyTreeShader or not noiseTexture then
		return false
	end

	--Set shader values.
	dxSetShaderValue(treeShader, "sNoiseTexture", noiseTexture)
	dxSetShaderValue(naughtyTreeShader, "sNoiseTexture", noiseTexture)
	dxSetShaderValue(snowShader, "sNoiseTexture", noiseTexture)
	dxSetShaderValue(snowShader, "sFadeEnd", maxEffectDistance)
	dxSetShaderValue(snowShader, "sFadeStart", maxEffectDistance - getFogDistance())
	
	--Process texture lists.
	for _,applyMatch in ipairs(snowApplyList) do
		engineApplyShaderToWorldTexture(snowShader, applyMatch)
	end
	for _,removeMatch in ipairs(snowRemoveList) do
		engineRemoveShaderFromWorldTexture(snowShader, removeMatch)
	end
	for _,applyMatch in ipairs(treeApplyList) do
		engineApplyShaderToWorldTexture(treeShader, applyMatch)
	end
	for _,applyMatch in ipairs(naughtyTreeApplyList) do
		engineApplyShaderToWorldTexture(naughtyTreeShader, applyMatch)
	end
	
	
	
	updateTimer = setTimer(processShader, 2500, 0)
	
	isEffectEnabled = true
	return true
end
addEventHandler("onClientResourceStart", resourceRoot, enableShader)

--This function disables the shader.
local function disableShader()
	if not isEffectEnabled then
		return false
	end

	if isElement(snowShader) then
		destroyElement(snowShader)
		destroyElement(treeShader)
		destroyElement(naughtyTreeShader)
		destroyElement(noiseTexture)
	end
	
	resetSkyGradient()
	
	if isTimer(updateTimer) then
		killTimer(updateTimer)
	end
	
	isEffectEnabled = false
	return true
end
addEventHandler("onClientResourceStop", resourceRoot, disableShader)

--This function ensures the max-distance of the shader is always correct.
function processShader()
	if maxEffectDistance ~= getFarClipDistance() then
		maxEffectDistance = getFarClipDistance()
		dxSetShaderValue(snowShader, "sFadeEnd", maxEffectDistance)
		dxSetShaderValue(snowShader, "sFadeStart", maxEffectDistance - getFogDistance())
	end
end

--This function sets the shader status. EXPORTED!
function setShaderEnabled(doEnableShader)
	if doEnableShader then
		outputChatBox("Um den Wintermode richtig nutzen zu können, stelle 'sunshine-effekt' und 'neue Details' aus")
		return enableShader()
	else
		return disableShader()
	end
end
function switchWinterMode()
	setShaderEnabled(not(isShaderEnabled()))
	outputChatBox("Wintermodus geändert")
end
addCommandHandler("winter",switchWinterMode,false,false)

function onClientResourceStart_winter()
	outputChatBox("Um den Wintermode richtig nutzen zu können, stelle 'sunshine-effekt' und 'neue Details' aus",160,0,160)
	outputChatBox("Wintermodus aus und an schalten mit /winter",160,0,160)
	outputChatBox("Schneefallmodus aus und ein schalten mit /snow",160,0,160)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),onClientResourceStart_winter)



--This function returns true if the shader is enabled, false otherwise.
function isShaderEnabled()
	return (isEffectEnabled and isElement(snowShader))
end
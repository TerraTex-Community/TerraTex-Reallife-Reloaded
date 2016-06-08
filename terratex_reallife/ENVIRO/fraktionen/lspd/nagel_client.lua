
local newAlkaRockets={
    {3405.7109375,-2.2666015625,12.309700012207,12}, --groß
    {3425.40234375,207.484375,12.309700012207,12}, --groß
    {3371.58984375,149.3427734375,29.97260093689,4},
    {3372.4208984375,28.4208984375,29.965999603271,4},
    {3393.990234375,38.349609375,18.497400283813,4},
    {3393.310546875,135.69921875,18.47739982605,4},
    {3309.9599609375,64.12109375,21.884399414063,4},
    {3309.7783203125,90.353515625,22.60000038147,4},
    {3378.95703125,229.3701171875,22.759199142456,4},
    {3535.0048828125,176.3916015625,18.78809928894,4},
    {3538.716796875,53.8876953125,16.144800186157,4},
    {3481.974609375,-46.3369140625,20.295600891113,4},
}


local alkashape = false
function erhalteAlkaShapeData(aasd)
	alkashape = aasd
end
addEvent("alka_shape", true)
addEventHandler("alka_shape", getRootElement(), erhalteAlkaShapeData)

local wasInAlkaShape = false
function onAlkaShapeChange()
	if (alkashape) then
		local x, y, z = getElementPosition(getLocalPlayer())
		if (isInsideRadarArea(alkashape, x, y)) then
			if not (wasInAlkaShape) then
				wasInAlkaShape = true
				triggerServerEvent("onColShapeHit_alka", alkashape, getLocalPlayer())
			end
		else
			wasInAlkaShape = false
		end	
	end
end
addEventHandler("onClientRender", getRootElement(), onAlkaShapeChange)

addEvent("shootAlka", true)
function shootAlka_func()

    for theKey, theTable in ipairs(newAlkaRockets)do
        createProjectile(getLocalPlayer(), 20 ,theTable[1], theTable[2], theTable[3] + theTable[4], 200, source, 90, 0, 0 )
    end

	setTimer(shootAlka_func_mor, 1000, 1, source)
	setTimer(shootAlka_func_mor, 2000, 1, source)
	setTimer(shootAlka_func_mor, 3000, 1, source)
end
addEventHandler("shootAlka", getRootElement(), shootAlka_func)

function shootAlka_func_mor(source)
	if (isElement(source)) then
        for theKey, theTable in ipairs(newAlkaRockets)do
            createProjectile(getLocalPlayer(), 20 ,theTable[1], theTable[2], theTable[3] + theTable[4], 200, source, 90, 0, 0 )
        end
	end
end











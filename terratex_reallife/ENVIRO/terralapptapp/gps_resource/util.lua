local CRs = {}

local _resume = coroutine.resume
function coroutine.resume(cr, ...)
	if(cr)then
		local ret = { _resume(cr, ...) }
		if coroutine.status(cr) == 'dead' then
			CRs[CRs[cr]] = nil
			CRs[cr] = nil
		end
		if not ret[1] then
			--outputDebugString(ret[2], 1)
			return false
		end
		table.remove(ret, 1)
		return unpack(ret)
	end
end

local serverMT = {}
function serverMT:__index(fnName)
	return function(...)
		triggerServerEvent('onServerCallback', getLocalPlayer(), CRs[coroutine.running()], fnName, ...)
		return coroutine.yield()
	end
end
server = setmetatable({}, serverMT)

addEvent('onServerCallbackReply', true)
addEventHandler('onServerCallbackReply', getResourceRootElement(getThisResource()),
	function(crID, ...)
		coroutine.resume(CRs[crID], ...)
	end,
	false
)

local function wrapHandler(fn)
	return function(...)
		local cr = coroutine.create(fn)
		local id = #CRs + 1
		CRs[id] = cr
		CRs[cr] = id
		coroutine.resume(cr, ...)
	end
end

function addGpsEventHandler(event, elem, fn, getPropagated)
    if(not isElement(elem))then
        outputDebugString("ErrorHelp addEventHandler: "..debug.traceback())
    end
	return addEventHandler(
		event,
		elem,
		(event == 'onClientRender' or event == 'onClientPreRender') and fn or wrapHandler(fn),
		getPropagated
	)
end

function addGpsCommandHandler(command, fn)
	return addCommandHandler(command, wrapHandler(fn))
end

function table.merge_gps ( ... )
	local ret = { }
	
	for index, tbl in ipairs ( {...} ) do
		for index, val in ipairs ( tbl ) do
			table.insert ( ret, val )
		end
	end
	
	return ret
end







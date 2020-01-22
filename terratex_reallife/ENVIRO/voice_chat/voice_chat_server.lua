function userJoinedServer_prepare()
    setPlayerVoiceIgnoreFrom ( source, nil)
    setPlayerVoiceBroadcastTo ( source, getRootElement() )
end
addEventHandler("onPlayerJoin", getRootElement(), userJoinedServer_prepare)

-- talking events setElementData isTalking
function startTalking()
    setElementData(source, "isTalking", "true")
end
addEventHandler("onPlayerVoiceStart", getRootElement(), startTalking)

function stopTalking()
    setElementData(source, "isTalking", "false")
end
addEventHandler("onPlayerVoiceStop", getRootElement(), stopTalking)

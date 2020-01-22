function userJoinedServer_prepare()
    setPlayerVoiceIgnoreFrom ( source, nil)
    setPlayerVoiceBroadcastTo ( source, getRootElement() )
end
addEventHandler("onPlayerJoin", getRootElement(), userJoinedServer_prepare)

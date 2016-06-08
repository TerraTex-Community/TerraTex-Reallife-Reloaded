addEvent("setAtomKatastropheClient",true)
atomkatastrophe=false
function setAtomKatastropheClient_func(status)	
	atomkatastrophe=status
end
addEventHandler("setAtomKatastropheClient",getRootElement(),setAtomKatastropheClient_func)









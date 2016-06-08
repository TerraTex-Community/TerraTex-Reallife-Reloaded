local notizpath="notizen.txt"

addEventHandler("onClientResourceStart",resourceRoot,
    function()
        Notizblock_Window = {}
        Notizblock_Button = {}
        Notizblock_Memo = {}

        Notizblock_Window[1] = guiCreateWindow(590,248,573,488,"Notiz",false)
        Notizblock_Button[1] = guiCreateButton(27,36,167,32,"RESET",false,Notizblock_Window[1])
        Notizblock_Button[2] = guiCreateButton(200,36,167,32,"Speichern und Beenden",false,Notizblock_Window[1])
        Notizblock_Memo[1] = guiCreateMemo(26,78,534,393,"",false,Notizblock_Window[1])
		
		addEventHandler("onClientGUIClick",Notizblock_Button[2],closeNotiz,false)
		addEventHandler("onClientGUIClick",Notizblock_Button[1],resetNotiz,false)
		guiSetVisible(Notizblock_Window[1],false)
		
		if not(fileExists ( notizpath ))then
			fileCreate(notizpath)
			fileClose(notizpath)
		end
    end
)
function resetNotiz()
	guiSetText(Notizblock_Memo[1],"")
end

function showNotiz()
	guiSetText(Notizblock_Memo[1],"")
	local hFile = fileOpen(notizpath)       
	if hFile then                                 
		local buffer
		while not fileIsEOF(hFile) do             
			buffer = fileRead(hFile, 500)          
			guiSetText(Notizblock_Memo[1],guiGetText(Notizblock_Memo[1])..buffer)   
		end
		fileClose(hFile)                           
	end
	guiSetVisible(Notizblock_Window[1],true)
end


function closeNotiz()
	local savestring=guiGetText(Notizblock_Memo[1])
	fileDelete(notizpath)
	local file=fileCreate(notizpath)
	fileWrite(file,savestring)
	fileClose(file)
	guiSetVisible(Notizblock_Window[1],false)
end









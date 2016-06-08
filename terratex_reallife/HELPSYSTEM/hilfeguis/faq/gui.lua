
f1_faq = {
    window = {},
    scrollpane = {},
    staticimage = {},
    label = {}
}





addEventHandler("onClientResourceStart", getRootElement(),
    function()
        f1_faq.window[1] = guiCreateWindow(253, 183, 600, 535, "FAQ", false)
        guiWindowSetSizable(f1_faq.window[1], false)

        f1_faq.scrollpane[1] = guiCreateScrollPane(11, 27, 579, 498, false, f1_faq.window[1])

		triggerServerEvent("sendMeFAQ",getLocalPlayer())
		
		guiSetVisible(f1_faq.window[1],false)
		f1_menu.functions.addButton("FAQ",f1_faq.window[1])	
    end
)

addEvent("addFAQ",true)
function addFAQ_func(rules)
	local calcHeight=0
	for theKeyName,theKategorie in ipairs(rules)do
		f1_faq.label[1] = guiCreateLabel(0, calcHeight, 350, 15, theKategorie["title"], false, f1_faq.scrollpane[1])
		guiSetFont(f1_faq.label[1], "default-bold-small")
		calcHeight=calcHeight+16
		
		for theKey, theRule in ipairs(theKategorie["rules"])do
			f1_faq.label[2] = guiCreateLabel(0, calcHeight, 15, 15, "->", false, f1_faq.scrollpane[1])
			guiSetFont(f1_faq.label[2], "default-bold-small")	
			
		
			f1_faq.label[4] = guiCreateLabel(15, calcHeight, 530, 14, theRule["text"], false, f1_faq.scrollpane[1])						
			calcHeight=calcHeight+resizeHeight(f1_faq.label[4])
			guiLabelSetHorizontalAlign(f1_faq.label[4], "left", true)
			
			guiLabelSetColor ( f1_faq.label[2] ,255,0,0)
			guiLabelSetColor ( f1_faq.label[4] ,255,0,0)
		
			
				
			f1_faq.label[5] = guiCreateLabel(0, calcHeight, 30, 15, "--->", false, f1_faq.scrollpane[1])
			guiSetFont(f1_faq.label[5], "default-bold-small")
			
	
			f1_faq.label[6] = guiCreateLabel(30, calcHeight, 515, 14, theRule["answer"], false, f1_faq.scrollpane[1])
			calcHeight=calcHeight+resizeHeight(f1_faq.label[6])+5
			guiLabelSetHorizontalAlign(f1_faq.label[6], "left", true)
			
			guiLabelSetColor ( f1_faq.label[5] ,0,255,0)
			guiLabelSetColor ( f1_faq.label[6] ,0,255,0)
			
		
		end	
		
		f1_faq.staticimage[1] = guiCreateStaticImage(9, calcHeight, 546, 2, "FILES/IMAGES/f1/dot_white.png", false, f1_faq.scrollpane[1]) 
		calcHeight=calcHeight+5
	end
end
addEventHandler("addFAQ",getRootElement(),addFAQ_func)










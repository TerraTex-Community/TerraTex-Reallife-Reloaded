
f1_welcome = {
    window = {},
    staticimage = {},
    label = {}
}
addEventHandler("onClientResourceStart", getRootElement(),
    function()
        f1_welcome.window[1] = guiCreateWindow(253, 183, 600, 535, "Willkommen auf TerraTex!", false)
        guiWindowSetSizable(f1_welcome.window[1], false)

        f1_welcome.staticimage[1] = guiCreateStaticImage(18, 33, 561, 95, "FILES/IMAGES/header.png", false, f1_welcome.window[1])
        f1_welcome.staticimage[2] = guiCreateStaticImage(410, 356, 169, 169, "FILES/IMAGES/f1/ttlogo_q.png", false, f1_welcome.window[1])
        f1_welcome.label[1] = guiCreateLabel(18, 194, 561, 178, "Wir freuen uns dich hier begrüßen zu dürfen!\n\nDies ist ein Reallife-Server. Hier geht es darum, so realitätsnah wie möglich zu spielen. Natürlich ist Spaß wichtig, aber den sollen alle haben. Um das zu gewährleisten halte dich bitte an ALLE geltenden Regeln. Nachlesen kannst du Sie hier im GUI (aufrufbar mit F1) unter dem Button 'Regeln'.\n\nWenn du Hilfe benötigst schau in dieses Hilfe GUI und wähle einen entsprechenden Menüpunkt aus. Dort werden alle wichtigen Dinge erklärt. Für Fragen gibt es viele Hilfsbereite User.  Solltest du dennoch nicht weiterkommen,  kannst du uns natürlich auch unter /report erreichen. Bitte bedenke, dass wir sehr viele Anfragen bekommen und es daher auch etwas dauern kann. ", false, f1_welcome.window[1])
        guiLabelSetHorizontalAlign(f1_welcome.label[1], "left", true)
        f1_welcome.label[2] = guiCreateLabel(18, 137, 561, 47, "WILLKOMMEN AUF "..string.upper(config["communityname"]).."!", false, f1_welcome.window[1])
        local font_0 = guiCreateFont("FILES/FONTS/taho.ttf",24)
        guiSetFont(f1_welcome.label[2], font_0)
        guiLabelSetHorizontalAlign(f1_welcome.label[2], "left", true)
        
        local WelcomeCredits=""
        
        WelcomeCredits=WelcomeCredits.."Kontakt:\n\nInhaber: "..config["owner"]
        WelcomeCredits=WelcomeCredits.."\nE-Mail: "..config["supportmail"]
        WelcomeCredits=WelcomeCredits.."\n\nForum: "..config["maindomain"]
	WelcomeCredits=WelcomeCredits.."\nBugtracker: "..config["bugdomain"]
        
        WelcomeCredits=WelcomeCredits.."\n\n Dieses Script basiert auf dem TerraTex Reallife Script. Das TerraTex Reallife Script von Colin Weber (http://terratex.eu) ist lizenziert unter einer Creative Commons Namensnennung-Nicht kommerziell 4.0 International Lizenz."
        
        f1_welcome.label[3] = guiCreateLabel(18, 382, 386, 143, WelcomeCredits, false, f1_welcome.window[1])    
		
		guiSetVisible(f1_welcome.window[1],false)

		
		f1_menu.functions.addButton("Willkommen",f1_welcome.window[1])	
    end
)










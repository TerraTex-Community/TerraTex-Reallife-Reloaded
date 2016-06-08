addEvent("give_Pokal_Money",true)
function give_Money_Pokal()
    changePlayerMoney(source,500,"sonstiges","Pokal erhalten")
	outputChatBox("Du erhälst für ein geschaften Erfolg 500$",source,0,255,0)
end
addEventHandler("give_Pokal_Money",getRootElement(),give_Money_Pokal)









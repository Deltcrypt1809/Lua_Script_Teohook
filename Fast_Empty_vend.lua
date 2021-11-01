function vend(varlist)
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|vending") then
        pkt = string.format([[action|dialog_return
            dialog_name|vending
            tilex|%d|
            tiley|%d|
            buttonClicked|pullstock
            ]], varlist[1]:match("embed_data|tilex|(%d+)"), varlist[1]:match("embed_data|tiley|(%d+)"))
    
        sendPacket(false, pkt, 2)
        return true
    end
end

addHook("OnVarlist", "emptyvend", vend)





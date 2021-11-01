function sign(varlist)
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|sign_edit") then
        pkt = string.format([[action|dialog_return
dialog_name|sign_edit
tilex|%d|
tiley|%d|
sign_text|`2Join to TheC0mpany Discord Server: `whttps://discord.gg/5fpyrWcnhQ
]], varlist[1]:match("embed_data|tilex|(%d+)"), varlist[1]:match("embed_data|tiley|(%d+)"))

        sendPacket(false, pkt, 2)
        return true
    end
end

addHook("OnVarlist", "fastsign", sign)

function hook(varlist)
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|password_reply") then
        return true
    end
end

addHook(5, "hook_type_2", hook)

amount = 30 --amount

for i = 1,amount do
    sleep(30)
    pkt = {}
    pkt.type = 7
    pkt.int_x = getLocal().tile.x
    pkt.int_y = getLocal().tile.y
    sendPacketRaw(false,pkt)
    sendPacket(false,"action|dialog_return\ndialog_name|password_reply\ntilex|"..tostring(getLocal().tile.x).."|\ntiley|"..tostring(getLocal().tile.y).."|\npassword|"..tostring(i),2) 
end


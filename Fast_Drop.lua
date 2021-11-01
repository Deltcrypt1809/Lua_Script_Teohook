function hook2(varlist)
if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|drop_item") then
pkt = string.format([[action|dialog_return
dialog_name|drop_item
itemID|%d|
count|%d
]], varlist[1]:match("itemID|(%d+)"), varlist[1]:match("count||(%d+)"))

sendPacket(false, pkt, 2)
return true
end
end

addHook("OnVarlist", "fastdrop", hook2)



function retrieve(varlist)
if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|itemremovedfromsucker|Close|Retrieve|") then
pkt = string.format([[action|dialog_return
dialog_name|itemremovedfromsucker
tilex|%d|
tiley|%d|
itemtoremove|200
]], varlist[1]:match("tilex|(%d+)"),varlist[1]:match("tiley|(%d+)"), varlist[1]:match("itemtoremove|(%d+)"))

sendPacket(false, pkt, 2)
return true
end
end

addHook("OnVarlist", "fastretrieve", retrieve)


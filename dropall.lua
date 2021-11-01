function hook(varlist)
if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|drop_item") then
return true
end
end

addHook(5, "hook_type_5", hook)

for k,v in ipairs(getInventory()) do
sendPacket(false,"action|drop\n|itemID|"..v.id,2)
sendPacket(false,"action|dialog_return\ndialog_name|drop_item\nitemID|"..v.id.."|\ncount|"..v.count,2)
end

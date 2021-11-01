function hook(varlist)
if varlist[1]:find("add_button|report_player|") then
sendPacket(false, "action|dialog_return\ndialog_name|popup\nnetID|"..varlist[1]:match("netID|(%d+)").."|\nnetID|"..varlist[1]:match("netID|(%d+)").."|\nbuttonClicked|pull",2)
return true
end
end

addHook("OnVarlist", "hook_type_5", hook)

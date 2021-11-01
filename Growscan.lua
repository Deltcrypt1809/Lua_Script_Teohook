droppedshit = "add_spacer|small|"
for _,object in pairs(getObjects()) do
droppedshit = droppedshit.."\nadd_label_with_icon|small|`o: "..getItemInfo(object.id).name..":"..object.count.."``|left|"..tostring(object.id)
end
varlist = {}
varlist[0] = "OnDialogRequest"
varlist[1] = "set_default_color|`o\nadd_label_with_icon|big|Growscan``|left|6016\n"..droppedshit.."\nadd_quick_exit"
sendVarlist(varlist)

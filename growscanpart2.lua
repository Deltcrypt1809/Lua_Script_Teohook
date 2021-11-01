placedshit = "add_spacer|small|"
for _,tile in pairs(getTiles()) do
if tile.fg ~= 0 then
placedshit = placedshit.."\nadd_label_with_icon|small|`oitemid: "..tostring(tile.fg).."``|left|"..tostring(tile.fg)
end
end
varlist = {}
varlist[0] = "OnDialogRequest"
varlist[1] = "set_default_color|`o\nadd_label_with_icon|big|Growscan``|left|6016\n"..placedshit.."\nadd_quick_exit"
sendVarlist(varlist)

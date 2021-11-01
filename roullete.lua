
function hook(vlist)
vlist.delay = 0
sendVarlist(vlist)
return true
end

addHook("OnVarlist", "system speed", hook)

messagetext = "Test AutoMessage";

function proautomsgnocap(varlist)
	if varlist[0]:find("OnSpawn") then
		a = varlist[1]:gsub("`", "")
		name = a:match("name|(%a+%d+)")
		sendPacket(false, "action|input\n|text|/msg /"..string.sub(name,2).. " ".. messagetext,2)
		return false
	end
end
addHook("OnVarlist", "dawdawfger", proautomsgnocap)

--[[
spawn|avatar
netID|1
userID|43517446
colrect|0|0|20|30
posXY|160|448
name|`wHZID66``
country|il
invis|0
mstate|0
smstate|0
onlineID|
type|local
]]



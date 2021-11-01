function hook(packet, type)
if packet:find("action|input") then
text = packet:gsub("action|input\n|text|", "")
if text:find("/") then
cmd = text:gsub("/", "")
if cmd:find("warp ") then
world = cmd:gsub("warp ", "")
log("`2warping to "..world)
sendPacket(false, "action|join_request\nname|"..world, 3)
return true
end
end
end
end

addHook("Packet", "cmdhook", hook)

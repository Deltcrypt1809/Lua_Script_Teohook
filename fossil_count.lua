count = 0
for _, tile in pairs(getTiles()) do
if tile.fg == 3918 then
count = count + 1
end
end

sendPacket(false, "action|input\n|text|there is "..count.." fossils in this world", 2)

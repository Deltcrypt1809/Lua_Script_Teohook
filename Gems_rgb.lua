removeHooks()

col = {}
col.x = 0
col.y = 0
col.z = 1

r = 255
g = 0
b = 0

m = 0

function hook()
if m == 0 then
 g = g + 2.5
 if g == 255 then
  m = 1
 end
elseif m == 1 then
 r = r - 2.5
 if r == 0 then
  m = 2
 end
elseif m == 2 then
 b = b + 2.5
 if b == 255 then
  m = 3
 end
elseif m == 3 then
 g = g - 2.5
 if g == 0 then
  m = 4
end
elseif m == 4 then
 r = r + 2.5
 if r == 255 then
  m = 5
 end
elseif m == 5 then
 b = b - 2.5
 if b == 0 then
  m = 0
 end
end

col.x = r / 255
col.y = g / 255
col.z = b / 255

count = 0
for _, obj in pairs(getObjects()) do
if obj.id == 112 then
count = count + obj.count
end
end
drawText(10, 100, tostring(count).." Gems", col)
end

addHook("render", "gemesp", hook)

function poggies(packet, type)
if packet:find("action|quit_to_exit") then
removeHook("gemesp")
--removeHook("lmao")
end
end

function hook2(pkt, type)
if pkt:find("entered. There are") then
addHook("render", "gemesp", hook)
--addHook("Render", "lmao", rendrect)
end
end

function hook3(vlist)
if vlist[0]:find("OnRequestWorldSelectMenu") then
removeHook("gemesp")
--removeHook("lmao")
end
end

--[[function rendrect()
drawRect(62, 100, 5, 115, col)
end

--addHook("Render", "lmao", rendrect)]]
addHook("OnVarlist", "lop", hook3)
addHook("OnPacket", "lel", hook2)
addHook("Packet", "testoff", poggies)







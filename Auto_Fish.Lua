enabled = false
itemid = 2914-- your bait itemid here

function hook1(packet, type)
if packet:find("!start") then
enabled = true
return true
end
if packet:find("!stop") then
enabled = false
return true
end
end
addHook("Packet", "startstop", hook1)

function place_tile (x,y)
pkt = {}
pkt.type = 3
pkt.int_data = itemid
pkt.pos_x = getLocal().pos.x
pkt.pos_y = getLocal().pos.y
pkt.int_x = x
pkt.int_y = y
sendPacketRaw(false, pkt)
end

while true do
if enabled == true then
place_tile(findPath(58,23))
end

addHook("RawPacket", "autofish", hook)
function hook (packet)
if packet.type == 31 then
place_tile(findPath(58,23))
sleep(100)
end
end

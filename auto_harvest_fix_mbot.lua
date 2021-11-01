for _, tile in pairs(getTiles()) do
if tile.fg == 880 then
findPath(tile.pos.x, tile.pos.y)
sleep(200)
pkt = {}
pkt.type = 3
pkt.int_data = 18
pkt.pos_x = getLocal().pos.x
pkt.pos_y = getLocal().pos.y
pkt.int_x = tile.pos.x
pkt.int_y = tile.pos.y
sendPacketRaw(pkt)
end
end

function collectItems()
    pos = getLocal().pos
    for _, obj in pairs(getObjects()) do
        posx = math.abs(pos.x - obj.pos.x)
        posy = math.abs(pos.y - obj.pos.y)
        if posx < 100 and posy < 100 then
            pkt = {}
            pkt.type = 11
            pkt.int_data = obj.oid
            pkt.pos_x = obj.pos.x
            pkt.pos_y = obj.pos.y
            sendPacketRaw(pkt)
            sleep(10)
        end
    end
end

collectItems()

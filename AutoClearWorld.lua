breaklmao = true;

function break_tile(x, y)
    id = getTile(x, y)
    if id ~= 0 then
        hit_tile(x, y)
        sleep(40)
        id = getTile(x, y)
        sleep(40)
    end
end

function CheckCaveBackground()
    for __, tile in pairs(getTiles()) do
        if tile.fg ~= 8 then
        if  tile.fg == 2 or tile.bg == 14 then
            if getTile(tile.pos.x, tile.pos.y - 1).fg == 0 then
            findPath(tile.pos.x, tile.pos.y - 1)
            sleep(90)
            break_tile(tile.pos.x, tile.pos.y)
            return true
        else if getTile(tile.pos.x, tile.pos.y - 1).fg == 0  then
            findPath(tile.pos.x, tile.pos.y - 1)
            sleep(90)
            break_tile(tile.pos.x, tile.pos.y)
            return true
        end
        end
    end
        end
    end
    return false
end

function hit_tile(x, y)
    pkt = {}
    pkt.type = 3
    pkt.int_data = 18
    pkt.int_x = x
    pkt.int_y = y
    pkt.pos_x = getLocal().pos.x
    pkt.pos_y = getLocal().pos.y
    --sendPacketRaw(false, pkt)
    sendPacketRaw(pkt)
end
function main()
while breaklmao do
breaking = true
--sleep(40)
while breaking do
breaking = CheckCaveBackground()
end
end
end
main()

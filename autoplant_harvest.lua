--Auto Plant
mode = "plant"
seedid = 881 --ur tree id/seed id

function findpathnocrash(x, y)
findPath(x,y)
sleep(100)
end

function findItem(id)
    for _, itm in pairs(getInventory()) do
        if itm.id == id then
            return itm.count
        end    
    end
    return 0
end

function place_tile(x, y, id)
    pkt = {}
    pkt.type = 3
    pkt.int_data = id
    pkt.int_x = x
    pkt.int_y = y
    pkt.pos_x = getLocal().pos.x
    pkt.pos_y = getLocal().pos.y
    sleep(120)
    sendPacketRaw(false, pkt)
end

planting = true
startx = 0
starty = 0

function hook(packet, type)
if packet:find("!stop") then
planting = false
log("stopped")
end
end

function autoplant()
addHook("Packet", "stop", hook)
startx = getLocal().pos.x / 32
starty = getLocal().pos.y / 32
while planting do
if mode == "plant" then
for _, tile in pairs(getTiles()) do
        if tile.fg ~= 0 then
            if getTile(tile.pos.x, tile.pos.y - 1).fg == 0 then
            if findItem(seedid) < 5 then
                findpathnocrash(startx, starty)
                sleep(1000)
            else
                findpathnocrash(tile.pos.x, tile.pos.y - 1)
                place_tile(tile.pos.x, tile.pos.y - 1, seedid)
                sleep(200)
            end
            end
        end
    end
elseif mode == "harvest" then
for _, tile in pairs(getTiles()) do
        if tile.fg ~= 0 then
            if getTile(tile.pos.x, tile.pos.y - 1).fg == seedid then
            findpathnocrash(tile.pos.x, tile.pos.y - 1)
            place_tile(tile.pos.x, tile.pos.y - 1, 18)
            sleep(200)
            end
        end
    end
end
end
    
end
autoplant()





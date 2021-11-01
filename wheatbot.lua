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
            sendPacketRaw(false, pkt)
            sleep(10)
        end
    end
end

function findItem(id)
    for _, itm in pairs(getInventory()) do
        if itm.id == id then
            return itm.count
        end    
    end
    return 0
end

function hit_tile(x, y)
    pkt = {}
    pkt.type = 3
    pkt.int_data = 18
    pkt.int_x = x
    pkt.int_y = y
    pkt.pos_x = getLocal().pos.x
    pkt.pos_y = getLocal().pos.y
    sleep(50)
    sendPacketRaw(false, pkt)
end

function place_tile(x, y, id)
    pkt = {}
    pkt.type = 3
    pkt.int_data = id
    pkt.int_x = x
    pkt.int_y = y
    pkt.pos_x = getLocal().pos.x
    pkt.pos_y = getLocal().pos.y
    sleep(50)
    sendPacketRaw(false, pkt)
end

function wrench_tile(x, y)
    pkt = {}
    pkt.type = 3
    pkt.int_data = 32
    pkt.int_x = x
    pkt.int_y = y
    pkt.pos_x = getLocal().pos.x
    pkt.pos_y = getLocal().pos.y
    sendPacketRaw(false, pkt)
end

function findEmptyPlat()
    for _, tile in pairs(getTiles()) do
        if tile.fg == 102 then
            if getTile(tile.pos.x, tile.pos.y - 1).fg == 0 then
                findPath(tile.pos.x, tile.pos.y - 1)
                --sleep(200)
                place_tile(tile.pos.x, tile.pos.y - 1, 881)
                sleep(500)
                return true
            end
        end
    end
    return false
end

function findGrassPlat()
    for _, tile in pairs(getTiles()) do
        if tile.fg == 102 then
            if getTile(tile.pos.x, tile.pos.y - 1).fg == 881 then
                findPath(tile.pos.x, tile.pos.y - 1)
                --sleep(200)
                hit_tile(tile.pos.x, tile.pos.y - 1)
                sleep(500)
                collectItems()
                return true
            end
        end
    end
    return false
end

function break_tile(x, y)
    id = getTile(x, y)
    if id ~= 0 then
        hit_tile(x, y)
        sleep(50)
        id = getTile(x, y)
        sleep(50)
    end
end

mode = 0

farming = true
harvesting = false
planting = false

startx = 0
starty = 0

function hook(packet, type)
    if packet:find("action|input") and packet:find("stop") then
        farming = false
        log("Farming stopped, wait until loop is done.")
    end
end

function hook2(vlist)
    if vlist[0]:find("OnDialogRequest") and vlist[1]:find("end_dialog|vending") then
        sendPacket(false, "action|dialog_return\ndialog_name|vending\ntilex|"..tostring(startx).."|\ntiley|"..tostring(starty).."|\nbuttonClicked|addstock", 2)
        return true
    end
end

function farmgrass()
    log("Grass farming started.")
    addHook("Packet", "stophook", hook)
    addHook("OnVarlist", "vendhook", hook2)
    startx = getLocal().pos.x / 32
    starty = getLocal().pos.y / 32
    while farming do
        findPath(startx, starty)
        sleep(30)
        if findItem(880) >= 10 then
            if findItem(881) < 100 then
                place_tile(startx - 1, starty, 880)
                sleep(50)
                break_tile(startx - 1, starty)
                collectItems()
            else
                planting = true
                while planting do
                    planting = findEmptyPlat()
                    if findItem(881) <= 10 then
                        planting = false
                    end
                end
                findPath(startx, starty)
                sleep(400)
                wrench_tile(startx, starty)
                sleep(120000)
            end
        else
            harvesting = true
            while harvesting do
                harvesting = findGrassPlat()
                if findItem(880) >= 180 then
                    harvesting = false
                end
            end
            if findItem(880) < 10 then
                planting = true
                while planting do
                    planting = findEmptyPlat()
                    if findItem(881) <= 10 then
                        planting = false
                    end
                end
                sleep(120000)
            end
        end
    end
    log("Farming stopped.")
end

farmgrass()






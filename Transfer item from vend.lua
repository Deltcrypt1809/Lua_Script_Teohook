removeHooks()
sleep(250)

local owner = "name"

local world2 = "world1"
local world = "world2"

function vend(varlist)
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|vending") then
        pkt = string.format([[action|dialog_return
            dialog_name|vending
            tilex|%d|
            tiley|%d|
            buttonClicked|pullstock
            ]], varlist[1]:match("embed_data|tilex|(%d+)"), varlist[1]:match("embed_data|tiley|(%d+)"))
    
        sendPacket(pkt, 2)
        return true
    end
end
addHook("OnVarlist", "emptyvend", vend)
function vend2(varlist)
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|vending") then
        pkt = string.format([[action|dialog_return
            dialog_name|vending
            tilex|%d|
            tiley|%d|
            buttonClicked|addstock
            ]], varlist[1]:match("embed_data|tilex|(%d+)"), varlist[1]:match("embed_data|tiley|(%d+)"))

        sendPacket(false, pkt, 2)
        return true
    end
end

function retrieveTile(x, y)
    pkt = {}
    pkt.type = 3
    pkt.int_data = 32
    pkt.int_x = x
    pkt.int_y = y
    pkt.pos_x = getLocal().pos.x
    pkt.pos_y = getLocal().pos.y
    sendPacketRaw(pkt)
end

while true do
local posvend = 0 -- set count to 0
local newposvend = 0
local vendpos = {}
local newvendpos = {}
local tilex = {}
local tiley = {}
local tilexs = {}
local tileys = {}
removeHooks()
sendPacket("action|join_request\nname|"..world2 , 3)
sleep(1000)
for _, tile in ipairs(getTiles()) do -- for each tile in the world
    if tile.fg == 2978 then -- check if tile is 3918 (fossil rock)
        table.insert(vendpos, tile.pos)
        posvend = posvend + 1 -- add 1 to the count
    end
end
sendPacket("action|input\n|text|/msg /"..owner.."`w Found "..posvend.." `2vends `win total at this world!", 2)
if posvend > 0 then
    for i = 1, posvend do
		sendPacket("action|input\n|text|/msg /"..owner.."`w Retrieving...", 2)
        findPath(vendpos[i].x, vendpos[i].y)
		tilex = getLocal().pos.x / 32
		tiley = getLocal().pos.y / 32
		sleep(1000)
		retrieveTile(tilex, tiley)
		sleep(5000)
		sendPacket(pkt, 2)
    end
end
sendPacket("action|input\n|text|/msg /"..owner.."`w Joining world...", 2)
sendPacket("action|join_request\nname|"..world , 3)
sleep(1000)
for _, tile in ipairs(getTiles()) do -- for each tile in the world
    if tile.fg == 2978 then -- check if tile is 3918 (fossil rock)
        table.insert(newvendpos, tile.pos)
        newposvend = newposvend + 1 -- add 1 to the count
    end
end
removeHooks()
addHook("OnVarlist", "addstock", vend2)
if newposvend > 0 then
    for i = 1, newposvend do
		sendPacket("action|input\n|text|/msg /"..owner.."`w Adding...", 2)
        findPath(newvendpos[i].x, newvendpos[i].y)
		tilexs = getLocal().pos.x / 32
		tileys = getLocal().pos.y / 32
		sleep(1000)
		retrieveTile(tilexs, tileys)
		sleep(5000)
		sendPacket(pkt, 2)
    end
end
end
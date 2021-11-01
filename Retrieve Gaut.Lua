removeHooks()

-- https://github.com/Deltcrypt1809 --
function dropItem(itemID, count)
    hideDrop = true
    sendPacket("action|drop\n|itemID|" .. itemID, 2)
    sendPacket("action|dialog_return\ndialog_name|drop_item\nitemID|" .. itemID .. "|\ncount|" .. count, 2)
    sleep(175)
    hideDrop = false
end

function wrenchTile(x, y)
    pkt = {}
    pkt.type = 3
    pkt.int_data = 32
    pkt.int_x = x
    pkt.int_y = y
    pkt.pos_x = getLocal().pos.x
    pkt.pos_y = getLocal().pos.y
    sendPacketRaw(pkt)
end

-- https://github.com/Deltcrypt1809 --

-- ================================ GAIA ================================ --
while true do -- loop
findPath(3,23)
wrenchTile(1, 22)

function retrieve(varlist)
if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|itemsucker_seed|Close|Update|") then
kt = string.format([[action|dialog_return
dialog_name|itemsucker_seed
tilex|%d|
tiley|%d|
buttonClicked|retrieveitem

chk_enablesucking|1
]], varlist[1]:match("tilex|(%d+)"),varlist[1]:match("tiley|(%d+)"))
sendPacket(kt, 2)
return true
end
if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|itemremovedfromsucker|Close|Retrieve|") then
pkt = string.format([[action|dialog_return
dialog_name|itemremovedfromsucker
tilex|%d|
tiley|%d|
itemtoremove|200
]], varlist[1]:match("tilex|(%d+)"),varlist[1]:match("tiley|(%d+)"), varlist[1]:match("itemtoremove|(%d+)"))

sendPacket(pkt, 2)
return true
end
end
addHook("OnVarlist", "fastretrievegaia", retrieve)

seedsID = "5667"

-- dropping seeds --
findPath(3,23) -- go to gaia
sleep(2000)
wrenchTile(1, 22) -- take seeds
findPath(3,18) -- go to position
dropItem(seedsID, 200) -- drop seeds
findPath(1,21) -- go to gaia
sleep(2000)
wrenchTile(1, 22) -- take seeds
findPath(3,17) -- go to position
dropItem(seedsID, 200) -- drop seeds
findPath(1,21) -- go to gaia
sleep(2000)
wrenchTile(1, 22) -- take seeds
findPath(3,16) -- go to position
dropItem(seedsID, 200) -- drop seeds
findPath(1,21) -- go to gaia
sleep(2000)
wrenchTile(1, 22) -- take seeds
findPath(3,15) -- go to position
dropItem(seedsID, 200) -- drop seeds
findPath(1,21)
sleep(5000)
-- dropping seeds --

-- ================================ GAIA ================================ --

removeHooks()

-- ================================ UT ================================ --
function retrieve(varlist)
if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|itemsucker_block|Close|Update|") then
kt = string.format([[action|dialog_return
dialog_name|itemsucker_block
tilex|%d|
tiley|%d|
buttonClicked|retrieveitem

chk_enablesucking|1
]], varlist[1]:match("tilex|(%d+)"),varlist[1]:match("tiley|(%d+)"))
sendPacket(kt, 2)
return true
end
if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|itemremovedfromsucker|Close|Retrieve|") then
pkt = string.format([[action|dialog_return
dialog_name|itemremovedfromsucker
tilex|%d|
tiley|%d|
itemtoremove|200
]], varlist[1]:match("tilex|(%d+)"),varlist[1]:match("tiley|(%d+)"), varlist[1]:match("itemtoremove|(%d+)"))

sendPacket(pkt, 2)
return true
end
end
addHook("OnVarlist", "fastretrieveut", retrieve)

blocksID = "5666"

-- dropping seeds --
findPath(2, 21) -- go to gaia
sleep(2000)
wrenchTile(2, 22) -- take seeds
findPath(5,18) -- go to position
dropItem(blocksID, 200) -- drop seeds
findPath(2,21) -- go to gaia
sleep(2000)
wrenchTile(2, 22) -- take seeds
findPath(5,17) -- go to position
dropItem(blocksID, 200) -- drop seeds
findPath(2,21) -- go to gaia
sleep(2000)
wrenchTile(2, 22) -- take seeds
findPath(5,16) -- go to position
dropItem(blocksID, 200) -- drop seeds
findPath(2,21) -- go to gaia
sleep(2000)
wrenchTile(2, 22) -- take seeds
findPath(5,15) -- go to position
dropItem(blocksID, 200) -- drop seeds
findPath(2,21)
sleep(5000)
end
-- dropping seeds --
-- ================================ UT ================================ --
-- ==================================================================== --
-- =====================By: Hima Mori#4188 =========================== --
-- ==================================================================== --

pathx = getLocal().pos.x / 32
pathy = getLocal().pos.y / 32
starty = getLocal().pos.y / 32
for _,cur in pairs(getInventory()) do
    if cur.id ~= 0 and cur.id ~= 32 and cur.id ~= 18  then
        if cur.id == 2 then
pktdrop = string.format([[action|drop
|itemID|%d
]], cur.id)
pktdropclick = string.format([[action|dialog_return
dialog_name|drop_item
itemID|%d|
count|%d
]],cur.id, 1)
for i=1,200 do
    if pathy < starty - 5 then
pathy = starty
pathx = pathx + 1
end
pathy = pathy - 1
        sendPacket(false, pktdrop,2)
        sleep(1)
        sendPacket(false, pktdropclick,2)
        sleep(80)
        findPath(pathx, pathy)
end
        end
    end
end

while true do
sleep(300)
for _, itm in pairs(getInventory()) do
if itm.count == 200 then
sendPacket(false, "action|drop\nitemID|"..itm.id, 2)
end
end
end

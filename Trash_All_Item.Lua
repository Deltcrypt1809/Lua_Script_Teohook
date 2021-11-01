function trashAllItems()
    for _,v in pairs(getInventory()) do
        sendPacket(false, 'action|trash\n|itemID|'..v.id, 2)
        sendPacket(false, 'action|dialog_return\ndialog_name|trash_item\nitemID|'..v.id..'|\ncount|'..v.count, 2)
        sendPacket(false, 'action|dialog_return\ndialog_name|trash_item2\nitemID|'..v.id..'|\ncount|'..v.count, 2)
    end
end

trashAllItems()

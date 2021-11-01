while true do
sendPacket(false, "action|join_request\nname|YourWorld\ninvitedWorld|0", 3) -- world to take items from
sleep(1150)
findPath(51,49) -- path of items that are dropped to move
sleep(1150)
sendPacket(false, "action|join_request\nname|Yourworld2\ninvitedWorld|0", 3)-- world to drop items in
sleep(1250)
findPath(38,23) -- path of where to drop items that were collected
sleep(500)
sendPacket(false, "action|drop\n|itemID|3004", 2) -- drop item id put it as the item u are dropping
sendPacket(false, "action|dialog_return\ndialog_name|drop_item\nitemID|881|\ncount|200", 2) -- replace item id and count with your item

function blockDropDialog(varlist)
    if varlist[0]:find("OnDialogRequest") and varlist[1]:find("end_dialog|drop_item") then
        return true
    end
end

addHook("onVarList", "drop", blockDropDialog)
end

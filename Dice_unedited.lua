function hook(packet)
if packet.type == 8 then
dice_roll = tostring(packet.count2 + 1);
log("dice number : `2"..dice_roll)
end
end

addHook(4, "allahdice", hook)

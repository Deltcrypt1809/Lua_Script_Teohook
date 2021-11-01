mode = 0
  
function hook(packet)
if packet.type == 23 then
if mode == 0 then
mode = 1
sendPacket(false, "action|setSkin\ncolor|1348237567", 2)
else
mode = 0
sendPacket(false, "action|setSkin\ncolor|3370516479", 2)
end
end
end
addHook(3, "freenpass", hook)

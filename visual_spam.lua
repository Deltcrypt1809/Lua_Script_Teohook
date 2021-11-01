spam = "d" -- what text your player will be spamming
enable = false
interval = 5000 -- interval

function hook(packet, type)
if packet:find("!start") then
enable = true
return true
end
if packet:find("!stop") then
enable = false
return true
end
end

addHook("Packet", "spammer", hook)

function say(text)
sendPacket(false, "action|input\n|text|"..text, 2)
end

while true do
if enable == true then
say(spam)
sleep(interval)
end
end





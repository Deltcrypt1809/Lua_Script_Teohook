
-- Without Name
function hook(vlist)
    if vlist[0]:find("OnConsoleMessage") then
        local name_=tostring(vlist[1]:match('`%w[%w]+'):sub(3))
        local message=tostring(vlist[1]:match('`$`$.*'):sub(5,-5))
		local world=message:match('%s[%w]+'):sub(2)

		if message:sub(1,1)=='!' and message:match('[%w]+')=='warp' then
			sendMessage("Warping to `9"..world)
			sendPacket(false, "action|join_request\nname|"..world, 3)
		end
    end
end


-- With Name

name=''
function hook(vlist)
    if vlist[0]:find("OnConsoleMessage") then
        local name_=tostring(vlist[1]:match('`%w[%w]+'):sub(3))
        message=tostring(vlist[1]:match('`$`$.*'):sub(5,-5))

        if name_==name then
			if message:sub(1,1)=='!' and message:match('[%w]+')=='warp' then
				sendMessage("Warping to `9"..world)
				sendPacket(false, "action|join_request\nname|"..world, 3)
			end
		end
    end
end
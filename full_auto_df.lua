removeHooks()

-- WRAPPER FUNCTIONS

function hit_tile(x,y,bot)
	pkt = {}
	pkt.type = 3
	pkt.int_data = 18
	pkt.int_x = x
	pkt.int_y = y
	pkt.pos_x = getLocal().pos.x
	pkt.pos_y = getLocal().pos.y
	sleep(50)

	if bot then
		sendPacketRaw(pkt)
	else
		sendPacketRaw(false, pkt)
	end
end

function place_tile(x,y,id,bot)
	pkt = {}
	pkt.type = 3
	pkt.int_data = id
	pkt.pos_x = getLocal().pos.x
	pkt.pos_y = getLocal().pos.y
	pkt.int_x = x
	pkt.int_y = y

	if bot then
		sendPacketRaw(pkt)
	else
		sendPacketRaw(false, pkt)
	end
end

function drop_item(id,count,side,bot)
	side=side or 'left'
	for _,v in ipairs(getInventory()) do
		if v.id==id then
			count=count or v.count

			local pkt1="action|drop\n|itemID|"..id
			local pkt2="action|dialog_return\ndialog_name|drop_item\nitemID|"..id.."|\ncount|"..count
			local pkt = {}

			pkt.type = 0
			pkt.pos_x = getLocal().pos.x
			pkt.pos_y = getLocal().pos.y

			if side == "left" then
				pkt.flags = 48
			elseif side == "right" then
				pkt.flags = 32
			end

			if bot then
				sendPacket(pkt1,2)
				sendPacketRaw(pkt)
				sendPacket(pkt2,2)
			else
				sendPacket(false,pkt1,2)
				sendPacketRaw(false,pkt)
				sendPacket(false,pkt2,2)
			end
			return true
		end
	end
	return false
end

function sendMessage(msg,bot)
	if bot then
		sendPacket("action|input\n|text|"..msg, 2)
	else
		sendPacket(false, "action|input\n|text|"..msg, 2)
	end
end




-- OTHER FUNCTIONS

function getWDPos()
	for _,v in ipairs(getTiles()) do
		if v.fg==6 then return {v.pos.x,v.pos.y} end
	end
end

function hasItem(id)
	for _,v in ipairs(getInventory()) do
		if v.id==id then return true end
	end
	return false
end

function collectItems(range,bot)
	pos = getLocal().pos
	for _, obj in pairs(getObjects()) do
		posx = math.abs(pos.x - obj.pos.x)
		posy = math.abs(pos.y - obj.pos.y)
		if posx < range and posy < range then
			pkt = {}
			pkt.type = 11
			pkt.int_data = obj.oid
			pkt.pos_x = obj.pos.x
			pkt.pos_y = obj.pos.y
			if bot then
				sendPacketRaw(pkt)
			else
				sendPacketRaw(false,pkt)
			end
			sleep(10)
		end
	end
end




-- MAIN

function createDirtFarm(drop_pos,dirt_pos,optional_tiles,bot)
	local width=getTiles()[#getTiles()].pos.x
	local height=getTiles()[#getTiles()].pos.y
	local wd=false
	local dirt_tiles={}
	bot=bot or false
	
	local function opPos(x,y,tbl)
		for _,v in pairs(tbl) do
			if v[1]==x and v[2]==y then return true end
		end
		return false
	end
	
	local function itemCount(val)
	    if tostring(val):find('-') then
		    return val+256
		end
		return val
	end

	height=height-6


	-- DIRT TILES

	for i=2,height,2 do
		if getWDPos()[2]==i then wd=true break end
		dirt_tiles[i]=true
	end

	if wd then
		dirt_tiles={}
		for i=1,height,2 do
			dirt_tiles[i]=true
		end
	end


	--OPTIONAL
	if not bot then
		sendMessage=log
	end
	


	-- MAIN

	-- VARIABLES

	local stop
	local time
	local ftime=0

	-- P1. CLEAR SIDES
	sendMessage('`2Start! `o- `9Part 1. CLEAR SIDES',bot)
	time=os.time()

	for _,x in ipairs({0,width}) do
		for y=0,height do
			while getTile(x,y).fg>0 or getTile(x,y).bg>0 do
				findPath(x,y)
				sleep(20)
				hit_tile(x,y,bot)
			end
		end
	end

	time=(os.time()-time)
	ftime=ftime+time
	sendMessage('`2Part 1 COMPLETE! `o- `9Time Took : `2'..time..'s',bot)
	sleep(1000)


	-- P2. CLEAR DIRT/BLOCKS
	sendMessage('`2Start! `o- `9Part 2. CLEAR DIRT')
	time=os.time()

	for y=0,height do
		for x=1,width-1 do
			if not dirt_tiles[y] and not opPos(x,y,optional_tiles) then
				local tfg,tbg=getTile(x,y).fg,getTile(x,y).bg

				if tfg~=6 and tfg>0 or tbg>0 then				
					while tfg>0 or tbg>0 do
						tfg,tbg=getTile(x,y).fg,getTile(x,y).bg

						findPath(x-1,y)
						sleep(20)
						hit_tile(x,y,bot)
					end

					collectItems(64,bot)
					for _,v in ipairs(getInventory()) do
						if itemCount(v.count)==200 then
							findPath(drop_pos[1]-1,drop_pos[2])
							sleep(50)
							drop_item(v.id,200,'right',bot)
							break
						end
					end
				end
			end
		end
	end

	time=(os.time()-time)
	ftime=ftime+time
	sendMessage('`2Part 2 COMPLETE! `o- `9Time Took : `2'..time..'s',bot)
	sleep(1000)


	-- P3. PLACE DIRT BLOCKS
	sendMessage('`2Start! `o- `9Part 3 [ LAST ]. PLACE DIRT',bot)
	time=os.time()

	if not skip then
		for y=0,height do
			for x=1,width-1 do
				if dirt_tiles[y] and not opPos(x,y,optional_tiles) then
					if not hasItem(2) then
						findPath(dirt_pos[1],dirt_pos[2])
						collectItems(10,bot)
						sleep(1000)
						if not hasItem(2) then
							stop=true
							goto STOP
						end
					end

					if getTile(x,y).fg~=8 then
						::PLACE::
						if getTile(x,y).fg==0 then
							while getTile(x,y).fg==0 do
								findPath(x,y+1)
								sleep(20)
								place_tile(x,y,2,bot)
								sleep(500)
							end
							sleep(200)	
				
						elseif getTile(x,y).fg==4 or not isSolid(x,y) then
							while getTile(x,y).fg>0 do
								findPath(x,y+1)
								sleep(20)
								hit_tile(x,y,bot)
							end
							collectItems(64,bot)
							sleep(20)
							goto PLACE
						end
					end
				end
			end
		end
	end


	::STOP::

	if stop then
		time=(os.time()-time)
		ftime=ftime+time
		sendMessage('`4ERROR, Not enough dirt! `o- `9Time Took : `2'..time..'s - `9Full Time : `2'..ftime..'s',bot)
	else
		time=(os.time()-time)
		ftime=ftime+time
		sendMessage('`2Finished! `o- `9Time Took : `2'..time..'s - `9Full Time : `2'..ftime..'s',bot)
	end
end

removeHooks()

opt={
	{73,23},{75,23}
}

createDirtFarm({67,23},{72,23},opt)

--[[

Script made by HexaG0n | 7th October 2021 | Auto Dirt Farm Creator
------------------------------------------------------------------
							 PARAMS
	
	drop_pos - Where the bot should go to drop seeds/etc. when
			   full.

	dirt_pos - Where the bot should go when it runs out of dirt.

	optional_tiles - Tiles you dont want the bot to break. e.g.
	white door blocks, etc.

		NOTE:
		drop_pos and dirt_pos are NOT optional tiles. You
		also must have space beside drop_pos [ left ].
	
		All parameters must be in table form {tilex,tiley}.

   Will check if dirt_tiles is in way of white door, Replaces
  lava and non-solid blocks with dirt, can be used by bot/main.

------------------------------------------------------------------
]]
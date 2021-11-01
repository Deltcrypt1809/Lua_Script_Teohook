function closestTile(posx)
    local tilex=math.floor(posx/32)
    local true_tilex=0
    for i=1,tilex do
        true_tilex=true_tilex+32
    end

    if posx>true_tilex+12 then
        return tilex+1
    end
    return tilex
end

function followPlayer(player)
    has_player=true
    local tries=0
    local found=false

    while has_player do
        found=false
        for _,plr in ipairs(getPlayers()) do
            if plr.name:sub(3,-3)==player then
                found=true

                local x,y=closestTile(plr.pos.x),math.floor(plr.pos.y/32)
                findPath(x,y)

                sleep(10)
                if getLocal().tile.x~=x and getLocal().tile.y~=y then
                    tries=tries+1
                elseif tries>0 then
                    tries=tries-1
                end
                break
            end
        end

        if not found then log('PLAYER NOT FOUND') break end
        if tries>5 then log('BREAK') break end
    end
end

followPlayer('F4X5_121')

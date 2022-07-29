LevelManager = Class{}
function createMap(level)
    local brickset = {}
    local ncol = math.random(7,13)
    local nrow = math.random(5)
    ncol = ncol%2 == 0 and ncol+1 or ncol
    for y = 0, nrow - 1 do
        local highest_color = math.min(5,level%5+3)
        local highest_tier = math.min(4, math.floor(level/5)+1)
        local skippattern =  math.random(2) == 1 and true or false
        local alternatepattern =  math.random(2) == 1 and true or false
        local skipflag = math.random(2) == 1 and true or false
        local alternateflag = math.random(2) == 1 and true or false
        local alternatecolor1 = math.random(highest_color)
        local alternatetier1 = math.random(highest_tier)
        local alternatecolor2 = math.random(highest_color)
        local alternatetier2 = math.random(highest_tier)
        local solidcolor = math.random(highest_color)
        local solidtier = math.random(highest_tier)
        for x = 0,ncol - 1 do
            if skippattern and skipflag then
                skipflag = not skipflag
                goto continue
            else
                skipflag = not skipflag
            end
            b = Brick(((VIRTUAL_WIDTH - ncol*32)/2)+x*32,(y+1)*16)
            if alternatepattern and alternateflag then
                b.skin = alternatecolor1
                b.flavor = alternatetier1
                alternateflag = not alternateflag
            elseif alternatepattern then
                b.skin = alternatecolor2
                b.flavor = alternatetier2
                alternateflag = not alternateflag
            else
                b.skin = solidcolor
                b.flavor = solidtier
            end
            table.insert(brickset,b)
            ::continue::
        end
    end
    return brickset
end
function GenerateQuads(atlas,twidth,theight)
    local yno = atlas:getHeight()/theight
    local xno = atlas:getWidth()/twidth
    local quads={}
    local counter = 1
    for i=0,(yno-1) do
        for j=0,(xno-1) do
            quads[counter] = love.graphics.newQuad(j*twidth,i*theight,twidth,theight,atlas:getDimensions())
            counter = counter + 1
        end
    end
    return quads
end
function GeneratePaddles(atlas)
    local x = 0
    local y = 64
    local paddlecount = 1
    paddlequad = {}
    for i=0,3 do
        paddlequad[paddlecount] = love.graphics.newQuad(x,y,32,16,atlas:getDimensions())
        paddlecount = paddlecount+1
        paddlequad[paddlecount] = love.graphics.newQuad(x+32,y,64,16,atlas:getDimensions())
        paddlecount = paddlecount+1
        paddlequad[paddlecount] = love.graphics.newQuad(x+96,y,96,16,atlas:getDimensions())
        paddlecount = paddlecount+1
        paddlequad[paddlecount] = love.graphics.newQuad(x,y+16,128,16,atlas:getDimensions())
        paddlecount = paddlecount+1
        y = y + 32
    end
    return paddlequad
end
function GenerateBalls(atlas)
    local x = 96
    local y = 48
    local ballcounter = 1
    local ballquads = {}
    for i=0,3 do
        ballquads[ballcounter] = love.graphics.newQuad(x,y,8,8,atlas:getDimensions())
        ballcounter = ballcounter+1
        x = x+8
    end
    x = 96
    y = 56
    for i=0,2 do
        ballquads[ballcounter] = love.graphics.newQuad(x,y,8,8,atlas:getDimensions())
        ballcounter = ballcounter+1
        x = x+8
    end
    return ballquads
end
function GenerateBricks(atlas)
    local brickquads = GenerateQuads(atlas,32,16)
    for i=22,48 do
        brickquads[i] = NULL
    end
    return brickquads
end
function GenerateHearts(atlas)
    local heartquad = GenerateQuads(atlas,10,9)
    return heartquad
end
function GenerateButtons(atlas)
    local paddlebutton = GenerateQuads(atlas,24,24)
    return paddlebutton
end
function RenderHeart(health)
    local x = VIRTUAL_WIDTH -100
    for i = 1,health do
        love.graphics.draw(gTextures['hearts'],gFrames['hearts'][1],x,5)
        x = x + 11
    end
    for i = 1, 3-health do
        love.graphics.draw(gTextures['hearts'],gFrames['hearts'][2],x,5)
        x = x + 11
    end
end
function RenderScore(score)
    love.graphics.setFont(gFonts['small'])
    love.graphics.print('Score : '..tostring(score),VIRTUAL_WIDTH-60,5)
end
function checkvictory(bricks)
    for k,brick in pairs(bricks) do
        if brick.inplay then 
            return false
        end
    end
    return true
end
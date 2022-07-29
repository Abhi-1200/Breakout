PaddleselectState = Class{__includes = BaseState}
function PaddleselectState:enter(params)
    self.ball = params.ball
    self.score = params.score
    self.health = params.health
    self.level = LEVEL
    self.bricks = params.bricks
    pskin = 1
end
function PaddleselectState:update(dt)
    if gKeyinputs['enter'] == true or gKeyinputs['return'] == true then
        gSounds['confirm']:stop()
        gSounds['confirm']:play()
        gStateMachine:change('serve',{
            paddle = Paddle(pskin),
            ball = self.ball,
            score = self.score,
            health = self.health,
            bricks = self.bricks,
        })
    end
    if gKeyinputs['right'] == true then
        if pskin == 4 then
            gSounds['no-select']:stop()
            gSounds['no-select']:play()
        else
            gSounds['select']:stop()
            gSounds['select']:play()
        end
        pskin = math.min(4,pskin + 1)
    end
    if gKeyinputs['left'] == true then
        if pskin == 1 then
            gSounds['no-select']:stop()
            gSounds['no-select']:play()
        else
            gSounds['select']:stop()
            gSounds['select']:play()
        end
        pskin = math.max(1,pskin - 1)
    end
end
function PaddleselectState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Select the Paddle',0,30,VIRTUAL_WIDTH,'center')
    if pskin == 1 then
        love.graphics.setColor(50/255, 50/255, 50/255, 128/255)
    end
    love.graphics.draw(gTextures['arrows'],gFrames['buttons'][1],VIRTUAL_WIDTH/2-96-15,VIRTUAL_HEIGHT*2/3)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(gTextures['main'],gFrames['paddle'][2 +(4*(pskin-1))],VIRTUAL_WIDTH/2-32,VIRTUAL_HEIGHT*2/3+4)
    if pskin == 4 then
        love.graphics.setColor(50/255, 50/255, 50/255, 128/255)
    end
    love.graphics.draw(gTextures['arrows'],gFrames['buttons'][2],VIRTUAL_WIDTH/2+72+15,VIRTUAL_HEIGHT*2/3 )
    love.graphics.setColor(1,1,1,1)
end
StartState = Class{__includes = BaseState}
function StartState:init()
    highlighted = 1
end
function StartState:update(dt)
    if gKeyinputs['up'] == true or gKeyinputs['down'] == true then
        highlighted = highlighted == 1 and 2 or 1
        gSounds['paddle-hit']:play()
    end
    if gKeyinputs['enter'] == true or gKeyinputs['return'] == true then
        gSounds['confirm']:play()
        if highlighted == 1 then
            gStateMachine:change('select',{
                paddle = Paddle(1),
                ball = Ball(math.random(7)),
                score = 0,
                health = 3,
                level = LEVEL,
                bricks = createMap(LEVEL)
            })
        end
    end
end
function StartState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('BREAKOUT',0,VIRTUAL_HEIGHT/3,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(gFonts['medium'])
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
        love.graphics.printf('START',0,VIRTUAL_HEIGHT/2+70,VIRTUAL_WIDTH,'center')
        love.graphics.setColor(1,1,1,1)
        love.graphics.printf('HIGH SCORE',0,VIRTUAL_HEIGHT/2+90,VIRTUAL_WIDTH,'center')
    else
        love.graphics.printf('START',0,VIRTUAL_HEIGHT/2+70,VIRTUAL_WIDTH,'center')
        love.graphics.setColor(103/255, 1, 1, 1)
        love.graphics.printf('HIGH SCORE',0,VIRTUAL_HEIGHT/2+90,VIRTUAL_WIDTH,'center')
        love.graphics.setColor(1,1,1,1)
    end
end
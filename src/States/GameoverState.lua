GameoverState = Class{__includes = BaseState}
function GameoverState:enter(params)
    self.score = params.score
end
function GameoverState:update(dt)
    if gKeyinputs['enter'] == true or gKeyinputs['return'] == true then
        gStateMachine:change('start')
    end
end
function GameoverState:render(dt)
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Game Over!',0,VIRTUAL_HEIGHT/3,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Final Score : '..tostring(self.score),0,VIRTUAL_HEIGHT/3+60,VIRTUAL_WIDTH,'center')
    love.graphics.printf('Press ENTER To Restart',0,VIRTUAL_HEIGHT/3 +80,VIRTUAL_WIDTH,'center')
end
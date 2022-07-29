VictoryState = Class{__includes = BaseState}
function VictoryState:enter(params)
    self.level = LEVEL
    self.paddle = params.paddle
    self.ball = params.ball
    self.score = params.score
    self.health = params.health
end
function VictoryState:update(dt)
    if gKeyinputs['enter'] == true or gKeyinputs['return'] == true then
        LEVEL = LEVEL + 1
        self.level = LEVEL
        gStateMachine:change('serve',{
            paddle = self.paddle,
            ball = self.ball,
            score = self.score,
            health = self.health,
            bricks = createMap(self.level),
            level = self.level
        })
    end
end
function VictoryState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Level '..tostring(self.level)..' complete',0,VIRTUAL_HEIGHT/3,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press ENTER to serve',0,VIRTUAL_HEIGHT/3 +60,VIRTUAL_WIDTH,'center')
end
ServeState = Class{__includes = BaseState}
function ServeState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
    self.score = params.score
    self.health = params.health
    self.bricks = params.bricks
    self.level = LEVEL
end
function ServeState:update(dt)
    if love.keyboard.isDown('right') then
        self.paddle:update(dt)
        self.ball.x = math.min(VIRTUAL_WIDTH-4-self.paddle.width/2,self.ball.x + 200*dt)
    end
    if love.keyboard.isDown('left') then
        self.paddle:update(dt)
        self.ball.x = math.max(self.paddle.width/2 - 4,self.ball.x - 200*dt)
    end
    if gKeyinputs['enter'] == true or gKeyinputs['return'] == true then
        gStateMachine:change('play',{
            paddle =self.paddle,
            ball = self.ball,
            score = self.score,
            health = self.health,
            bricks = self.bricks,
            level = self.level
        })
    end
end
function ServeState:render()
    self.ball:render()
    self.paddle:render()
    for k,brick in pairs(self.bricks) do
        brick:render()
    end
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('Level '..tostring(self.level),0,VIRTUAL_HEIGHT/3+10,VIRTUAL_WIDTH,'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf('Press ENTER to serve!',0,VIRTUAL_HEIGHT/3+60,VIRTUAL_WIDTH,'center')
    RenderScore(self.score)
    RenderHeart(self.health)
end
PlayState = Class{__includes = BaseState}
function PlayState:enter(params)
    self.paddle = params.paddle
    self.ball = params.ball
    self.bricks = params.bricks
    self.score = params.score
    self.health = params.health
    self.pause = false
    self.level = LEVEL
end
function PlayState:update(dt)
    if gKeyinputs['space'] then
        if self.pause then
            gSounds['pause']:play()
            self.pause = false
        else
            gSounds['pause']:play()
            self.pause = true
        end
    end
    if checkvictory(self.bricks) then
        self.paddle:reset()
        self.ball:reset()
        gStateMachine:change('victory',{
            paddle = self.paddle,
            ball = self.ball,
            score = self.score,
            health = self.health
        })
    end
    if self.pause == false then
        self.paddle:update(dt)
        self.ball:update(dt)
        k = math.abs(self.paddle.x + self.paddle.width/2-self.ball.x-4)+ 6
        if collide(self.ball,self.paddle) == 12  then
            gSounds['paddle-hit']:play()
            self.ball.dy = -self.ball.dy
            self.ball.y = self.paddle.y -8
            self.ball.dx = self.ball.dx >=0 and math.min(200,k*self.ball.dx/20) or math.max(-200,k*self.ball.dx/20)
        elseif collide(self.ball,self.paddle) == 3 then
            gSounds['paddle-hit']:play()
            self.ball.dx = self.ball.dx >=0 and self.ball.dx +1 or -self.ball.dx
            self.ball.dx = self.ball.dx >=0 and math.min(200,k*self.ball.dx/20) or math.max(-200,k*self.ball.dx/20)
            self.ball.dy = -self.ball.dy
            self.ball.x = self.paddle.x + self.paddle.width + 2
        elseif collide(self.ball,self.paddle) == 9 then
            gSounds['paddle-hit']:play()
            self.ball.dx = self.ball.dx <=0 and self.ball.dx +1 or -self.ball.dx
            self.ball.dx = self.ball.dx >=0 and math.min(200,k*self.ball.dx/20) or math.max(-200,k*self.ball.dx/20)
            self.ball.dy = -self.ball.dy
            self.ball.x = self.paddle.x -10
        end
        for k,brick in pairs(self.bricks) do
            brick:update(dt)
            if brick.inplay then
                if collide(self.ball,brick) == 12  then
                    brick:hit()
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y -8
                    self.score = self.score + 10
                    break
                elseif collide(self.ball,brick) == 6 then
                    brick:hit()
                    self.ball.dy = -self.ball.dy
                    self.ball.y = brick.y + brick.height
                    self.score = self.score + 10
                    break
                elseif collide(self.ball,brick) == 3 then
                    brick:hit()
                    self.ball.dx = -self.ball.dx
                    self.ball.x = brick.x + brick.width
                    self.score = self.score + 10
                    break
                elseif collide(self.ball,brick) == 9 then
                    brick:hit()
                    self.ball.dx = -self.ball.dx
                    self.ball.x = brick.x -8
                    self.score = self.score + 10
                    break
                end
            end
        end
        if self.ball.y + 7 >= VIRTUAL_HEIGHT then
            self.paddle:reset()
            self.ball:reset()
            self.health = self.health - 1
            gStateMachine:change('serve',{
                paddle = self.paddle,
                ball = self.ball,
                score = self.score,
                health = self.health,
                bricks = self.bricks
            })
        end
        if self.health == 0 then
            gStateMachine:change('game-over',{
                score = self.score
            })
        end
    end
end
function PlayState:render()
    self.paddle:render()
    self.ball:render()
    RenderHeart(self.health)
    RenderScore(self.score)
    for k,brick in pairs(self.bricks) do
        brick:render()
        brick:renderParticles()
    end
    if self.pause then
        love.graphics.setFont(gFonts['large'])
        love.graphics.printf('PAUSED',0,VIRTUAL_HEIGHT/3+10,VIRTUAL_WIDTH,'center')
        love.graphics.setFont(gFonts['medium'])
        love.graphics.printf('Press SPACE To Resume',0,VIRTUAL_HEIGHT/3+50,VIRTUAL_WIDTH,'center')
    end
end
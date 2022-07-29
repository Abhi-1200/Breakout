Paddle = Class{}
function Paddle:init(skin)
    self.skin = skin
    self.size = 2
    self.x = VIRTUAL_WIDTH/2-(self.size*16)
    self.y = VIRTUAL_HEIGHT-32
    self.width = self.size*32
    self.height = 16
end
function Paddle:update(dt)
    if love.keyboard.isDown('a') then
        self. x = math.max(0,self.x - paddlespeed * dt)
    elseif love.keyboard.isDown('d') then
        self. x = math.min(VIRTUAL_WIDTH-(self.size*32),self.x + paddlespeed * dt)
    end
end
function Paddle:reset()
    self.x = VIRTUAL_WIDTH/2-(self.size*16)
    self.y = VIRTUAL_HEIGHT-32
end
function Paddle:render()
    love.graphics.draw(gTextures['main'],gFrames['paddle'][self.size +(4*(self.skin-1))],self.x,self.y)
end
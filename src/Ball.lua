Ball = Class{}
function Ball:init(skin)
    self.x = VIRTUAL_WIDTH/2-4
    self.y = VIRTUAL_HEIGHT-40
    self.width = 8
    self.height = 8
    self.dx = math.random(50,160)
    self.dy = math.random(-50,-60)
    self.skin = skin
end
function Ball:update(dt)
    if self.x <= 0 or self.x+8 >= VIRTUAL_WIDTH  then
        self.dx = -self.dx
        gSounds['wall-hit']:play()
        self.x = self.x <= 0 and 0 or VIRTUAL_WIDTH - 8
    end
    if self.y <=0 then
        self.dy = -self.dy
        gSounds['wall-hit']:play()
        self.y = 0
    end
    self.x = self.x + self.dx * dt
    self.y = self.y + self.dy * dt
end
function Ball:reset()
    self.x = VIRTUAL_WIDTH/2-4
    self.y = VIRTUAL_HEIGHT-40
    self.dx = math.random(50,160)
    self.dy = math.random(-50,-60)
end
function Ball:render()
    love.graphics.draw(gTextures['main'],gFrames['ball'][self.skin],self.x,self.y)
end
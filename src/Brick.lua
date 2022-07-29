Brick = Class{}
particlecolor = {
    [1] = {['r'] = 99/255,['g'] = 154/255,['b'] = 254/255},
    [2] = {['r'] = 104/255,['g'] = 187/255,['b'] = 49/255},
    [3] = {['r'] = 217/255,['g'] = 87/255,['b'] = 99/255},
    [4] = {['r'] = 214/255,['g'] = 122/255,['b'] = 186/255},
    [5] = {['r'] = 251/255,['g'] = 242/255,['b'] = 52/255}
}
function Brick:init(x,y)
    self.x = x
    self.y = y
    self.skin = 1
    self.flavor = 1
    self.width = 32
    self.height = 16
    self.inplay = true
    self.psystem = love.graphics.newParticleSystem(gTextures['particle'],64)
    self.psystem:setParticleLifetime(0.5,1)
    self.psystem:setEmissionArea('normal',10,10)
    self.psystem:setLinearAcceleration(-15,-5,15,25)
end
function Brick:hit()
    self.psystem:setColors(particlecolor[self.skin]['r'],particlecolor[self.skin]['g'],particlecolor[self.skin]['b'],55*self.flavor/255,
    particlecolor[self.skin]['r'],particlecolor[self.skin]['g'],particlecolor[self.skin]['b'],0)
    self.psystem:emit(64)
    gSounds['brick-hit-2']:stop()
    gSounds['brick-hit-2']:play()
    if self.skin > 1 then
        self.skin = self.skin -1
    else 
        if self.flavor > 1 then
            self. falvor = self.flavor - 1
        else
            self.inplay = false
        end
    end
    if not self.inplay then
        gSounds['brick-hit-1']:stop()
        gSounds['brick-hit-1']:play()
    end
end
function Brick:update(dt)
    self.psystem:update(dt)
end
function Brick:render()
    if self.inplay then
        love.graphics.draw(gTextures['main'],gFrames['bricks'][4*(self.skin - 1)+ self.flavor],self.x,self.y)
    end
end
function Brick:renderParticles()
    love.graphics.draw(self.psystem,self.x + 16,self.y + 8)
end
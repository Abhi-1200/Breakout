require 'src/Dependencies'
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243
paddlespeed = 200
function love.load()
    love.graphics.setDefaultFilter('nearest','nearest')
    love.window.setTitle('Breakout')
    math.randomseed(os.time())
    ai = math.random(5)
    bi = math.random(4)
    LEVEL = 1
    gKeyinputs = {}
    gStateMachine = StateMachine{
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['serve'] = function() return ServeState() end,
        ['game-over'] = function() return GameoverState() end,
        ['victory'] = function() return VictoryState() end,
        ['select'] = function() return PaddleselectState() end
    }
    gTextures = {
        ['background'] = love.graphics.newImage('Graphics/background.png'),
        ['main'] = love.graphics.newImage('Graphics/breakout.png'),
        ['arrows'] = love.graphics.newImage('Graphics/arrows.png'),
        ['hearts'] = love.graphics.newImage('Graphics/hearts.png'),
        ['particle'] = love.graphics.newImage('Graphics/particle.png'),
    }
    gSounds = {
        ['paddle-hit'] = love.audio.newSource('Sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('Sounds/score.wav', 'static'),
        ['wall-hit'] = love.audio.newSource('Sounds/wall_hit.wav', 'static'),
        ['confirm'] = love.audio.newSource('Sounds/confirm.wav', 'static'),
        ['select'] = love.audio.newSource('Sounds/select.wav', 'static'),
        ['no-select'] = love.audio.newSource('Sounds/no-select.wav', 'static'),
        ['brick-hit-1'] = love.audio.newSource('Sounds/brick-hit-1.wav', 'static'),
        ['brick-hit-2'] = love.audio.newSource('Sounds/brick-hit-2.wav', 'static'),
        ['hurt'] = love.audio.newSource('Sounds/hurt.wav', 'static'),
        ['victory'] = love.audio.newSource('Sounds/victory.wav', 'static'),
        ['recover'] = love.audio.newSource('Sounds/recover.wav', 'static'),
        ['high-score'] = love.audio.newSource('Sounds/high_score.wav', 'static'),
        ['pause'] = love.audio.newSource('Sounds/pause.wav', 'static'),
        ['music'] = love.audio.newSource('Sounds/music.wav', 'static'),
    }
    gFonts = {
        ['small'] = love.graphics.newFont('Fonts/font.ttf', 8),
        ['medium'] = love.graphics.newFont('Fonts/font.ttf', 16),
        ['large'] = love.graphics.newFont('Fonts/font.ttf', 32),
    }
    gFrames = {
        ['paddle'] = GeneratePaddles(gTextures['main']),
        ['ball'] = GenerateBalls(gTextures['main']),
        ['bricks'] = GenerateBricks(gTextures['main']),
        ['hearts'] = GenerateHearts(gTextures['hearts']),
        ['buttons'] = GenerateButtons(gTextures['arrows'])
    }
    p:setupScreen(VIRTUAL_WIDTH,VIRTUAL_HEIGHT,WINDOW_WIDTH,WINDOW_HEIGHT,{fullscreen = false,resizable = true,vsync = true})
    gStateMachine:change('start')
    gSounds['music']:setLooping(true)
    gSounds['music']:play()
end
function love.resize(w,h)
    p:resize(w,h)
end
function love.update(dt)
    gStateMachine:update(dt)
    gKeyinputs = {}
end
function love.keypressed(key)
    gKeyinputs[key] = true
    if key == 'escape' then
        love.event.quit()
    end
end
function getFPS()
    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(0/255,255/255,0/255,255/255)
    love.graphics.print('FPS : '..tostring(love.timer.getFPS()),8,8)
    love.graphics.setColor(255/255,255/255,255/255,255/255)
end
function love.draw()
    p:start()
    bgi_width = gTextures['background']:getWidth()
    bgi_height = gTextures['background']:getHeight()
    love.graphics.draw(gTextures['background'],0,0,0,VIRTUAL_WIDTH/(bgi_width-1),VIRTUAL_HEIGHT/(bgi_height - 1))
    getFPS()
    gStateMachine:render()
    p:finish()
end
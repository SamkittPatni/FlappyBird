push = require 'push'
Class = require 'class'
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountdownState'
require 'states/PauseState'
require 'Bird'
require 'Pipe'
require 'PipePair'

-- Constants --
WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local backgroundscroll = 0
local ground = love.graphics.newImage('ground.png')
local groundscroll = 0
gold_medal = love.graphics.newImage('gold_medal.png')
silver_medal = love.graphics.newImage('silver_medal.png')
bronze_medal = love.graphics.newImage('bronze_medal.png')
BACKGROUND_SCROLL_SPEED = 30
GROUND_SCROLL_SPEED = 70
local BACKGROUND_LOOPING_POINT = 413
local GROUND_LOOPING_POINT = 514
scrolling  = true

-- Function to create the main screen layout --
function love.load()
  love.graphics.setDefaultFilter('nearest', 'nearest')
  love.window.setTitle('Flappy Bird')
  smallfont = love.graphics.newFont('font.ttf', 8)
  mediumfont = love.graphics.newFont('flappy.ttf', 14)
  flappyfont = love.graphics.newFont('flappy.ttf', 28)
  largefont = love.graphics.newFont('flappy.ttf', 56)
  love.graphics.setFont(flappyfont)
  math.randomseed(os.time())
  push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
    vsync = true,
    fullscreen = false,
    resizable = true
  })

  -- Initialising states of the state machine --
  gStateMachine = StateMachine {
    ['title'] = function() return TitleScreenState() end,
    ['play'] = function() return PlayState() end,
    ['score'] = function() return ScoreState() end,
    ['countdown'] = function() return CountdownState() end,
    ['pause'] = function() return PauseState() end
  }

  -- Initialising all the sounds --
  sounds = {
    ['jump'] = love.audio.newSource('jump.wav', 'static'),
    ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
    ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
    ['score'] = love.audio.newSource('score.wav', 'static'),
    ['main'] = love.audio.newSource('marios_way.mp3', 'static')
  }
  sounds['main']:setLooping(true)
  sounds['main']:play()
  gStateMachine:change('title')
  love.keyboard.keysPressed = {}
end

-- Function to allow window resizing --
function love.resize(w, h)
  push:resize(w, h)
end

-- Function for all input --
function love.keypressed(key)
  love.keyboard.keysPressed[key] = true
  if key == 'escape' then
    love.event.quit()
  end
end

-- Function to check if a key was pressed --
function love.keyboard.wasPressed(key)
  if love.keyboard.keysPressed[key] then
    return true
  else
    return false
  end
end

-- Function to update main game --
function love.update(dt)
  backgroundscroll = (backgroundscroll + BACKGROUND_SCROLL_SPEED * dt)
    % BACKGROUND_LOOPING_POINT
  groundscroll = (groundscroll + GROUND_SCROLL_SPEED * dt)
    % GROUND_LOOPING_POINT
  gStateMachine:update(dt)
  love.keyboard.keysPressed = {}
end

-- Function to render screen --
function love.draw()
  push:start()
  love.graphics.draw(background, -backgroundscroll, 0)
  gStateMachine:render()
  love.graphics.draw(ground, -groundscroll, VIRTUAL_HEIGHT - 16)
  displayFPS()
  love.graphics.setFont(flappyfont)
  love.graphics.setColor(1, 1, 1, 1)
  push:finish()
end

-- Function to display frames per seconds --
function displayFPS()
  love.graphics.setFont(smallfont)
  love.graphics.setColor(1, 0, 0, 1)
  love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, VIRTUAL_HEIGHT - 15)
end

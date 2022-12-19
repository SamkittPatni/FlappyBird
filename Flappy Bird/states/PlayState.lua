PlayState = Class{__includes = BaseState}

-- Declaring constants for game --
PIPE_SCROLL = -70
PIPE_WIDTH = 70
PIPE_HEIGHT = 288
BIRD_WIDTH = 38
BIRD_HEIGHT = 24
--score = 0

-- Setting variables when enter play state --
function PlayState:enter(params)
  scrolling = true
  self.bird = params.bird
  self.pipePairs = params.pipePairs
  self.timer = params.timer
  self.score = params.score
end

-- Initialise function for play state --
function PlayState:init()
  self.enterParams = {}
  --self.bird = Bird()
  --self.pipePairs = {}
  --self.timer = 0
  --self.score = 0
end

-- Function to update position of pipes, bird, score and timer based on delta time --
function PlayState:update(dt)
  self.timer = self.timer + dt
  if self.timer > 3 then
    local y = math.max(-PIPE_HEIGHT + 10, math.random(-PIPE_HEIGHT + 10, VIRTUAL_HEIGHT - 150 - PIPE_HEIGHT))
    table.insert(self.pipePairs, PipePair(y))
    self.timer = 0
  end
  for k, pair in pairs(self.pipePairs) do
    if not pair.scored then
      if pair.x + PIPE_WIDTH < self.bird.x then
        self.score = self.score + 1
        pair.scored = true
        sounds['score']:play()
      end
    end
    pair:update(dt)
  end
  for k, pair in pairs(self.pipePairs) do
    if pair.remove then
      table.remove(self.pipePairs, k)
    end
  end
  for k, pair in pairs(self.pipePairs) do
    for l, pipe in pairs(pair.pipes) do
      if self.bird:collision(pipe) then
        score = self.score
        sounds['hurt']:play()
        sounds['explosion']:play()
        gStateMachine:change('score', {
          score = self.score
        })
      end
    end
  end
  self.bird:update(dt)
  if self.bird.y > VIRTUAL_HEIGHT - 15 then
    sounds['hurt']:play()
    sounds['explosion']:play()
    gStateMachine:change('score', {
      score = self.score
    })
  end
  if self.bird.y < 0 then
    sounds['hurt']:play()
    sounds['explosion']:play()
    gStateMachine:change('score', {
      score = self.score
    })
  end
  if love.keyboard.wasPressed('p') then
    self.enterParams = {
      ['bird'] = self.bird,
      ['pipePairs']  = self.pipePairs,
      ['timer'] = self.timer,
      ['score'] = self.score
    }
    gStateMachine:change('pause', self.enterParams)
  end
end

-- Function to render everything on screen when in play state --
function PlayState:render()
  for k, pair in pairs(self.pipePairs) do
    pair:render()
  end
  love.graphics.setFont(flappyfont)
  love.graphics.print("Score: " .. tostring(self.score), 8, 8)
  self.bird:render()
end

-- Function to stop scrolling when exiting play state --
function PlayState:exit()
  scrolling = false
end

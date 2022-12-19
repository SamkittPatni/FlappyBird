PauseState = Class{__includes = BaseState}

-- Function to initialise the pause screen text and halt play --
function PauseState:init()
  self.timer = 0
  self.enterParams = {}
  BACKGROUND_SCROLL_SPEED = 0
  GROUND_SCROLL_SPEED = 0
end

-- Function that releases play information when unpasued --
function PauseState:update(dt)
  if love.keyboard.wasPressed('p') then
    self.timer = self.timer + dt * 0
    self.enterParams = {
      ['bird'] = self.bird,
      ['pipePairs'] = self.pipePairs,
      ['timer'] = self.timer,
      ['score'] = self.score
    }
    BACKGROUND_SCROLL_SPEED = 30
    GROUND_SCROLL_SPEED = 70
    self.timer = self.timer + dt * 0
    gStateMachine:change('play',self.enterParams)
  end
end

-- Function that exeuted on entering the pause state --
function PauseState:enter(enterParams)
  scorlling = false

  -- Storing all state and game vaiables --
  self.bird = enterParams.bird
  self.pipePairs = enterParams.pipePairs
  self.timer = enterParams.timer
  self.score = enterParams.score
end

-- Function to render images while paused --
function PauseState:render()
  for k, pair in pairs(self.pipePairs) do
    pair:render()
  end
  self.bird:render()
  love.graphics.setFont(largefont)
  love.graphics.printf("Paused", 0, VIRTUAL_HEIGHT / 2 - 60, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(mediumfont)
  love.graphics.printf("Press 'p' to resume", 0, VIRTUAL_HEIGHT / 2 - 5, VIRTUAL_WIDTH, 'center')
  love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2 - 20, VIRTUAL_HEIGHT / 2 + 15, 10, 50)
  love.graphics.rectangle('fill', VIRTUAL_WIDTH / 2, VIRTUAL_HEIGHT / 2 + 15, 10, 50)
end

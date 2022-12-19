CountdownState = Class{__includes = BaseState}
COUNTDOWN_TIME = 0.75

-- Initialise function for when the game is in countdown state --
function CountdownState:init()
  self.count = 3
  self.timer = 0
  self.enterParams = {}
end

-- Function that updates countdown --
function CountdownState:update(dt)
  self.timer = self.timer + dt
  if self.timer >= COUNTDOWN_TIME then
    self.count = self.count - 1
    self.timer  = 0

    -- Initialising the bird and the other variables when timer hits 0 --
    if self.count == 0 then
      self.enterParams = {
        ['bird'] = Bird(),
        ['pipePairs'] = {},
        ['timer'] = 0,
        ['score'] = 0
      }
      gStateMachine:change('play', self.enterParams) -- Changing state to plau
    end
  end
end

-- Function to render countdown text on the screen --
function CountdownState:render()
  love.graphics.setFont(largefont)
  love.graphics.printf(tostring(self.count), 0, VIRTUAL_HEIGHT / 2 - 28, VIRTUAL_WIDTH, 'center')
end

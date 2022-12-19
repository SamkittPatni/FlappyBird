PipePair = Class{}
--local GAP_HEIGHT = 120

-- Initialise function for paddle object --
function PipePair:init(y)
  self.scored = false
  self.x = VIRTUAL_WIDTH + 32 -- Spawning object outside screen
  self.y = y
  GAP_HEIGHT = math.random(2) == 1 and 110 or 120
  self.pipes = {
    ['upper'] = Pipe('top', self.y),
    ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)
  }
  self.remove = false
end

-- Function to update poition of pipe pairs with respect to dt --
function PipePair:update(dt)
  if self.x > -PIPE_WIDTH then
    self.x = self.x + PIPE_SCROLL * dt
    self.pipes['lower'].x = self.x
    self.pipes['upper'].x = self.x
  else
    self.remove = true
  end
end

-- Function to render the pair of pipes --
function PipePair:render()
  for k, pipe in pairs(self.pipes) do
    pipe:render()
  end
end

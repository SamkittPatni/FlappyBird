Pipe = Class{}

-- Initialising image for pipe --
local PIPE_IMAGE = love.graphics.newImage('pipe.png')

-- Initialise function for pipe object --
function Pipe:init(orientation, y)
  self.x = VIRTUAL_WIDTH + 64
  self.y = y
  self.width = PIPE_WIDTH
  self.height = PIPE_HEIGHT
  self.orientation = orientation
end

-- Empty function for update. Updation done in pipe pair class --
function Pipe:update(dt)
end

-- Function to render pipe on screen --
function Pipe:render()
  love.graphics.draw(PIPE_IMAGE, self.x, (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y), 0, 1, self.orientation == 'top' and -1 or 1)
end

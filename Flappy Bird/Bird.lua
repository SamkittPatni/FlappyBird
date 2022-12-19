Bird = Class{}
local GRAVITY = 1150

-- Initialise function for bird object --
function Bird:init()
  self.image = love.graphics.newImage('bird.png')
  self.width = self.image:getWidth()
  self.height = self.image:getHeight()
  self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
  self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)
  self.dy = 0
end

-- Collision function to check if the bird collied with a pipe --
function Bird:collision(pipe)
  if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
    if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
      return true
    end
  end
  return false
end

-- Function that updates position of the bird based on delta time --
function Bird:update(dt)
  self.dy = self.dy + GRAVITY * dt
  if love.keyboard.wasPressed('space') then
    self.dy = -370
    sounds['jump']:play()
  end
  self.y = self.y + self.dy * dt
end

-- Function to render bird onto the screen --
function Bird:render()
  love.graphics.draw(self.image, self.x, self.y)
end

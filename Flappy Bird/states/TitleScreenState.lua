TitleScreenState = Class{__includes = BaseState}

-- Function to change state from title to countdown to start game --
function TitleScreenState:update(dt)
  if love.keyboard.wasPressed('space') then
    gStateMachine:change('countdown')
  end
end

-- Function to render title text --
function TitleScreenState:render()
  love.graphics.setFont(flappyfont)
  love.graphics.printf("Flappy Bird", 0, 64, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(mediumfont)
  love.graphics.printf("Press space to start", 0, 100, VIRTUAL_WIDTH, 'center')
end

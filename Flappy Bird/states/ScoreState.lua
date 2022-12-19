ScoreState = Class{__includes = BaseState}

-- Empty initialise function --
function ScoreState:init()
end

-- Enter function to store score --
function ScoreState:enter(params)
  score1 = params.score
end

-- Function that changes state to countdown after score display --
function ScoreState:update(dt)
  if love.keyboard.wasPressed('space') then
    gStateMachine:change('countdown')
  end
end

-- Function to render final score and medal --
function ScoreState.render()
  love.graphics.setFont(flappyfont)
  love.graphics.printf("Oof! You Lost!", 0, 64, VIRTUAL_WIDTH, 'center')
  love.graphics.setFont(mediumfont)
  love.graphics.printf("Score: " .. tostring(score1), 0, 100, VIRTUAL_WIDTH, 'center')
  if score1 >= 30 then
    love.graphics.draw(gold_medal, VIRTUAL_WIDTH / 2 - 15, VIRTUAL_WIDTH / 2 - 135)
  elseif score1 >= 15 and score1 < 30 then
    love.graphics.draw(silver_medal, VIRTUAL_WIDTH / 2 - 15, VIRTUAL_WIDTH / 2 - 135)
  else
    love.graphics.draw(bronze_medal, VIRTUAL_WIDTH / 2 - 15, VIRTUAL_WIDTH / 2 - 135)
  end
  love.graphics.printf('Press space to Play again', 0, 160, VIRTUAL_WIDTH, 'center')
end

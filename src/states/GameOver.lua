GameOver = Class{__includes = BaseState}

function GameOver:init()

end

function GameOver:update()
    if love.keyboard.wasPressed("enter") or love.keyboard.wasPressed("return") then
        gStateMachine:change("play")
    end
end

function GameOver:render()
    love.graphics.setFont(BigFont)
    love.graphics.setColor(255,255,255,255)
    love.graphics.printf("GAME OVER", 0, VIRTUAL_HEIGHT/2 - 20, VIRTUAL_WIDTH, 'center')
end
StartState = Class{__includes = BaseState}

function StartState:init()

end

function StartState:update()

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end

end

function StartState:render()
    love.graphics.setFont(Font)
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf("GEOMETRIC INVADERS", 0, VIRTUAL_HEIGHT/2 - 20, VIRTUAL_WIDTH, 'center')
end
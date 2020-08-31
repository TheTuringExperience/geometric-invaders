Tank = Class{}

function Tank:init()

    self.width = 20
    self.height = 10

    self.x = VIRTUAL_WIDTH/2 - self.width/2
    self.y = VIRTUAL_HEIGHT - self.height - 5
    
    self.lives = 3

    self.bullet = nil

end

function Tank:update(dt)
    if love.keyboard.isDown("left") then
        self.x = math.max(0, self.x - TANK_MOVE_SPEED * dt)
    elseif love.keyboard.isDown("right") then
        self.x = math.min(VIRTUAL_WIDTH - self.width, self.x + TANK_MOVE_SPEED * dt)
    end   
end

function Tank:render()
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle('fill', self.x + self.width/2 - self.height/10, self.y -4, self.height/5,self.width/5)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    --Display the amount of lifes the tank has
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(tostring(self.lives), 0, VIRTUAL_HEIGHT - 30, 20, 'center')
end

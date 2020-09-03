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
    
    -- Player shooting
    if love.keyboard.wasPressed('space') and (self.bullet == nil) then
        self.bullet = Bullet(self.x + (self.width/2), self.y, "UP")
    end

    --Update the player's bullet
    if not (self.bullet == nil) then
        if self.bullet:update(dt) then
            self.bullet = nil
        end        
    end
end

function Tank:checkCollision(object)
    return not (self.x + self.width < object.x or self.x > object.x + object.width or
                self.y + self.height < object.y or self.y > object.y + object.height)
end

function Tank:takeDamage(damage)
    self.lives = math.max(0, self.lives - damage)
end

function Tank:render()
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.rectangle('fill', self.x + self.width/2 - self.height/10, self.y -4, self.height/5,self.width/5)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)

    --Render the bullet
    if not (self.bullet == nil) then
        self.bullet:render()
    end

    --Display the amount of lifes the tank has
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.printf(tostring(self.lives), 0, VIRTUAL_HEIGHT - 30, 20, 'center')
end

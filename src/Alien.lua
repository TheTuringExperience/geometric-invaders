Alien = Class{}

function Alien:init(x, y)
    self.width = 20
    self.height = 15

    -- Multiply the alien's position by it's width and height and add an offset
    self.x = (x * self.width) + ALIEN_X_OFFSET
    self.y = (y * self.height) + ALIEN_Y_OFFSET

    self.alive = true
   
end

function Alien:update(dt, dx, dy)
    self.x = self.x + (dx * dt)
    self.y = self.y + (dy * dt)
end

function Alien:collides(bullet)
    return not (self.x + self.width < bullet.x or self.x > bullet.x + bullet.width or
                self.y + self.height < bullet.y or self.y > bullet.y + bullet.height)
end

function Alien:render()
    if self.alive then
        love.graphics.setColor(0, 0, 255, 255)
        love.graphics.rectangle('fill', self.x, self.y, self.width - 5, self.height -5)
    end
end
Bullet = Class{}

function Bullet:init(x, y)
    self.x = x
    self.y = y

    self.width = 2
    self.height = 5
end

function Bullet:update(dt)
    self.y = self.y + BULLET_SPEED * dt
    --Check if the bullet went out of the screen
    if self.y + self.height < 0 then
        return true
    end
end

function Bullet:render()
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end
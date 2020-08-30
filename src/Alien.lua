Alien = Class{}

function Alien:init(x, y)
    self.gridX = x
    self.gridY = y

    self.width = 25
    self.height = 15

    self.alive = true

    self.direction = 'right'
    self.down = false
    self.steps = 0

    self:updateRenderPos(self.gridX, self.gridY)
end

function Alien:updateRenderPos(x, y)
    self.renderX = x * self.width
    self.renderY = y * self.height
end

function Alien:update(dt)
    if self.down then
        self.gridY = self.gridY + 1 * dt
        self:updateRenderPos(self.gridX, self.gridY)
        self.steps = self.steps + 1 * dt
        if self.steps >= 1 then
            self.down = false
            self.steps = 0            
        end
    elseif self.direction == 'right' then
        self.gridX = self.gridX + 1 * dt
        self:updateRenderPos(self.gridX, self.gridY)
        self.steps = self.steps + 1 * dt
        if self.steps >= 5 then
            self.direction = 'left'
            self.down = true
            self.steps = 0
        end
    elseif self.direction == 'left' then
        self.gridX = self.gridX - 1 * dt
        self:updateRenderPos(self.gridX, self.gridY)
        self.steps = self.steps + 1 * dt
        if self.steps >= 5 then
            self.direction = 'right'
            self.down = true
            self.steps = 0
        end          
    end

end

function Alien:collides(bullet)
    return not (self.renderX + self.width < bullet.x or self.renderX > bullet.x + bullet.width or
                self.renderY + self.height < bullet.y or self.renderY > bullet.y + bullet.height)
end

function Alien:render()
    if self.alive then
        love.graphics.setColor(0, 0, 255, 255)
        love.graphics.rectangle('fill', self.renderX, self.renderY, self.width - 5, self.height -5)
    end
end
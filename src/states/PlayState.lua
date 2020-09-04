PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.tank = Tank{}
    self.alienSquad = AlienSquad()
    self.score = 0
end

function PlayState:update(dt)
    self.tank:update(dt)
    self.alienSquad:update(dt)
    Timer.update(dt)

    Timer.every(1, function () self.alienSquad:shoot() end)
    
    --check for collisions between aliens and the bullet
    if not (self.tank.bullet == nil) then
        --If the bullet collided against a alien delete it and give the player 10 points
        if self.alienSquad:checkCollision(self.tank.bullet) then
            self.tank.bullet = nil
            self.score = self.score + 1
        end
    end

    --check for collisions between player and the alien's bullets
    if not (self.alienSquad.bullets == nil) then
        --If the bullet collided against a alien delete it
        for index, bullet in pairs(self.alienSquad.bullets) do
            if self.tank:checkCollision(bullet) then
                self.tank:takeDamage(1)
                -- After the bullet collides with the player delete it
                table.remove(self.alienSquad.bullets, index)
            end
        end
    end

      --Check if all the aliens are dead to end the game
    if (self.alienSquad.numAliensAlive <= 0) or (self.tank.lives <=0) then
        gStateMachine:change("gameOver")
    end

end

function PlayState:render()
    --Display score
    love.graphics.setColor(255, 255, 255)    
    love.graphics.printf(tostring(self.score), 0, 0, 20, 'center')

    self.tank:render()    
    self.alienSquad:render()    
end
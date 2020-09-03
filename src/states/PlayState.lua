PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.tank = Tank{}
    self.alienSquad = AlienSquad()

end

function PlayState:update(dt)
    self.tank:update(dt)
    self.alienSquad:update(dt)
    Timer.update(dt)

    Timer.every(1, function () self.alienSquad:shoot() end)
    
    --check for collisions between aliens and the bullet
    if not (self.tank.bullet == nil) then
        --If the bullet collided against a alien delete it
        if self.alienSquad:checkCollision(self.tank.bullet) then
            self.tank.bullet = nil
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
    if (self.alienSquad.aliensAlive == 0) or (self.tank.lives <=0) then
        gStateMachine:change("gameOver")
    end
end

function PlayState:render()
    self.tank:render()    

    self.alienSquad:render()
end
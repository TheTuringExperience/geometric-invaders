PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.tank = Tank{}

    --Since the bullet behaviour is super simple I'm just gonna putt it here
    self.bullet = nil    

    self.alienSquad = AlienSquad()
end

function PlayState:update(dt)
    self.tank:update(dt)

     -- Shooting mechanic
    if love.keyboard.wasPressed('space') and (self.bullet == nil) then
        self.bullet = Bullet(self.tank.x + (self.tank.width/2), self.tank.y)
    end

    if not (self.bullet == nil) then
        if self.bullet:update(dt) then
            self.bullet = nil
        end        
    end

    --check for collisions between aliens and the bullet
    if not (self.bullet == nil) then
        --If the bullet collided against a alien delete it
        if self.alienSquad:checkCollision(self.bullet) then
            self.bullet = nil
        end
    end
    
    --Check if all the aliens are dead to end the game
    if self.alienSquad.aliensAlive == 0 then
        gStateMachine:change("gameOver")
    end

    --Update the Aliens
    self.alienSquad:update(dt)

end

function PlayState:render()
    self.tank:render()
    --Render the bullet
    if not (self.bullet == nil) then
        self.bullet:render()
    end

    self.alienSquad:render()
end
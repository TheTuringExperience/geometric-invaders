PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.tank = Tank{}

    --Since the bullet behaviour is super simple I'm just gonna putt it here
    self.bullet = nil   

    self.alienSquad = AlienSquad()
end

function PlayState:update(dt)
    self.tank:update(dt)
    self.alienSquad:update(dt)
    Timer.update(dt)

    -- Player shooting
    if love.keyboard.wasPressed('space') and (self.bullet == nil) then
        self.bullet = Bullet(self.tank.x + (self.tank.width/2), self.tank.y, "UP")
    end

    --Update the player's bullet
    if not (self.bullet == nil) then
        if self.bullet:update(dt) then
            self.bullet = nil
        end        
    end

    Timer.every(1, function () self.alienSquad:shoot() end)
    
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
end

function PlayState:render()
    self.tank:render()
    --Render the bullet
    if not (self.bullet == nil) then
        self.bullet:render()
    end

    self.alienSquad:render()
end
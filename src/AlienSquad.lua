AlienSquad = Class{}

function AlienSquad:init()
    self.aliens = {}

    --Insert empty tables to later fill them with aliens
    for i = 1, SQUAD_ROWS, 1 do
        table.insert(self.aliens, {})
    end

    for y = 1, SQUAD_ROWS, 1 do
        for x = 1, SQUAD_COLUMNS, 1 do             
            table.insert(self.aliens[y], Alien(x, y))
        end
    end
    self.movementDirection = "right"

    self.numAliensAlive = SQUAD_TOTAL_UNITS
    self.bullets = {}
end

function AlienSquad:update(dt)    
    --Update Aliens:
    --Set by how much the aliens should move (the x movement gets faster as the number of aliens decreases)
    local aliensDx = ALIEN_X_SPEED + (SQUAD_TOTAL_UNITS - self.numAliensAlive)
    local aliensDy = 0

    --Get the left-most or right-most alien in the squad    
    local outermost = AlienSquad:getOutermostAlien(self.movementDirection, self.aliens)
    if ((outermost.x + outermost.width) >= VIRTUAL_WIDTH) then
        self.movementDirection = "left"
        aliensDy = ALIEN_Y_SPEED
    elseif outermost.x <= 0 then
        self.movementDirection = "right"
        aliensDy = ALIEN_Y_SPEED
    end

    if self.movementDirection == "right" then
        for y = 1, SQUAD_ROWS, 1 do
            for x = 1, SQUAD_COLUMNS, 1 do 
                self.aliens[y][x]:update(dt, aliensDx, aliensDy)
            end
        end
    else
         for y = 1, SQUAD_ROWS, 1 do
            for x = 1, SQUAD_COLUMNS, 1 do 
                self.aliens[y][x]:update(dt, -aliensDx, aliensDy)
            end
        end
    end

    --Update bullets:
    --If the bullets table is not empty, update the position of the bullets
    if table.getn(self.bullets) >= 1 then
        for index, bullet in pairs(self.bullets) do
            --The update function of the bullet returns true if the bullet goes of screen
            if bullet:update(dt) then
                table.remove(self.bullets, index)
            end
        end
    end

end

function AlienSquad:getOutermostAlien(movementDirection, aliens)
    if movementDirection == "right" then
        for x=SQUAD_COLUMNS, 1, -1 do
            for y = SQUAD_ROWS, 1, -1 do 
                local alien = aliens[y][x]
                if alien.alive then
                    return alien
                end
            end
        end
    elseif movementDirection == "left" then
        for x = 1, SQUAD_COLUMNS, 1 do
            for y = 1, SQUAD_ROWS, 1 do    
                local alien = aliens[y][x]
                if alien.alive then
                    return alien
                end
            end
        end
    end
    
end

function AlienSquad:checkCollision(bullet)
    for y = 1, SQUAD_ROWS, 1 do
        for x = 1, SQUAD_COLUMNS, 1 do 
            --Check if an alien is alive before checking for a collision for eficiency
            if self.aliens[y][x].alive then
                --Check for a collition between the bullet and the alien; if they collide kill the alien and return true
                if self.aliens[y][x]:collides(bullet) then
                    self.aliens[y][x].alive = false
                    self.numAliensAlive = self.numAliensAlive - 1
                    return true
                end
            end
        end
    end

end

function AlienSquad:shoot() 
    -- If there are 3 bullets in the screen already then don't create any more
    -- TODO: The number of possible bullets in the screen could be a function of the level
    if table.getn(self.bullets) >= 3 then
        return
    end
    local shooter = self.aliens[math.random(1,SQUAD_ROWS)][math.random(1,SQUAD_COLUMNS)]
    if shooter.alive then
        table.insert(self.bullets, Bullet(shooter.x + (shooter.width/2), shooter.y, "DOWN"))
    end
end

function AlienSquad:render()
    --Render the aliens
    for y = 1, SQUAD_ROWS, 1 do
        for x = 1, SQUAD_COLUMNS, 1 do 
            self.aliens[y][x]:render()
        end
    end

    --If the bullets table is not empty, render the bullets
    if table.getn(self.bullets) >=1 then
        for index, bullet in pairs(self.bullets) do
            bullet:render()
        end
    end
end
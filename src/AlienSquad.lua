AlienSquad = Class{}

function AlienSquad:init()
    self.aliens = {}

    --Insert empty tables to later fill them with aliens
    for i = 1, 4, 1 do
        table.insert(self.aliens, {})
    end

    for y = 1, 4, 1 do
        for x = 1, 10, 1 do 
            table.insert(self.aliens[y], Alien(x, y))
        end
    end

    self.aliensAlive = 40    
    self.bullets = {}
end

function AlienSquad:update(dt)
    --Update the position of the ship
    for y = 1, 4, 1 do
        for x = 1, 10, 1 do 
            self.aliens[y][x]:update(dt)
        end
    end

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

function AlienSquad:checkCollision(bullet)
    for y = 1, 4, 1 do
        for x = 1, 10, 1 do 
            --Check if an alien is alive before checking for a collision for eficiency
            if self.aliens[y][x].alive then
                --Check for a collition between the bullet and the alien; if they collide kill the alien and return true
                if self.aliens[y][x]:collides(bullet) then
                    self.aliens[y][x].alive = false
                    self.aliensAlive = self.aliensAlive - 1
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

    for y = 1, 4, 1 do
        for x = 1, 10, 1 do 
            -- The chance of any alien to shoot a bullet increases as the number of aliens decreases
            -- otherwise as the number of aliens goes down there would be less bullets shooted and the game would get easier
            local shoot_prob = math.random(50 - self.aliensAlive) 
            -- Shoot the bullet from the position of a random living alien           
            -- The likelihood that no alien shoots a bullet is equal to (9.8/shoot_prob)**self.aliensAlive            
            local alien = self.aliens[y][x]
            if alien.alive and (shoot_prob > 9.9) then
                -- Once the bullet is created end the loop
                return
                table.insert(self.bullets, Bullet(alien.renderX + (alien.width/2), alien.renderY, "DOWN"))                                    
            end
        end
    end

end

function AlienSquad:render()
    --Render the aliens
    for y = 1, 4, 1 do
        for x = 1, 10, 1 do 
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
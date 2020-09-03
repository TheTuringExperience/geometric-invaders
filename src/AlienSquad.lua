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
    local shooter = self.aliens[math.random(1,4)][math.random(1,10)]
    if shooter.alive then
        table.insert(self.bullets, Bullet(shooter.renderX + (shooter.width/2), shooter.renderY, "DOWN"))
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
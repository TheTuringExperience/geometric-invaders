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
end

function AlienSquad:update(dt)
    for y = 1, 4, 1 do
        for x = 1, 10, 1 do 
            self.aliens[y][x]:update(dt)
        end
    end
end

function AlienSquad:checkCollision(bullet)
    for y = 1, 4, 1 do
        for x = 1, 10, 1 do 
            --Check if an alien is alive before checking for a collision for eficiency
            if self.aliens[y][x].alive then
                --Check for a collition between the bullet and the alien if thy collide kill the alien and return false
                if self.aliens[y][x]:collides(bullet) then
                    self.aliens[y][x].alive = false
                    self.aliensAlive = self.aliensAlive - 1
                    return true
                end
            end
        end
    end
end

function AlienSquad:render()
    for y = 1, 4, 1 do
        for x = 1, 10, 1 do 
            self.aliens[y][x]:render()
        end
    end
end
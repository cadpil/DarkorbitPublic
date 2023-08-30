local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage"); local shared = ReplicatedStorage:WaitForChild("Shared")
local shipsFolder = ServerStorage:WaitForChild("Ships")

--Require the 'Ship' module that every ship is created from
local shipModule = require(shared:WaitForChild("Ship"):WaitForChild("Ship"))

--Detect whena  player is added
game.Players.PlayerAdded:Connect(function(player)
    --Find the player's ship in the 'Ships' folder and clone it
    local shipInstance = shipsFolder:FindFirstChild("Eagle"):Clone()

    local shipModules = {
        Thrusters = {
            Size=1,
            Class = "D",
        },
    }

    --Create a new ship component called 'shipClass' from the 'shipModule.new' constructer, passing in the cloned ship and the ship's internal modules as arguments
    local shipClass = shipModule.new(shipInstance, shipModules)
    print(shipClass)
end)
local serverStorage = game:GetService("ServerStorage");
local shipsFolder = serverStorage:WaitForChild("Ships");
local eagleShip = shipsFolder:WaitForChild("Eagle");
local spawnPos = game.Workspace:WaitForChild("ShipSpawnPosition").CFrame;

local eagleClone = eagleShip:Clone()
eagleClone:PivotTo(spawnPos)
eagleClone.Parent = game.Workspace
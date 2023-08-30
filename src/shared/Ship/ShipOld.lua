local ship = {}
ship.__index = ship

-- local capital = {}
-- capital.__index = capital
-- setmetatable(capital, ship)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local shipsFolder = ServerStorage:WaitForChild("Ships")

function ship.new(model : string, position : CFrame, owner : Player)
    local newShip = {}
    setmetatable(newShip, ship)

    newShip.shipInstance = shipsFolder:FindFirstChild(model, true):Clone();
    newShip.seat = newShip.shipInstance:WaitForChild("Seat");
    newShip.angularVelocity = newShip.seat:WaitForChild("AngularVelocity");
    newShip.linearVelocity = newShip.seat:WaitForChild("LinearVelocity");
    newShip.owner = owner;

    newShip.shipInstance:PivotTo(position);

    newShip.ProximityPrompt = ReplicatedStorage.Assets.ProximityPrompts.Ship:Clone()
    newShip.ProximityPrompt.ObjectText = model
    newShip.ProximityPrompt.Parent = newShip.seat

    return newShip;
end

-- function capital.new(position, driver, model, powerup)
--     local newCarrier = ship.new(position, driver, model)
--     setmetatable(newCarrier, capital)

--     newCarrier.powerUp = powerup;
--     newCarrier.class = "Capital"

--     return newCarrier
-- end

function ship:Boost()
    print("Boosting a "..self.model.." "..self.class)
    self.speed += 5
end

function ship:Serialize()
    local table_ = table.clone(table.pack(self, getmetatable(self)))
    table_[2]["__index"] = nil
    table.remove(table_[2], table_[2]["__index"])
    return table_
end

function ship.Deserialize(data)
    local t1, t2 = table.unpack(data)
    for key, value in pairs(t2) do
        if typeof(value) == "table" then continue end
        t1[key] = value
    end
    return t1
end

function ship:Setup()
    print("setting up")
end

-- function capital:Boost() 
--     print("Carrier boosting a "..self.model.." "..self.class)
--     self.speed += 20
-- end

return {ship, {}}
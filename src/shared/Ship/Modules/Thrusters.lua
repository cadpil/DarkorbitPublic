--Create class called thrusters and make it so that if a key is called that doesnt exist in a sub-class then look inside the 'thrusters' class before returning nil
local thrusters = {}
thrusters.__index = thrusters

--Get all information about every module in the game
local shipModuleStats = require(script.Parent:WaitForChild("ShipModuleStats"))

--A function of the 'thrusters' class called 'new', which takes in the size and class of the thrusters
function thrusters.new(size : number, class : string)
    --Create a table called 'newThrusters' with it's metatable set to the 'thrusters' class
    local newThrusters = setmetatable({}, thrusters)

    --Create values inside the 'newThrusters' table correlating the the arguments passed in 'thrusters.new'
    newThrusters.Size = size;
    newThrusters.Class = class;
    newThrusters.Stats = shipModuleStats.CoreInternal.Thrusters["Size_"..size]["Class_"..class]
    
    --Return the 'newThrusters' component back to the 'newShip' class
    return newThrusters
end

return thrusters
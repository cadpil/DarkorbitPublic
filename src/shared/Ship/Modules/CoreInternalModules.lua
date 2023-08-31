--Create class called thrusters and make it so that if a key is called that doesnt exist in a sub-class then look inside the 'thrusters' class before returning nil
local coreInternal = {}
coreInternal.__index = coreInternal

local moduleConstructer = require(script.Parent:WaitForChild("ShipModuleConstructer"))

--A function of the 'thrusters' class called 'new', which takes in the size and class of the thrusters
function coreInternal.newThrusters(size : number, class : string)
    --Create a table called 'newThrusters' with it's metatable set to the 'thrusters' class
    local newThrusters = setmetatable(moduleConstructer.new({"CoreInternal", "Thrusters"}, size, class), coreInternal)
    
    --Return the 'newThrusters' component back to the 'newShip' class
    return newThrusters
end

function coreInternal.newHull(size : number, class : string, spec : string)
    local newHull = setmetatable(moduleConstructer.new({"CoreInternal", "Hull", spec}, size, class), coreInternal)

    return newHull
end

-- function thrusters:Boost()
--     print("Boosting "..self.Size..self.Class.." thrusters")
--     return true
-- end

return coreInternal
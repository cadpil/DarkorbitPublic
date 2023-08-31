local baseModule = {}
baseModule.__index = baseModule

--Get all information about every module in the game
local shipModuleStats = require(script.Parent:WaitForChild("ShipModuleStats"))

function baseModule.new(moduleStatsLocation: table, size : number, class : string)
    local newModule = setmetatable({}, baseModule)

    --Set the 'root' directory of all modules
    local moduleDirectory = shipModuleStats
    for i = 1, #moduleStatsLocation, 1 do
        --Set moduleDirectory to the next index in the table, thus creating a 'path' or 'directory' to where the module's stats are located
        moduleDirectory = moduleDirectory[moduleStatsLocation[i]]
    end

    newModule.Size = size
    newModule.Class = class
    newModule.Stats = moduleDirectory["Size_"..size]["Class_"..class]

    return newModule
end

return baseModule
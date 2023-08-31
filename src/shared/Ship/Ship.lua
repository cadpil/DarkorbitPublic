--Create class called ship and make it so that if a key is called that doesnt exist in a sub-class then look inside 'ship' class before returning nil
local ship = {}
ship.__index = ship

--Create a table of Ship Module's module scripts, so that each module's respective Ship Module can be created
local modulesTable = {}
for _, module in pairs(script.Parent:WaitForChild("Modules"):GetChildren()) do
    if module:IsA("ModuleScript") then
        modulesTable[module.Name] = require(module)
    end
end

--A function of the ship class called 'new', which takes in an instance of a ship and the modules of said ship in a table
function ship.new(shipInstance : Instance, shipModules : table)
    --Create a table called 'newShip' with it's metatable set to the 'ship' class
    local newShip = setmetatable({}, ship)

    --Set "newShip"'s shipInstance to the ship instance passed as an argument
    newShip.shipInstance = shipInstance
    
    --Create an empty table called 'modules' inside 'newShip'
    newShip.modules = {}
    --Loop through the 'shipModules' table passed as an argument, and setting 'moduleName' to the name(key/index) of the ship module, and 'moduleValues' to the stats of the module
    for moduleType, modules in pairs(shipModules) do
        if not modulesTable[moduleType.."Modules"] then continue end
        for moduleName, moduleStats in pairs(modules) do
            --Check if 'modulesTable', which contains the name and constructer of every ship module in it, has 'moduleName' in it. If it doesn't then skip that key in the 'shipModules' table.
            if not modulesTable[moduleType.."Modules"]["new"..moduleName] then continue end
            --[[If 'modulesTable' does contain 'moduleName' in it, then it is a valid module, and a key/index of the module will be created in the 'newship.modules' table, with
            the value of the key being a new class of the ship module, containing all of the information in moduleValues (i.e. size and class of the ship module)]]
            newShip.modules[moduleName] = modulesTable[moduleType.."Modules"]["new"..moduleName](moduleStats.Size, moduleStats.Class, moduleStats.Specification)
        end
    end

    --Finally, return the 'newShip' table, containing all of the information about the ship, and all of the methods under the metatable it is assigned to (the 'ship' table)
    return newShip
end

return ship
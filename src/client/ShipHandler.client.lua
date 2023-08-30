local players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local easyFunctions = require(game.ReplicatedStorage.Shared.EasyFunctions)

local player = players.LocalPlayer

repeat task.wait() until game:IsLoaded()

local playerGui = player:WaitForChild("PlayerGui")
local shipUI = playerGui:WaitForChild("ShipUI")
local persistent = shipUI:WaitForChild("Persistent")
local mouseIcon = persistent:WaitForChild("Mouse")
local mouseGhost = persistent:WaitForChild("MouseGhost")
local mouseBoundry = persistent:WaitForChild("MouseBoundry")

local camera = game.Workspace.CurrentCamera
local vpSize = camera.ViewportSize
local centre = vpSize/2

local character = player.Character or player.CharacterAdded:Wait()

userInputService.MouseIconEnabled = false

player.CameraMode = Enum.CameraMode.LockFirstPerson

local ship = nil
local seat = nil
local gyro = nil
local velocity = nil
local mouseX = 0
local mouseY = 0

-- Mouse lock has to be continuously set for some reason

local function handleShip()
    userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
    if ship and seat then

        gyro.AngularVelocity = Vector3.new(mouseX*0.9,0,mouseY*0.9)
    end
end

local function mouseMoved(actionName, inputState, inputObject)
    if not shipUI.Enabled or not ship then return end

    local delta = inputObject.Delta
	
    local newMousePosition = mouseGhost.Position + UDim2.new(0,delta.X,0,delta.Y)
    
    -- Set the position of 'MouseGhost' to the position of normal mouse
    mouseGhost.Position = UDim2.new(0.5, math.clamp(newMousePosition.X.Offset, -(mouseBoundry.AbsoluteSize.X/2), mouseBoundry.AbsoluteSize.X/2), 0.5, math.clamp(newMousePosition.Y.Offset, -(mouseBoundry.AbsoluteSize.Y/2), mouseBoundry.AbsoluteSize.Y/2))
    --Set the position of the custom cursor to the ghost mouse, but 3 times closer to the centre
    mouseIcon.Position = UDim2.new(mouseGhost.Position.X.Scale, mouseGhost.Position.X.Offset/3, mouseGhost.Position.Y.Scale, mouseGhost.Position.Y.Offset/3)

    -- Get the cursor's position from -1 to 1 relative to the centre of the screen
    local absValue = Vector2.new(mouseGhost.AbsolutePosition.X+(mouseGhost.AbsoluteSize.X/2), (mouseGhost.AbsolutePosition.Y+(mouseGhost.AbsoluteSize.Y/2))+36) - centre
    absValue /= Vector2.new(mouseBoundry.AbsoluteSize.X/2,mouseBoundry.AbsoluteSize.Y/2)
    
    -- Turn cursor's position into a 2 decimal number
    mouseX = math.round(absValue.X*100)/100
    mouseY = (math.round(absValue.Y*100)/100)*-1
    local rounded = Vector2.new(mouseX, mouseY)

    -- Make the cursor more transparent as it gets closer to the centre of the screen, once it is close enough, make it completely transparent
    local mouseTransparency = 1 - ((Vector2.new(vpSize.X/2,mouseBoundry.AbsoluteSize.Y/2) - (mouseGhost.AbsolutePosition+Vector2.new(0,36))-(mouseGhost.AbsoluteSize/Vector2.new(2,2))) / mouseBoundry.AbsoluteSize*2).Magnitude
    if mouseTransparency > 0.91 then mouseTransparency = 1; --[[mouseX = 0; mouseY = 0]] end

    mouseIcon.Icon.ImageTransparency = mouseTransparency + 0.15
    easyFunctions.PointTo(mouseIcon, mouseGhost) 
    
end

ReplicatedStorage.Events.ShipRelated.BoardShip.OnClientEvent:Connect(function(shipInfo) 
    shipUI.Enabled = true
    ship = shipInfo.shipInstance
    seat = shipInfo.seat
    gyro = shipInfo.angularVelocity
    velocity = shipInfo.linearVelocity

    print(shipInfo)
    local methods = table.clone(shipInfo[2])
    print(methods)

    setmetatable(shipInfo[1], methods)
    shipInfo = shipInfo[1]

    print(getmetatable(shipInfo))



    for _, part in pairs(character:GetDescendants()) do
        if part:IsA("BasePart") then
            part.Transparency = 1
        end
    end

    shipInfo:Setup()

    runService:BindToRenderStep("ShipHandler", 99, handleShip)
end)

-- When the mouse is moved, call the 'mouseMoved' function
game:GetService("ContextActionService"):BindAction("MouseMoved", mouseMoved, false, Enum.UserInputType.MouseMovement)
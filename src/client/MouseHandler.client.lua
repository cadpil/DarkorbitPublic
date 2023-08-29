local players = game:GetService("Players")
local userInputService = game:GetService("UserInputService")
local runService = game:GetService("RunService")

local easyFunctions = require(game.ReplicatedStorage.Shared.EasyFunctions)

local player = players.LocalPlayer

repeat task.wait() until game:IsLoaded()

local playerGui = player:WaitForChild("PlayerGui")
local shipUI = playerGui:WaitForChild"ShipUI"
local persistent = shipUI:WaitForChild"Persistent"
local mouseIcon = persistent:WaitForChild"Mouse"
local mouseGhost = persistent:WaitForChild"MouseGhost"
local mouseBoundry = persistent:WaitForChild"MouseBoundry"

local camera = game.Workspace.CurrentCamera
local vpSize = camera.ViewportSize

camera.CameraSubject = game.Workspace:WaitForChild("ShipSpawnPosition")
camera.CameraType = Enum.CameraType.Scriptable
camera.CFrame = game.Workspace.ShipSpawnPosition.CFrame

userInputService.MouseIconEnabled = false

runService:BindToRenderStep("MouseLock", 0, function()
    userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
end)

shipUI.Enabled = true

local function mouseMoved(actionName, inputState, inputObject)
    local delta = inputObject.Delta
	
    local newMousePosition = mouseGhost.Position + UDim2.new(0,delta.X,0,delta.Y)
    
    mouseGhost.Position = UDim2.new(0.5, math.clamp(newMousePosition.X.Offset, -(mouseBoundry.AbsoluteSize.X/2), mouseBoundry.AbsoluteSize.X/2), 0.5, math.clamp(newMousePosition.Y.Offset, -(mouseBoundry.AbsoluteSize.Y/2), mouseBoundry.AbsoluteSize.Y/2))
    mouseIcon.Position = UDim2.new(mouseGhost.Position.X.Scale, mouseGhost.Position.X.Offset/3, mouseGhost.Position.Y.Scale, mouseGhost.Position.Y.Offset/3)
    
    local mouseTransparency = 1 - ((Vector2.new(vpSize.X/2,mouseBoundry.AbsoluteSize.Y/2) - (mouseGhost.AbsolutePosition+Vector2.new(0,36))-(mouseGhost.AbsoluteSize/Vector2.new(2,2))) / mouseBoundry.AbsoluteSize*2).Magnitude
    if mouseTransparency > 0.91 then mouseTransparency = 1 end

    mouseIcon.Icon.ImageTransparency = mouseTransparency + 0.15
    easyFunctions.PointTo(mouseIcon, mouseGhost)

    
    
end
-- When the mouse is moved, call the 'mouseMoved' function
game:GetService("ContextActionService"):BindAction("MouseMoved", mouseMoved, false, Enum.UserInputType.MouseMovement)
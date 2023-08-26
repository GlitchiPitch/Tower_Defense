local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')

local events = game:GetService('ReplicatedStorage')

local PlayerBackManager = require(game:GetService('ReplicatedStorage').PlayerBackManager)
local PlayerFrontManager = require(game:GetService('ReplicatedStorage').PlayerFrontManager)

local cursorIsContained = false
local isRunning = false

local player = game:GetService('Players').LocalPlayer
local character = player.Character
local humanoid = character.Humanoid

local mouse = player:GetMouse()

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    -- if input.UserInputType == Enum.UserInputType.MouseButton1 then
    --     if cursorIsContained then
    --         PlayerBackManager.GetMouseVector3Position(player, true)
    --     end

    -- end

    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.LeftShift then
        isRunning = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessedEvent)
    if gameProcessedEvent then return end

    if input.KeyCode == Enum.KeyCode.LeftShift then
        isRunning = false
    end

end)

RunService.Heartbeat:Connect(function(deltaTime)
    
    -- local humanoid = script.Parent:FindFirstChild('Humanoid')
    -- if not humanoid then return end
    humanoid.WalkSpeed = isRunning and 50 or 16
    -- if cursorIsContained then PlayerBackManager.GetMouseVector3Position(player)
end)


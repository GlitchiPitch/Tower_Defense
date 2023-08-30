local ServerStorage = game:GetService('ServerStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local Settings = require(ServerScriptService.Settings)

local BindableEvents = ServerStorage.BindableEvents

local Mob = {}

Mob.__index = Mob

function Mob.new(game_, properties, model, side, cframe)
    local self = setmetatable({}, Mob)
    -- self.Tower = towerDefense
    self.Game = game_
    self.Parent = side -- towerDefense.ExistMobs or workspace.PalyerMobs

    self.Model = model

    self.SpawnCFrame = cframe

    for key, value in pairs(properties) do
        self[key] = value
    end

    -- self.health = 10
    -- self.speed = 5
    
    return self
end

function Mob:CheckDead()
    if self.Humanoid.Health <= 0 then
        self:Destroy()
    end
end

function Mob:Setup(humanoid)
    for i, o in pairs(self) do
        local currentProperty = humanoid:FindFirstChild(i)
        if currentProperty then 
            currentProperty = o 
        else
            humanoid:SetAttribute(i, o)
        end
    end

    
end

function Mob:Spawn()
    self.Humanoid = self.Model:FindFirstChild('Humanoid')
    self.HumanoidRootPart = self.Model:FindFirstChild('HumanoidRootPart')
    
    self.Model.Parent = self.Parent
    self.HumanoidRootPart.CFrame = self.SpawnCFrame -- part    
end

function Mob:Init()

    self:Spawn()
    self:CheckDead()

    self.Waypoints = self.Tower.Waypoints
    
    self:Move()
end

function Mob:Move(waypoints)

    for _, waypoint in pairs(waypoints:GetChildren()) do
        self.Humanoid:MoveTo(waypoint.Position)
        self.Humanoid.MoveToFinished:Wait()
    end

    -- finished event
    self.Game.Signals.ToTower:Fire('MobIsFinished')
    self:Destroy()
end

return Mob
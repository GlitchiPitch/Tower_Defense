local ServerStorage = game:GetService('ServerStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local Settings = require(ServerScriptService.Settings)

local BindableEvents = ServerStorage.BindableEvents

local Mob = {}

Mob.__index = Mob

function Mob.new(towerDefense, modModel)
    local self = setmetatable({}, Mob)
    self.Tower = towerDefense
    self.health = 10
    self.speed = 5
    self.Model = modModel
    self.Parent = towerDefense.ExistMobs

    return self
end

function Mob:CheckDead()
    if self.Humanoid.Health <= 0 then
        self:Destroy()
    end
end

function Mob:Init()
    self.Humanoid = self.Model:FindFirstChild('Humanoid')
    self.Waypoints = self.Tower.Waypoints

    self.Model.Parent = self.Parent
    self.Model:FindFirstChild('HumanoidRootPart').CFrame = self.Tower.spawnPoint -- part

    self:CheckDead()

    self:Move()
end

function Mob:Move()

    for _, waypoint in pairs(self.Waypoints:GetChildren()) do
        self.Humanoid:MoveTo(waypoint.Position)
        self.Humanoid.MoveToFinished:Wait()
    end

    -- finished event
    self.Tower.Events.ToTower:Fire('MobIsFinished')
    self:Destroy()
end

return Mob
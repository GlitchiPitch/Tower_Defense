local ServerStorage = game:GetService('ServerStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local Settings = require(ServerScriptService.Settings)

local BindableEvents = ServerStorage.BindableEvents

local Mob = {}

Mob.__index = Mob

function Mob.new(towerDefense)
    local self = setmetatable({}, Mob)
    self.Tower = towerDefense
    
    self.Parent = towerDefense.ExistMobs
    self.MobList = self.Tower.Mobs

    self.health = 10
    self.speed = 5
    
    return self
end

function Mob:CheckDead()
    if self.Humanoid.Health <= 0 then
        self:Destroy()
    end
end

function Mob:Create()
    return self.MobList[math.random(#self.MobList)]:Clone()
end

function Mob:Spawn()
    self.Humanoid = self.Mob:FindFirstChild('Humanoid')
    self.Mob.Parent = self.Parent
    self.Mob:FindFirstChild('HumanoidRootPart').CFrame = self.Tower.spawnPoint -- part    
end

function Mob:Init()

    self.Mob = self:Create()    

    self.Waypoints = self.Tower.Waypoints
    
    self:Spawn()
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
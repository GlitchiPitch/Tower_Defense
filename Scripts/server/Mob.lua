local ServerStorage = game:GetService('ServerStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local PathfindingService = game:GetService('PathfindingService')
local Settings = require(ServerScriptService.Settings)

local BindableEvents = ServerStorage.BindableEvents

local Mob = {}

Mob.__index = Mob

function Mob.new(game_, type_, properties, model, side, cframe)
    local self = setmetatable({}, Mob)
    -- self.Tower = towerDefense
    self.Game = game_
    self.Parent = side -- towerDefense.ExistMobs or towerDefence.PalyerMobs
    self.Type = type_
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

function Mob:Setup()
    for i, o in pairs(self) do
        local currentProperty = self.Humanoid:FindFirstChild(i)
        if currentProperty then 
            currentProperty = o 
        else
            self.Humanoid:SetAttribute(i, o)
        end
    end

    
end

function Mob:Action()
    if self.Type == 'Mob' then
        self:Move()
    elseif self.Type == 'PlayerMob' then
        self:FindTarget()
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
    self:Setup()
    self:CheckDead()

    self:Action()

    self.Waypoints = self.Parent:FindFirstChild('Waypoints')
    
    self:Move()
end

function Mob:GetPath()
    local path = PathfindingService:CreatePath()
    path:ComputeAsync(self.HumanoidRootPart.Position, self.Parent.Parent:FindFirstChild('startPoint').Position)
    return path:GetWaypoints()
end

function Mob:Move()

    for _, waypoint in pairs(self:GetPath():GetChildren()) do
        self.Humanoid:MoveTo(waypoint.Position)
        self.Humanoid.MoveToFinished:Wait()
    end

    -- finished event
    self.Game.Signals.ToTower:Fire('MobIsFinished')
    self:Destroy()
end

function Mob:FindTarget()
    

    self:Shoot()
end

function Mob:Shoot()
    
end

return Mob
local ServerStorage = game:GetService('ServerStorage')
local ServerScriptService = game:GetService('ServerScriptService')

local MobsManager = require(ServerScriptService.MobsManager)

local Settings = require(ServerScriptService.Settings)

local BindableEvents = ServerStorage.BindableEvents

TOWER_DAMAGE = 10
COOL_DOWN = 5
WAVE_COOL_DOWN = 5

BindableTags = {'MobIsFinished', -- minus health
                'GameOver'} -- health is 0}

local Tower = {}

Tower.__index = Tower

function Tower.new(game_, waves, mobsQuantity, towerDefense)
    local self = setmetatable({}, Tower)

    self.Game = game_
    self.TowerDefense = towerDefense
    self.Health = 1000

    self.ModsQuantity = mobsQuantity
    self.Waves = waves
    
    return self
    
end

function Tower:Init()
    self.Events = self.Game.Events
    self.MobList = self.Game.Mobs:GetChildren()

    self.ExistMobs = Instance.new('Folder')
    self.ExistMobs.Parent = workspace

    self:SpawnMobs()

    
end


function Tower:CreateMob()
    MobsManager.new(self, self.MobList[math.random(#self.MobList)]:Clone())
    self.MobsQuantity -= 1
end

function Tower:SpawnMobs()
    coroutine.wrap(function()
        while self.Game.Status and self.Waves > 0 do
            self:CreateMob()
            wait(COOL_DOWN)
            if self.MobsQuantity == 0 then
                self.Waves -= 1
                task.wait(WAVE_COOL_DOWN)
            end
        end
        
        if self.Waves == 0 then
            self.Events.ToGame:Fire('Win')
        end
    end)()
end

function Tower:ChangeHealth()

    self.Events.ToTower.Event:Connect(function(action)
        if action == 'MobIsFinished' then
            self.Health -= TOWER_DAMAGE
            if self.Health <= 0 then
                self.Events.ToGame:Fire('GameOver')
            end
        end
    end)

end

return Tower
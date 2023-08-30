local ServerStorage = game:GetService('ServerStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local Settings = require(ServerScriptService.Settings)

local TowerManager = require(ServerScriptService.TowerManager)
local MainMobsManager = require(ServerScriptService.MainMobsManager)

local BindableEvents = ServerStorage.BindableEvents
local TowerDefenseTemplate = workspace.TowerDefenseTemplate

local GameDescription = require(ServerScriptService.GameDescription)

local mobsModules = ServerScriptService.MobsModules
local playerMobsModules = ServerScriptService.PlayerMobsModules

function CreateBindableEvents(events)

    -- local EVENTS = {'ToGame', 'ToTower', 'ToClient'}

    local eventsFolder = Instance.new('Folder')
    -- eventsFolder.Parent = game:GetService('ReplicatedStorage')      --ServerStorage
    -- eventsFolder.Name = nameFolder

    local function setupEvent(name)
        local event = Instance.new('BindableEvent')
        event.Parent = eventsFolder
        event.Name = name
    end

    for _, eventName in pairs(events) do
        setupEvent(eventName)
    end

    return eventsFolder
end

local Game = {}

Game.__index = Game

function Game.new(player)
    local self = setmetatable({}, Game)

    self.Status = true
    self.Player = player

    self.Signals = CreateBindableEvents(GameDescription.Signals)
    self.GameEvents = CreateBindableEvents(GameDescription.GameEvents)

    self.Mobs = MainMobsManager.MobsManager(self, GameDescription.Mobs)
    self.PlayerMobs = MainMobsManager.MobsManager(self, GameDescription.PlayerMobs)
    
    
    self.Tower = TowerManager.new(self, TowerDefenseTemplate)
    self.WavesQuantity = 10
    self.MobsPerWaveQuantity = 10

    return self
end

function Game:WaitGameOver()
   self.Signals.ToGame.Event:Connect(function(action)
        if action == 'GameOver' then
            self.Status = false
        elseif action == 'Win' then
            -- player get money
            self.Status = false
        end
   end)
end

function Game:SubscribeEvents()
    for _, event in pairs(self.Signals) do
        
    end

    for _, event in pairs(self.GameEvents) do
        
    end

end

function Game:StartGame()
    self.Tower:Init()
    self.Mobs:Init()
    self.PlayerMobs:Init()
end

function Game:Init()
    
    self:StartGame()
    


    self:WaitGameOver()
end

return Game
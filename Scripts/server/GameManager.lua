local ServerStorage = game:GetService('ServerStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local Settings = require(ServerScriptService.Settings)

local TowerManager = require(ServerScriptService.TowerManager)
local MainMobsManager = require(ServerScriptService.MainMobsManager)

local BindableEvents = ServerStorage.BindableEvents
local TowerDefenseTemplate = workspace.TowerDefenseTemplate
local MobsModels = workspace.MobsModels

local mobsModules = ServerScriptService.MobsModules
local playerMobsModules = ServerScriptService.PlayerMobsModules

function CreateBindableEvents()

    local EVENTS = {'ToGame', 'ToTower', 'ToClient'}

    local eventsFolder = Instance.new('Folder')
    eventsFolder.Parent = game:GetService('ReplicatedStorage')      --ServerStorage
    eventsFolder.Name = 'BindableEvents'

    local function setupEvent(name)
        local event = Instance.new('BindableEvent')
        event.Parent = eventsFolder
        event.Name = name
    end

    for _, eventName in pairs(EVENTS) do
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

    self.Events = CreateBindableEvents()
    self.Mobs = MainMobsManager.MobsManager(self, mobsModules)
    self.PlayerMobs = MainMobsManager.MobsManager(self, playerMobsModules)
    
    
    self.TowerDefense = TowerManager.new(self, TowerDefenseTemplate)
    self.WavesQuantity = 10
    self.MobsPerWaveQuantity = 10

    return self
end

function Game:WaitGameOver()
   self.Events.ToGame.Event:Connect(function(action)
        if action == 'GameOver' then
            self.Status = false
        elseif action == 'Win' then
            -- player get money
            self.Status = false
        end
   end)
end

function Game:StartGame()
    self.TowerDefense:Init()
end

function Game:Init()
    
    self.Mobs:Init()
    self.PlayerMobs:Init()

    self:StartGame()

    self:WaitGameOver()
end

return Game
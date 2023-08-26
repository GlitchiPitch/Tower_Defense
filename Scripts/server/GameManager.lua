local ServerStorage = game:GetService('ServerStorage')
local ServerScriptService = game:GetService('ServerScriptService')
local Settings = require(ServerScriptService.Settings)

local TowerManager = require(ServerScriptService.TowerManager)

local BindableEvents = ServerStorage.BindableEvents
local TowerDefenseTemplate = workspace.TowerDefenseTemplate
local MobsModels = workspace.MobsModels


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

function Game.new()
    local self = setmetatable({}, Game)

    self.Status = true
    
    self.Events = CreateBindableEvents()
    self.Mobs = MobsModels
    
    self.TowerDefense = TowerManager.new(self, TowerDefenseTemplate)

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
    

    self:WaitGameOver()
end

return Game
local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local PlayerMobsModules = (ServerScriptService.PlayerMobsModules)
local GameDescription = require(ServerScriptService.GameDescription)
local Mob = require(ServerScriptService.Mob)

local MobsModels = workspace.MobsModels

local MainMobsManager = {}

MainMobsManager.__index = MainMobsManager

function MainMobsManager.MobsManager(game_, tableProperties) -- mobsModules
    local self = setmetatable({}, MainMobsManager)

    self.Game = game_
    self.MobClasses = self:CreateMobClasses(tableProperties)
    self.MobsModelList = self:GetMobModels()

    

    -- self.MobsModules = self:RequireModules(mobsModules)

    return self
end

function MainMobsManager:CreateMobClasses(tableProperties)
    local mobClasses = setmetatable({}, self)
    for mobName, mobDescription in pairs(tableProperties) do
        for key, value in pairs(mobDescription) do
            mobClasses[mobName] = { key = value }
            
        end
    end
    return mobClasses
end

function MainMobsManager:GetMobModels()
    local mobModelList = {}
    for mobName, mobDescription in pairs(self.MobsClasses) do
        local id = mobDescription.id
        for _, mob in pairs(MobsModels:GetChildren()) do
            if mob:GetAttribute('Id') == id then
                mobModelList[id] = mob
            end
        end
    end
    return mobModelList
end

function MainMobsManager:Init()
    -- events from the game
    self.Game.Signals.ToGame.Event:Connect(function(event, ...)
        if event == GameDescription.GameEvents.SpawnMob then
            local parent, cframe, mobId = ... -- parent, cframe, mobId
            self[GameDescription.GameEvents.SpawnMob](mobId, parent, cframe)
        end
        
    end)
end

function MainMobsManager:SetupMob(mobMobel, parent, spawnCFrame) -- возможно из тавера 
    local mob = mobMobel:Clone()
    mob.Parent = parent
    local humanoidRootPart = mob:FindFirstChild('HumanoidRootPart')
    if humanoidRootPart then humanoidRootPart.CFrame = spawnCFrame end

end

function MainMobsManager:SpawnMob(mobId, parent, cframe)
    local mob
    for _, mobClass in pairs(self.MobClasses) do
        if mobClass.id == mobId then mob = Mob.new(mobClass, self.MobsModelList[mobId]:Clone(), parent, cframe) break end
    end
    if mob then mob:Init() end
end

return MainMobsManager
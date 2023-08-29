local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local PlayerMobsModules = (ServerScriptService.PlayerMobsModules)

local MainMobsManager = {}

MainMobsManager.__index = MainMobsManager

function MainMobsManager.MobsManager(game_, mobsModules)
    local self = setmetatable({}, MainMobsManager)

    self.Game = game_
    self.MobsModules = self:RequireModules(mobsModules)

    return self
end
local PlayerMobsList = MainMobsManager.RequireModules()

function MainMobsManager:RequireModules(mobsModules)
    local mobsList = {}
    for i, module in pairs(mobsModules:GetChildren()) do
        mobsList[i] = { name = module.Name, module = require(module)}
    end 
    return mobsList
end

function MainMobsManager:Init()
    
end


function MainMobsManager:FindMob(mobId)
    local currentMob = self.MobsModules[mobId].new()
end

function MainMobsManager:SpawnMob(mobId)
    local mob = MainMobsManager.FindMob(mobId)
end

return MainMobsManager
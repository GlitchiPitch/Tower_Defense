local ServerScriptService = game:GetService("ServerScriptService")
local ServerStorage = game:GetService("ServerStorage")

local PlayerMobsModules = (ServerScriptService.PlayerMobsModules)

local PlayerMobsManager = {}

local PlayerMobsList = PlayerMobsManager.RequireModules()

PlayerMobsManager.RequireModules = function()
    local playerMobsModules = {}
    for i, module in pairs(playerMobsModules:GetChildren()) do
        playerMobsModules[i] = { name = module.Name, module = require(module)}
    end 
    return playerMobsModules
end

PlayerMobsManager.FindMob = function(mobIdFromCLient)
    local currentMob = PlayerMobsList[mobIdFromCLient].new()
end

PlayerMobsManager.SpawnMob = function(mobIdFromCLient)
    local mob = PlayerMobsManager.FindMob(mobIdFromCLient)
end

return PlayerMobsManager
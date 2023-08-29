local ServerScriptService = game:GetService("ServerScriptService")

local mobsModules = ServerScriptService.MobsModules

local MobManager = {}

MobManager.SpawnMob = function(mobIdFromServer)
end

MobManager.MobList = MobManager.RequireModules()

MobManager.RequireModules = function()
    local mobList = {}
    for i, module in pairs(mobsModules:GetChildren()) do
        mobList[i] = { name = module.Name, module = require(module)}
    end 
    return mobList
end

return MobManager
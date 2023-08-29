local ServerScriptService = game:GetService('ServerScriptService')
local Players = game:GetService('Players')
local Game = require(ServerScriptService.GameManager)

Players.PlayerAdded:Connect(function(player)
    game.Loaded:Wait()

    local game = Game.new(player)
    game:Init(player)
end)


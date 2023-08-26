local PlayerMob = require(game:GetService('ServerScriptService').PlayerMob)

local PlayerMob5 = {}

function PlayerMob5(game_)
    local model = 'model'
    local self = setmetatable({}, PlayerMob.new(game_, model, 10, 10, 10))

    self.Bullet = 'bullet'
    return self
end



function PlayerMob5:Init()
    
end

return PlayerMob5
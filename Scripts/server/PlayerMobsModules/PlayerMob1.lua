local PlayerMob = require(game:GetService('ServerScriptService').PlayerMob)

local PlayerMob1 = {}

function PlayerMob1(game_)
    local model = 'model'
    local self = setmetatable({}, PlayerMob.new(game_, model, 10, 10, 10))

    self.Bullet = 'bullet'
    return self
end



function PlayerMob1:Init()
    
end

return PlayerMob1
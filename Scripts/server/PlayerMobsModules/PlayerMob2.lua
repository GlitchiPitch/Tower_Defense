local PlayerMob = require(game:GetService('ServerScriptService').PlayerMob)

local PlayerMob2 = {}

function PlayerMob2(game_)
    local model = 'model'
    local self = setmetatable({}, PlayerMob.new(game_, model, 10, 10, 10))

    self.Bullet = 'bullet'
    return self
end



function PlayerMob2:Init()
    
end

return PlayerMob2
local PlayerMob = require(game:GetService('ServerScriptService').PlayerMob)

local PlayerMob4 = {}

function PlayerMob4(game_)
    local model = 'model'
    local self = setmetatable({}, PlayerMob.new(game_, model, 10, 10, 10))

    self.Bullet = 'bullet'
    return self
end



function PlayerMob4:Init()
    
end

return PlayerMob4
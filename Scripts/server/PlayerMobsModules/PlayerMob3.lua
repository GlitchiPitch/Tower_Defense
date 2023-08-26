local PlayerMob = require(game:GetService('ServerScriptService').PlayerMob)

local PlayerMob3 = {}

function PlayerMob3(game_)
    local model = 'model'
    local self = setmetatable({}, PlayerMob.new(game_, model, 10, 10, 10))

    self.Bullet = 'bullet'
    return self
end



function PlayerMob3:Init()
    
end

return PlayerMob3
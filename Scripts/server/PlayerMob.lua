local PlayerMob = {}

PlayerMob.__index = PlayerMob

function PlayerMob.new(game_, mob, health, damage, coolDown)
    local self = setmetatable({}, PlayerMob)

    self.Game = game_
    self.Mob = mob
    self.Health = health
    self.Damage = damage
    self.CoolDown = coolDown

    return self
end

function PlayerMob:Update()

    if self.MobHumanoid.Health <= 0 then
        self:Destroy()
    end

end

function PlayerMob:Shoot()
    
end

function PlayerMob:Init()
    self.Events = self.Game.Events
    self.MobHumanoid = self.Mob.Humanoid
    self.MobHumanoid.Health, self.MobHumanoid.MaxHealth = self.Health, self.Health
end

return PlayerMob
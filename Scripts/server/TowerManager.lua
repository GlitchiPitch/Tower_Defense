local ServerStorage = game:GetService("ServerStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local MobsManager = require(ServerScriptService.MobsManager)
local PlayerManager = require(ServerScriptService.PlayerManager)

local Settings = require(ServerScriptService.Settings)

local BindableEvents = ServerStorage.BindableEvents

TOWER_DAMAGE = 10
COOL_DOWN = 5
WAVE_COOL_DOWN = 5

BindableTags = {
	"MobIsFinished", -- minus health
	"GameOver",
} -- health is 0}

local Tower = {}

Tower.__index = Tower

function Tower.new(game_, waves, mobsQuantity, towerDefense)
	local self = setmetatable({}, Tower)

	self.Game = game_
	self.TowerDefense = towerDefense
	self.Health = 1000

	self.ModsQuantity = mobsQuantity
	self.Waves = waves

	return self
end

function Tower:Init()
	self.Events = self.Game.Events
	self.MobList = self.Game.Mobs:GetChildren()

	self.ExistMobs = Instance.new("Folder")
	self.ExistMobs.Parent = workspace
	self:SpawnMobs()
end

function Tower:SpawnMobs()
    local plrGui = PlayerManager.GetGui(self.Game.Player)
	coroutine.wrap(function()
		for wave = 1, self.Game.WavesQuantity do
			for i = 1, self.Game.MobsPerWaveQuantity do
                if self.Game.Status then
                    local mob = MobsManager.new(self)
                    mob:Init()
                    wait(COOL_DOWN)
                    plrGui.WavesBar.mobText.Text = i
                end
			end
            task.wait(WAVE_COOL_DOWN)
            plrGui.WavesBar.waveText.Text = wave
		end
        if self.Game.Status then self.Events.ToGame:Fire("Win") end
	end)()

end

function Tower:ChangeHealth()
	self.Events.ToTower.Event:Connect(function(action)
		if action == "MobIsFinished" then
			self.Health -= TOWER_DAMAGE
			if self.Health <= 0 then
				self.Events.ToGame:Fire("GameOver")
			end
		end
	end)
end

return Tower

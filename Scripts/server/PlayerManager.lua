local PlayerManager = {}

PlayerManager.GetGui = function(player)
	local playerGui = player:FindFirstChild("PlayerGui")
	local mainGui = playerGui:FindFirstChild("MainGui")

	local hpBar = mainGui.HpBar
	local moneyBar = mainGui.MoneyBar
	local attentionBar = mainGui.AttentionBar
    local wavesBar = mainGui.WavesBar

	return {
		HpBar = { background = hpBar.background, text = hpBar.text },
		MoneyBar = { text = moneyBar.text },
		AttentionBar = { text = attentionBar.text },
		WavesBar = { waveText = wavesBar.waveText, mobText = wavesBar.mobText },
	}
end

PlayerManager.GetMoney = function(player) end

PlayerManager.SetMoney = function(player) end

PlayerManager.PlayerData = function(player) end

PlayerManager.GetPlayerMobs = function(player) end

return PlayerManager

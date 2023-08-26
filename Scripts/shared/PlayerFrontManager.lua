local PlayerManager = {}

PlayerManager.GetLeadboard = function(player)
    local leaderstats = player.leaderstats

    return leaderstats
end

PlayerManager.GetGui = function(player)
    local plrGui = player:FindFirstChild('PlayerGui')
    local MainGui = plrGui:FindFirstChild('MainGui')
    return MainGui    
end

PlayerManager.SetMoney = function(player, value)
    PlayerManager.GetLeadboard(player).Money = value
end

PlayerManager.GetMoney = function(player)
    return PlayerManager.GetLeadboard(player).Money
end


return PlayerManager
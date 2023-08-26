local PlayerManager = {}

PlayerManager.PlayerData = function(player)
    -- get player data
end


PlayerManager.

PlayerManager.GetMouseVector3Position = function(player)
    local mouse = player:GetMouse()
    local checkMouse
    if action then
        checkMouse = mouse.Move:Connect(function()
            return mouse.Hit.Position
        end)
    end
    if not action then checkMouse:Disconnect() end
end


return PlayerManager
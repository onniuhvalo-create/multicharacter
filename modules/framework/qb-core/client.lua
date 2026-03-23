if GetResourceState('qb-core') ~= 'started' then return end
if GetResourceState('qbx_core') == 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()

Framework = {}

--- Framework.GetFrameworkName()
--- @return string
function Framework.GetFrameworkName()
    return 'qb-core'
end

--- Framework.GetPlayerData()
--- @return table
function Framework.GetPlayerData()
    local playerData = QBCore.Functions.GetPlayerData()
    if not playerData then
        return {}
    end

    return playerData
end
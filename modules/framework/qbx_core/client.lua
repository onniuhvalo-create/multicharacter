if GetResourceState('qbx_core') ~= 'started' then return end

local QBox = exports.qbx_core

Framework = {}

--- Framework.GetFrameworkName()
--- @return string
function Framework.GetFrameworkName()
    return 'qbx_core'
end

--- Framework.GetPlayerData()
--- @return table
function Framework.GetPlayerData()
    local playerData = QBox:GetPlayerData()
    if not playerData then
        return {}
    end

    return playerData
end
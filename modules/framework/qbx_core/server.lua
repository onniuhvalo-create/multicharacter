if GetResourceState('qbx_core') ~= 'started' then return end

local QBox = exports.qbx_core

Framework = {}

--- Framework.GetFrameworkName()
--- @return string
function Framework.GetFrameworkName()
    return 'qbx_core'
end

function FormatPlayersQuery(data)
    local players = {}

    for _, player in ipairs(data) do
        players[#players+1] = {
            cid = player.cid,
            citizenid = player.citizenid,
            charinfo = json.decode(player.charinfo),
            job = json.decode(player.job),
            money = json.decode(player.money),
            position = json.decode(player.position),
        }
    end

    return players
end

--- Framework.GetPlayerQuery(source)
--- @param source number
--- @return table|nil
function Framework.GetPlayerQuery(source)
    if not source then return nil end

    local retval = GetPlayerIdentifierByType(tostring(source), 'license2')
    if not retval then return nil end

    local query = MySQL.query.await('SELECT * FROM players WHERE license = ?', { retval })
    if not query or #query == 0 then return nil end

    return FormatPlayersQuery(query)
end

--- Framework.Login(source, citizenid, newData)
--- @param source number
--- @param citizenid string|nil
--- @param newData? table
--- @return boolean
function Framework.Login(source, citizenid, newData)
    return QBox:Login(source, citizenid, newData)
end

--- Framework.Logout(source)
--- @param source number
--- @return nil
function Framework.Logout(source)
    if not source then return false end

    QBox:Logout(source)
end

function Framework.RefreshCommand(source)
end

--- Framework.GetPlayer(source)
--- @param source number
--- @return table|nil
function Framework.GetPlayer(source)
    if not source then return nil end

    return QBox:GetPlayer(source)
end
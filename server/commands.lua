local Config = require 'config.config'

lib.addCommand('logout', { help = 'Log out of your character!', params = {}, restricted = 'group.admin' }, function(source, args, raw)
    if not source then return end

    local playerId = source
    local xPlayer = Framework.GetPlayer(playerId)

    if not xPlayer then return end

    if not PlayerData[playerId] then
        Debug("Player %s (%s) is not logged in", GetPlayerName(playerId), playerId)
        return
    end

    Framework.Logout(playerId)

    print('^2[0r-multicharacterv3]^7 ' .. GetPlayerName(playerId) .. ' has logged out successfully!')
    TriggerClientEvent('0r-multicharacterv3:client:loadUserData', playerId)

    AddLogs(playerId, '[LOGOUT]', 'User has logged out of the server', 'red', 'logout')
end)

lib.addCommand('deletecharacter', { help = 'Delete a character data', params = {{ name = 'citizenid', type = 'string', help = 'Target player\'s citizen id' }}, restricted = 'group.admin' }, function(source, args, raw)
    if not source then return end

    local playerId = source
    local xPlayer = Framework.GetPlayer(playerId)

    if not xPlayer then return end

    local targetCID = Items(args.citizenid)

    if not targetCID or targetCID == '' then return end

    DeleteCharacter(targetCID)
end)

if Config.DeveloperMode then
    lib.addCommand('checkbucket', { help = 'Check your routing bucket', params = {}, restricted = 'group.admin' }, function(source, args, raw)
        if not source then return end

        local playerId = source
        print(GetPlayerRoutingBucket(playerId))
    end)
end
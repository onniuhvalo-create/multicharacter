PlayerData = {}
Characters = {}

local Config = require 'config.config'

local function CheckLicense(source)
    local identifier = GetPlayerIdentifierByType(tostring(source), 'license')

    if not identifier or identifier == '' then
        return 0
    end

    for _, license in ipairs(Config.CharacterSlots.Custom.licenses) do
        if identifier == license.id then
            return license.slot or 0
        end
    end

    return 0
end

--- GetNumberCharacterSlots(source)
--- @param source number
--- @return number
local function GetNumberCharacterSlots(source)
    if not source then return 0 end

    local identifier = GetPlayerIdentifierByType(tostring(source), 'license2')
    if not identifier then
        return Config.DefaultCharacterSlots
    end

    local baseSlots = Config.DefaultCharacterSlots
    local discordSlots, licenseSlots = 0, 0

    if Config.CharacterSlots.Discord.status then
        discordSlots = tonumber(CheckDiscord(source)) or 0
    end

    if Config.CharacterSlots.Custom.status then
        licenseSlots = tonumber(CheckLicense(source)) or 0
    end

    local result = MySQL.query.await('SELECT character_slot FROM 0r_multicharacterv3 WHERE identifier = ?', { identifier })

    local dbSlots = 0
    if result and result[1] then
        dbSlots = tonumber(result[1].character_slot) or 0
    end

    return baseSlots + dbSlots + discordSlots + licenseSlots
end


lib.callback.register('0r-multicharacterv3:callback:getCharacters', function(source)
    if not source then return end

    local playerId = source

    Characters = {}
    local slotCount = GetNumberCharacterSlots(playerId)
    local playerQuery = Framework.GetPlayerQuery(playerId)

    if playerQuery then
        Debug("Characters loaded for %s (%s)", GetPlayerName(playerId), playerId)
        Characters = playerQuery
        return playerQuery, slotCount
    else
        Debug("Not characters data for %s (%s)", GetPlayerName(playerId), playerId)
        return {}, slotCount
    end
end)

lib.callback.register('0r-multicharacterv3:server:deleteCharacter', function(source, citizenid)
    if not source then return end

    for i = 1, #Characters do
        if Characters[i] and Characters[i].citizenid == citizenid then
            DeleteCharacter(citizenid)
        end
    end
end)

lib.callback.register('0r-multicharacterv3:server:checkTebexCode', function(source, code)
    if not source or not code then return end

    local playerId = source
    local identifier = GetPlayerIdentifierByType(tostring(playerId), 'license2')

    if not identifier or identifier == '' then
        return { status = 'error' }
    end

    local totalSlot = 0

    if string.find(code, 'tbx') and Config.CharacterSlots.Tebex.status then
        local retval = CheckTebex(code)

        if not retval or retval == false then
            return { status = 'error' }
        end

        totalSlot = retval
    else
        local retval = MySQL.query.await('SELECT * FROM 0r_multicharacterv3_code WHERE code = ?', { code })

        if not retval or #retval == 0 then
            return { status = 'error' }
        end

        totalSlot = retval[1].slot
        MySQL.query.await('DELETE FROM 0r_multicharacterv3_code WHERE code = ?', { code })
    end

    local newSlot = GetNumberCharacterSlots(playerId) + totalSlot
    MySQL.query.await('UPDATE 0r_multicharacterv3 SET character_slot = ? WHERE identifier = ?', { newSlot, identifier })

    return {
        status = 'success',
        slot = newSlot
    }
end)

AddEventHandler('QBCore:Server:PlayerLoaded', function(Player)
    Wait(1000)
    PlayerData[Player.PlayerData.source] = true
end)

AddEventHandler('QBCore:Server:OnPlayerUnload', function(src)
    PlayerData[src] = false
end)

RegisterNetEvent('esx:playerLoaded', function(player, xPlayer, isNew)
    Wait(1000)
    PlayerData[player] = true
end)

RegisterNetEvent('esx:playerDropped', function(playerId, reason)
    PlayerData[playerId] = false
end)

RegisterNetEvent('0r-multicharacterv3:server:changeRoutingBucket', function(boolean)
    if not source then return end

    local playerId = source

    if boolean then
        print('^2[0r-multicharacterv3]^7 ' .. GetPlayerName(playerId) .. ' has changed routing bucket to 0')
        SetPlayerRoutingBucket(playerId, 0)
    else
        print('^2[0r-multicharacterv3]^7 ' .. GetPlayerName(playerId) .. ' has changed routing bucket to ' .. playerId + 1)
        SetPlayerRoutingBucket(playerId, playerId + 1)
    end
end)

RegisterNetEvent('0r-multicharacterv3:server:playCharacter', function(characterData)
    if not source then return end

    local playerId = source
    local success = Framework.Login(playerId, characterData.citizenid)

    if success then
        while not PlayerData[playerId] do
            Wait(100)
        end

        print('^2[0r-multicharacterv3]^7 ' .. GetPlayerName(playerId) .. ' (Citizen ID: ' .. characterData.citizenid .. ') has successfully loaded!')

        Framework.RefreshCommand(playerId)
        LoadHouseData(playerId)
        SetPlayerRoutingBucket(playerId, 0)
        GetSpawnUI(playerId, characterData)

        AddLogs(playerId, '[PLAY GAME]', 'User has joined the server | CitizenID: ' .. characterData.citizenid, 'green', 'playgame')
    end
end)

RegisterNetEvent('0r-multicharacterv3:server:createCharacter', function(characterData)
    if not source then return end

    local playerId = source
    local success = Framework.Login(playerId, nil, characterData)

    if success then
        while not PlayerData[playerId] do
            Wait(100)
        end

        print('^2[0r-multicharacterv3]^7 ' .. GetPlayerName(playerId) .. ' (Citizen ID: ' .. characterData.charinfo.cid .. ') has successfully created a character!')

        Framework.RefreshCommand(playerId)
        LoadHouseData(playerId)
        GiveStarterItems(playerId)

        if Config.ApartmentStart then
            TriggerClientEvent('0r-multicharacterv3:client:startingApartment', playerId)
        else
            TriggerClientEvent('0r-multicharacterv3:client:noStartingApartment', playerId)
        end
    end
end)

CreateThread(function()
    if not Inventory then
        error('The inventory script was not detected. Please start your inventory script before the 0r-multicharacterv3 script, or your inventory script may not be supported.')
    end

    if GetResourceState('basic-gamemode') == 'started'  then
        error('The basic-gamemode script was detected. Please delete the basic-gamemode script for the script to work properly.')
    end
end)

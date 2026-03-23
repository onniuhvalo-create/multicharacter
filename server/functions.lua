local Config = require 'config.config'
local Database = require 'config.database'

--- CustomIDCard(source, item)
--- @param source number
--- @param item table
--- @return nil
local function CustomIDCard(source, item)
     if GetResourceState('um-idcard') == 'started' then
        exports['um-idcard']:CreateMetaLicense(source, item)
    elseif GetResourceState('bl_idcard') == 'started' then
        TriggerClientEvent('bl_idcard:client:openID', source, item)
    elseif GetResourceState('qbx_idcard') == 'started' then
        exports['qbx_idcard']:CreateMetaLicense(source, item)
    end
end

--- DefaultQBMetaData(player, item)
--- @param player table
--- @param item string
--- @return table
local function DefaultQBMetaData(player, item)
    local data = {}
    if item == "id_card" then
        data = {
            citizenid = player.citizenid,
            firstname = player.charinfo.firstname,
            lastname = player.charinfo.lastname,
            birthdate = player.charinfo.birthdate,
            gender = player.charinfo.gender,
            nationality = player.charinfo.nationality,
        }
    elseif item == "driver_license" then
        data = {
            firstname = player.charinfo.firstname,
            lastname = player.charinfo.lastname,
            birthdate = player.charinfo.birthdate,
            type = "Class C Driver License",
        }
    end
    return data
end

--- GiveStarterItems(source)
--- @param playerId number
--- @return nil
function GiveStarterItems(playerId)
    if not playerId then return end

    local xPlayer = Framework.GetPlayer(playerId)
    if not xPlayer then return end

    local starterItems = Config.StarterItems
    if not starterItems or #starterItems == 0 then
        print('^1[0r-multicharacterv3]^7 No starter items configured in config.lua')
        return
    end

    for i = 1, #starterItems do
        local item = starterItems[i]
        local metadata = {}

        if item.name == 'id_card' or item.name == 'driver_license' then
            if item.customExport then
                CustomIDCard(playerId, item)
            else
                if Framework.GetFrameworkName() ~= 'es_extended' then
                    metadata = DefaultQBMetaData(xPlayer.PlayerData, item.name)
                end
            end
        end

        if not item.customExport then
            Inventory.AddItem(playerId, item.name, item.amount, nil, metadata)
        end
    end
end

--- GetSpawnUI(playerId, characterData)
--- @param playerId number
--- @param characterData table
--- @return nil
function GetSpawnUI(playerId, characterData)
    if not playerId or not characterData then return end

    local position = characterData.position

    if Config.SkipSpawnSelector then
        TriggerClientEvent('0r-multicharacterv3:client:hideAnimation', playerId)
        TriggerClientEvent('0r-multicharacterv3:client:spawnPlayer', playerId, position)
    elseif Config.SpawnSelector == 'custom' then
        Config.CustomSpawnExports(playerId, position)
    elseif Config.SpawnSelector and Config.SpawnSelector ~= '' then
        if Config.SpawnSelector == '0r-spawn' then
            TriggerClientEvent('0r-multicharacterv3:client:hideAnimation', playerId)
            TriggerClientEvent('0r-multicharacterv3:client:spawnSelector', playerId, 'spawn', position)
        elseif Config.SpawnSelector == 'qbx_spawn' then
            TriggerClientEvent('qb-spawn:client:setupSpawns', playerId)
            Wait(500)
            TriggerClientEvent('0r-multicharacterv3:client:closeNUI', playerId)
        elseif Config.SpawnSelector == 'qb-spawn' then
            TriggerClientEvent('qb-spawn:client:setupSpawns', playerId, { citizenid = characterData.citizenid }, false, nil)
            TriggerClientEvent('qb-spawn:client:openUI', playerId, true)
            TriggerClientEvent('0r-multicharacterv3:client:closeNUI', playerId)
        elseif Config.SpawnSelector == 'um-spawn' then
            TriggerClientEvent('um-spawn:client:startSpawnUI', playerId)
            TriggerClientEvent('0r-multicharacterv3:client:closeNUI', playerId)
        elseif Config.SpawnSelector == 'vms_spawnselector' then
            TriggerClientEvent('vms_spawnselector:open', playerId)
            TriggerClientEvent('0r-multicharacterv3:client:closeNUI', playerId)
        end
    else
        print('^1[0r-multicharacterv3]^7 Invalid spawn selector configured in config.lua')
    end
end

--- LoadHouseData(source)
--- @param source number
--- @return nil
function LoadHouseData(source)
    if Framework.GetFrameworkName() ~= 'qb-core' then
        return
    end

    local HouseGarages = {}
    local Houses = {}
    local result = MySQL.query.await('SELECT * FROM houselocations', {})
    if result[1] ~= nil then
        for _, v in pairs(result) do
            local owned = false
            if tonumber(v.owned) == 1 then
                owned = true
            end
            local garage = v.garage ~= nil and json.decode(v.garage) or {}
            Houses[v.name] = {
                coords = json.decode(v.coords),
                owned = owned,
                price = v.price,
                locked = true,
                adress = v.label,
                tier = v.tier,
                garage = garage,
                decorations = {},
            }
            HouseGarages[v.name] = {
                label = v.label,
                takeVehicle = garage,
            }
        end
    end
    TriggerClientEvent("qb-garages:client:houseGarageConfig", source, HouseGarages)
    TriggerClientEvent("qb-houses:client:setHouseConfig", source, Houses)
end

--- DeleteCharacter(citizenid)
--- @param citizenid string
--- @return nil
function DeleteCharacter(citizenid)
    if not source then return end

    local frameworkName = Framework.GetFrameworkName()
    local tables = Database.List[frameworkName]
    if not tables or #tables == 0 then
        Debug('Error deleting a character! Database tables not found! Edit 0r-multicharacterv3/config/database.lua!')
        return
    end

    for _, table in pairs(tables) do
        if not table.table or not table.column or not table.type then
            Debug('Error deleting a character! Invalid table configuration in config/database.lua!')
            return
        end

        local query = string.format('SELECT * FROM %s WHERE %s = ?', table.table, table.column)
        local identifier = nil

        if table.type == 'citizenid' then
            identifier = citizenid
        else
            identifier = GetPlayerIdentifierByType(citizenid, table.type)
        end

        if not identifier then
            Debug('Error deleting a character! Identifier not found for citizen ID: ' .. citizenid)
            return
        end

        local result = MySQL.query.await(query, { identifier })

        if result and result[1] then
            query = string.format('DELETE FROM %s WHERE %s = ?', table.table, table.column)

            MySQL.query.await(query, { identifier })
        end
    end

    print('^2[0r-multicharacterv3]^7 Character with citizen ID ' .. citizenid .. ' has been deleted successfully!')

    for i = 1, #Characters do
        if Characters[i] and Characters[i].citizenid == citizenid then
            Characters[i] = nil
            break
        end
    end
end
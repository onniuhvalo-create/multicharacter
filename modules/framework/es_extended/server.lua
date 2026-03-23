if GetResourceState('es_extended') ~= 'started' then return end

local Config = require 'config.config'

ESX = exports["es_extended"]:getSharedObject()

Framework = {}

--- Framework.GetFrameworkName()
--- @return string
function Framework.GetFrameworkName()
    return 'es_extended'
end

local function ConvertESXCharacterDataToQB(data)
    local players = {}

    for _, player in ipairs(data) do
        local job = player.job
        local grade = player.job_grade

        if ESX.DoesJobExist(job, grade) then
            local Jobs = ESX.GetJobs()

            player.job = Jobs[job] and Jobs[job].label or 'Unemployed'
            player.job_grade = Jobs[job] and Jobs[job].grades[tostring(grade)].label or 'Unemployed'
        else
            player.job = 'Unemployed'
            player.job_grade = 'Unemployed'
        end

        local num = string.match(player.identifier, "char(%d+):")

        player.accounts = json.decode(player.accounts)
        player.position = json.decode(player.position)

        players[#players+1] = {
            cid = num,
            citizenid = player.identifier,
            charinfo = {
                cid = num,
                firstname = player.firstname,
                lastname = player.lastname,
                birthdate = player.dateofbirth,
                gender = player.sex,
                phone = player.phone_number or 'N/A',
                nationality = player.nationality or 'N/A',
                height = player.height or false,
            },
            job = {
                name = player.job,
                label = player.job,
                grade = {
                    name = player.job_grade,
                }
            },
            money = {
                cash = player.accounts.money or 0,
                bank = player.accounts.bank or 0,
            },
            position = {
                x = player.position.x or 0.0,
                y = player.position.y or 0.0,
                z = player.position.z or 0.0,
                w = player.position.heading or 0.0,
            }
        }
    end

    return players
end

--- Framework.GetPlayerQuery(source)
--- @param source number
--- @return table|nil
function Framework.GetPlayerQuery(source)
    if not source then return nil end

    local retval = GetPlayerIdentifierByType(tostring(source), 'license'):gsub('license:', '')
    if not retval then return nil end

    local query = MySQL.query.await('SELECT * FROM users WHERE identifier LIKE ?', { "%:" .. retval })
    if not query or #query == 0 then return nil end

    return ConvertESXCharacterDataToQB(query)
end

local function ConvertQBNewDataToESX(newData)
    if not newData or type(newData) ~= 'table' then return nil end

    return {
        firstname = newData.charinfo.firstname or '',
        lastname = newData.charinfo.lastname or '',
        dateofbirth = newData.charinfo.birthdate or '',
        height = newData.charinfo.height or nil,
        nationality = newData.charinfo.nationality or nil,
        sex = newData.charinfo.gender == 0 and 'm' or 'f',
    }
end

--- Framework.Login(source, citizenid, newData)
--- @param source number
--- @param citizenid string|nil
--- @param newData? table
--- @return boolean
function Framework.Login(source, citizenid, newData)
    if not source then return false end
    local newCid = nil
    if citizenid then
        newCid = citizenid:gsub(':' .. GetPlayerIdentifierByType(tostring(source), 'license'):gsub('license:', ''), '')
    else
        newCid = Config.Prefix .. newData.cid
    end
    
    ESX.Players[source] = true
    local formattedData = ConvertQBNewDataToESX(newData)
    TriggerEvent('esx:onPlayerJoined', source, newCid, formattedData)

    return true
end

--- Framework.Logout(source)
--- @param source number
--- @return nil
function Framework.Logout(source)
    if not source then return false end

    ESX.Players[source] = nil
    TriggerEvent("esx:playerLogout", source)
end

function Framework.RefreshCommand(source)
end

--- Framework.GetPlayer(source)
--- @param source number
--- @return table|nil
function Framework.GetPlayer(source)
    if not source then return nil end

    return ESX.GetPlayerFromId(source)
end
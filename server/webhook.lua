local Config = require 'config.config'
if not Config.Logs.status or Config.Logs.logger ~= 'discord' then return end

local botSettings = {
    name = '0R Multicharacter V3',
    image = ''
}

local webhooks = {
    ['playgame'] = '',
    ['logout'] = '',
    ['exploit'] = '',
    ['createcharacter'] = '',
    ['deletecharacter'] = '',
}

local colors = {
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ['lightgreen'] = 65309,
}

---@param src string
---@param idType string
---@return string
local function getIdentifier(src, idType)
    local identifier = GetPlayerIdentifierByType(src, idType) or 'unknown'
    return identifier:gsub(idType .. ':', '') or identifier
end

---@param src string
---@return string
local function userInformation(src)
    local information = string.format(
        "### User Information\n**ID: **%s\n**Name: **%s\n**Discord: **%s\n**Steam: **%s\n**License: **%s\n**License 2: **%s\n",
        tostring(src),
        GetPlayerName(src),
        getIdentifier(src, 'discord'),
        getIdentifier(src, 'steam'),
        getIdentifier(src, 'license'),
        getIdentifier(src, 'license2')
    )
    return information
end

---@param data table
---@async
local function sendWebHook(data)
    local timestamp = os.date("%c")

    local message = {
        {
            ["color"] = data.color,
            ["title"] = data.title,
            ["description"] = data.message,
            ["footer"] = {
                ["text"] = timestamp .. ' | version '..GetResourceMetadata(GetCurrentResourceName(), 'version', 0),
                ["icon_url"] = botSettings.image,
            },
        }
    }

    local jsonData = json.encode({
        username = botSettings.name,
        avatar_url = botSettings.image,
        embeds = message
    })

    SetTimeout(1000, function()
        PerformHttpRequest(data.link, function(_, _, _)
        end, 'POST', jsonData, { ['Content-Type'] = 'application/json' })
    end)
end

---@param src string
---@param type string
---@param message string
---@param color? string
---@param webhook? string
function DiscordWebHook(src, type, message, color, webhook)
    local webhookLink = webhooks[webhook]
    if not webhookLink or webhookLink == '' then return end

    local data = {
        link = webhookLink,
        title = type,
        color = colors[color] or colors['blue'],
        message = userInformation(src) .. '### Message \n ### ' .. message .. ' \n'
    }

    sendWebHook(data)
end
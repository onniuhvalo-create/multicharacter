local Config = require 'config.config'
local selectedLogger = Config.Logs.logger or 'discord'

--- AddLogs(src, type, message, color, webhook)
--- @param source string
--- @param type string
--- @param message string
--- @param color? string
--- @param webhook? string
--- @return nil
function AddLogs(source, type, message, color, webhook)
    if not Config.Logs.status then return end

    if not source then return end

    if selectedLogger == 'discord' then
        DiscordWebHook(source, type, message, color, webhook)
        return
    end

    lib.logger(source, type, message)
end
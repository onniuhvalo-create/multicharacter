local Config = require 'config.config'

function Debug(message, ...)
    if Config.Debug then
        local formattedMessage = string.format(message, ...)
        print("[DEBUG] " .. formattedMessage)
    end
end
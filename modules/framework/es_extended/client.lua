if GetResourceState('es_extended') ~= 'started' then return end

local Config = require 'config.config'

ESX = exports["es_extended"]:getSharedObject()

Framework = {}

--- Framework.GetFrameworkName()
--- @return string
function Framework.GetFrameworkName()
    return 'es_extended'
end
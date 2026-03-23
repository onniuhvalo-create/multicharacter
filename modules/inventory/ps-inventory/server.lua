if GetResourceState('qb-inventory') ~= 'started' then return end

local QBCore = exports['qb-core']:GetCoreObject()
local PS = exports['ps-inventory']

Inventory = Inventory or {}

--- AddItem(source, item, count, slot, metadata)
--- @param source number
--- @param item string
--- @param count? number|nil
--- @param slot? number|nil
--- @param metadata? any|nil
--- @return boolean
function Inventory.AddItem(source, item, count, slot, metadata)
    if not source or not item then
        return false
    end

    TriggerClientEvent('qb-inventory:client:ItemBox', source, QBCore.Shared.Items[item], 'add', count or 1)
    return PS:AddItem(
        source,
        item,
        count or 1,
        slot or nil,
        metadata or {}
    )
end
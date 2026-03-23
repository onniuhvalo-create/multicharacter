if GetResourceState('qs-inventory') ~= 'started' then return end

local Quasar = exports['qs-inventory']

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

    return Quasar:AddItem(
        source,
        item,
        count or 1,
        slot or nil,
        metadata or {}
    )
end
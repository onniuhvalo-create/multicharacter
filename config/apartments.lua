local Config = require 'config.config'
local Apartments = {}

Apartments.List = {
    ['es_extended'] = {
    },
    ['qb-core'] = {
        {
            id = 1,
            label = 'South Rockford Drive',
            img = 'test-image',
            icon = 'fa-solid fa-building',
            coords = vec3(-667.02, -1105.24, 14.63)
        },
        {
            id = 2,
            label = 'Morningwood Blvd',
            img = 'test-image',
            icon = 'fa-solid fa-building',
            coords = vec3(-1288.52, -430.51, 35.15)
        },
        {
            id = 3,
            label = 'Integrity Way',
            img = 'test-image',
            icon = 'fa-solid fa-building',
            coords = vec3(269.73, -640.75, 42.02)
        },
        {
            id = 4,
            label = 'Tinsel Towers',
            img = 'test-image',
            icon = 'fa-solid fa-building',
            coords = vec3(-619.29, 37.69, 43.59)
        },
        {
            id = 5,
            label = 'Fantastic Plaza',
            img = 'test-image',
            icon = 'fa-solid fa-building',
            coords = vec3(291.517, -1078.674, 29.405)
        },
    },
    ['qbx_core'] = {
        {
            id = 1,
            label = 'Del Perro Heights Apt',
            img = 'del-perror-heights',
            icon = 'fa-solid fa-building',
            coords = vec3(-1447.35, -537.84, 34.74)
        },
        {
            id = 2,
            label = 'Del Perro Heights Apt',
            img = 'del-perror-heights',
            icon = 'fa-solid fa-building',
            coords = vec3(-1447.35, -537.84, 34.74)
        },
        {
            id = 3,
            label = '4 Integrity Way Apt',
            img = 'integrity-way',
            icon = 'fa-solid fa-building',
            coords = vec3(-59.4, -616.29, 37.36)
        },
        {
            id = 4,
            label = '4 Integrity Way Apt',
            img = 'integrity-way',
            icon = 'fa-solid fa-building',
            coords = vec3(-47.52, -585.86, 37.95)
        },
        {
            id = 5,
            label = 'Richard Majestic Apt',
            img = 'richard-majestic',
            icon = 'fa-solid fa-building',
            coords = vec3(-936.15, -378.91, 38.96)
        },
        {
            id = 6,
            label = 'Tinsel Towers Apt',
            img = 'tinsel-towers',
            icon = 'fa-solid fa-building',
            coords = vec3(-614.58, 46.52, 43.59)
        },
    }
}

Apartments.SpawnCreateCharacter = function(appType)
    if not Config.ApartmentStart or Framework.GetFrameworkName() == 'es_extended' then return end
    if GetResourceState('ps-housing') == 'started' then
        TriggerServerEvent("ps-housing:server:createNewApartment", appType)
    elseif GetResourceState('qb-apartments') == 'started' then
        local apartmentType = { 'apartment1', 'apartment2', 'apartment3', 'apartment4', 'apartment5' }
        TriggerServerEvent('apartments:server:CreateApartment', apartmentType[appType], Apartments.List[Framework.GetFrameworkName()][appType].label, true)
    elseif GetResourceState('qbx_properties') == 'started' then
        TriggerServerEvent('qbx_properties:server:apartmentSelect', appType)
    elseif GetResourceState('0r-apartment-v2') == 'started' then
        print('0r-apartment-v2 resource found.')
        TriggerServerEvent("apartments:server:CreateApartment", appType, Apartments.List[Framework.GetFrameworkName()][appType].label)
    else
        print('No apartment resource found.')
        return
    end
end

return Apartments

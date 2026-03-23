-- ██╗    ██╗███████╗██╗      ██████╗ ██████╗ ███╗   ███╗███████╗    ████████╗ ██████╗      ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗ 
-- ██║    ██║██╔════╝██║     ██╔════╝██╔═══██╗████╗ ████║██╔════╝    ╚══██╔══╝██╔═══██╗    ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝ 
-- ██║ █╗ ██║█████╗  ██║     ██║     ██║   ██║██╔████╔██║█████╗         ██║   ██║   ██║    ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
-- ██║███╗██║██╔══╝  ██║     ██║     ██║   ██║██║╚██╔╝██║██╔══╝         ██║   ██║   ██║    ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
-- ╚███╔███╔╝███████╗███████╗╚██████╗╚██████╔╝██║ ╚═╝ ██║███████╗       ██║   ╚██████╔╝    ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
--  ╚══╝╚══╝ ╚══════╝╚══════╝ ╚═════╝ ╚═════╝ ╚═╝     ╚═╝╚══════╝       ╚═╝    ╚═════╝      ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝ 

--[[
    Hello Dear Customer!

    Thank you for purchasing the 0Resmon Multicharacter Version 3 script!

    Here you can easily change many settings and customise it to make it compatible with your own server.

    If you encounter any problems, you can open a ticket via https://discord.gg/0resmon
]]

local Config = {}

-- ██████╗ ███████╗██╗   ██╗███████╗██╗      ██████╗ ██████╗ ███████╗██████╗     ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
-- ██╔══██╗██╔════╝██║   ██║██╔════╝██║     ██╔═══██╗██╔══██╗██╔════╝██╔══██╗    ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
-- ██║  ██║█████╗  ██║   ██║█████╗  ██║     ██║   ██║██████╔╝█████╗  ██████╔╝    ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
-- ██║  ██║██╔══╝  ╚██╗ ██╔╝██╔══╝  ██║     ██║   ██║██╔═══╝ ██╔══╝  ██╔══██╗    ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
-- ██████╔╝███████╗ ╚████╔╝ ███████╗███████╗╚██████╔╝██║     ███████╗██║  ██║    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
-- ╚═════╝ ╚══════╝  ╚═══╝  ╚══════╝╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝    ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

Config.Debug = false
Config.DeveloperMode = false

--  ██████╗ ███████╗███╗   ██╗███████╗██████╗  █████╗ ██╗         ███████╗███████╗████████╗████████╗██╗███╗   ██╗ ██████╗ ███████╗
-- ██╔════╝ ██╔════╝████╗  ██║██╔════╝██╔══██╗██╔══██╗██║         ██╔════╝██╔════╝╚══██╔══╝╚══██╔══╝██║████╗  ██║██╔════╝ ██╔════╝
-- ██║  ███╗█████╗  ██╔██╗ ██║█████╗  ██████╔╝███████║██║         ███████╗█████╗     ██║      ██║   ██║██╔██╗ ██║██║  ███╗███████╗
-- ██║   ██║██╔══╝  ██║╚██╗██║██╔══╝  ██╔══██╗██╔══██║██║         ╚════██║██╔══╝     ██║      ██║   ██║██║╚██╗██║██║   ██║╚════██║
-- ╚██████╔╝███████╗██║ ╚████║███████╗██║  ██║██║  ██║███████╗    ███████║███████╗   ██║      ██║   ██║██║ ╚████║╚██████╔╝███████║
--  ╚═════╝ ╚══════╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝    ╚══════╝╚══════╝   ╚═╝      ╚═╝   ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚══════╝

Config.Locale = 'en'

Config.HideRadar = true

Config.Prefix = 'char' -- for esx!

Config.DefaultCharacterSlots = 1

Config.SkipWarning = true -- NEW!

Config.DisableDeleteCharacter = false -- NEW!

-- ██╗      ██████╗  ██████╗ ███████╗
-- ██║     ██╔═══██╗██╔════╝ ██╔════╝
-- ██║     ██║   ██║██║  ███╗███████╗
-- ██║     ██║   ██║██║   ██║╚════██║
-- ███████╗╚██████╔╝╚██████╔╝███████║
-- ╚══════╝ ╚═════╝  ╚═════╝ ╚══════╝

Config.Logs = {
    status = false,
    logger = 'discord',
}

-- ███████╗████████╗ █████╗ ██████╗ ████████╗███████╗██████╗     ██╗████████╗███████╗███╗   ███╗███████╗
-- ██╔════╝╚══██╔══╝██╔══██╗██╔══██╗╚══██╔══╝██╔════╝██╔══██╗    ██║╚══██╔══╝██╔════╝████╗ ████║██╔════╝
-- ███████╗   ██║   ███████║██████╔╝   ██║   █████╗  ██████╔╝    ██║   ██║   █████╗  ██╔████╔██║███████╗
-- ╚════██║   ██║   ██╔══██║██╔══██╗   ██║   ██╔══╝  ██╔══██╗    ██║   ██║   ██╔══╝  ██║╚██╔╝██║╚════██║
-- ███████║   ██║   ██║  ██║██║  ██║   ██║   ███████╗██║  ██║    ██║   ██║   ███████╗██║ ╚═╝ ██║███████║
-- ╚══════╝   ╚═╝   ╚═╝  ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚═╝   ╚═╝   ╚══════╝╚═╝     ╚═╝╚══════╝

Config.StarterItems = {
    { name = 'phone',          amount = 1 },
    { name = 'id_card',        amount = 1, customExport = false },
    -- { name = 'driver_license', amount = 1, customExport = false },
}

--  ██████╗██╗      ██████╗ ████████╗██╗  ██╗██╗███╗   ██╗ ██████╗ 
-- ██╔════╝██║     ██╔═══██╗╚══██╔══╝██║  ██║██║████╗  ██║██╔════╝ 
-- ██║     ██║     ██║   ██║   ██║   ███████║██║██╔██╗ ██║██║  ███╗
-- ██║     ██║     ██║   ██║   ██║   ██╔══██║██║██║╚██╗██║██║   ██║
-- ╚██████╗███████╗╚██████╔╝   ██║   ██║  ██║██║██║ ╚████║╚██████╔╝
--  ╚═════╝╚══════╝ ╚═════╝    ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═══╝ ╚═════╝ 

Config.ClothingExports = function(cacheped, skinData)
    if GetResourceState('rcore_clothing') == 'started' then
        exports.rcore_clothing:setPedSkin(cacheped, skinData)
    elseif GetResourceState('illenium-appearance') == 'started' then
        exports['illenium-appearance']:setPedAppearance(cacheped, skinData)
    elseif GetResourceState('bl_appearance') == 'started' then
        exports.bl_appearance:SetPlayerPedAppearance(skinData)
    elseif GetResourceState('fivem-appearance') == 'started' then
        exports['fivem-appearance']:setPedAppearance(cacheped, skinData)
    elseif GetResourceState('qb-clothing') == 'started' then
        TriggerEvent('qb-clothing:client:loadPlayerClothing', skinData, cacheped)
    elseif GetResourceState('skinchanger') == 'started' then
        exports["skinchanger"]:LoadSkin(skinData)
    elseif GetResourceState('crm-appearance') == 'started' then
        exports['crm-appearance']:crm_set_ped_appearance(cacheped, skinData)
    elseif GetResourceState('0r-clothing') == 'started' then
        if Framework.GetFrameworkName() == 'es_extended' then
            TriggerEvent('skinchanger:loadSkin', skinData)
        else
            TriggerEvent('qb-clothing:client:loadPlayerClothing', skinData, cacheped)
        end
    else
        -- Example: exports['myclothing']:setPedAppearance(cacheped, skinData)
    end
end

Config.CreateCharacterExports = function()
    if GetResourceState('rcore_clothing') == 'started' then
        if Framework.GetFrameworkName() == 'es_extended' then
            TriggerEvent('esx_skin:resetFirstSpawn')
            TriggerEvent('esx_skin:playerRegistered')
        else
            TriggerEvent('qb-clothes:client:CreateFirstCharacter')
        end
    elseif GetResourceState('illenium-appearance') == 'started' then
        if Framework.GetFrameworkName() == 'es_extended' then
            TriggerEvent('esx_skin:resetFirstSpawn')
            TriggerEvent('esx_skin:playerRegistered')
        else
            TriggerEvent('qb-clothes:client:CreateFirstCharacter')
        end
    elseif GetResourceState('fivem-appearance') == 'started' then
        local config = {
            ped = true,
            headBlend = true,
            faceFeatures = true,
            headOverlays = true,
            components = true,
            props = true,
            allowExit = true,
            tattoos = true
        }

        exports['fivem-appearance']:startPlayerCustomization(function(appearance)
            TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', true)
        end, config)
    elseif GetResourceState('crm-appearance') == 'started' then
        TriggerEvent('crm-appearance:init-new-character', 'crm-male', function()
            TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', true)
        end)
    elseif GetResourceState('bl_appearance') == 'started' then
        exports.bl_appearance:InitialCreation(function()
            TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', true)
        end)
    elseif GetResourceState('qb-clothing') == 'started' then
        TriggerEvent('qb-clothes:client:CreateFirstCharacter')
    elseif GetResourceState('skinchanger') == 'started' then
        TriggerEvent('esx_skin:openSaveableMenu', function()
            TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', true)
        end,
        function()
            TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', true)
        end)
    elseif GetResourceState('qb-clothing') == 'started' then
        TriggerEvent('qb-clothes:client:CreateFirstCharacter')
    elseif GetResourceState('0r-clothing') == 'started' then
        if Framework.GetFrameworkName() == 'es_extended' then
            TriggerEvent('esx_skin:resetFirstSpawn')
            TriggerEvent('esx_skin:playerRegistered')
        else
            TriggerEvent('qb-clothes:client:CreateFirstCharacter')
        end
    else
        -- TriggerEvent('qb-clothes:client:CreateFirstCharacter')
    end
end

-- ███████╗██████╗  █████╗ ██╗    ██╗███╗   ██╗    ███████╗███████╗██╗     ███████╗ ██████╗████████╗ ██████╗ ██████╗ 
-- ██╔════╝██╔══██╗██╔══██╗██║    ██║████╗  ██║    ██╔════╝██╔════╝██║     ██╔════╝██╔════╝╚══██╔══╝██╔═══██╗██╔══██╗
-- ███████╗██████╔╝███████║██║ █╗ ██║██╔██╗ ██║    ███████╗█████╗  ██║     █████╗  ██║        ██║   ██║   ██║██████╔╝
-- ╚════██║██╔═══╝ ██╔══██║██║███╗██║██║╚██╗██║    ╚════██║██╔══╝  ██║     ██╔══╝  ██║        ██║   ██║   ██║██╔══██╗
-- ███████║██║     ██║  ██║╚███╔███╔╝██║ ╚████║    ███████║███████╗███████╗███████╗╚██████╗   ██║   ╚██████╔╝██║  ██║
-- ╚══════╝╚═╝     ╚═╝  ╚═╝ ╚══╝╚══╝ ╚═╝  ╚═══╝    ╚══════╝╚══════╝╚══════╝╚══════╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝  ╚═╝

Config.ApartmentStart = true
Config.NewPlayerSpawnCoords = vec4(-1037.74, -2737.75, 20.17, 327.06)
Config.SkipSpawnSelector = false
Config.SpawnSelector = '0r-spawn'
Config.CustomSpawnExports = function(playerId, position)
end

Config.SpawnLocations = {
    {
        id = 1,
        label = 'Legion Square',
        img = 'legion-square',
        icon = 'fa-solid fa-city',
        coords = vec4(195.17, -933.77, 29.7, 144.5)
    },
    {
        id = 2,
        label = 'Paleto Bay',
        img = 'paleto-bay',
        icon = 'fa-solid fa-mountain-city',
        coords = vec4(80.35, 6424.12, 30.67, 45.5),
    },
    {
        id = 3,
        label = 'Motels',
        img = 'motels',
        icon = 'fa-solid fa-house',
        coords = vec4(327.56, -205.08, 53.08, 163.5),
    },
    {
        id = 4,
        label = 'Sandy Shores',
        img = 'sandy-shores',
        icon = 'fa-solid fa-mountain-city',
        coords = vec4(1841.35, 3668.89, 33.68, 213.45),
    },
    {
        id = 5,
        label = 'Grapeseed',
        img = 'grapeseed',
        icon = 'fa-solid fa-seedling',
        coords = vec4(1700.47, 4802.38, 41.8, 88.1),
    },
    {
        id = 6,
        label = 'Davis',
        img = 'davis',
        icon = 'fa-solid fa-building',
        coords = vec4(426.93, -1638.19, 29.31, 265.69),
    },
    {
        id = 7,
        label = 'Hospital',
        img = 'hospital',
        icon = 'fa-solid fa-hospital',
        coords = vec4(285.21, -579.42, 43.23, 70.61),
    },
    {
        id = 8,
        label = 'Pier',
        img = 'pier',
        icon = 'fa-solid fa-umbrella-beach',
        coords = vec4(-1744.52, -1112.1, 13.02, 316.96),
    },
}

Config.CustomHud = function(status)
    if status then
        -- HIDE HUD
    else
        -- SHOW HUD
    end
end

-- ██████╗  █████╗  ██████╗██╗  ██╗ ██████╗ ██████╗  ██████╗ ██╗   ██╗███╗   ██╗██████╗     ███╗   ███╗██╗   ██╗███████╗██╗ ██████╗
-- ██╔══██╗██╔══██╗██╔════╝██║ ██╔╝██╔════╝ ██╔══██╗██╔═══██╗██║   ██║████╗  ██║██╔══██╗    ████╗ ████║██║   ██║██╔════╝██║██╔════╝
-- ██████╔╝███████║██║     █████╔╝ ██║  ███╗██████╔╝██║   ██║██║   ██║██╔██╗ ██║██║  ██║    ██╔████╔██║██║   ██║███████╗██║██║     
-- ██╔══██╗██╔══██║██║     ██╔═██╗ ██║   ██║██╔══██╗██║   ██║██║   ██║██║╚██╗██║██║  ██║    ██║╚██╔╝██║██║   ██║╚════██║██║██║     
-- ██████╔╝██║  ██║╚██████╗██║  ██╗╚██████╔╝██║  ██║╚██████╔╝╚██████╔╝██║ ╚████║██████╔╝    ██║ ╚═╝ ██║╚██████╔╝███████║██║╚██████╗
-- ╚═════╝ ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═╝ ╚═════╝  ╚═════╝ ╚═╝  ╚═══╝╚═════╝     ╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚═╝ ╚═════╝

Config.BackgroundMusic = {
    status = true,
    volume = 0.2,
    url = 'bgmusic.mp3',
}

--  ██████╗██╗  ██╗ █████╗ ██████╗  █████╗  ██████╗████████╗███████╗██████╗     ███████╗██╗      ██████╗ ████████╗███████╗
-- ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗    ██╔════╝██║     ██╔═══██╗╚══██╔══╝██╔════╝
-- ██║     ███████║███████║██████╔╝███████║██║        ██║   █████╗  ██████╔╝    ███████╗██║     ██║   ██║   ██║   ███████╗
-- ██║     ██╔══██║██╔══██║██╔══██╗██╔══██║██║        ██║   ██╔══╝  ██╔══██╗    ╚════██║██║     ██║   ██║   ██║   ╚════██║
-- ╚██████╗██║  ██║██║  ██║██║  ██║██║  ██║╚██████╗   ██║   ███████╗██║  ██║    ███████║███████╗╚██████╔╝   ██║   ███████║
--  ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝    ╚══════╝╚══════╝ ╚═════╝    ╚═╝   ╚══════╝

Config.CharacterSlots = {
    Tebex = {
        status = false,
        packages = {
            {
                id = 1,
                slot = 1,
            }
        }
    },
    Discord = {
        status = false,
        roles = {
            {
                id = 1,
                slot = 1,
            }
        }
    },
    Custom = {
        status = false,
        licenses = {
            {
                id = 'license:1213213',
                slot = 1,
            }
        }
    }
}

return Config

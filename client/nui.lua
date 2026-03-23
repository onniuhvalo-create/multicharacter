local Apartments = require 'config.apartments'
local Config = require 'config.config'

RegisterNUICallback("CHECKED_NUI", function(data, cb)
    NuiLoaded = true
    cb("ok")
end)

RegisterNUICallback("CHANGE_CHARACTER", function(data, cb)
    if data.characterData == 'no-data' then
        SetEntityVisible(PlayerPedId(), false, false)
    else
        PreparePlayerCameraAnimation()
        ChangeCharacter(data.characterData.citizenid)
    end

    cb("ok")
end)

RegisterNUICallback("PLAY_CHARACTER", function(data, cb)
    RotateingCam = false
    TriggerServerEvent('0r-multicharacterv3:server:playCharacter', data.characterData)
    DestroyAnyCam()
    ClearTimecycleModifier()
    FreezeEntityPosition(PlayerPedId(), false)
    SetWeatherSync(false)
    cb("ok")
end)

RegisterNUICallback("CREATE_CHARACTER", function(data, cb)
    RotateingCam = false
    local formatedData = {
        cid = data.cid or 1,
        charinfo = {
            cid = data.cid or 1,
            firstname = data.firstname,
            lastname = data.lastname,
            birthdate = data.birthday.year .. "-" .. data.birthday.month .. "-" .. data.birthday.day,
            nationality = data.nationality,
            gender = data.gender == 'man' and 0 or 1,
            height = data.height or nil,
        }
    }

    TriggerServerEvent('0r-multicharacterv3:server:createCharacter', formatedData)
    DestroyAnyCam()
    ClearTimecycleModifier()
    FreezeEntityPosition(PlayerPedId(), false)
    SetWeatherSync(false)


    cb("ok")
end)

RegisterNUICallback("DELETE_CHARACTER", function(data, cb)
    local citizenid = data.citizenid
    if not citizenid then
        cb("ok")
        return
    end

    lib.callback.await('0r-multicharacterv3:server:deleteCharacter', false, citizenid)
    cb("ok")
end)

RegisterNUICallback("UPDATE_SPAWN", function(data, cb)
    if not Camera then return end

    NuiMessage("ANIMATION_SHOW", {
        initial = true,
        text = _T("loading"),
    })

    Wait(500)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z, false, false, false, false)
    SetEntityHeading(PlayerPedId(), data.w or 0.0)

    local ped = PlayerPedId()
    local retval = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 50.0)

    SetCamParams(Camera, retval.x, retval.y, retval.z, -90.0, 0.0, GetEntityHeading(PlayerPedId())-180.0, 70.00, 1000, 0, 0, 2)

    SetTimeout(1000, function ()
        NuiMessage("ANIMATION_HIDE", {})
    end)
    cb("ok")
end)

RegisterNUICallback("SPAWN_LOCATION", function(data, cb)
    if not Camera then return end
    TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', true)

    SetNuiFocus(false, false)
    NuiMessage("CLOSE_NUI", {})
    RenderScriptCams(false, true, 2000, true, true)
    DestroyCam(Camera, false)

    if Framework.GetFrameworkName() == 'es_extended' then
        TriggerServerEvent("esx:onPlayerSpawn")
        TriggerEvent("esx:onPlayerSpawn")
        TriggerEvent("playerSpawned")
        TriggerEvent("esx:restoreLoadout")
    else
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
        TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
    end

    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityVisible(PlayerPedId(), true, false)
    SetEntityInvincible(PlayerPedId(), false)
    DisplayRadar(true)
    cb("ok")
end)

RegisterNUICallback("UPDATE_APARTMENT", function(data, cb)
     if not Camera then return end

    NuiMessage("ANIMATION_SHOW", {
        initial = true,
        text = _T("loading"),
    })

    Wait(500)

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z, false, false, false, false)
    SetEntityHeading(PlayerPedId(), data.w or 0.0)

    local ped = PlayerPedId()
    local retval = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 500.0)

    SetCamParams(Camera, retval.x, retval.y, retval.z, -90.0, 0.0, GetEntityHeading(PlayerPedId())-180.0, 70.00, 1000, 0, 0, 2)

    SetTimeout(1000, function ()
        NuiMessage("ANIMATION_HIDE", {})
    end)
    cb("ok")
end)

RegisterNUICallback("SPAWN_APARTMENT", function(data, cb)
    if not Camera then return end

    SetNuiFocus(false, false)
    NuiMessage("CLOSE_NUI", {})
    RenderScriptCams(false, true, 2000, true, true)
    DestroyCam(Camera, false)

    Apartments.SpawnCreateCharacter(data.apartmentType)

    FreezeEntityPosition(PlayerPedId(), false)
    SetEntityVisible(PlayerPedId(), true, false)
    SetEntityInvincible(PlayerPedId(), false)
    DisplayRadar(true)
    Wait(1000)
    if Framework.GetFrameworkName() == 'es_extended' then
        TriggerServerEvent("esx:onPlayerSpawn")
        TriggerEvent("esx:onPlayerSpawn")
        TriggerEvent("playerSpawned")
        TriggerEvent("esx:restoreLoadout")
    else
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
    end
    cb("ok")
end)

RegisterNUICallback("GET_SETTINGS", function(data, cb)
    Settings = data
    cb("ok")
end)

RegisterNUICallback("SETTINGS_UPDATE", function(data, cb)
    Settings[data.setting] = data.value

    if data.setting == "focus_player" then
        TriggerEvent("0r-multicharacterv3:client:focusPlayer")
    elseif data.setting == "particle_show" or data.setting == "particle_type" then
        TriggerEvent('0r-multicharacterv3:client:effects')
    elseif data.setting == "scenario_mode" or data.setting == "scenario_type" then
        TriggerEvent('0r-multicharacterv3:client:scenario')
    elseif data.setting == "camera_filter_mode" or data.setting == "camera_filter_type" then
        TriggerEvent('0r-multicharacterv3:client:cameraFilter')
    elseif data.setting == "weather_mode" or data.setting == "weather_type" then
        TriggerEvent('0r-multicharacterv3:client:weather')
    elseif data.setting == "time_mode" or data.setting == "time_type" then
        TriggerEvent('0r-multicharacterv3:client:time')
    end

    cb("ok")
end)

RegisterNUICallback("HIDING_WARNING_SCREEN", function(data, cb)
    SetWeatherSync(true)
    TriggerEvent('0r-multicharacterv3:client:weather')
    TriggerEvent('0r-multicharacterv3:client:time')
    if Config.BackgroundMusic.status then
        NuiMessage("PLAY_SONG", {
            song = Config.BackgroundMusic.url,
            volume = Config.BackgroundMusic.volume
        })
    end

    if not Characters or #Characters <= 0 then
        NuiMessage("CHANGE_PAGE", {
            page = 'Creator'
        })
        SetEntityVisible(PlayerPedId(), false, false)
        PreparePlayerCameraAnimation()
    else
        NuiMessage("CHANGE_PAGE", {
            page = "Selection"
        })
        local identifier = Characters[1].citizenid or Characters[1].identifier
        ChangeCharacter(identifier)
    end

    Wait(1000)

    NuiMessage("ANIMATION_HIDE", {})

    CreateThread(function()
        while DoesCamExist(Camera) and Config.HideRadar do
            Wait(1)
            HideHudAndRadarThisFrame()
            DisplayRadar(false)
        end
    end)

    TriggerEvent("0r-multicharacterv3:client:focusPlayer")
    TriggerEvent('0r-multicharacterv3:client:effects')
    TriggerEvent('0r-multicharacterv3:client:scenario')
    TriggerEvent('0r-multicharacterv3:client:cameraFilter')
    cb("ok")
end)

RegisterNUICallback("CHECK_TEBEX_CODE", function(data, cb)
    if not data.code or data.code == '' then
        cb({
            status = "error",
        })
        return
    end

    lib.callback('0r-multicharacterv3:server:checkTebexCode', false, function(response)
        if response and response.status == "success" then
            cb({
                status = "success",
                slot = response.slot,
            })
        else
            cb({
                status = "error",
            })
        end
    end, data.code)
end)

RegisterNUICallback("CHANGE_BACKGROUND", function(data, cb)
    if not Camera then return end
    NuiMessage("ANIMATION_SHOW", {
        initial = true,
        text = _T("loading"),
    })

    Wait(500)

    Settings.background = data.background

    SetEntityCoords(PlayerPedId(), data.background.coords.x, data.background.coords.y, data.background.coords.z-1.0, false, false, false, false)
    SetEntityHeading(PlayerPedId(), data.background.coords.w or 0.0)

    local retval = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, .5)
    SetCamParams(Camera, retval.x, retval.y, retval.z, 0.0, 0.0, GetEntityHeading(PlayerPedId())-180.0, 70.00, 0, 0, 0, 2)

    Wait(1000)

    NuiMessage("ANIMATION_HIDE", {})
    cb("ok")
end)

RegisterNUICallback("CHANGED_PAGE", function(data, cb)
    if not Camera then return end
    local heading = GetCamRot(Camera, 0).z

    if data.page == 'Selection' then
        RotateingCam = false
        Wait(50)

        SetEntityVisible(PlayerPedId(), true, false)
        local retval = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, .5)

        SetCamParams(Camera, retval.x, retval.y, retval.z, 0.0, 0.0, GetEntityHeading(PlayerPedId())-180.0, 70.00, 1000, 0, 0, 2)
    else
        SetEntityVisible(PlayerPedId(), false, false)
        SetEntityInvincible(PlayerPedId(), true)
        RotateingCam = true

        CreateThread(function()
            while RotateingCam do
                Wait(25)
    
                heading = heading + 0.1
                if heading >= 360.0 then
                    heading = 0.0
                end
    
                SetCamRot(Camera, 0.0, 0.0, heading, 2)
            end
        end)
    end
end)
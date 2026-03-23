NuiLoaded = false
RotateingCam = false
Camera = nil
Settings = {}
Characters = {}

local Config = require 'config.config'
local AnimationConfig = require 'config.animation'
local CameraConfig = require 'config.camera'
local EffectsConfig = require 'config.effects'
local WeatherConfig = require 'config.weather'
local Locations = require 'config.locations'
local Apartments = require 'config.apartments'

--- GetWebLocales()
--- @return table
local function GetWebLocales()
    local path = 'locales/' .. Config.Locale .. '.json'
    local file = LoadResourceFile(GetCurrentResourceName(), path)

    if not file then
        file = LoadResourceFile(GetCurrentResourceName(), 'locales/en.json')
        print(('Locale file "%s" not found, falling back to default "en".'):format(Config.Locale))
        return {}
    end

    if not file or file == '' then
        error('Locale file is empty or not found')
        return {}
    end

    local success, content = pcall(json.decode, file)

	if not success then
        error(('Failed to decode JSON from locale file: %s'):format(content))
        return {}
    end

    if not content['Web'] then
        error('Missing "Web" section in locale file')
        return {}
    end

    return content['Web']
end

--- CheckNui()
--- Waits until the NUI is loaded before sending messages.
--- @return nil
local function CheckNui()
    while not NuiLoaded do
        Wait(100)
    end
end

--- NuiMessage(action, payload)
--- Sends a message to the NUI with the specified action and payload.
--- @param action string The action to perform in the NUI.
--- @param payload table The data to send with the action.
--- @return nil
function NuiMessage(action, payload)
    CheckNui()
    SendNUIMessage({
        action = action,
        payload = payload
    })
end

--- CreatePlayerCam()
--- @return nil
local function CreatePlayerCam()
    DestroyAnyCam()
    local ped = PlayerPedId()
    local retval = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, .5)
    Camera = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', retval.x, retval.y, retval.z, 0.0, 0.0, GetEntityHeading(ped)-180.0, 70.00, false, 0)
    SetCamActive(Camera, true)
    SetCamUseShallowDofMode(Camera, true)
    SetCamFov(Camera, 70.0)
    SetCamNearDof(Camera, 0.3)
    SetCamFarDof(Camera, 1.3)
    SetCamDofStrength(Camera, 1.0)
    RenderScriptCams(true, false, 1, false, true)
    ShakeCam(Camera, "HAND_SHAKE", 0.1)
end

--- CreateAirCam()
--- @param position vector4|vector3
--- @return nil
local function CreateAirCam(position)
    DestroyAnyCam()
    local ped = PlayerPedId()

    SetEntityCoords(ped, position.x, position.y, position.z-1.0, false, false, false, false)
    SetEntityHeading(ped, position.w or 0.0)
    local retval = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 50.0)

    Camera = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', retval.x, retval.y, retval.z, -90.0, 0.0, GetEntityHeading(ped)-180.0, 70.00, false, 0)
    SetCamActive(Camera, true)
    SetCamUseShallowDofMode(Camera, true)
    SetCamFov(Camera, 70.0)
    RenderScriptCams(true, false, 1, false, true)
end

--- CreateApartmentCam()
--- @param position vector4|vector3
--- @return nil
local function CreateApartmentCam(position)
    DestroyAnyCam()
    local ped = PlayerPedId()

    SetEntityCoords(ped, position.x, position.y, position.z-1.0, false, false, false, false)
    SetEntityHeading(ped, position.w or 0.0)
    local retval = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, 500.0)

    Camera = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', retval.x, retval.y, retval.z, -90.0, 0.0, GetEntityHeading(ped)-180.0, 70.00, false, 0)
    SetCamActive(Camera, true)
    SetCamUseShallowDofMode(Camera, true)
    RenderScriptCams(true, false, 1, false, true)
end

--- DestroyAnyCam()
--- @return nil
function DestroyAnyCam()
    if Camera and DoesCamExist(Camera) then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(Camera, false)
        Camera = nil
    end
end

--- ChangeCharacter(identifier)
--- @param identifier string|number
--- @return nil
function ChangeCharacter(identifier)
    local isLoading = true
    local isModel = nil
    local isSkin = nil

    lib.callback('0r-multicharacterv3:callback:getSkin', false, function(model, skin)
        if model and skin then
            isModel = model
            isSkin = skin
        end
        isLoading = false
    end, identifier)

    while isLoading do
        Wait(100)
    end

    if not isModel or not isSkin then return end

    local modelHash = nil

    if tonumber(isModel) then
        modelHash = tonumber(isModel)
    else
        modelHash = GetHashKey(isModel)
    end

    if not IsModelInCdimage(modelHash) or not IsModelValid(modelHash) then
        error(("Invalid model hash: %s"):format(modelHash))
        return
    end

    lib.requestModel(modelHash)

    SetPlayerModel(PlayerId(), modelHash)
    SetModelAsNoLongerNeeded(modelHash)

    local ped = PlayerPedId()

    SetEntityVisible(ped, true, false)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, false)
    PlaceObjectOnGroundProperly(ped)
    SetBlockingOfNonTemporaryEvents(ped, true)

    Config.ClothingExports(ped, isSkin)
end

function PreparePlayerCameraAnimation()
    local ped = PlayerPedId()

    if Settings.background.coords then
        SetEntityCoords(ped, Settings.background.coords.x, Settings.background.coords.y, Settings.background.coords.z-1.0, false, false, false, false)
        SetEntityHeading(ped, Settings.background.coords.w or 0.0)
    else
        SetEntityCoords(ped, Locations.List[1].coords.x, Locations.List[1].coords.y, Locations.List[1].coords.z-1.0, false, false, false, false)
        SetEntityHeading(ped, Locations.List[1].coords.w or 0.0)
    end

    if GetResourceState('spawnmanager') == 'started' then
		exports['spawnmanager']:setAutoSpawn(false)
	end
    CreatePlayerCam()
end

--- SetWeatherSync(bool)
--- @param bool boolean
--- @return nil
function SetWeatherSync(bool)
    if bool then
        Wait(150)
        if GetResourceState('cd_easytime') == 'started' then
            TriggerEvent('cd_easytime:PauseSync', true)
        elseif GetResourceState('qb-weathersync') == 'started' or GetResourceState('Renewed-Weathersync') == 'started' then
            TriggerEvent('qb-weathersync:client:DisableSync')
        elseif GetResourceState('vSync') == 'started' then
            TriggerEvent('vSync:toggle', false)
            Wait(100)
            TriggerEvent('vSync:updateWeather', 'SUNNY', false)
        end

        LocalPlayer.state.syncWeather = false
    else
        Wait(150)
        if GetResourceState('cd_easytime') == 'started' then
            TriggerEvent('cd_easytime:PauseSync', false)
        elseif GetResourceState('qb-weathersync') == 'started' or GetResourceState('Renewed-Weathersync') == 'started' then
            TriggerEvent('qb-weathersync:client:EnableSync')
        elseif GetResourceState('vSync') == 'started' then
            TriggerEvent('vSync:toggle', true)
            Wait(100)
            TriggerServerEvent('vSync:requestSync')
        end

        LocalPlayer.state.syncWeather = true
    end
end

CreateThread(function()
    while not NuiLoaded do
        if NetworkIsSessionStarted() then
            SendNUIMessage({
                action = "CHECK_NUI",
            })
        end
        Wait(2000)
    end
end)

CreateThread(function()
	while true do
		Wait(0)
		if NetworkIsSessionStarted() then
            while not NuiLoaded do
                Wait(100)
            end

            TriggerEvent('0r-multicharacterv3:client:loadUserData')
			return
		end
	end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DestroyAnyCam()
        FreezeEntityPosition(PlayerPedId(), false)
        SetWeatherSync(false)
    end
end)

RegisterNetEvent('0r-multicharacterv3:client:loadUserData', function()
    ShutdownLoadingScreen()
	ShutdownLoadingScreenNui()

    DoScreenFadeIn(0)

    Wait(300)

    FreezeEntityPosition(PlayerPedId(), true)

    NuiMessage("ANIMATION_SHOW", {
        initial = true,
        text = _T("setting_locale"),
    })

    NuiMessage("SET_LOCALES", {
        locales = GetWebLocales(),
    })

    NuiMessage("SET_CONFIG", {
        scenario_type = #AnimationConfig.List,
        particle_type = #EffectsConfig.List,
        camera_filter_type = #CameraConfig.List,
        weather_type = #WeatherConfig.List,
        time_type = 23,
        disable_delete_character = Config.DisableDeleteCharacter,
    })

    NuiMessage("SET_BACKGROUNDS", {
        backgrounds = Locations.List,
    })

    Wait(1000)

    NuiMessage("ANIMATION_UPDATE", {
        initial = false,
        text = _T("loading_settings"),
    })

    while not Settings or next(Settings) == nil do
        Wait(100)
    end

    Wait(1000)

    NuiMessage("ANIMATION_UPDATE", {
        initial = true,
        text = _T("getting_character"),
    })

    TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', false)

    Characters = {}
    local character_slot = 0
    local isLoading = true

    lib.callback('0r-multicharacterv3:callback:getCharacters', false, function(data, slot)
        Characters = data
        character_slot = slot
        isLoading = false
    end)

    while isLoading do
        Wait(100)
    end

    if Characters and #Characters > 0 then
        NuiMessage("CHARACTER_LIST_UPDATE", {
            characters = Characters,
            character_slot = character_slot,
        })
    else
        NuiMessage("CHARACTER_LIST_UPDATE", {
            characters = {},
            character_slot = character_slot,
        })
    end

    SetNuiFocus(true, true)

    if not Config.SkipWarning then
        NuiMessage("WARNING_MESSAGE_SHOW", {})
    else
        NuiMessage("WARNING_MESSAGE_SKIP", {})
    end

    NuiMessage("ANIMATION_UPDATE", {
        initial = false,
        text = _T("loading_characters"),
    })
end)

RegisterNetEvent('0r-multicharacterv3:client:hideAnimation', function()
    NuiMessage("ANIMATION_HIDE", {})
end)

RegisterNetEvent('0r-multicharacterv3:client:spawnSelector', function(type, position)
    Config.CustomHud(true)
    TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', false)
    CreateAirCam(position)
    NuiMessage("CHANGE_SPAWN_SELECTOR", {
        type = type,
    })

    SetEntityVisible(PlayerPedId(), false, false)
    SetEntityInvincible(PlayerPedId(), true)

    NuiMessage("SHOW_SPAWN_SELECTOR", {
        locations = Config.SpawnLocations,
        last_location = {
            id = 'last_location',
            label = _T("last_location"),
            img = 'test-image',
            icon = 'fa-solid fa-location-dot',
            coords = vec4(position.x, position.y, position.z-1.0, position.w or 0.0),
        }
    })
end)

RegisterNetEvent('0r-multicharacterv3:client:spawnPlayer', function(position)
    Config.CustomHud(false)
    SetEntityCoords(PlayerPedId(), position.x, position.y, position.z-1.0, false, false, false, false)
    SetEntityHeading(PlayerPedId(), position.w or 0.0)

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
    SetNuiFocus(false, false)
    NuiMessage("CLOSE_NUI", {})
end)

RegisterNetEvent('0r-multicharacterv3:client:closeNUI', function()
    SetNuiFocus(false, false)
    NuiMessage("CLOSE_NUI", {})
end)

-- SETTINGS

RegisterNetEvent('0r-multicharacterv3:client:focusPlayer', function()
    CreateThread(function()
        while Settings['focus_player'] do
            SetUseHiDof()
            Wait(0)
        end
    end)
end)

RegisterNetEvent('0r-multicharacterv3:client:effects', function()
    if not Settings.particle_show then return end

    local pedCoords = GetEntityCoords(PlayerPedId())

    RequestNamedPtfxAsset(EffectsConfig.List[Settings.particle_type].pName)
    while not HasNamedPtfxAssetLoaded(EffectsConfig.List[Settings.particle_type].pName) do
        Citizen.Wait(0)
    end

    UseParticleFxAssetNextCall(EffectsConfig.List[Settings.particle_type].pName)
    StartParticleFxNonLoopedAtCoord(EffectsConfig.List[Settings.particle_type].pNameChild, pedCoords.x, pedCoords.y, pedCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false)
    RemoveNamedPtfxAsset(EffectsConfig.List[Settings.particle_type].pName)
end)

RegisterNetEvent('0r-multicharacterv3:client:scenario', function()
    local ped = PlayerPedId()
    if not Settings.scenario_mode then
        ClearPedTasks(ped)
        return
    end

    ClearPedTasks(ped)
    Wait(50)
    TaskStartScenarioInPlace(ped, AnimationConfig.List[Settings.scenario_type], 0, true)
end)

RegisterNetEvent('0r-multicharacterv3:client:cameraFilter', function()
    if not Settings.camera_filter_mode then
        ClearTimecycleModifier()
        return
    end

    local filter = CameraConfig.List[Settings.camera_filter_type]
    if filter then
        SetTimecycleModifier(filter)
        SetTimecycleModifierStrength(1.0)
    else
        ClearTimecycleModifier()
    end
end)

RegisterNetEvent('0r-multicharacterv3:client:weather', function()
    if not Settings.weather_mode then
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypeNowPersist('EXTRASUNNY')
        SetWeatherTypeNow('EXTRASUNNY')
        return
    end

    local weather = WeatherConfig.List[Settings.weather_type]
    if weather then
        SetWeatherTypeOverTime(weather, 15.0)
        SetOverrideWeather(weather)
        SetWeatherTypeNow(weather)
        SetWeatherTypeNowPersist(weather)
    else
        ClearOverrideWeather()
        ClearWeatherTypePersist()
    end
end)

RegisterNetEvent('0r-multicharacterv3:client:time', function()
    if not Settings.time_mode then
        NetworkOverrideClockTime(12, 0, 0)
        return
    end

    local time = Settings.time_type
    if time then
        NetworkOverrideClockTime(time, 0, 0)
    else
        NetworkOverrideClockTime(12, 0, 0)
    end
end)

RegisterNetEvent('0r-multicharacterv3:client:startingApartment', function()
    TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', false)
    CreateApartmentCam(Apartments.List[Framework.GetFrameworkName()][1].coords)
    NuiMessage("CHANGE_SPAWN_SELECTOR", {
        type = 'apartment',
    })

    SetEntityVisible(PlayerPedId(), false, false)
    SetEntityInvincible(PlayerPedId(), true)

    NuiMessage("SHOW_SPAWN_SELECTOR", {
        locations = Apartments.List[Framework.GetFrameworkName()],
    })

    NuiMessage("ANIMATION_HIDE", {})
end)

RegisterNetEvent('0r-multicharacterv3:client:noStartingApartment', function()
    TriggerServerEvent('0r-multicharacterv3:server:changeRoutingBucket', false)
    local ped = PlayerPedId()
    SetEntityCoords(ped, Config.NewPlayerSpawnCoords.x, Config.NewPlayerSpawnCoords.y, Config.NewPlayerSpawnCoords.z-1.0, false, false, false, false)
    SetEntityHeading(ped, Config.NewPlayerSpawnCoords.w or 0.0)

    FreezeEntityPosition(ped, false)
    SetEntityInvincible(ped, false)
    SetEntityVisible(ped, true, false)

    SetNuiFocus(false, false)
    NuiMessage("CLOSE_NUI", {})

    DestroyAnyCam()
    Config.CreateCharacterExports()

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
end)

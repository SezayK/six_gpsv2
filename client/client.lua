local PlayerData

Citizen.CreateThread(function()
    while true do
        PlayerData = getPlayerData()

        Citizen.Wait(1000)
    end
end)


local blips = {}

local function haveItem(item, count)
    for _, v in pairs(getInventory()) do
        if v.name == item and v.count >= count then
            return true
        end
    end
    return false
end

local function createBlipForPlayer(playerData)
    local player = GetPlayerFromServerId(playerData.playerId)
    local ped = GetPlayerPed(player)
    local status = nil

    if IsEntityDead(ped) then
        status = "dead"
    else
        if IsPedOnFoot(ped) then
            status = "foot"
        else
            local vehicle = GetVehiclePedIsIn(ped, false)
            if IsThisModelAPlane(GetEntityModel(vehicle)) then
                status = "plane"
            elseif IsThisModelAHeli(GetEntityModel(vehicle)) then
                status = "heli"
            elseif IsThisModelACar(GetEntityModel(vehicle)) then
                status = "car"
            elseif IsThisModelABoat(GetEntityModel(vehicle)) then
                status = "boat"
            end
        end
    end

    if status then
        local blip = AddBlipForCoord(playerData.coords)
        SetBlipScale(blip, Config.Blips[status].scale)
        SetBlipDisplay(blip, Config.Blips[status].display)
        SetBlipSprite(blip, Config.Blips[status].sprite)
        SetBlipColour(blip, Config.Blips[status].color)
        SetBlipCategory(blip, Config.Blips[status].category)
        SetBlipAsShortRange(blip, Config.Blips[status].shortRange)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(playerData.rpName)
        EndTextCommandSetBlipName(blip)
        table.insert(blips, blip)
    end
end

local function removeBlips()
    for _, v in pairs(blips) do
        RemoveBlip(v)
    end
    blips = {}
end

RegisterNetEvent('sixv_gps:sendGPS')
AddEventHandler('sixv_gps:sendGPS', function(data)
    removeBlips()

    for _, v in pairs(data) do
        if PlayerData.job.name == v.job and haveItem(Config.GPS.item, 1) and v.playerId ~= GetPlayerServerId(PlayerId()) then
            local hasAccess = true
            for _, jobname in pairs(Config.GPS.NoAccessToGPS) do
                if PlayerData.job.name == jobname then
                    hasAccess = false
                    break
                end
            end

            if hasAccess then
                createBlipForPlayer(v)
            end
        end
    end
end)

RegisterNetEvent('sixv_gps:clearBlips')
AddEventHandler('sixv_gps:clearBlips', function()
    removeBlips()
end)
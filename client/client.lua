local blips = {}

local function haveItem(item, count)
    for _, v in pairs(getInventory()) do
        if v.name == item and v.count >= count then
            return true
        end
    end
    return false
end

local function createBlipForPlayer(data)
    local player = GetPlayerFromServerId(data.playerId)
    local ped = GetPlayerPed(player)
    local status = nil

    if IsEntityDead(ped) then
        if Config.Blips.dead.activated then
            status = "dead"
        else
            TriggerServerEvent("sixv_gps:stopGPS")
        end
    else
        if IsPedOnFoot(ped) and Config.Blips.foot.activated then
            status = "foot"
        else
            local vehicle = GetVehiclePedIsIn(ped, false)
            if IsThisModelAPlane(GetEntityModel(vehicle)) and Config.Blips.plane.activated then
                status = "plane"
            elseif IsThisModelAHeli(GetEntityModel(vehicle)) and Config.Blips.heli.activated then
                status = "heli"
            elseif IsThisModelACar(GetEntityModel(vehicle)) and Config.Blips.car.activated then
                status = "car"
            elseif IsThisModelABoat(GetEntityModel(vehicle)) and Config.Blips.boat.activated then
                status = "boat"
            end
        end
    end

    if status then
        local blip = AddBlipForCoord(data.coords)
        SetBlipScale(blip, Config.Blips[status].scale)
        SetBlipDisplay(blip, Config.Blips[status].display)
        SetBlipSprite(blip, Config.Blips[status].sprite)
        SetBlipColour(blip, Config.Blips[status].color)
        SetBlipCategory(blip, Config.Blips[status].category)
        SetBlipAsShortRange(blip, Config.Blips[status].shortRange)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(data.rpName)
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

    local PlayerData = getPlayerData()

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
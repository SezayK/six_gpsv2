if Config.framework == "esx" then
    if Config.newESX == false then
        ESX = nil

        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    else
        ESX = exports["es_extended"]:getSharedObject()
    end

    function RegisterUsableItem(name, callback)
        ESX.RegisterUsableItem(name, callback)
    end

    function GetPlayerObject(source)
        local xPlayer = ESX.GetPlayerFromId(source)

        return xPlayer
    end

    function getIdentifier(xPlayer)
        return xPlayer.identifier
    end

    function getSource(xPlayer)
        return xPlayer.source
    end

    function getCoords(player)
        local ped = GetPlayerPed(player.source)
        local coords = GetEntityCoords(ped)

        return coords
    end

    function getJobName(xPlayer)
        return xPlayer.getJob().name
    end 

    function getName(xPlayer)
        return xPlayer.name
    end

    function getInventoryItemCount(xPlayer, item)
        return xPlayer.getInventoryItem(item).count
    end
end
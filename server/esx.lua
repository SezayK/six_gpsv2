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

    function getJobName(xPlayer)
        return xPlayer.getJob().name
    end 

    function getName(xPlayer)
        return xPlayer.name
    end

    function getCoords(xPlayer)
        return GetEntityCoords(GetPlayerPed(xPlayer.source))
    end

    function getInventoryItemCount(xPlayer, item)
        return xPlayer.getInventoryItem(item).count
    end
    
    AddEventHandler('esx:onRemoveInventoryItem', function(source, item, count)
        local xPlayer = ESX.GetPlayerFromId(source)

        if item.name == Config.GPS.item then
            for _, gps in ipairs(gpsdata) do
                if gps.playerId == xPlayer.source then
                    table.remove(gpsdata, _)
                    notify(xPlayer.source, text("gps_notify_title"), text("gps_off"), "error")
                    TriggerClientEvent("sixv_gps:clearBlips", xPlayer.source)
                    return
                end
            end
        end
    end)
end
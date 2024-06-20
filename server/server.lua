local gpsdata = {}

function text(key, ...)
    local placeholders = {...}
    local text = Config.Locales[Config.Language][key]

    if text then
        return string.format(text, table.unpack(placeholders))
    end
end

AddEventHandler('onResourceStart', function()
    startgps()
end)

RegisterNetEvent("esx:removeInventoryItem")
AddEventHandler("esx:removeInventoryItem", function(item, count)
    if item.name == Config.GPS.item then
        for _, gps in ipairs(gpsdata) do
            if gps.playerId == source then
                table.remove(gpsdata, _)
                notify(source, text("gps_notify_title"), text("gps_off"), "error")
                TriggerClientEvent("sixv_gps:clearBlips", source)
                return
            end
        end
    end
end)

function startgps()
    SetTimeout(Config.GPS.refreshtime, function()
        local updatedData = {}

        for i, gps in ipairs(gpsdata) do
            local xPlayer = GetPlayerObject(gps.playerId)
            local ped = GetPlayerPed(gps.playerId)

            if xPlayer then  
                gps.coords = GetEntityCoords(ped)
                gps.job = getJobName(xPlayer)

                table.insert(updatedData, gps)
            else
                table.remove(gpsdata, i)
            end
        end

        if #updatedData > 0 then
            TriggerClientEvent("sixv_gps:sendGPS", -1, updatedData)
        end
        startgps()
    end)
end

RegisterUsableItem(Config.GPS.item, function(source)
    local xPlayer = GetPlayerObject(source)

    for _, gps in ipairs(gpsdata) do
        if gps.playerId == getSource(xPlayer) then
            table.remove(gpsdata, _)
            notify(source, text("gps_notify_title"), text("gps_off"), "error")
            TriggerClientEvent("sixv_gps:clearBlips", source)
            return
        end
    end

    table.insert(
        gpsdata,
        {
            playerId = getSource(xPlayer),
            identifier = getIdentifier(xPlayer),
            rpName = getName(xPlayer),
            job = getJobName(xPlayer),
            coords = getCoords(xPlayer),
        }
    )
    notify(source, text("gps_notify_title"), text("gps_on"), "success")
end)
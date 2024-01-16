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

function startgps()
    SetTimeout(Config.GPS.refreshtime, function()
        for _, gps in ipairs(gpsdata) do
            local xPlayer = GetPlayerObject(gps.playerId)
            if xPlayer then  
                local count = getInventoryItemCount(xPlayer, Config.GPS.item)
                if count > 0 then
                    gps.coords = getCoords(xPlayer)
                    gps.job = getJobName(xPlayer)
                    TriggerClientEvent("sixv_gps:sendGPS", gps.playerId, gpsdata)
                end
            else
                table.remove(gpsdata, _)
            end
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
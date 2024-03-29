if Config.framework == "qb" then
    local QBCore = exports['qb-core']:GetCoreObject()

    function RegisterUsableItem(name, callback)
        QBCore.Functions.CreateUseableItem(name, callback)
    end

    function GetPlayerObject(source)
        local player = QBCore.Functions.GetPlayer(source)

        return player
    end

    function getIdentifier(player)
        return player.PlayerData.citizenid
    end

    function getSource(player)
        return player.PlayerData.source
    end

    function getCoords(player)
        local ped = GetPlayerPed(player.PlayerData.source)
        local coords = GetEntityCoords(ped)

        return coords
    end

    function getJobName(player)
        return player.PlayerData.job.name
    end 

    function getName(player)
        return player.PlayerData.charinfo.firstname .. " " .. player.PlayerData.charinfo.lastname
    end

    function getInventoryItemCount(player, item)
        return player.Functions.GetItemByName(item).amount
    end
end
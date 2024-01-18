if Config.framework == "qb" then
    local playerLoaded = false

    Citizen.CreateThread(function()
        QBCore = exports['qb-core']:GetCoreObject()

        playerLoaded = true

        function TriggerServerCallback(name, cb, ...)
            if not IsDuplicityVersion() then
                QB.Functions.TriggerCallback(name, function(...) 
                    cb(...)
                end, ...)
            end
        end
    end)

    function getInventory()
        local PlayerData = QBCore.Functions.GetPlayerData()
        return PlayerData.inventory
    end

    function getPlayerData()
        local PlayerData = QBCore.Functions.GetPlayerData()
        while not PlayerData do
            Citizen.Wait(50)
        end
        return PlayerData
    end
end
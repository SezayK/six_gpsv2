if Config.framework == "qb" then
    local playerLoaded = false

    PlayerData = {}

    Citizen.CreateThread(function()
        QBCore = exports['qb-core']:GetCoreObject()

        playerLoaded = true

        PlayerData = QBCore.Functions.GetPlayerData()

        function TriggerServerCallback(name, cb, ...)
            if not IsDuplicityVersion() then
                QB.Functions.TriggerCallback(name, function(...) 
                    cb(...)
                end, ...)
            end
        end
    end)

    function getInventory()
        return PlayerData.inventory
    end

    function getPlayerData()
        while not PlayerData do
            Citizen.Wait(50)
        end
        return PlayerData
    end    

    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
        PlayerData.job = JobInfo
    end)
end
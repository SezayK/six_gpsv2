
if Config.framework == "esx" then
    local ESX = nil
    local playerLoaded = false

    PlayerData = {}

    Citizen.CreateThread(function()
        if Config.newESX == false then
            ESX = nil

            while ESX == nil do
                TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
                Citizen.Wait(50)
            end
        else
            ESX = exports["es_extended"]:getSharedObject()
        end

        PlayerData = ESX.GetPlayerData()

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(100)
        end

        while not ESX.IsPlayerLoaded() do
            Citizen.Wait(50)
        end

        playerLoaded = true

    end)

    function getInventory()
        PlayerData = ESX.GetPlayerData()
        return PlayerData.inventory
    end

    function getPlayerData()
        while not PlayerData do
            Citizen.Wait(50)
        end
        return PlayerData
    end

    RegisterNetEvent('esx:setJob')
    AddEventHandler('esx:setJob', function(job)
        PlayerData.job = job
    end)
end
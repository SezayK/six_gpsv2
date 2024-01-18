
if Config.framework == "esx" then
    local ESX = nil
    local playerLoaded = false

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
    end)

    function getInventory()
        local PlayerData = ESX.GetPlayerData()
        return PlayerData.inventory
    end

    function getPlayerData()
        local PlayerData = ESX.GetPlayerData()
        while not PlayerData do
            Citizen.Wait(50)
        end
        return PlayerData
    end
end
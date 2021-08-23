ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
    TriggerEvent('esx_license:getLicenses', source, function(licenses)
        TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
    end)
end)

RegisterNetEvent('yamsoo_autoecol:ajoutlicense')
AddEventHandler('yamsoo_autoecol:ajoutlicense', function(type)
    local _source = source

    TriggerEvent('esx_license:addLicense', _source, type, function()
        TriggerEvent('esx_license:getLicenses', _source, function(licenses)
            TriggerClientEvent('esx_dmvschool:loadLicenses', _source, licenses)
        end)
    end)
end)

RegisterNetEvent('paytonpermis')
AddEventHandler('paytonpermis', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    
        xPlayer.removeMoney(Config.Prix)
        TriggerClientEvent('esx:showNotification', source, 'Tu a payé ~g~'..Config.Prix..' $ ~s~pour le Permis.')
end)





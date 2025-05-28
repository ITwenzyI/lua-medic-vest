ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('medicbulletproof', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= 'ambulance' then
        cb(false, false) -- Not a medic
        return
    end

    if xPlayer.job.grade < 3 then
        cb(false, false) -- Rank too low
        return
    end

    if xPlayer.getInventoryItem("medicbulletproof").count >= 1 then
        xPlayer.removeInventoryItem("medicbulletproof", 1)
        cb(true, true) -- Has vest, is a medic, and rank is sufficient
    else
        cb(false, true) -- Is a medic with sufficient rank, but no vest
    end
end)

ESX.RegisterUsableItem('medicbulletproof', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= 'ambulance' then
        TriggerClientEvent('notifications', source, '#ff0000', "Error", "You are not a medic!")
        return
    end

    if xPlayer.job.grade < 3 then
        TriggerClientEvent('notifications', source, '#ff0000', "Error", "You are not a high-ranking medic!")
        return
    end

    TriggerClientEvent('medicbulletproof', source)
end)

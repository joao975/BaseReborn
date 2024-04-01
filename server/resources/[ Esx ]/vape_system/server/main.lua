ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Citizen.CreateThread(function()
	for i, v in ipairs(Config.Sigarette) do
		ESX.RegisterUsableItem(v.item, function(src)
			TriggerClientEvent('Vape:StartVaping', src)
		end)
	end
	for i,v in ipairs(Config.Gusti) do
		ESX.RegisterUsableItem(v.item,function(src) 
			local xPlayer = ESX.GetPlayerFromId(src)
			xPlayer.removeInventoryItem(v.item, 1)
			TriggerClientEvent('Vape:UseGusto', src, v.item, v.usage)
		end)
	end
end)

RegisterNetEvent("Vape:Failure")
AddEventHandler("Vape:Failure", function()
	TriggerClientEvent('esx:showNotification', source, 'Parece que o cigarro explodiu na sua cara')
end)

RegisterServerEvent("eff_smokes")
AddEventHandler("eff_smokes", function(entity)
	TriggerClientEvent("c_eff_smokes", -1, entity)
end)

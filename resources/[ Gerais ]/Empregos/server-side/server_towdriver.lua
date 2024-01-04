-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
twVRP = {}
Tunnel.bindInterface("towdriver",twVRP)
vtCLIENT = Tunnel.getInterface("towdriver")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local userList = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function twVRP.paymentMethodTow()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		userList[user_id] = nil
		vRP.upgradeStress(user_id,1)
		local value = configs.towdriver.payment

		vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
		TriggerClientEvent("vrp_sound:source",source,"coin",0.5)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOW
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tow",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vtCLIENT.checkServiceTow(source) or vRP.hasPermission(user_id,"Mechanic") then
			if vRPclient.getHealth(source) > 101 then
				vtCLIENT.towPlayer(source)
				userList[user_id] = source
			end
		else
			TriggerClientEvent("Notify",source,"importante","Somente trabalhadores do <b>Reboque</b> podem utilizar deste serviço.",5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYTOW
-----------------------------------------------------------------------------------------------------------------------------------------
function twVRP.tryTow(vehid01,vehid02,mod)
	TriggerClientEvent("vrp_towdriver:syncTow",-1,vehid01,vehid02,tostring(mod))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_TOWDRIVER:ALERTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_towdriver:alertPlayers")
AddEventHandler("vrp_towdriver:alertPlayers",function(x,y,z,message)
	for k,v in pairs(userList) do
		async(function()
			TriggerClientEvent("NotifyPush",v,{ time = os.date("%H:%M:%S - %d/%m/%Y"), code = 20, title = "Registro de Veículo", x = x, y = y, z = z, vehicle = message, rgba = {160,108,15} })
		end)
	end
end)

RegisterNetEvent("DeleteVehicle")
AddEventHandler("DeleteVehicle",function(vehid)
	TriggerClientEvent("will_garages_v2:deleteVehicle",-1,vehid)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if userList[user_id] then
		userList[user_id] = nil
	end
end)
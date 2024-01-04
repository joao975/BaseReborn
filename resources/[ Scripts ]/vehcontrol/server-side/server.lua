-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
---------------------------------------------------------------------
RegisterServerEvent("lvc_TogDfltSrnMuted_s")
AddEventHandler("lvc_TogDfltSrnMuted_s", function(toggle)
	TriggerClientEvent("lvc_TogDfltSrnMuted_c",-1,source,toggle)
end)
---------------------------------------------------------------------
RegisterServerEvent("lvc_SetLxSirenState_s")
AddEventHandler("lvc_SetLxSirenState_s", function(newstate)
	TriggerClientEvent("lvc_SetLxSirenState_c",-1,source,newstate)
end)
---------------------------------------------------------------------
RegisterServerEvent("lvc_SetAirManuState_s")
AddEventHandler("lvc_SetAirManuState_s", function(newstate)
	TriggerClientEvent("lvc_SetAirManuState_c",-1,source,newstate)
end)
---------------------------------------------------------------------
RegisterServerEvent("lvc_TogIndicState_s")
AddEventHandler("lvc_TogIndicState_s", function(newstate)
	TriggerClientEvent("lvc_TogIndicState_c",-1,source,newstate)
end)
---------------------------------------------------------------------
RegisterNetEvent("vehcontrol:Doors")
AddEventHandler("vehcontrol:Doors", function(door)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) > 101 then
			local vehicle,vehNet = vRPclient.vehList(source,7)
			if vehicle then
				if door == "6" then
					TriggerClientEvent("vrp_player:syncHood",-1,vehNet)
				else
					TriggerClientEvent("vrp_player:syncDoors",-1,vehicle,door)
				end
			end
		end
	end
end)

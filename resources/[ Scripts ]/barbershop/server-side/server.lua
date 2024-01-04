-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cO = {}
Tunnel.bindInterface("barbershop",cO)
vCLIENT = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBER
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.checkOpen()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if not vRP.searchReturn(source,user_id) then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.updateSkin(myClothes)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"currentCharacterMode", json.encode(myClothes))
		SetTimeout(1000, function()
			local value = vRP.getUData(user_id,"currentCharacterMode")
			if value ~= nil then
				local custom = json.decode(value) or {}
				vCLIENT.updateFacial(source,custom)
			end
		end)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DESBUGAR para player
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("desbugar",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("Notify",source,"SUCESSO","Você foi desbugado.")
		local value = vRP.getUData(user_id,"currentCharacterMode")
		if value ~= nil then
			local custom = json.decode(value) or {}
			vCLIENT.setCharacter(source,custom)
			vRPclient.DeletarObjeto()
			vRPclient._stopAnim(false)
		end
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- /bvida 
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("barbershop:bvida")
AddEventHandler("barbershop:bvida",function()
    local source = source
    vRPclient._setCustomization(source,vRPclient.getCustomization(source))
    vRP.removeCloak(source)
	local user_id = vRP.getUserId(source)
	local value = vRP.getUData(user_id,"currentCharacterMode")
	if value ~= nil then
		local custom = json.decode(value) or {}
		vCLIENT.setCharacter(source,custom)
		vRPclient.DeletarObjeto(source)
		vRPclient._stopAnim(source,false)
	end
end)
----------------------------------------------------------------------------------------------------------------------------------------
-- SETINSTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.setInstance(status)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then 
        if status then 
	        SetPlayerRoutingBucket(source, parseInt(user_id))
        else
			if GetPlayerRoutingBucket(source) ~= 0 then
		        SetPlayerRoutingBucket(source, 0)
			end
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN CHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("b2k-barbershop:init", function(user_id)
	local player = vRP.getUserSource(user_id)
	if player then
		local value = vRP.getUData(user_id,"currentCharacterMode")
		if value ~= nil then
			local custom = json.decode(value) or {}
			vCLIENT.setCharacter(player,custom)
		end
	end
end)

RegisterNetEvent("barbershop:reset")
AddEventHandler("barbershop:reset",function()
	local source = source
	local user_id = vRP.getUserId(source)
	if source then
		local value = vRP.getUData(user_id,"currentCharacterMode")
		if value ~= nil then
			local custom = json.decode(value) or {}
			vCLIENT.setCharacter(source,custom)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cRP = {}
Tunnel.bindInterface("skinshop",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.checkShares()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.getFines(user_id) > 0 then
			TriggerClientEvent("Notify",source,"aviso","Multas pendentes encontradas.",3000)
			return false
		end

		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATECLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.updateClothes(clothes)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id, "Clothings", json.encode(clothes))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("skin",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id and args[1] then
		if vRP.hasPermission(user_id,"admin.permissao") then
			local otherPlayer = vRP.getUserSource(parseInt(args[1]))
			if otherPlayer then
				vRPC.applySkin(otherPlayer,GetHashKey(args[2]))
				vRP.updateSelectSkin(parseInt(args[1]),GetHashKey(args[2]))
			end
		end
	end
end)

RegisterCommand("mascara",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		TriggerClientEvent("skinshop:setMask",source)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKINSHOP:REMOVEPROPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("skinshop:removeProps")
AddEventHandler("skinshop:removeProps",function(mode)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local otherPlayer = vRPC.nearestPlayer(source)
		if otherPlayer then
			if vRP.hasPermission(user_id,"Police") then
				TriggerClientEvent("skinshop:set"..mode,otherPlayer)
			end
		end
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    local source = source
    local data = json.decode(vRP.getUData(user_id,"Clothings"))
    if data then
		Citizen.Wait(1200)
		TriggerClientEvent("skinshop:apply", source, data)
	end
end)

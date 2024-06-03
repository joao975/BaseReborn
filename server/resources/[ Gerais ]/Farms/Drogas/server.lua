local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
drugs = {}
Tunnel.bindInterface("drogas",drugs)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES
-----------------------------------------------------------------------------------------------------------------------------------------
function drugs.checkPermission(perm)
	local source = source
	local user_id = vRP.getUserId(source)
	return vRP.hasPermission(user_id,perm)
end

function drugs.checkPayment(id,farm)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local src = Farms[farm].itens
		if src[id].re ~= nil then
			if vRP.computeInvWeight(user_id)+vRP.itemWeightList(src[id].item)*src[id].itemqtd <= vRP.getBackpack(user_id) then
				if vRP.tryGetInventoryItem(user_id,src[id].re,src[id].reqtd,false) then
					vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
					return true
				else
					TriggerClientEvent("Notify",source,"negado","Você não possui "..src[id].reqtd.."x "..vRP.itemNameList(src[id].re), 5000)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Você não possui espaço suficiente", 5000)
			end
		else
			if vRP.computeInvWeight(user_id)+vRP.itemWeightList(src[id].item)*src[id].itemqtd <= vRP.getBackpack(user_id) then
				vRP.giveInventoryItem(user_id,src[id].item,src[id].itemqtd,false)
				return true
			else
				TriggerClientEvent("Notify",source,"negado","Você não possui espaço suficiente", 5000)
			end
		end
	end
end

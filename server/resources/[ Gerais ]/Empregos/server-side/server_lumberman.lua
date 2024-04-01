vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
lmVRP = {}
Tunnel.bindInterface("lumberman",lmVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {}
local collectMin = 2
local collectMax = 6

local amount = {}
local consumeItem = "woodlog"
-----------------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function lmVRP.amountService()
	local source = source
	if amount[source] == nil then
		amount[source] = configs.lumberman.amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function lmVRP.collectMethodLumber()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local amount = math.random(collectMin,collectMax)
		if vRP.computeInvWeight(user_id) + vRP.itemWeightList(tostring(consumeItem)) * amount <= vRP.getBackpack(user_id) then
			vRPclient.stopActived(source)
			TriggerClientEvent("Progress",source,3000,"Coletando...")
			TriggerClientEvent("cancelando",source,true)
			vRP.giveInventoryItem(user_id,tostring(consumeItem),amount,true)
			vRPclient._playAnim(source,false,{"melee@hatchet@streamed_core","plyr_front_takedown_b"},true)
			return true
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function lmVRP.paymentMethodLenhador()
	lmVRP.amountService()

	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,tostring(consumeItem),parseInt(amount[source])) then
			vRP.upgradeStress(user_id,1)
			local value = configs.lumberman.payment * amount[source]

			vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
			TriggerClientEvent("vrp_sound:source",source,"coin",0.5)
			amount[source] = nil

			return true
		else
			TriggerClientEvent("Notify",source,"aviso","Você precisa de <b>"..vRP.format(parseInt(amount[source])).."x "..vRP.itemNameList(consumeItem).."</b>.",5000)
		end

		return false
	end
end
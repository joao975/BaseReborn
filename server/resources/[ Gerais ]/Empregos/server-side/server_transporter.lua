-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
tpVRP = {}
Tunnel.bindInterface("transporter",tpVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local collect = {}
local collectMin = 2
local collectMax = 4

local amount = {}
local consumeItem = "pouch"
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTCOLLECT
-----------------------------------------------------------------------------------------------------------------------------------------
function tpVRP.amountCollect(source)
	local source = source
	if collect[source] == nil then
		collect[source] = math.random(collectMin,collectMax)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- AMOUNTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function tpVRP.amountService(source)
	local source = source
	if amount[source] == nil then
		amount[source] = configs.transporter.amount
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLLECTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function tpVRP.collectMethod()
	local source = source
	tpVRP.amountCollect(source)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.computeInvWeight(user_id) + vRP.itemWeightList(tostring(consumeItem)) * parseInt(collect[source]) <= vRP.getBackpack(user_id) then
			vRPclient.stopActived(source)
			TriggerClientEvent("Progress",source,5000,"Coletando...")
			TriggerClientEvent("cancelando",source,true)
			vRP.giveInventoryItem(user_id,tostring(consumeItem),parseInt(collect[source]))
			vRPclient._playAnim(source,false,{"amb@prop_human_atm@male@idle_a","idle_a"},false)
			collect[source] = nil

			return true
		else
			TriggerClientEvent("Notify",source,"negado","Sem espaço suficiente",5000)
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function tpVRP.paymentMethodTransporter()
	local source = source
	tpVRP.amountService(source)

	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,tostring(consumeItem),parseInt(amount[source])) then
			local value = configs.transporter.payment * amount[source]

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
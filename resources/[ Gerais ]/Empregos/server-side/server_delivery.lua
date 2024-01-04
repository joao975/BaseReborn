-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
dvVRP = {}
Tunnel.bindInterface("delivery",dvVRP)
vTASKBAR = Tunnel.getInterface("taskbar")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local locates = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local itemCheck = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local itemList = { "tacos","hamburger","hotdog","soda","cola","chocolate","sandwich","fries","absolut","chandon","dewars","donut","hennessy" }
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function dvVRP.paymentMethodDelivery()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.tryGetInventoryItem(user_id,"delivery",1) then
			local myBonus = vRP.bonusDelivery(user_id)
			local value = configs.delivery.payment
			vRPclient._playAnim(source,false,{"pickup_object","pickup_low"},true)
			Citizen.Wait(500)
			vRP.giveInventoryItem(user_id,"dollars",parseInt(value+(value*myBonus/100)),true)

			TriggerClientEvent("vrp_sound:source",source,"coin",0.5)
			vRPclient._stopAnim(source)
			return true
		end
		return false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DROPFOOD
-----------------------------------------------------------------------------------------------------------------------------------------
function dvVRP.dropFood(locate,food)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if locates ~= nil then
			if vRP.getInventoryItemAmount(user_id,"paperbag") >= 1 and vRP.getInventoryItemAmount(user_id,food) >= 1 then
				vRPclient._playAnim(source,false,{"amb@prop_human_parking_meter@female@idle_a","idle_a_female"},false)
				local taskResult = vTASKBAR.taskOne(source)
				if taskResult then
					vRP.removeInventoryItem(user_id,"paperbag",1,false)
					vRP.removeInventoryItem(user_id,food,1,false)
					itemCheck[locate] = true
					locates = nil
					vRPclient._stopAnim(source,false)
					TriggerClientEvent("vrp_delivery:updateItem",-1,locates)
					dvVRP.takeDelivery(source,locate)
					dvVRP.groupDelivery(source)
					return true
				end
			else
				TriggerClientEvent("Notify",source,"aviso","Voce nao possui <b>saco de papel</b> ou <b>"..food..'</b>.',7000)
			end
			vRPclient._stopAnim(source,false)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TAKEDELIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function dvVRP.takeDelivery(source, locate)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		locates = itemList[math.random(#itemList)]
		vRP.giveInventoryItem(user_id,"delivery",1,true)
		TriggerClientEvent("vrp_delivery:updateItem",-1,locates)
	end
end

function dvVRP.groupDelivery(source)
	local source = source
	local user_id = vRP.getUserId(source)
	if not vRP.hasPermission(user_id,"Delivery") then
		vRP.execute("vRP/add_group",{ user_id = user_id, permiss = tostring("Delivery") })
		vRP.insertPermission(user_id,tostring("Delivery"))
		TriggerClientEvent("Notify",source,"sucesso","Você iniciou o trabalho de Delivery.",5000)
		TriggerClientEvent("Notify",source,"importante",'Utilize "/entrega" para sair de serviço.',5000)
	end
end

function dvVRP.ungroupDelivery()
	local source = source
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Delivery") then
		vRP.execute("vRP/del_group",{ user_id = user_id, permiss = tostring("Delivery") })
		vRP.removePermission(user_id,tostring("Delivery"))
	end
	TriggerClientEvent("Notify",source,"sucesso","Você saiu de serviço.",5000)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSTART
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	locates = itemList[math.random(#itemList)]
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("vrp_delivery:updateItem",source,locates)
end)

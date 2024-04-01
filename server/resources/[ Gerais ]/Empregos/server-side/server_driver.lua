-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
will = {}
Tunnel.bindInterface("driver", will)
vCLIENT = Tunnel.getInterface("driver")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTMETHOD
-----------------------------------------------------------------------------------------------------------------------------------------
function will.paymentMethodDriver()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local value = configs.driver['payment']
		vRP.giveInventoryItem(user_id,"dollars",parseInt(value),true)
		TriggerClientEvent("vrp_sound:source",source,"coin",0.5)
	end
end

--#########################
---## FRAMEWORK FUNCTIONS
--#########################

function getUserId(source)
    if Config.base == "cn" then
		return vRP.Passport(source)
    end
    return vRP.getUserId(source)
end

function hasPermission(user_id, perm)
    if Config.base == "cn" then
        return vRP.HasPermission(user_id, perm)
    end
    return vRP.hasPermission(user_id, perm)
end

function tryPayment(user_id, price)
    if Config.base == "cn" then
        return vRP.PaymentFull(user_id, parseInt(price))
    elseif Config.base == "summerz" then
        return vRP.paymentFull(user_id, parseInt(price))
    end
	return vRP.tryFullPayment(user_id, parseInt(price))
end

function getVehiclePlate(plate)
    return vRP.getVehiclePlate(plate)
end

function getUserBank(user_id)
    if Config.base == "cn" then
        return vRP.GetBank(user_id)
    elseif Config.base == "summerz" then
        return vRP.getBank(user_id)
    end
    return vRP.getBankMoney(user_id)
end

function setSData(dkey, dvalue)
    vRP.setSData(dkey, dvalue)
end

function getSData(key)
    return vRP.getSData(key)
end

RegisterCommand('customs', function (source, args)
    local source = tonumber(source)
    local user_id = getUserId(source)
    if hasPermission(user_id, Config.adminPermission) then
        TriggerClientEvent('will_customs:openmenu',source, true)
    end
end)

--#########################
---## FUNCTIONS
--#########################

function getUserId(source)
    if Config.base == "cn" then
		return vRP.Passport(source)
    end
    return vRP.getUserId(source)
end

function getUserSource(user_id)
	if Config.base == "summerz" then
		return vRP.userSource(user_id)
    elseif Config.base == "cn" then
		return vRP.Source(user_id)
	end
	return vRP.getUserSource(user_id)
end

function getUserIdentity(user_id)
    local identity = vRP.getUserIdentity(user_id)
    if Config.base == "summerz" then
		identity = vRP.userIdentity(user_id)
    elseif Config.base == "cn" then
		identity = vRP.Identity(user_id)
	end
	if not identity.name2 then
        identity.name2 = identity.firstname
    end
    return identity
end

function giveInventoryItem(user_id, item, amount)
    if Config.base == "cn" then
		vRP.GiveItem(user_id, item, amount, true)
    else
        vRP.giveInventoryItem(user_id, item, amount, true)
	end
end

function checkUserWeight(user_id, item, amount)
    if Config.base == "cn" then
        if vRP.InventoryWeight(user_id) + (getItemWeight(item) * amount) <= vRP.GetWeight(user_id) then
            return true
        end
    elseif Config.base == "summerz" then
        if vRP.inventoryWeight(user_id) + (getItemWeight(item) * amount) <= vRP.getWeight(user_id) then
            return true
        end
    elseif Config.base == "creative" then
        if vRP.computeInvWeight(user_id) + (getItemWeight(item) * amount) <= vRP.getBackpack(user_id) then
            return true
        end
    else
        if vRP.getInventoryWeight(user_id) + (getItemWeight(item) * amount) <= vRP.getInventoryMaxWeight(user_id) then
            return true
        end
    end
    local source = getUserSource(user_id)
    if source then
        notify(source, "Denied", Config.Notify['NoWeight'])
    end
end

function getItemName(item)
    return vRP.itemNameList(item) or item
end

function getItemWeight(item)
    if item == "fuel" then
        return 0.01
    end
    return vRP.itemWeightList(item) or 0.5
end

function tryPayment(user_id, price)
    if Config.base == "cn" then
        return vRP.PaymentFull(user_id, parseInt(price))
    elseif Config.base == "summerz" then
        return vRP.paymentFull(user_id, parseInt(price))
    end
	return vRP.tryFullPayment(user_id, parseInt(price))
end

function getUserMoney(user_id)
    if Config.base == "cn" then
        return vRP.InventoryFull(user_id,"dollars")
    elseif Config.base == "summerz" then
        return vRP.itemAmount(user_id, "dollars")
    end
    return vRP.getInventoryItemAmount(user_id, "dollars")
end

function giveUserMoney(user_id, money)
    if Config.base == "cn" then
        vRP.GiveBank(user_id, money)
    elseif Config.base == "vrpex" then
        vRP.giveMoneyBank(user_id, money)
    else
        vRP.addBank(user_id, money)
    end
end

function prepare(name, query)
    vRP.prepare(name, query)
end

function query(name, data)
    return vRP.query(name, data)
end

function execute(name, data)
    if Config.base == "cn" then
        vRP.query(name, data)
    else
        vRP.execute(name, data)
    end
end

function spawnVehicle(vehName, coords)
    local debugVehicle = 0
    local mHash = GetHashKey(vehName)
    local nveh = CreateVehicle(mHash,coords,true,true)
    while not DoesEntityExist(nveh) and debugVehicle <= 80 do
        debugVehicle = debugVehicle + 1
        Citizen.Wait(100)
    end
    if DoesEntityExist(nveh) then
        local vehPlate = "SHOPS"..math.random(100,999)
        SetVehicleNumberPlateText(nveh,vehPlate)
        TriggerEvent("setPlateEveryone",vehPlate)
        TriggerEvent("plateEveryone",vehPlate)
        SetVehicleDoorsLocked(nveh,1)
        return NetworkGetNetworkIdFromEntity(nveh)
    end
end

function deleteVehicle(vehNet)
    local nveh = NetworkGetEntityFromNetworkId(vehNet)
    if DoesEntityExist(nveh) then
        DeleteEntity(nveh)
    end
end

function request(source,text)
    return vRP.request(source,text,30)
end

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    playerSpawn(source, user_id)
end)

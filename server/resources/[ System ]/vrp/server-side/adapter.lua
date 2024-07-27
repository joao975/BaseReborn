function exportHandler(resource, exportName, func)
    AddEventHandler(('__cfx_export_%s_%s'):format(resource,exportName), function(setCB)
        setCB(func)
    end)
end
-------##########-------##########-------##########-------##########
--						CREATIVE -> VRP
-------##########-------##########-------##########-------##########

-- MONEY

vRP.giveBankMoney = function(id, price)
    vRP.addBank(id, price)
end

vRP.setBankMoney = function(id, price)
    vRP.setBank(id, price)
end

vRP.getMoney = function(user_id)
	return vRP.getInventoryItemAmount(user_id,'dollars')
end

vRP.setMoney = function(user_id,value)
    local money = vRP.getMoney(user_id)
    if vRP.tryGetInventoryItem(user_id, 'dollars', money) then
        vRP.giveMoney(user_id, value)
    end
end

vRP.getBankMoney = function(id)
    return vRP.getBank(id)
end

vRP.tryPayment = function(id, price)
    return vRP.paymentBank(id, price)
end

function vRP.giveMoney(user_id, amount)
    if parseInt(amount) > 0 then
        vRP.giveInventoryItem(user_id, "dollars", parseInt(amount))
    end
end

-- INVENTORY

vRP.getItemWeight = function(item)
    return vRP.itemWeightList(item)
end

vRP.getInventoryWeight = function(id)
    return vRP.computeInvWeight(id)
end

vRP.computeItemsWeight = function(items)
    return vRP.computeChestWeight(items)
end

vRP.getInventoryMaxWeight = function(id)
    return vRP.getBackpack(id)
end

-- IDENTITY

vRP.getUserByRegistration = function(id)
    return vRP.getUserIdRegistration(id)
end

-- CREATIVE V5

vRP.checkBanned = function(id)
    return vRP.isBanned(id)
end

vRP.userData = function(id,key)
    return vRP.getUData(id,key)
end

vRP.infoAccount = function(id)
    return vRP.getInfos(id)
end

vRP.userInventory = function(id)
    return vRP.getInventory(id)
end

vRP.userPlayers = function()
    return vRP.getUsers()
end

vRP.userSource = function(id)
    return vRP.getUserSource(id)
end

vRP.getDatatable = function(id)
    return vRP.getUserDataTable(id)
end

vRP.userIdentity = function(id)
    return vRP.getUserIdentity(id)
end

vRP.generateItem = function(id,item,amount,notify)
    return vRP.giveInventoryItem(id,item,amount,notify)
end

vRP.userBank = function(id)
    return vRP.getBank(id)
end

vRP.setPermission = function(id,group)
    return vRP.addUserGroup(id,group)
end

vRP.remPermission = function(id,group)
    return vRP.removeUserGroup(id,group)
end

vRP.updatePermission = function(user_id,perm,new)
    if vRP.hasPermission(user_id,perm) then
        vRP.removeUserGroup(user_id,perm)
        vRP.addUserGroup(user_id,new)
    end
end

vRP.characterChosen = function(source,user_id,model,locate)
    TriggerEvent("baseModule:idLoaded",source,user_id,model)
end

vRP.userPlate = function(data)
    return vRP.getVehiclePlate(data)
end

vRP.userPhone = function(data)
    return vRP.getUserByPhone(data)
end

vRP.generatePlate = function()
    return vRP.generatePlateNumber()
end

vRP.generatePhone = function()
    return vRP.generatePhoneNumber()
end

vRP.generateSerial = function()
    return vRP.generateRegistrationNumber()
end

vRP.userSerial = function(id)
    return vRP.getUserIdRegistration(id)
end

vRP.getSrvdata = function(key)
    return vRP.getSData(key)
end

vRP.setSrvdata = function(key,value)
    return vRP.setSData(key,value)
end

vRP.remSrvdata = function(key)
    vRP.setSData(key,'[]')
end

vRP.getWeight = function(id)
    return vRP.getBackpack(id)
end

vRP.setWeight = function(id,amount)
    return vRP.setBackpack(id,amount)
end

vRP.inventoryWeight = function(id)
    return vRP.computeInvWeight(id)
end

vRP.chestWeight = function(id)
    return vRP.computeChestWeight(id)
end

vRP.tryChest = function(user_id,chestData,itemName,amount,slot)
    return vRP.tryChestItem(user_id,chestData,itemName,amount,slot)
end

vRP.storeChest = function(user_id,chestData,itemName,amount,chest,slot)
    return vRP.storeChestItem(user_id,chestData,itemName,amount,chest,slot)
end

vRP.updateChest = function(user_id,chestData,itemName,amount,chest,slot)
    return vRP.storeChestItem(user_id,chestData,itemName,amount,chest,slot)
end

vRP.paymentFull = function(id,amount)
    return vRP.paymentBank(id,amount)
end

-------##########-------##########-------##########-------##########
--							PERMISSIONS
-------##########-------##########-------##########-------##########

vRP.getUsersByPermission = function(group)
    if string.find(group, ".permissao") then
        local users = {}
        for k,v in pairs(vRP.rusers) do
            if vRP.hasPermission(tonumber(k), group) then
                table.insert(users,tonumber(k))
            end
        end
        return users
    end
    return vRP.numPermission(group) 
end

vRP.hasGroup = function(user_id,group)
    return vRP.hasPermission(user_id,group)
end

vRP.addUserGroup = function(user, group)
    local source = vRP.getUserSource(parseInt(user))
    Reborn.setGroup(source, group)
end

vRP.removeUserGroup = function(user,group)
    local source = vRP.getUserSource(parseInt(user))
    Reborn.remGroup(source,group)
end

vRP.Source = vRP.getUserSource
vRP.Passport = vRP.getUserId
vRP.UserData = vRP.getUData
vRP.Query = vRP.query
vRP.Prepare = vRP.prepare
vRP.Datatable = vRP.getUserDataTable
vRP.HasPermission = vRP.hasPermission
vRP.PaymentFull = vRP.tryFullPayment

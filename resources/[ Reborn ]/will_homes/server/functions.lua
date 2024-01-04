-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------
--########## Funções vRP ##########
-----------------------------------

function getUserId(source)
    return vRP.getUserId(source)
end

function getUserSource(user_id)
	return vRP.getUserSource(user_id)
end

function getUserIdentity(user_id)
	return vRP.getUserIdentity(user_id)
end

function hasPermission(user_id, perm)
    return vRP.hasPermission(user_id, perm)
end

function paymentMethod(user_id, price, house)
    if house.vip then
        -- funçao de pagar com gemas
        return true or false
    end
    local payment = vRP.paymentBank(parseInt(user_id),price)
    if not payment then
        local nplayer = getUserSource(user_id)
        TriggerClientEvent("Notify",nplayer,"negado","Dinheiro insuficiente",5000)
    end
    return payment
end

function addBank(user_id, amount)
    vRP.addBank(user_id, amount)
    local nplayer = getUserSource(user_id)
    if nplayer then
        TriggerClientEvent("Notify",nplayer,"sucesso","Dinheiro recebido R$"..amount,5000)
    end
end

function getNearestPlayers(source)
    local result = {}
    local users = vRPclient.nearestPlayers(source, 4)
    if users then
        for k,v in pairs(users) do
            local nuser_id = getUserId(k)
            local identity = getUserIdentity(nuser_id)
            table.insert(result, { id = nuser_id, name = identity.name })
        end
    end
    return result
end

function prepare(name, query)
    vRP.prepare(name, query)
end

function query(name, data)
    return vRP.query(name, data)
end

function execute(name, data)
    vRP.execute(name, data)
end

function request(source,text,time)
    return vRP.request(source,text,time)
end

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    playerSpawn(user_id, source)
end)

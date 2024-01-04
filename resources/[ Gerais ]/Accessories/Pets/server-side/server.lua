
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
local ped = {}
Tunnel.bindInterface(GetCurrentResourceName(),ped)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())


local animal = {}

function ped.CreatePed(model,x,y,z,heading,typ)
    local spawnPeds = 0
    local mHash = GetHashKey(model)
    local Ped = CreatePed(typ,mHash,x,y,z,heading,true,false)

    while not DoesEntityExist(Ped) and spawnPeds <= 1000 do
        spawnPeds = spawnPeds + 1
        Citizen.Wait(1)
    end

    if DoesEntityExist(Ped) then
        return true,NetworkGetNetworkIdFromEntity(Ped)
    end

    return false
end

function ped.animalRegister(netId)
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        animal[user_id] = netId
    end
end

function ped.getPets()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        local jsonData = vRP.getUData(user_id,'Animals')
        local data = json.decode(jsonData)
        return data
    end
end

function ped.animalCleaner()
    local source = source
    local user_id = vRP.getUserId(source)
    if user_id then
        TriggerEvent("trydeleteped",animal[user_id])
        animal[user_id] = nil
    end
end
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
arc = {}
Tunnel.bindInterface(GetCurrentResourceName(),arc)
vCLIENT = Tunnel.getInterface(GetCurrentResourceName())
vRPclient = Tunnel.getInterface("vRP")
br =  Tunnel.getInterface("barbershop")
Reborn = Proxy.getInterface("Reborn")

local userlogin = {}

--vRP.prepare("vRP/update_name","UPDATE vrp_user_identities SET name = @name, firstname = @firstname WHERE user_id = @user_id")
--vRP.prepare("arcade/createCharacterres","UPDATE vrp_user_identities SET name = @name, firstname = @name2, age = @idade, vimPor = @where WHERE user_id = @newID")

RegisterServerEvent("createModule:createAccount")
AddEventHandler("createModule:createAccount",function(currentCharacterMode,current)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.setUData(user_id,"currentCharacterMode",json.encode(currentCharacterMode))
		vRP.setUData(user_id,"vRP:spawnController",json.encode(2))
		--vRP.execute("arcade/createCharacterres",{ newID = user_id, name = current.name, name2 = current.lastname, idade = parseInt(current.age), where = current.where })
		local first_login = Reborn.first_login()
		vRPclient.teleport(source,first_login['Spawn'].x,first_login['Spawn'].y,first_login['Spawn'].z)
		userlogin[user_id] = true
		SetPlayerRoutingBucket(source,0)
        vRP.updateSelectSkin(user_id,GetEntityModel(GetPlayerPed(source)))
		Citizen.Wait(500)
		vRPclient._setCustomization(source,vRPclient.getCustomization(source))
		Citizen.Wait(500)
		vRPclient.setHealth(source, 400)
		TriggerClientEvent("creation:spawn",source, {}, {}, false)
		if currentCharacterMode ~= nil then
			br.setCharacter(source,currentCharacterMode)
		end
		local clothes = {}
		if GetEntityModel(GetPlayerPed(source)) == 1885233650 then
			clothes = first_login['Clothes']['Male']
		else
			clothes = first_login['Clothes']['Female']
		end
		TriggerClientEvent("skinshop:apply",source,clothes)
		for k,v in pairs(first_login['Itens']) do
			vRP.giveInventoryItem(user_id,k,v)
		end
	end
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local data = vRP.getUData(user_id,"vRP:spawnController")
	local sdata = json.decode(data) or 0
	if sdata then
		Citizen.Wait(1000)
		processSpawnController(source,sdata,user_id)
	end
end)

function processSpawnController(source,statusSent,user_id)
	if statusSent == 2 then
		if not userlogin[user_id] then
			userlogin[user_id] = true
			doSpawnPlayer(source,user_id,true)
		else
			doSpawnPlayer(source,user_id,false)
		end
	elseif statusSent == 1 or statusSent == 0 then
		userlogin[user_id] = true
		TriggerClientEvent("createModule:characterCreate",source)
		SetPlayerRoutingBucket(source,source)
	end
end

function doSpawnPlayer(source, user_id, firstspawn)
	local roupas = getUserClothes(user_id)
    local barber = getUserBarber(user_id)
	TriggerEvent("b2k-barbershop:init", user_id)
    TriggerClientEvent("creation:spawn",source, roupas, barber, firstspawn)
end

function getUserClothes(user_id)
    local data = vRP.getUData(user_id, "Datatable")
    if data and data ~= "" then
        local datatable = json.decode(data)
        if datatable and datatable.customization then
            return datatable.customization
        end
    end
end

function getUserBarber(user_id)
    local data = vRP.getUData(user_id, "currentCharacterMode")
    if data and data ~= "" then
        local datatable = json.decode(data)
        return datatable
    end
end

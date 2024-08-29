-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Will = {}
Tunnel.bindInterface("initial",Will)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKINIT
-----------------------------------------------------------------------------------------------------------------------------------------
function Will.CheckInit()
	local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id,true)
	if user_id then
        if identity.initial == "false" then
            return true
        end	
	end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
function Will.Save(vehName)
	local source = source
	local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id, true)
	if user_id then
        if identity.initial == "false" then
            if GetResourceState("will_garages_v2") == "started" then
                exports['will_garages_v2']:addVehicle(user_id, vehName)
            else
                local plate = vRP.generatePlateNumber()
                local phone = vRP.getPhone(user_id)
                vRP.execute("vRP/add_vehicle",{ user_id = parseInt(user_id), vehicle = vehName, plate = plate, phone = phone, work = 'false' })
            end
            vRP.query("accounts/Initial",{ id = user_id })
            TriggerClientEvent("Notify",source,"verde",NotifySuccess,30000)
        else
            TriggerClientEvent("Notify",source,"vermelho","Você já resgatou o seu prêmio inicial!",10000)
	    end
    end
end

AddEventHandler("vRP:playerSpawn",function(user_id, source)
    local identity = vRP.getUserIdentity(user_id, true)
	if identity and (identity.initial == "false" or identity.initial == false) then
        TriggerClientEvent("initial:Notify", source)
	end
end)

CreateThread(function()
    Wait(500)
    vRP.prepare("accounts/Initial","UPDATE `vrp_users` SET initial = 'true' WHERE id = @id")
    vRP.execute("ALTER TABLE `vrp_users` ADD COLUMN IF NOT EXISTS `initial` VARCHAR(50) NULL DEFAULT 'false';")
end)
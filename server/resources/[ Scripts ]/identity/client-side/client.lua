-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
will = {}
Tunnel.bindInterface("identity",will)
vSERVER = Tunnel.getInterface("identity")

local opened = false

RegisterCommand("identidade", function()
    if not opened then
        opened = true
        local infos = vSERVER.getIndentity()
        SendNUIMessage({ open = true, infos = infos })
        SetTimeout(6000, function()
            SendNUIMessage({ open = false })
            opened = false
        end)
    else
        SendNUIMessage({ open = false })
        opened = false
    end
end)

RegisterKeyMapping("identidade","Identity: Mostrar Identidade","keyboard","f11")
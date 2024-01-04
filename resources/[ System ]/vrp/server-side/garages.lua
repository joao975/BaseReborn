-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
local Tunnel = module("vrp","lib/Tunnel")

function vRP.vehicleGlobal()
	return exports['will_garages_v2']:getVehicleGlobal()
end

function vRP.vehicleName(vname)
	return exports['will_garages_v2']:getVehicleName(vname)
end

function vRP.vehicleChest(vname)
	return exports['will_garages_v2']:getVehicleChest(vname)
end

function vRP.vehiclePrice(vname)
	return exports['will_garages_v2']:getVehiclePrice(vname)
end

function vRP.vehicleType(vname)
	return exports['will_garages_v2']:getVehicleType(vname)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHGLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.vehicleGlobal()
	if GetResourceState("will_garages_v2") == "started" then
		return exports['will_garages_v2']:getVehicleGlobal()
	end
	return Reborn.vehList()
end

function vRP.vehicleName(vname)
	if GetResourceState("will_garages_v2") == "started" then
		return exports['will_garages_v2']:getVehicleName(vname)
	end
	local vehList = Reborn.vehList()
	for k,v in pairs(vehList) do
		if v.hash == GetEntityModel(vname) then
			return v.name
		end
	end
end

function vRP.vehicleChest(vname)
	if GetResourceState("will_garages_v2") == "started" then
		return exports['will_garages_v2']:getVehicleChest(vname)
	end
	local vehList = Reborn.vehList()
	for k,v in pairs(vehList) do
		if v.hash == GetEntityModel(vname) then
			return v.capacidade
		end
	end
end

function vRP.vehiclePrice(vname)
	if GetResourceState("will_garages_v2") == "started" then
		return exports['will_garages_v2']:getVehiclePrice(vname)
	end
	local vehList = Reborn.vehList()
	for k,v in pairs(vehList) do
		if v.hash == GetEntityModel(vname) then
			return v.price
		end
	end
end

function vRP.vehicleType(vname)
	if GetResourceState("will_garages_v2") == "started" then
		return exports['will_garages_v2']:getVehicleType(vname)
	end
	local vehList = Reborn.vehList()
	for k,v in pairs(vehList) do
		if v.hash == GetEntityModel(vname) then
			return v.tipo
		end
	end
end

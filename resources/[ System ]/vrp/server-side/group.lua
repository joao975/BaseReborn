local permissions = {}

local groups = Reborn.groups()
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.getGroupTitle(group)
	local g = groups[group]
	if g and g._config and g._config.title then
		return g._config.title
	end
	return group
end

function vRP.getUserGroups(user_id)
    local data = vRP.query("vRP/get_perm", { user_id = user_id })
    local groups = {}
    if data then
        for k,v in pairs(data) do
            groups[v.permiss] = true
        end
    end
    return groups
end

function vRP.getUserGroupByType(user_id,gtype)
    local user_groups = vRP.getUserGroups(user_id)
    for k,v in pairs(user_groups) do
        local kgroup = groups[k]
        if kgroup then
            if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
                return k
            end
        end
    end
    return nil
end

function vRP.getSalaryByGroup(group)
	local g = groups[group]
	if g and g._config and g._config.salary then
		return g._config.salary
	end
	return nil
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.insertPermission(user_id,perm)
	local source = vRP.getUserSource(user_id)
	if not permissions[user_id] then permissions[user_id] = {} end
	table.insert(permissions[user_id], { permiss = perm } )
	if vRP.hasPermission(user_id, "policia.permissao") then
		TriggerClientEvent("target:setState",source,"Police",true)
		TriggerEvent("vrp_blipsystem:serviceEnter",source,"Policial",77)
	elseif vRP.hasPermission(user_id, "paramedico.permissao") then
		TriggerClientEvent("target:setState",source,"Paramedic",true)
		TriggerEvent("vrp_blipsystem:serviceEnter",source,"Paramedico",83)
	elseif vRP.hasPermission(user_id, "mecanico.permissao") then
		TriggerClientEvent("target:setState",source,"Mechanic",true)
		TriggerEvent("vrp_blipsystem:serviceEnter",source,"Mecanico",51)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NUMPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.removePermission(user_id,perm)
	local source = vRP.getUserSource(user_id)
	if permissions[user_id] then
		for k,v in pairs(permissions[user_id]) do
			if perm == v.permiss then
				table.remove(permissions[user_id], k)
				TriggerClientEvent("target:setState",source,perm,nil)
				return
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function vRP.hasPermission(user_id,perm)
	if permissions[user_id] then
		for k,v in pairs(permissions[user_id]) do
			if v.permiss == perm then
				return true
			else
				local group = groups[v.permiss]
				if group then
					for l,w in pairs(group) do
						if l ~= "_config" and w == perm then
							return true
						end
					end
				end
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if permissions[user_id] then
		permissions[user_id] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
	local consult = vRP.query("vRP/get_perm", { user_id = user_id })
	for k,v in pairs(consult) do
		vRP.insertPermission(user_id, v.permiss)
		if vRP.hasPermission(user_id,"policia.permissao") then
			TriggerEvent("vrp_blipsystem:serviceEnter",source,"Policial",77)
			TriggerClientEvent("target:setState",source,"Police", true)
		elseif vRP.hasPermission(user_id,"paramedico.permissao") then
			TriggerEvent("vrp_blipsystem:serviceEnter",source,"Paramedico",83)
			TriggerClientEvent("target:setState",source,"Paramedic", true)
		elseif vRP.hasPermission(user_id,"mecanico.permissao") then
			TriggerEvent("vrp_blipsystem:serviceEnter",source,"Mecanico",51)
			TriggerClientEvent("target:setState",source,"Mechanic", true)
		end
	end
end)

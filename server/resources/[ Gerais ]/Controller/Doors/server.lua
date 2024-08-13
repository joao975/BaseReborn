-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
doorTunnel = {}
Tunnel.bindInterface("doors",doorTunnel)
vCLIENTdoors = Tunnel.getInterface("doors")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("setdoor",function(source)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			local infos = vCLIENTdoors.getDoorInfos(source)
			if infos and infos.hash ~= 0 then
				local perm = vRP.prompt(source,"Permissao:","")
				table.insert(doors,{
					['x'] = infos.x,
					['y'] = infos.y,
					['z'] = infos.z,
					['hash'] = infos.hash,
					['lock'] = true,
					['text'] = true,
					['distance'] = 10,
					['press'] = 1.5,
					['perm'] = perm,
					['sound'] = true
				})
				TriggerClientEvent("doors:doorsUpdate",-1,doors)
				local doorsFormat = "	[%s] = { ['x'] = %s, ['y'] = %s, ['z'] = %s, ['hash'] = %s, ['lock'] = true, ['text'] = true, ['distance'] = 10, ['press'] = 1.5, ['perm'] = %q, ['sound'] = true },"
				doorsFormat = doorsFormat:format(#doors + 1,infos.x, infos.y, infos.z, infos.hash, perm)
				local doorsFile = {LoadResourceFile(GetCurrentResourceName(), "Doors/config.lua")}
				if doorsFile and doorsFile[1] then
					doorsFile[1] = doorsFile[1]:gsub('}$', '')
					local fileSize = #doorsFile
					fileSize = fileSize + 1
					doorsFile[fileSize] = doorsFormat:gsub('[%s]-[%w]+ = "?nil"?,?', '')
					doorsFile[fileSize + 1] = '\n}'
					SaveResourceFile(GetCurrentResourceName(), "Doors/config.lua", table.concat(doorsFile), -1)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
function doorTunnel.doorsStatistics(doorNumber,doorStatus)
	local source = source

	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)

	if doors[parseInt(doorNumber)].sound then
		TriggerClientEvent("vrp_sound:source",source,"outhouse",0.1)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSSTATISTICS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("doors:doorsStatistics")
AddEventHandler("doors:doorsStatistics",function(doorNumber,doorStatus)
	doors[parseInt(doorNumber)].lock = doorStatus

	if doors[parseInt(doorNumber)].other ~= nil then
		local doorSecond = doors[parseInt(doorNumber)].other
		doors[doorSecond].lock = doorStatus
	end

	TriggerClientEvent("doors:doorsUpdate",-1,doors)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSPERMISSION
-----------------------------------------------------------------------------------------------------------------------------------------
function doorTunnel.doorsPermission(doorNumber)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if doors[parseInt(doorNumber)].perm ~= nil then
			if vRP.hasPermission(user_id,doors[parseInt(doorNumber)].perm) then
				return true
			elseif vRP.hasPermission(user_id,"admin.permissao") then
				local doorStatus = doors[parseInt(doorNumber)].lock and "Deseja abrir?" or "Deseja fechar?"
				return vRP.request(source,"[ADM] Essa porta pertence a "..doors[parseInt(doorNumber)].perm..". "..doorStatus,30)
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
	TriggerClientEvent("doors:doorsUpdate",source,doors)
end)

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	TriggerClientEvent("doors:doorsUpdate",-1,doors)
end)

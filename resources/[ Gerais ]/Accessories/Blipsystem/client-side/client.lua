-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
bsVRP = {}
Tunnel.bindInterface("vrp_blipsystem",bsVRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local userList = {}
local userBlips = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_BLIPSYSTEM:UPDATEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_blipsystem:updateBlips")
AddEventHandler("vrp_blipsystem:updateBlips",function(status)
	userList = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_BLIPSYSTEM:CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_blipsystem:cleanBlips")
AddEventHandler("vrp_blipsystem:cleanBlips",function()
	for k,v in pairs(userBlips) do
		RemoveBlip(userBlips[k])
	end

	userList = {}
	userBlips = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP_BLIPSYSTEM:CLEANBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_blipsystem:removeBlips")
AddEventHandler("vrp_blipsystem:removeBlips",function(source)
	if DoesBlipExist(userBlips[source]) then
		RemoveBlip(userBlips[source])
		userBlips[source] = nil
		userList[source] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREAD:UPDATEBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		for k,v in pairs(userList) do
			if DoesBlipExist(userBlips[k]) then
				SetBlipCoords(userBlips[k],v[1],v[2],v[3])
			else
				userBlips[k] = AddBlipForCoord(v[1],v[2],v[3])
				SetBlipSprite(userBlips[k],1)
				SetBlipScale(userBlips[k],0.5)
				SetBlipColour(userBlips[k],v[5])
				SetBlipAsShortRange(userBlips[k],false)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(v[4])
				EndTextCommandSetBlipName(userBlips[k])
			end
		end

		Citizen.Wait(1000)
	end
end)


local locaisFogos = { 
    [1] = {['x'] = 385.54, ['y'] = 446.56, ['z'] = 143.11, ['x2'] = 422.92, ['y2'] = 457.76, ['z2'] = 160.93},
    [2] = {['x'] = 385.54, ['y'] = 446.56, ['z'] = 143.11, ['x2'] = 440.65, ['y2'] = 459.74, ['z2'] = 163.47},
    [3] = {['x'] = 385.54, ['y'] = 446.56, ['z'] = 143.11, ['x2'] = 395.21, ['y2'] = 453.51, ['z2'] = 161.31}
}

RegisterNetEvent("fogosArtificio")
AddEventHandler("fogosArtificio",function()
    TriggerEvent("Notify","sucesso","Fogos iniciados com sucesso!")
    qntd = 0
    repeat
        qntd = qntd + 1

        RequestModel("mp_s_m_armoured_01")
        while not HasModelLoaded("mp_s_m_armoured_01") do
            Citizen.Wait(0)
            RequestModel("mp_s_m_armoured_01")
        end

        local ped = CreatePed("PED_TYPE_SWAT", GetHashKey("mp_s_m_armoured_01"), locaisFogos[qntd]['x'], locaisFogos[qntd]['y'], locaisFogos[qntd]['z'], true, true)

        FreezeEntityPosition(ped,true)
        SetEntityInvincible(ped,false)
        SetEntityVisible(ped,false,false)
        GiveWeaponToPed(ped, GetHashKey("WEAPON_FIREWORK"), 20, false, true)
        SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREWORK") )
        TaskShootAtCoord(ped, locaisFogos[qntd]['x2'], locaisFogos[qntd]['y2'], locaisFogos[qntd]['z2'], 5*1000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
        
        AddRelationshipGroup("aliados")
        SetPedRelationshipGroupHash(ped, GetHashKey("aliados"))

        Citizen.Wait(0)
    until(qntd == 3)
end)
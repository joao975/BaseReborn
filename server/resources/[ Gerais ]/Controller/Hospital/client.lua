-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
hpSERVER = {}
Tunnel.bindInterface("Hospital",hpSERVER)
hpSERVER = Tunnel.getInterface("Hospital")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local damaged = {}
local bleeding = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if GetEntityHealth(ped) > 110 and not IsPedInAnyVehicle(ped) then
			if not damaged.vehicle and HasEntityBeenDamagedByAnyVehicle(ped) then
				ClearEntityLastDamageEntity(ped)
				damaged.vehicle = true
				bleeding = bleeding + 2
			end
			
			if HasEntityBeenDamagedByWeapon(ped,0,2) then
				ClearEntityLastDamageEntity(ped)
				damaged.bullet = true
				bleeding = bleeding + 1
			end

			if not damaged.taser and IsPedBeingStunned(ped) then
				ClearEntityLastDamageEntity(ped)
				damaged.taser = true
			end
		end

		local hit,bone = GetPedLastDamageBone(ped)
		if hit and not damaged[bone] and bone ~= 0 then
			damaged[bone] = true
		end

		Wait(1500)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PRESSEDBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if GetEntityHealth(ped) > 101 then
			if bleeding == 4 then
				SetEntityHealth(ped,GetEntityHealth(ped)-2)
			elseif bleeding == 5 then
				SetEntityHealth(ped,GetEntityHealth(ped)-3)
			elseif bleeding == 6 then
				SetEntityHealth(ped,GetEntityHealth(ped)-4)
			elseif bleeding >= 7 then
				SetEntityHealth(ped,GetEntityHealth(ped)-5)
			end

			if bleeding >= 4 then
				TriggerEvent("Notify","negado","Você está sangrando.",3000)
			end
		end

		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetDiagnostic")
AddEventHandler("resetDiagnostic",function()
	local ped = PlayerPedId()
	ClearPedBloodDamage(ped)

	damaged = {}
	bleeding = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetBleeding")
AddEventHandler("resetBleeding",function()
	bleeding = 0
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWINJURIES
-----------------------------------------------------------------------------------------------------------------------------------------
local function draw3dtext(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/300
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end

local exit = true

RegisterNetEvent("drawInjuries")
AddEventHandler("drawInjuries",function(ped,injuries)
	CreateThread(function()
		local counter = 0
		exit = not exit

		while true do
			if counter > 4000 or exit then
				exit = true
				break
			end

			for k,v in pairs(injuries) do
				local x,y,z = table.unpack(GetPedBoneCoords(GetPlayerPed(GetPlayerFromServerId(ped)),k))
				draw3dtext(x,y,z,"~w~"..string.upper(v))
			end

			counter = counter + 1
			Wait(0)
		end
	end)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
function hpSERVER.getDiagnostic()
	return damaged,bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETBLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
function hpSERVER.getBleeding()
	return bleeding
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
local checkIn = {
	{ -435.81,-325.86,34.92,"Santos" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDSIN
-----------------------------------------------------------------------------------------------------------------------------------------
local bedsIn = {
	["Santos"] = {
		{ -454.8,-286.38,35.84 },
		{ -451.61,-285.1,35.84 },
		{ -448.19,-283.54,35.84},
		{ -460.15,-288.6,35.84 },
		{ -464.06,-289.63,35.84 },
		{ -467.13,-291.12,35.84 },
		--[[ { 319.42,-581.03,44.21 },
		{ 313.93,-579.04,44.21 },
		{ 309.36,-577.37,44.21 } ]]
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 1000
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for _,v in pairs(checkIn) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 3 then
					timeDistance = 4
					DrawText3Ds(v[1],v[2],v[3],"~g~E~w~   ATENDIMENTO")
					if distance <= 1.5 and IsControlJustPressed(1,38) and hpSERVER.checkServices() then
						if GetEntityHealth(ped) < 400 then
							local checkBusy = 0
							local checkSelected = v[4]
							for _,v in pairs(bedsIn[checkSelected]) do
								checkBusy = checkBusy + 1
								local checkPos = nearestPlayer(v[1],v[2],v[3])
								if checkPos == nil then
									if hpSERVER.paymentCheckin() then
										SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)

										if GetEntityHealth(ped) <= 101 then
											TriggerEvent("vrp_survival:CheckIn")
										end

										DoScreenFadeOut(1000)
										Wait(1000)

										SetEntityCoords(ped,v[1],v[2],v[3])

										Wait(500)
										TriggerEvent("emotes","checkin")

										Wait(5000)
										DoScreenFadeIn(1000)
									end
									break
								end
							end

							if checkBusy >= #bedsIn[checkSelected] then
								TriggerEvent("Notify","importante","Todas as macas estão ocupadas, aguarde.",5000)
							end
						else
							TriggerEvent("Notify","negado","Você está bem de saude.",5000)
						end
					end
				end
			end
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MACAS DO HOSPITAL
-----------------------------------------------------------------------------------------------------------------------------------------
local macas = {
	{ ['x'] = 321.76, ['y'] = -586.79, ['z'] = 43.29, ['x2'] = 322.69, ['y2'] = -587.0, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 314.7, ['y'] = -579.51, ['z'] = 43.29, ['x2'] = 313.7, ['y2'] = -579.24, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 310.35, ['y'] = -577.82, ['z'] = 43.29, ['x2'] = 309.51, ['y2'] = -577.47, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = -577.47, ['y'] = -581.57, ['z'] = 43.29, ['x2'] = 307.78, ['y2'] = -581.56, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 312.08, ['y'] = -583.11, ['z'] = 43.29, ['x2'] = 311.27, ['y2'] = -583.01, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 315.42, ['y'] = -584.65, ['z'] = 43.29, ['x2'] = 314.61, ['y2'] = -583.85, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 318.62, ['y'] = -585.7, ['z'] = 43.29, ['x2'] = 317.79, ['y2'] = -584.9, ['z2'] = 44.21, ['h'] = 160.8 },
	{ ['x'] = 308.68, ['y'] = -582.1, ['z'] = 43.29, ['x2'] = 307.62, ['y2'] = -581.66, ['z2'] = 44.21, ['h'] = 160.8 },
}

CreateThread(function()
	for k,v in pairs(macas) do
		local cod = macas[k]
		exports["target"]:AddCircleZone("treatment:"..k,vector3(cod.x,cod.y,cod.z),1.0,{
			name = "treatment:"..k,
			heading = 3374176
		},{
			shop = "Sandy",
			distance = 1.5,
			options = {
				{
					event = "emotes",
					label = "Tratamento",
					tunnel = "shop"
				}
			}
		})
	end
end)

local emMaca = false
CreateThread(function()
	while true do
		local idle = 1000
		for k,v in pairs(macas) do
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local bowz,cdz = GetGroundZFor_3dCoord(v.x,v.y,v.z)
			local distance = GetDistanceBetweenCoords(v.x,v.y,cdz,x,y,z,true)
			local cod = macas[k]

			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),cod.x,cod.y,cod.z,true) < 1.5 then
				idle = 5
				--DrawText3D(cod.x,cod.y,cod.z,"~g~E ~w~ DEITAR")
			end

			if distance < 1.5 then
				idle = 4
				if IsControlJustPressed(0,38) then
					SetEntityCoords(ped,v.x2,v.y2,v.z2)
					SetEntityHeading(ped,v.h)
					vRP._playAnim(false,{"amb@world_human_sunbathe@female@back@idle_a","idle_a"},true)
					emMaca = true
				end

			end

			if IsControlJustPressed(0,167) and emMaca then
				ClearPedTasks(GetPlayerPed(-1))
				emMaca = false
			end
		end

		Wait(idle)
	end
end)

RegisterNetEvent('tratamento-macas')
AddEventHandler('tratamento-macas',function()
	TriggerEvent("cancelando",true)
	repeat
		SetEntityHealth(PlayerPedId(),GetEntityHealth(PlayerPedId())+3)
		Wait(1500)
	until GetEntityHealth(PlayerPedId()) >= 399 or GetEntityHealth(PlayerPedId()) <= 101
	TriggerEvent("Notify","importante","Tratamento concluido.")
	TriggerEvent("cancelando",false)
	TriggerEvent("vrp_survival:desbugar")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
--[ TRATAMENTO ]-------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
local tratamento = false
RegisterNetEvent("tratamento")
AddEventHandler("tratamento",function()
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)

    SetEntityHealth(ped,health)
	if emMaca then
		if tratamento then
			return
		end

		tratamento = true
		TriggerEvent("Notify","sucesso","Tratamento iniciado, aguarde a liberação do <b>profissional médico.</b>.",8000)

		if tratamento then
			repeat
				Wait(600)
				if GetEntityHealth(ped) > 101 then
					SetEntityHealth(ped,GetEntityHealth(ped)+3)
				end
			until GetEntityHealth(ped) >= 399 or GetEntityHealth(ped) <= 101
				TriggerEvent("Notify","sucesso","Tratamento concluido.",8000)
				tratamento = false
				TriggerEvent("vrp_survival:desbugar")
		end
	else
		TriggerEvent("Notify","negado","Você precisa estar deitado em uma maca para ser tratado.",8000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/350
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayers(x2,y2,z2)
	local r = {}
	local players = vRP.activePlayers()
	for k,v in pairs(players) do
		local player = GetPlayerFromServerId(v)
		if player ~= PlayerId() and NetworkIsPlayerConnected(player) then
			local oped = GetPlayerPed(player)
			local coords = GetEntityCoords(oped)
			local distance = #(coords - vector3(x2,y2,z2))
			if distance <= 2 then
				r[GetPlayerServerId(player)] = distance
			end
		end
	end
	return r
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEARESTPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function nearestPlayer(x,y,z)
	local p = nil
	local players = nearestPlayers(x,y,z)
	local min = 2.0001
	for k,v in pairs(players) do
		if v < min then
			min = v
			p = k
		end
	end
	return p
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
---------------------------------------------------------------------
local count_bcast_timer = 0
local delay_bcast_timer = 200
---------------------------------------------------------------------
local count_sndclean_timer = 0
local delay_sndclean_timer = 400
---------------------------------------------------------------------
local actv_ind_timer = false
local count_ind_timer = 0
local delay_ind_timer = 180
---------------------------------------------------------------------
local actv_lxsrnmute_temp = false
local srntone_temp = 0
local dsrn_mute = true
---------------------------------------------------------------------
local state_indic = {}
local state_lxsiren = {}
local state_airmanu = {}
---------------------------------------------------------------------
local ind_state_o = 0
local ind_state_l = 1
local ind_state_r = 2
local ind_state_h = 3
---------------------------------------------------------------------
local snd_lxsiren = {}
local snd_airmanu = {}
---------------------------------------------------------------------
local eModelsWithFireSrn = {
	"FIRETRUK"
}
---------------------------------------------------------------------
local eModelsWithPcall = {
	"AMBULANCE",
	"FIRETRUK",
	"LGUARD"
}
---------------------------------------------------------------------
function useFiretruckSiren(veh)
	local model = GetEntityModel(veh)
	for i = 1,#eModelsWithFireSrn,1 do
		if model == GetHashKey(eModelsWithFireSrn[i]) then
			return true
		end
	end
	return false
end
---------------------------------------------------------------------
function usePowercallAuxSrn(veh)
	local model = GetEntityModel(veh)
	for i = 1, #eModelsWithPcall, 1 do
		if model == GetHashKey(eModelsWithPcall[i]) then
			return true
		end
	end
	return false
end
---------------------------------------------------------------------
function CleanupSounds()
	if count_sndclean_timer > delay_sndclean_timer then
		count_sndclean_timer = 0

		for k, v in pairs(state_lxsiren) do
			if v > 0 then
				if not DoesEntityExist(k) or IsEntityDead(k) then
					if snd_lxsiren[k] ~= nil then
						StopSound(snd_lxsiren[k])
						ReleaseSoundId(snd_lxsiren[k])
						snd_lxsiren[k] = nil
						state_lxsiren[k] = nil
					end
				end
			end
		end

		for k, v in pairs(state_airmanu) do
			if v then
				if not DoesEntityExist(k) or IsEntityDead(k) or IsVehicleSeatFree(k,-1) then
					if snd_airmanu[k] ~= nil then
						StopSound(snd_airmanu[k])
						ReleaseSoundId(snd_airmanu[k])
						snd_airmanu[k] = nil
						state_airmanu[k] = nil
					end
				end
			end
		end
	else
		count_sndclean_timer = count_sndclean_timer + 1
	end
end
---------------------------------------------------------------------
function TogIndicStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate == ind_state_o then
			SetVehicleIndicatorLights(veh,0,false)
			SetVehicleIndicatorLights(veh,1,false)
		elseif newstate == ind_state_l then
			SetVehicleIndicatorLights(veh,0,false)
			SetVehicleIndicatorLights(veh,1,true)
		elseif newstate == ind_state_r then
			SetVehicleIndicatorLights(veh,0,true)
			SetVehicleIndicatorLights(veh,1,false)
		elseif newstate == ind_state_h then
			SetVehicleIndicatorLights(veh,0,true)
			SetVehicleIndicatorLights(veh,1,true)
		end
		state_indic[veh] = newstate
	end
end
---------------------------------------------------------------------
function TogMuteDfltSrnForVeh(veh,toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		DisableVehicleImpactExplosionActivation(veh,toggle)
	end
end
---------------------------------------------------------------------
function SetLxSirenStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_lxsiren[veh] then
			if snd_lxsiren[veh] ~= nil then
				StopSound(snd_lxsiren[veh])
				ReleaseSoundId(snd_lxsiren[veh])
				snd_lxsiren[veh] = nil
			end

			if newstate == 1 then
				if useFiretruckSiren(veh) then
					TogMuteDfltSrnForVeh(veh,false)
				else
					snd_lxsiren[veh] = GetSoundId()	
					PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_SIREN_1",veh,0,0,0)
					TogMuteDfltSrnForVeh(veh,true)
				end
			elseif newstate == 2 then
				snd_lxsiren[veh] = GetSoundId()
				PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_SIREN_2",veh,0,0,0)
				TogMuteDfltSrnForVeh(veh,true)
			elseif newstate == 3 then
				snd_lxsiren[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_AMBULANCE_WARNING",veh,0,0,0)
				else
					PlaySoundFromEntity(snd_lxsiren[veh],"VEHICLES_HORNS_POLICE_WARNING",veh,0,0,0)
				end
				TogMuteDfltSrnForVeh(veh,true)
			else
				TogMuteDfltSrnForVeh(veh,true)
			end
			state_lxsiren[veh] = newstate
		end
	end
end
---------------------------------------------------------------------
function SetAirManuStateForVeh(veh,newstate)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if newstate ~= state_airmanu[veh] then
			if snd_airmanu[veh] ~= nil then
				StopSound(snd_airmanu[veh])
				ReleaseSoundId(snd_airmanu[veh])
				snd_airmanu[veh] = nil
			end

			if newstate == 1 then
				snd_airmanu[veh] = GetSoundId()
				if useFiretruckSiren(veh) then
					PlaySoundFromEntity(snd_airmanu[veh],"VEHICLES_HORNS_FIRETRUCK_WARNING",veh,0,0,0)
				else
					PlaySoundFromEntity(snd_airmanu[veh],"SIRENS_AIRHORN",veh,0,0,0)
				end
			elseif newstate == 2 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"VEHICLES_HORNS_SIREN_1",veh,0,0,0)
			elseif newstate == 3 then
				snd_airmanu[veh] = GetSoundId()
				PlaySoundFromEntity(snd_airmanu[veh],"VEHICLES_HORNS_SIREN_2",veh,0,0,0)
			end
			state_airmanu[veh] = newstate
		end
	end
end
---------------------------------------------------------------------
RegisterNetEvent("lvc_TogIndicState_c")
AddEventHandler("lvc_TogIndicState_c",function(sender,newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s,false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogIndicStateForVeh(veh,newstate)
			end
		end
	end
end)
---------------------------------------------------------------------
RegisterNetEvent("lvc_TogDfltSrnMuted_c")
AddEventHandler("lvc_TogDfltSrnMuted_c",function(sender,toggle)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s,false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogMuteDfltSrnForVeh(veh,toggle)
			end
		end
	end
end)
---------------------------------------------------------------------
RegisterNetEvent("lvc_SetLxSirenState_c")
AddEventHandler("lvc_SetLxSirenState_c",function(sender,newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s,false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetLxSirenStateForVeh(veh,newstate)
			end
		end
	end
end)
---------------------------------------------------------------------
RegisterNetEvent("lvc_SetAirManuState_c")
AddEventHandler("lvc_SetAirManuState_c",function(sender,newstate)
	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		if ped_s ~= PlayerPedId() then
			if IsPedInAnyVehicle(ped_s,false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				SetAirManuStateForVeh(veh,newstate)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHMENU
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("enterVehmenus",function(source,args,rawCommand)
	local ped = PlayerPedId()
	if not IsEntityInWater(ped) and GetEntityHealth(ped) > 101 then
		local vehicle = vRP.vehList(7)
		if vehicle then
			SendNUIMessage({ show = true })
			SetCursorLocation(0.5,0.8)
			SetNuiFocus(true,true)
		end
	end
end)

RegisterNetEvent("enterVehmenus")
AddEventHandler("enterVehmenus",function()
	local ped = PlayerPedId()
	if not IsEntityInWater(ped) and GetEntityHealth(ped) > 101 then
		local vehicle = vRP.vehList(7)
		if vehicle then
			SendNUIMessage({ show = true })
			SetCursorLocation(0.5,0.8)
			SetNuiFocus(true,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHCONTROL
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterKeyMapping("enterVehmenus","Interação veícular.","keyboard","F4")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSESYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeSystem",function()
	SendNUIMessage({ show = false })
	SetCursorLocation(0.5,0.5)
	SetNuiFocus(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MENUACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("menuActive",function(data)
	local ped = PlayerPedId()
	if GetVehiclePedIsTryingToEnter(ped) <= 0 then
		if data["active"] == "chest" then
			TriggerServerEvent("trunkchest:openTrunk")

			SendNUIMessage({ show = false })
			SetCursorLocation(0.5,0.5)
			SetNuiFocus(false,false)
		elseif data["active"] == "door1" then
			TriggerServerEvent("vehcontrol:Doors","1")
		elseif data["active"] == "door2" then
			TriggerServerEvent("vehcontrol:Doors","2")
		elseif data["active"] == "door3" then
			TriggerServerEvent("vehcontrol:Doors","3")
		elseif data["active"] == "door4" then
			TriggerServerEvent("vehcontrol:Doors","4")
		elseif data["active"] == "trunk" then
			TriggerServerEvent("vehcontrol:Doors","5")
		elseif data["active"] == "hood" then
			TriggerServerEvent("vehcontrol:Doors","6")
		elseif data["active"] == "vtuning" then
			TriggerEvent("engine:vehTuning")

			SendNUIMessage({ show = false })
			SetCursorLocation(0.5,0.5)
			SetNuiFocus(false,false)
		end
	end
end)

RegisterNetEvent("engine:vehTuning")
AddEventHandler("engine:vehTuning",function()
	local vehicle = vRP.getNearVehicle(5)
	if vehicle then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Desativado"
		elseif motor == 0 then
			motor = "Nível 1 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 1 then
			motor = "Nível 2 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 2 then
			motor = "Nível 3 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 3 then
			motor = "Nível 4 / "..GetNumVehicleMods(vehicle,11)
		elseif motor == 4 then
			motor = "Nível 5 / "..GetNumVehicleMods(vehicle,11)
		end

		if freio == -1 then
			freio = "Desativado"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Desativado"
		elseif transmissao == 0 then
			transmissao = "Nível 1 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 1 then
			transmissao = "Nível 2 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 2 then
			transmissao = "Nível 3 / "..GetNumVehicleMods(vehicle,13)
		elseif transmissao == 3 then
			transmissao = "Nível 4 / "..GetNumVehicleMods(vehicle,13)
		end

		if suspensao == -1 then
			suspensao = "Desativado"
		elseif suspensao == 0 then
			suspensao = "Nível 1 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 1 then
			suspensao = "Nível 2 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 2 then
			suspensao = "Nível 3 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 3 then
			suspensao = "Nível 4 / "..GetNumVehicleMods(vehicle,15)
		elseif suspensao == 4 then
			suspensao = "Nível 5 / "..GetNumVehicleMods(vehicle,15)
		end

		if blindagem == -1 then
			blindagem = "Desativado"
		elseif blindagem == 0 then
			blindagem = "Nível 1 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 1 then
			blindagem = "Nível 2 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 2 then
			blindagem = "Nível 3 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 3 then
			blindagem = "Nível 4 / "..GetNumVehicleMods(vehicle,16)
		elseif blindagem == 4 then
			blindagem = "Nível 5 / "..GetNumVehicleMods(vehicle,16)
		end

		TriggerEvent("Notify","importante","<b>Motor:</b> "..motor.."<br><b>Freio:</b> "..freio.."<br><b>Transmissão:</b> "..transmissao.."<br><b>Suspensão:</b> "..suspensao.."<br><b>Blindagem:</b> "..blindagem.."<br><b>Lataria:</b> "..parseInt(body/10).."%<br><b>Motor:</b> "..parseInt(engine/10).."%<br><b>Gasolina:</b> "..parseInt(fuel).."%",10000)
	end
end)
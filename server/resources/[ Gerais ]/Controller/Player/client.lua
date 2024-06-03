-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
plVRP = {}
Tunnel.bindInterface("Player",plVRP)
plSERVER = Tunnel.getInterface("Player")
local gsrTime = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- RECEIVESALARY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(30*60000)
		TriggerServerEvent("vrp_player:salary")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIVING
-----------------------------------------------------------------------------------------------------------------------------------------
function plVRP.setDiving()
	local ped = PlayerPedId()
	if IsPedSwimming(ped) then
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,8,123,0,2)
			SetPedPropIndex(ped,1,26,0,2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,8,153,0,2)
			SetPedPropIndex(ped,1,28,0,2)
		end
	end
end

function plVRP.playerDriving()
	local ped = PlayerPedId()
	if GetPedInVehicleSeat(GetVehiclePedIsUsing(ped),-1) == ped or GetVehiclePedIsTryingToEnter(ped) > 0 then
		return true
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATSHUFFLE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) and not IsPedOnAnyBike(ped) then
			local veh = GetVehiclePedIsUsing(ped)
			if GetPedInVehicleSeat(veh,0) == ped then
				timeDistance = 4
				if not GetIsTaskActive(ped,164) and GetIsTaskActive(ped,165) then
					SetPedIntoVehicle(ped,veh,0)
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Trunkin
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_player:trunkin")
AddEventHandler("vrp_player:trunkin",function()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if not GetPedInVehicleSeat(veh,-1) == ped then
		if vRP.getHealth() > 101 and not IsPedInAnyVehicle(ped) then
			TriggerEvent("vrp_player:EnterTrunk")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
local energetic = 0
RegisterNetEvent("setEnergetic")
AddEventHandler("setEnergetic",function(timers,number)
	energetic = timers
	SetRunSprintMultiplierForPlayer(PlayerId(),number)
end)

Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		if energetic > 0 then
			timeDistance = 4
			RestorePlayerStamina(PlayerId(),1.0)
		end
		Citizen.Wait(timeDistance)
	end
end)

Citizen.CreateThread(function()
	while true do
		if energetic > 0 then
			energetic = energetic - 1

			if energetic <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				energetic = 0
				SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETECSTASY
-----------------------------------------------------------------------------------------------------------------------------------------
local ecstasy = 0
RegisterNetEvent("setEcstasy")
AddEventHandler("setEcstasy",function()
	ecstasy = ecstasy + 15
	if not GetScreenEffectIsActive("MinigameTransitionIn") then
		StartScreenEffect("MinigameTransitionIn",0,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETMETH
-----------------------------------------------------------------------------------------------------------------------------------------
local meth = 0
RegisterNetEvent("setMeth")
AddEventHandler("setMeth",function()
	meth = meth + 60
	if not GetScreenEffectIsActive("DMT_flight") then
		StartScreenEffect("DMT_flight",0,true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETDRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local drunkTime = 0
RegisterNetEvent("setDrunkTime")
AddEventHandler("setDrunkTime",function(timers)
	drunkTime = timers
	TriggerEvent("vrp:blockDrunk",true)
	RequestAnimSet("move_m@drunk@verydrunk")
	while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
		Citizen.Wait(10)
	end
	SetPedMovementClipset(PlayerPedId(),"move_m@drunk@verydrunk",0.25)
end)

Citizen.CreateThread(function()
	while true do
		if ecstasy > 0 then
			ecstasy = ecstasy - 1
			ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.05)
			if ecstasy <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ecstasy = 0
				if GetScreenEffectIsActive("MinigameTransitionIn") then
					StopScreenEffect("MinigameTransitionIn")
				end
			end
		end
		if meth > 0 then
			meth = meth - 1
			if meth <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				meth = 0
				if GetScreenEffectIsActive("DMT_flight") then
					StopScreenEffect("DMT_flight")
				end
			end
		end
		if drunkTime > 0 then
			drunkTime = drunkTime - 1
			if drunkTime <= 0 or GetEntityHealth(PlayerPedId()) <= 101 then
				ResetPedMovementClipset(PlayerPedId(),0.25)
				TriggerEvent("vrp:blockDrunk",false)
			end
		end
		if gsrTime > 0 then
			gsrTime = gsrTime - 1
		end
		Citizen.Wait(3000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEANEFFECTDRUGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("cleanEffectDrugs")
AddEventHandler("cleanEffectDrugs",function()
	if GetScreenEffectIsActive("MinigameTransitionIn") then
		StopScreenEffect("MinigameTransitionIn")
	end

	if GetScreenEffectIsActive("DMT_flight") then
		StopScreenEffect("DMT_flight")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCHOOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_player:syncHood")
AddEventHandler("vrp_player:syncHood",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			if GetVehicleDoorAngleRatio(v,4) == 0 then
				SetVehicleDoorOpen(v,4,0,1)
			else
				SetVehicleDoorShut(v,4,1)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCWINS
-----------------------------------------------------------------------------------------------------------------------------------------
local vidros = false

RegisterNetEvent("vrp_player:syncWins")
AddEventHandler("vrp_player:syncWins",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if vidros then
				vidros = false
				RollUpWindow(v,0)
				RollUpWindow(v,1)
				RollUpWindow(v,2)
				RollUpWindow(v,3)
			else
				vidros = true
				RollDownWindow(v,0)
				RollDownWindow(v,1)
				RollDownWindow(v,2)
				RollDownWindow(v,3)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCDOORS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_player:syncDoors")
AddEventHandler("vrp_player:syncDoors",function(index,door)
	--if NetworkDoesNetworkIdExist(index) then
		local v = index -- NetToEnt(index)
		if DoesEntityExist(v) then
			if door == "1" then
				if GetVehicleDoorAngleRatio(v,0) == 0 then
					SetVehicleDoorOpen(v,0,0,0)
				else
					SetVehicleDoorShut(v,0,0)
				end
			elseif door == "2" then
				if GetVehicleDoorAngleRatio(v,1) == 0 then
					SetVehicleDoorOpen(v,1,0,0)
				else
					SetVehicleDoorShut(v,1,0)
				end
			elseif door == "3" then
				if GetVehicleDoorAngleRatio(v,2) == 0 then
					SetVehicleDoorOpen(v,2,0,0)
				else
					SetVehicleDoorShut(v,2,0)
				end
			elseif door == "4" then
				if GetVehicleDoorAngleRatio(v,3) == 0 then
					SetVehicleDoorOpen(v,3,0,0)
				else
					SetVehicleDoorShut(v,3,0)
				end
			elseif door == "5" then
				if GetVehicleDoorAngleRatio(v,5) == 0 then
					SetVehicleDoorOpen(v,5,0,1)
				else
					SetVehicleDoorShut(v,5,1)
				end
			elseif door == nil then
				if GetVehicleDoorAngleRatio(v,0) == 0 and GetVehicleDoorAngleRatio(v,1) == 0 then
					SetVehicleDoorOpen(v,0,0,0)
					SetVehicleDoorOpen(v,1,0,0)
					SetVehicleDoorOpen(v,2,0,0)
					SetVehicleDoorOpen(v,3,0,0)
				else
					SetVehicleDoorShut(v,0,0)
					SetVehicleDoorShut(v,1,0)
					SetVehicleDoorShut(v,2,0)
					SetVehicleDoorShut(v,3,0)
				end
			end
		end
	--end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUFF
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindcuff",function(source,args)
	plSERVER.cuffToggle()
end)
RegisterKeyMapping("keybindcuff","Algemar o Cidadao","keyboard","g")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CARRY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("keybindcarry",function(source,args)
	plSERVER.carryToggle()
end)
RegisterKeyMapping("keybindcarry","Carregar o Cidadao","keyboard","h")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VTUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("vtuning",function(source,args)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if IsEntityAVehicle(vehicle) then
		local motor = GetVehicleMod(vehicle,11)
		local freio = GetVehicleMod(vehicle,12)
		local transmissao = GetVehicleMod(vehicle,13)
		local suspensao = GetVehicleMod(vehicle,15)
		local blindagem = GetVehicleMod(vehicle,16)
		local body = GetVehicleBodyHealth(vehicle)
		local engine = GetVehicleEngineHealth(vehicle)
		local fuel = GetVehicleFuelLevel(vehicle)

		if motor == -1 then
			motor = "Disabled"
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
			freio = "Disabled"
		elseif freio == 0 then
			freio = "Nível 1 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 1 then
			freio = "Nível 2 / "..GetNumVehicleMods(vehicle,12)
		elseif freio == 2 then
			freio = "Nível 3 / "..GetNumVehicleMods(vehicle,12)
		end

		if transmissao == -1 then
			transmissao = "Disabled"
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
			suspensao = "Disabled"
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
			blindagem = "Disabled"
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
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_player:SeatPlayer")
AddEventHandler("vrp_player:SeatPlayer",function(index)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if IsEntityAVehicle(vehicle) and IsPedInAnyVehicle(ped) then
		if parseInt(index) <= 1 or index == nil then
			seat = -1
		elseif parseInt(index) == 2 then
			seat = 0
		elseif parseInt(index) == 3 then
			seat = 1
		elseif parseInt(index) == 4 then
			seat = 2
		elseif parseInt(index) == 5 then
			seat = 3
		elseif parseInt(index) == 6 then
			seat = 4
		elseif parseInt(index) == 7 then
			seat = 5
		elseif parseInt(index) >= 8 then
			seat = 6
		end

		if IsVehicleSeatFree(vehicle,seat) then
			SetPedIntoVehicle(ped,vehicle,seat)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WCOMPONENTS
-----------------------------------------------------------------------------------------------------------------------------------------
local wComponents = {
	["WEAPON_PISTOL"] = {
		"COMPONENT_AT_PI_FLSH",
		"COMPONENT_PISTOL_CLIP_02",
		"COMPONENT_AT_PI_SUPP_02"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_PISTOL_MK2"] = {
		"COMPONENT_AT_PI_RAIL",
		"COMPONENT_AT_PI_FLSH_02",
		"COMPONENT_AT_PI_COMP"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_AT_PI_FLSH",
		"COMPONENT_AT_SCOPE_MACRO"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02",
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_SUPP_02"
	},
	["WEAPON_COMBATPDW"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_AR_AFGRIP",
		"COMPONENT_AT_SCOPE_SMALL"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_AT_AR_FLSH"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_MACHINEPISTOL"] = {
		"COMPONENT_AT_PI_SUPP"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_AT_AR_AFGRIP_02",
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_AT_PI_FLSH"
	},
	["WEAPON_SNSPISTOL_MK2"] = {
		"COMPONENT_AT_PI_FLSH_03",
		"COMPONENT_AT_PI_RAIL_02",
		"COMPONENT_AT_PI_COMP_02"
	},
	["WEAPON_SMG_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_SMG_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_BULLPUPRIFLE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_SMALL",
		"COMPONENT_AT_AR_SUPP"
	},
	["WEAPON_BULLPUPRIFLE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MACRO_02_MK2",
		"COMPONENT_AT_MUZZLE_01"
	},
	["WEAPON_SPECIALCARBINE"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM",
		"COMPONENT_AT_AR_AFGRIP"
	},
	["WEAPON_SPECIALCARBINE_MK2"] = {
		"COMPONENT_AT_AR_FLSH",
		"COMPONENT_AT_SCOPE_MEDIUM_MK2",
		"COMPONENT_AT_MUZZLE_01"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("attachs",function(source,args)
	local ped = PlayerPedId()
	if plSERVER.Attaches() then
		for k,v in pairs(wComponents) do
			if GetSelectedPedWeapon(ped) == GetHashKey(k) then
				for k2,v2 in pairs(v) do
					GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local handcuff = false

function plVRP.toggleHandcuff()
	local ped = PlayerPedId()
	if not handcuff then
		handcuff = true
		TriggerEvent("gcPhone:handcuff")
		TriggerEvent("radio:outServers")
		TriggerEvent("status:celular",true)
		if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
			SetPedComponentVariation(ped,7,41,0,2)
		elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
			SetPedComponentVariation(ped,7,25,0,2)
		end
	else
		handcuff = false
		TriggerEvent("status:celular",false)
		SetPedComponentVariation(ped,7,0,0,2)
	end
	LocalPlayer["state"]:set("Handcuff",handcuff,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
local mala = false
function plVRP.toggleMalas()
	mala = not mala
	ped = PlayerPedId()
	vehicle = plVRP.getNearestVehicle(7)

	if IsEntityAVehicle(vehicle) then
		if mala then
			AttachEntityToEntity(ped,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-0.4,-0.1,60.0,-90.0,180.0,false,false,false,true,2,true)
			SetEntityVisible(ped,false)
			SetEntityInvincible(ped,false) --mqcu
		else
			DetachEntity(ped,true,true)
			SetEntityVisible(ped,true)
			SetEntityInvincible(ped,false)
			SetPedToRagdoll(ped,2000,2000,0,0,0,0)
		end
		TriggerServerEvent("trymala",VehToNet(vehicle))
	end
end

RegisterNetEvent("syncmala")
AddEventHandler("syncmala",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToVeh(index)
		if DoesEntityExist(v) then
			if IsEntityAVehicle(v) then
				SetVehicleDoorOpen(v,5,0,0)
				Citizen.Wait(1000)
				SetVehicleDoorShut(v,5,0)
			end
		end
	end
end)

function plVRP.getHandcuff()
	return handcuff
end

function plVRP.getNoCarro()
	return IsPedInAnyVehicle(PlayerPedId())
end

function plVRP.getCarroClass(vehicle)
	return GetVehicleClass(vehicle) == 0 or GetVehicleClass(vehicle) == 1 or GetVehicleClass(vehicle) == 2 or GetVehicleClass(vehicle) == 3 or GetVehicleClass(vehicle) == 4 or GetVehicleClass(vehicle) == 5 or GetVehicleClass(vehicle) == 6 or GetVehicleClass(vehicle) == 7 or GetVehicleClass(vehicle) == 9 or GetVehicleClass(vehicle) == 12
end

function plVRP.setMalas(flag)
	if mala ~= flag then
		plVRP.toggleMalas()
	end
end

function plVRP.isMalas()
	return mala
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("resetHandcuff")
AddEventHandler("resetHandcuff",function()
	local ped = PlayerPedId()
	if handcuff then
		handcuff = false
		vRP.stopAnim(false)
		TriggerEvent("status:celular",false)
		SetPedComponentVariation(ped,7,0,0,2)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOVEMENTCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function plVRP.movementClip(dict)
	RequestAnimSet(dict)
	while not HasAnimSetLoaded(dict) do
		Citizen.Wait(10)
	end
	SetPedMovementClipset(PlayerPedId(),dict,0.25)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if handcuff then
			timeDistance = 4
			DisableControlAction(1,21,true)
			DisableControlAction(1,23,true)
			DisableControlAction(1,24,true)
			DisableControlAction(1,25,true)
			DisableControlAction(1,37,true)
			DisableControlAction(0,37,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,22,true)
			--DisableControlAction(1,73,true)
			DisableControlAction(1,167,true)
			DisableControlAction(1,311,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,182,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,245,true)
			DisableControlAction(1,243,true)
			DisableControlAction(1,105,true)
			DisableControlAction(0,21,true)
			DisableControlAction(0,22,true)
			DisableControlAction(0,24,true)
			DisableControlAction(0,25,true)
			DisableControlAction(0,29,true)
			DisableControlAction(0,32,true)
			DisableControlAction(0,33,true)
			DisableControlAction(0,34,true)
			DisableControlAction(0,35,true)
			DisableControlAction(0,56,true)
			DisableControlAction(0,58,true)
			--DisableControlAction(0,73,true)
			DisableControlAction(0,75,true)
			DisableControlAction(0,140,true)
			DisableControlAction(0,141,true)
			DisableControlAction(0,142,true)
			DisableControlAction(0,143,true)
			DisableControlAction(0,159,true)
			DisableControlAction(0,166,true)
			DisableControlAction(0,167,true)
			DisableControlAction(1,167,true)
			DisableControlAction(2,167,true)
			DisableControlAction(0,170,true)
			DisableControlAction(0,177,true)
			DisableControlAction(0,182,true)
			DisableControlAction(0,187,true)
			DisableControlAction(0,188,true)
			DisableControlAction(0,189,true)
			DisableControlAction(0,190,true)
			DisableControlAction(0,243,true)
			DisableControlAction(0,245,true)
			DisableControlAction(0,246,true)
			DisableControlAction(0,257,true)
			DisableControlAction(0,263,true)
			DisableControlAction(0,264,true)
			DisableControlAction(0,268,true)
			DisableControlAction(0,269,true)
			DisableControlAction(0,270,true)
			DisableControlAction(0,271,true)
			DisableControlAction(0,288,true)
			DisableControlAction(0,289,true)
			DisableControlAction(0,303,true)
			DisableControlAction(0,311,true)
			DisableControlAction(0,344,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADWHILEHANDCUFF
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if handcuff and GetEntityHealth(ped) > 101 then
			vRP.playAnim(true,{"mp_arresting","idle"},true)
		end
		Citizen.Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLACKWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blackWeapons = {
	"WEAPON_RAILGUN",
	"WEAPON_GARBAGEBAG",
	"VINTAGE_PISTOL",
	"WEAPON_MINIGUN",
	"WEAPON_PROXMINE",   
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_KNUCKLEDUSTER",
	"WEAPON_DOUBLEACTION",
	"WEAPON_SMG_MK2",
	"WEAPON_RAYCARBINE",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	"WEAPON_AUTOSHOTGUN",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	"WEAPON_GRENADELAUNCHER",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_GRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_PIPEBOMB",
	"WEAPON_BALL",
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSHOTSFIRED
-----------------------------------------------------------------------------------------------------------------------------------------
local inGame = false
RegisterNetEvent("will_pvp:inGame")
AddEventHandler("will_pvp:inGame",function(status)
	inGame = status
end)

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_UNARMED") and GetSelectedPedWeapon(ped) ~= GetHashKey("WEAPON_PETROLCAN") and not inGame then
			timeDistance = 4
			if IsPedShooting(ped) then
				for k,v in ipairs(blackWeapons) do
					if GetSelectedPedWeapon(ped) == GetHashKey(v) then
						bWeapons = true
					end
				end

				if not bWeapons then
					plSERVER.shotsFired()
					gsrTime = 60
				end

				bWeapons = false
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GSRCHECK
-----------------------------------------------------------------------------------------------------------------------------------------
function plVRP.gsrCheck()
	return gsrTime
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOTDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local shotDistance = {
	{ -186.1,-893.5,29.3,2500 },
	{ 1389.7,3237.2,37.6,1300 },
	{ -137.4,6228.4,31.2,1000 }
}

function plVRP.shotDistance(x,y,z)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(shotDistance) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= v[4] then
			return true
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function plVRP.toggleCarry(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		AttachEntityToEntity(ped,GetPlayerPed(GetPlayerFromServerId(uCarry)),11816,0.6,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end	
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLECARRY2
-----------------------------------------------------------------------------------------------------------------------------------------
local uCarry = nil
local iCarry = false
local sCarry = false
function plVRP.toggleCarry2(source)
	uCarry = source
	iCarry = not iCarry

	local ped = PlayerPedId()
	if iCarry and uCarry then
		Citizen.InvokeNative(0x6B9BBD38AB0796DF,PlayerPedId(),GetPlayerPed(GetPlayerFromServerId(uCarry)),4103,11816,0.5,0.0,0.0,0.0,0.0,0.0,false,false,false,false,2,true)
		sCarry = true
	else
		if sCarry then
			DetachEntity(ped,false,false)
			sCarry = false
		end
	end	
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMOVEVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function plVRP.removeVehicle()
	local ped = PlayerPedId()
	if IsPedSittingInAnyVehicle(ped) then
		iCarry = false
		DetachEntity(GetPlayerPed(GetPlayerFromServerId(uCarry)),false,false)
		TaskLeaveVehicle(ped,GetVehiclePedIsUsing(ped),4160)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
-----------------------------------------------------------------------------------------------------------------------------------------
function plVRP.extraVehicle(data)
	local vehicle = vRP.getNearVehicle(11)
	if data == "1" then
		if DoesExtraExist(vehicle,1) then
			if IsVehicleExtraTurnedOn(vehicle,1) then
				SetVehicleExtra(vehicle,1,true)
			else
				SetVehicleExtra(vehicle,1,false)
			end
		end
	elseif data == "2" then
		if DoesExtraExist(vehicle,2) then
			if IsVehicleExtraTurnedOn(vehicle,2) then
				SetVehicleExtra(vehicle,2,true)
			else
				SetVehicleExtra(vehicle,2,false)
			end
		end
	elseif data == "3" then
		if DoesExtraExist(vehicle,3) then
			if IsVehicleExtraTurnedOn(vehicle,3) then
				SetVehicleExtra(vehicle,3,true)
			else
				SetVehicleExtra(vehicle,3,false)
			end
		end
	elseif data == "4" then
		if DoesExtraExist(vehicle,4) then
			if IsVehicleExtraTurnedOn(vehicle,4) then
				SetVehicleExtra(vehicle,4,true)
			else
				SetVehicleExtra(vehicle,4,false)
			end
		end
	elseif data == "5" then
		if DoesExtraExist(vehicle,5) then
			if IsVehicleExtraTurnedOn(vehicle,5) then
				SetVehicleExtra(vehicle,5,true)
			else
				SetVehicleExtra(vehicle,5,false)
			end
		end
	elseif data == "6" then
		if DoesExtraExist(vehicle,6) then
			if IsVehicleExtraTurnedOn(vehicle,6) then
				SetVehicleExtra(vehicle,6,true)
			else
				SetVehicleExtra(vehicle,6,false)
			end
		end
	elseif data == "7" then
		if DoesExtraExist(vehicle,7) then
			if IsVehicleExtraTurnedOn(vehicle,7) then
				SetVehicleExtra(vehicle,7,true)
			else
				SetVehicleExtra(vehicle,7,false)
			end
		end
	elseif data == "8" then
		if DoesExtraExist(vehicle,8) then
			if IsVehicleExtraTurnedOn(vehicle,8) then
				SetVehicleExtra(vehicle,8,true)
			else
				SetVehicleExtra(vehicle,8,false)
			end
		end
	elseif data == "9" then
		if DoesExtraExist(vehicle,9) then
			if IsVehicleExtraTurnedOn(vehicle,9) then
				SetVehicleExtra(vehicle,9,true)
			else
				SetVehicleExtra(vehicle,9,false)
			end
		end
	elseif data == "10" then
		if DoesExtraExist(vehicle,10) then
			if IsVehicleExtraTurnedOn(vehicle,10) then
				SetVehicleExtra(vehicle,10,true)
			else
				SetVehicleExtra(vehicle,10,false)
			end
		end
	elseif data == "11" then
		if DoesExtraExist(vehicle,11) then
			if IsVehicleExtraTurnedOn(vehicle,11) then
				SetVehicleExtra(vehicle,11,true)
			else
				SetVehicleExtra(vehicle,11,false)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PUTVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function plVRP.putVehicle()
	local veh = vRP.getNearVehicle(11)
	if IsEntityAVehicle(veh) then
		local vehSeats = 10
		local Ped = PlayerPedId()

		repeat
			vehSeats = vehSeats - 1
			if IsVehicleSeatFree(veh,vehSeats) then
				ClearPedTasks(Ped)
				ClearPedSecondaryTask(Ped)
				SetPedIntoVehicle(Ped,veh,vehSeats)
				vehSeats = true
			end
		until vehSeats == true or vehSeats == 0
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HOLSTER
-----------------------------------------------------------------------------------------------------------------------------------------
local weapons = {
	"WEAPON_KNIFE",
	"WEAPON_HATCHET",
	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_PISTOL50",
	"WEAPON_REVOLVER",
	"WEAPON_COMBATPISTOL",
	"WEAPON_FLASHLIGHT",
	"WEAPON_NIGHTSTICK",
	"WEAPON_STUNGUN",
	"WEAPON_COMPACTRIFLE",
	"WEAPON_APPISTOL",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MICROSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_MINISMG",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_CARBINERIFLE",
	"WEAPON_SNIPERRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SMG",
	"WEAPON_PUMPSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_GUSENBERG"
}

local holster = false
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if DoesEntityExist(ped) and GetEntityHealth(ped) > 101 and not IsPedInAnyVehicle(ped) then
			if not holster and CheckWeapon(ped) then
				timeDistance = 4
				if not IsEntityPlayingAnim(ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) then
					loadAnimDict("rcmjosh4")
					TaskPlayAnim(ped,"rcmjosh4","josh_leadout_cop2",3.0,2.0,-1,48,10,0,0,0)
					Citizen.Wait(450)
					ClearPedTasks(ped)
				end
				holster = true
			elseif holster and not CheckWeapon(ped) then
				timeDistance = 4
				if not IsEntityPlayingAnim(ped,"amb@world_human_sunbathe@female@back@idle_a","idle_a",3) then
					loadAnimDict("weapons@pistol@")
					TaskPlayAnim(ped,"weapons@pistol@","aim_2_holster",3.0,2.0,-1,48,10,0,0,0)
					Citizen.Wait(450)
					ClearPedTasks(ped)
				end
				holster = false
			end
		end

		if GetEntityHealth(ped) <= 101 and holster then
			holster = false
			SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
		end
		Citizen.Wait(timeDistance)
	end
end)

function CheckWeapon(ped)
	for i = 1,#weapons do
		if GetHashKey(weapons[i]) == GetSelectedPedWeapon(ped) then
			return true
		end
	end
	return false
end

function loadAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIVERY
-----------------------------------------------------------------------------------------------------------------------------------------
function plVRP.toggleLivery(number)
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		SetVehicleLivery(GetVehiclePedIsUsing(ped),number)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WECOLORS
-----------------------------------------------------------------------------------------------------------------------------------------
function plVRP.weColors(number)
	local ped = PlayerPedId()
	local weapon = GetSelectedPedWeapon(ped)
	SetPedWeaponTintIndex(ped,weapon,parseInt(number))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
local wLux = {
	["WEAPON_PISTOL"] = {
		"COMPONENT_PISTOL_VARMOD_LUXE",

	},
	["WEAPON_APPISTOL"] = {
		"COMPONENT_APPISTOL_VARMOD_LUXE"
	},
	["WEAPON_HEAVYPISTOL"] = {
		"COMPONENT_HEAVYPISTOL_VARMOD_LUXE"
	},
	["WEAPON_MICROSMG"] = {
		"COMPONENT_MICROSMG_VARMOD_LUXE"
	},
	["WEAPON_SNSPISTOL"] = {
		"COMPONENT_SNSPISTOL_VARMOD_LOWRIDER"
	},
	["WEAPON_PISTOL50"] = {
		"COMPONENT_PISTOL50_VARMOD_LUXE"
	},
	["WEAPON_COMBATPISTOL"] = {
		"COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER"
	},
	["WEAPON_CARBINERIFLE"] = {
		"COMPONENT_CARBINERIFLE_VARMOD_LUXE"
	},
	["WEAPON_PUMPSHOTGUN"] = {
		"COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER"
	},
	["WEAPON_SAWNOFFSHOTGUN"] = {
		"COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE"
	},
	["WEAPON_SMG"] = {
		"COMPONENT_SMG_VARMOD_LUXE"
	},
	["WEAPON_ASSAULTRIFLE"] = {
		"COMPONENT_ASSAULTRIFLE_VARMOD_LUXE"
	},
	["WEAPON_ASSAULTRIFLE_MK2"] = {
		"COMPONENT_ASSAULTRIFLE_MK2_CAMO_IND_01"
	},
	["WEAPON_ASSAULTSMG"] = {
		"COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- WELUX
-----------------------------------------------------------------------------------------------------------------------------------------
function plVRP.weLux()
	local ped = PlayerPedId()
	for k,v in pairs(wLux) do
		if GetSelectedPedWeapon(ped) == GetHashKey(k) then
			for k2,v2 in pairs(v) do
				GiveWeaponComponentToPed(ped,GetHashKey(k),GetHashKey(v2))
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HIDETRUNK
-----------------------------------------------------------------------------------------------------------------------------------------
local inTrunk = false
RegisterNetEvent("vrp_player:EnterTrunk")
AddEventHandler("vrp_player:EnterTrunk",function()
	local ped = PlayerPedId()

	if not inTrunk then
		local vehicle = vRP.vehList(11)
		if DoesEntityExist(vehicle) then
			local trunk = GetEntityBoneIndexByName(vehicle,"boot")
			if trunk ~= -1 then
				local coords = GetEntityCoords(ped)
				local coordsEnt = GetWorldPositionOfEntityBone(vehicle,trunk)
				local distance = #(coords - coordsEnt)
				if distance <= 3.0 and not IsPedInAnyVehicle(ped) then
					timeDistance = 4
					if GetVehicleDoorAngleRatio(vehicle,5) < 0.9 and GetVehicleDoorsLockedForPlayer(vehicle,PlayerId()) ~= 1 then
						SetCarBootOpen(vehicle)
						SetEntityVisible(ped,false,false)
						Citizen.Wait(750)
						AttachEntityToEntity(ped,vehicle,-1,0.0,-2.2,0.5,0.0,0.0,0.0,false,false,false,false,20,true)
						inTrunk = true
						Citizen.Wait(500)
						SetVehicleDoorShut(vehicle,5)
					end
				end
			end
		end
	else
		local vehicle = vRP.vehList(11)
		local trunk = GetEntityBoneIndexByName(vehicle,"boot")
		if trunk ~= -1 then
			local coords = GetEntityCoords(ped)
			local coordsEnt = GetWorldPositionOfEntityBone(vehicle,trunk)
			local distance = #(coords - coordsEnt)
			if distance <= 3.0 then
				timeDistance = 4
				if DoesEntityExist(vehicle) then
					SetCarBootOpen(vehicle)
					Citizen.Wait(750)
					inTrunk = false
					DetachEntity(ped,false,false)
					SetEntityVisible(ped,true,false)
					SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
					Citizen.Wait(500)
					SetVehicleDoorShut(vehicle,5)
				end
			end
		end
	end
end)

RegisterNetEvent("vrp_player:CheckTrunk")
AddEventHandler("vrp_player:CheckTrunk",function()
	local ped = PlayerPedId()

	if inTrunk then
		local vehicle = GetEntityAttachedTo(ped)
		if DoesEntityExist(vehicle) then
			SetCarBootOpen(vehicle)
			Citizen.Wait(750)
			inTrunk = false
			DetachEntity(ped,false,false)
			SetEntityVisible(ped,true,false)
			SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
			Citizen.Wait(500)
			SetVehicleDoorShut(vehicle,5)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500

		if inTrunk then
			local ped = PlayerPedId()
			local vehicle = GetEntityAttachedTo(ped)
			if DoesEntityExist(vehicle) then
				timeDistance = 4

				DisableControlAction(1,73,true)
				DisableControlAction(1,29,true)
				DisableControlAction(1,47,true)
				DisableControlAction(1,187,true)
				DisableControlAction(1,189,true)
				DisableControlAction(1,190,true)
				DisableControlAction(1,188,true)
				DisableControlAction(1,311,true)
				DisableControlAction(1,245,true)
				DisableControlAction(1,257,true)
				DisableControlAction(1,167,true)
				DisableControlAction(1,140,true)
				DisableControlAction(1,141,true)
				DisableControlAction(1,142,true)
				DisableControlAction(1,137,true)
				--DisableControlAction(1,37,true)
				DisablePlayerFiring(ped,true)

				if IsEntityVisible(ped) then
					SetEntityVisible(ped,false,false)
				end

				if IsControlJustPressed(1,38) then
					SetCarBootOpen(vehicle)
					Citizen.Wait(750)
					inTrunk = false
					DetachEntity(ped,false,false)
					SetEntityVisible(ped,true,false)
					SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
					Citizen.Wait(500)
					SetVehicleDoorShut(vehicle,5)
				end
			else
				inTrunk = false
				DetachEntity(ped,false,false)
				SetEntityVisible(ped,true,false)
				SetEntityCoords(ped,GetOffsetFromEntityInWorldCoords(ped,0.0,-1.5,-0.75))
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- /sequestro
-----------------------------------------------------------------------------------------------------------------------------------------
local sequestrado = nil
RegisterCommand("sequestro2",function(source,args)
	local ped = PlayerPedId()
	local random,npc = FindFirstPed()
	repeat
		local distancia = GetDistanceBetweenCoords(GetEntityCoords(ped),GetEntityCoords(npc),true)
		if not IsPedAPlayer(npc) and distancia <= 3 and not IsPedInAnyVehicle(npc) then
			vehicle = vRP.getNearestVehicle(7)
			if IsEntityAVehicle(vehicle) then
				if vRP.getCarroClass(vehicle) then
					if sequestrado then
						AttachEntityToEntity(sequestrado,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-1.2,-0.6,60.0,-90.0,180.0,false,false,false,true,2,true)
						DetachEntity(sequestrado,true,true)
						SetEntityVisible(sequestrado,true)
						SetEntityInvincible(sequestrado,false)
						Citizen.InvokeNative(0xAD738C3085FE7E11,sequestrado,true,true)
						ClearPedTasksImmediately(sequestrado)
						sequestrado = nil
					elseif not sequestrado then
						Citizen.InvokeNative(0xAD738C3085FE7E11,npc,true,true)
						AttachEntityToEntity(npc,vehicle,GetEntityBoneIndexByName(vehicle,"bumper_r"),0.6,-0.4,-0.1,60.0,-90.0,180.0,false,false,false,true,2,true)
						SetEntityVisible(npc,false)
						SetEntityInvincible(npc,true)
						sequestrado = npc
						complet = true
					end
					TriggerServerEvent("trymala",VehToNet(vehicle))
				end
			end
		end
		complet,npc = FindNextPed(random)
	until not complet
	EndFindPed(random)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EMPURRAR
-----------------------------------------------------------------------------------------------------------------------------------------
local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter, id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum, entityEnumerator)

		local next = true
		repeat
		coroutine.yield(id)
		next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function GetVeh()
    local vehicles = {}
    for vehicle in EnumerateVehicles() do
        table.insert(vehicles,vehicle)
    end
    return vehicles
end

function GetClosestVeh(coords)
	local vehicles = GetVeh()
	local closestDistance = -1
	local closestVehicle = -1
	local coords = coords

	if coords == nil then
		local ped = PlayerPedId()
		coords = GetEntityCoords(ped)
	end

	for i=1,#vehicles,1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance = GetDistanceBetweenCoords(vehicleCoords,coords.x,coords.y,coords.z,true)
		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end
	end
	return closestVehicle,closestDistance
end

local First = vector3(0.0,0.0,0.0)
local Second = vector3(5.0,5.0,5.0)
local Vehicle = { Coords = nil, Vehicle = nil, Dimension = nil, IsInFront = false, Distance = nil }

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local closestVehicle,Distance = GetClosestVeh()
		if Distance < 6.1 and not IsPedInAnyVehicle(ped) then
			Vehicle.Coords = GetEntityCoords(closestVehicle)
			Vehicle.Dimensions = GetModelDimensions(GetEntityModel(closestVehicle),First,Second)
			Vehicle.Vehicle = closestVehicle
			Vehicle.Distance = Distance
			if GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle), GetEntityCoords(ped), true) > GetDistanceBetweenCoords(GetEntityCoords(closestVehicle) + GetEntityForwardVector(closestVehicle) * -1, GetEntityCoords(ped), true) then
				Vehicle.IsInFront = false
			else
				Vehicle.IsInFront = true
			end
		else
			Vehicle = { Coords = nil, Vehicle = nil, Dimensions = nil, IsInFront = false, Distance = nil }
		end
		Citizen.Wait(1200)
	end
end)

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1000)
		if Vehicle.Vehicle ~= nil then
			local ped = PlayerPedId()
			if IsControlPressed(0,244) and GetEntityHealth(ped) > 100 and IsVehicleSeatFree(Vehicle.Vehicle,-1) and not IsEntityInAir(ped) and not IsPedBeingStunned(ped) and not IsEntityAttachedToEntity(ped,Vehicle.Vehicle) and not (GetEntityRoll(Vehicle.Vehicle) > 75.0 or GetEntityRoll(Vehicle.Vehicle) < -75.0) then
				RequestAnimDict('missfinale_c2ig_11')
				TaskPlayAnim(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0,-8.0,-1,35,0,0,0,0)
				NetworkRequestControlOfEntity(Vehicle.Vehicle)

				if Vehicle.IsInFront then
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y*-1+0.1,Vehicle.Dimensions.z+1.0,0.0,0.0,180.0,0.0,false,false,true,false,true)
				else
					AttachEntityToEntity(ped,Vehicle.Vehicle,GetPedBoneIndex(6286),0.0,Vehicle.Dimensions.y-0.3,Vehicle.Dimensions.z+1.0,0.0,0.0,0.0,0.0,false,false,true,false,true)
				end

				while true do
					Citizen.Wait(5)
					if IsDisabledControlPressed(0,34) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,11,100)
					end

					if IsDisabledControlPressed(0,9) then
						TaskVehicleTempAction(ped,Vehicle.Vehicle,10,100)
					end

					if Vehicle.IsInFront then
						SetVehicleForwardSpeed(Vehicle.Vehicle,-1.0)
					else
						SetVehicleForwardSpeed(Vehicle.Vehicle,1.0)
					end

					if not IsDisabledControlPressed(0,244) then
						DetachEntity(ped,false,false)
						StopAnimTask(ped,'missfinale_c2ig_11','pushcar_offcliff_m',2.0)
						break
					end
				end
			end
		end
	end
end)


-------------------------------------------------------------------------------------------------------------------------------
-- LOGS
-------------------------------------------------------------------------------------------------------------------------------

local alreadyDead = false

function getWeaponHashName(hash)
	if hash ~= nil then
		if hash == "2725352035" then return "WEAPON_UNARMED"
		elseif hash == "4194021054" then return "WEAPON_ANIMAL"
		elseif hash == "148160082" then return "WEAPON_COUGAR"
		elseif hash == "1317494643" then return "WEAPON_HAMMER"
		elseif hash == "2508868239" then return "WEAPON_BAT"
		elseif hash == "2227010557" then return "WEAPON_CROWBAR"
		elseif hash == "453432689" then return "WEAPON_PISTOL"
		elseif hash == "2578778090" then return "WEAPON_KNIFE"
		elseif hash == "1593441988" then return "WEAPON_COMBATPISTOL"
		elseif hash == "1737195953" then return "WEAPON_NIGHTSTICK"
		elseif hash == "1141786504" then return "WEAPON_GOLFCLUB"
		elseif hash == "584646201" then return "WEAPON_APPISTOL"
		elseif hash == "2578377531" then return "WEAPON_PISTOL50"
		elseif hash == "2939590305" then return "WEAPON_RAYGUN"
		elseif hash == "171789620" then return "WEAPON_COMBATPDW"
		elseif hash == "324215364" then return "WEAPON_MICROSMG"
		elseif hash == "736523883" then return "WEAPON_SMG"
		elseif hash == "4024951519" then return "WEAPON_ASSAULTSMG"
		elseif hash == "2210333304" then return "WEAPON_CARBINERIFLE"
		elseif hash == "-1074790547" then return "WEAPON_ASSAULTRIFLE"
		elseif hash == "2634544996" then return "WEAPON_MG"
		elseif hash == "487013001" then return "WEAPON_PUMPSHOTGUN"
		elseif hash == "2017895192" then return "WEAPON_SAWNOFFSHOTGUN"
		elseif hash == "3800352039" then return "WEAPON_ASSAULTSHOTGUN"
		elseif hash == "2640438543" then return "WEAPON_BULLPUPSHOTGUN"
		elseif hash == "911657153" then return "WEAPON_STUNGUN"
		elseif hash == "100416529" then return "WEAPON_SNIPERRIFLE"
		elseif hash == "205991906" then return "WEAPON_HEAVYSNIPER"
		elseif hash == "856002082" then return "WEAPON_REMOTESNIPER"
		elseif hash == "2726580491" then return "WEAPON_GRENADELAUNCHER"
		elseif hash == "1305664598" then return "WEAPON_GRENADELAUNCHER_SMOKE"
		elseif hash == "2982836145" then return "WEAPON_RPG"
		elseif hash == "375527679" then return "WEAPON_PASSENGER_ROCKET"
		elseif hash == "2937143193" then return "WEAPON_ADVANCEDRIFLE"
		elseif hash == "2144741730" then return "WEAPON_COMBATMG"
		elseif hash == "324506233" then return "WEAPON_AIRSTRIKE_ROCKET"
		elseif hash == "1752584910" then return "WEAPON_STINGER"
		elseif hash == "1119849093" then return "WEAPON_MINIGUN"
		elseif hash == "2481070269" then return "WEAPON_GRENADE"
		elseif hash == "741814745" then return "WEAPON_STICKYBOMB"
		elseif hash == "4256991824" then return "WEAPON_SMOKEGRENADE"
		elseif hash == "2694266206" then return "WEAPON_BZGAS"
		elseif hash == "615608432" then return "WEAPON_MOLOTOV"
		elseif hash == "101631238" then return "WEAPON_FIREEXTINGUISHER"
		elseif hash == "883325847" then return "WEAPON_PETROLCAN"
		elseif hash == "4256881901" then return "WEAPON_DIGISCANNER"
		elseif hash == "2294779575" then return "WEAPON_BRIEFCASE"
		elseif hash == "28811031" then return "WEAPON_BRIEFCASE_02"
		elseif hash == "600439132" then return "WEAPON_BALL"
		elseif hash == "1233104067" then return "WEAPON_FLARE"
		elseif hash == "3204302209" then return "WEAPON_VEHICLE_ROCKET"
		elseif hash == "1223143800" then return "WEAPON_BARBED_WIRE"
		elseif hash == "4284007675" then return "WEAPON_DROWNING"
		elseif hash == "1936677264" then return "WEAPON_DROWNING_IN_VEHICLE"
		elseif hash == "539292904" then return "WEAPON_EXPLOSION"
		elseif hash == "3452007600" then return "WEAPON_FALL"
		elseif hash == "910830060" then return "WEAPON_EXHAUSTION"
		elseif hash == "3425972830" then return "WEAPON_HIT_BY_WATER_CANNON"
		elseif hash == "133987706" then return "WEAPON_RAMMED_BY_CAR"
		elseif hash == "2339582971" then return "WEAPON_BLEEDING"
		elseif hash == "2741846334" then return "WEAPON_RUN_OVER_BY_CAR"
		elseif hash == "341774354" then return "WEAPON_HELI_CRASH"
		elseif hash == "3750660587" then return "WEAPON_FIRE"
		elseif hash == "2461879995" then return "WEAPON_ELECTRIC_FENCE"
		elseif hash == "3218215474" then return "WEAPON_SNSPISTOL"
		elseif hash == "4192643659" then return "WEAPON_BOTTLE"
		elseif hash == "1627465347" then return "WEAPON_GUSENBERG"
		elseif hash == "3231910285" then return "WEAPON_SPECIALCARBINE"
		elseif hash == "3523564046" then return "WEAPON_HEAVYPISTOL"
		elseif hash == "2132975508" then return "WEAPON_BULLPUPRIFLE"
		elseif hash == "2460120199" then return "WEAPON_DAGGER"
		elseif hash == "137902532" then return "WEAPON_VINTAGEPISTOL"
		elseif hash == "2138347493" then return "WEAPON_FIREWORK"
		elseif hash == "2828843422" then return "WEAPON_MUSKET"
		elseif hash == "984333226" then return "WEAPON_HEAVYSHOTGUN"
		elseif hash == "3342088282" then return "WEAPON_MARKSMANRIFLE"
		elseif hash == "1672152130" then return "WEAPON_HOMINGLAUNCHER"
		elseif hash == "2874559379" then return "WEAPON_PROXMINE"
		elseif hash == "126349499" then return "WEAPON_SNOWBALL"
		elseif hash == "1198879012" then return "WEAPON_FLAREGUN"
		elseif hash == "3794977420" then return "WEAPON_GARBAGEBAG"
		elseif hash == "3494679629" then return "WEAPON_HANDCUFFS"
		elseif hash == "171789620" then return "WEAPON_COMBATPDW"
		elseif hash == "3696079510" then return "WEAPON_MARKSMANPISTOL"
		elseif hash == "3638508604" then return "WEAPON_KNUCKLE"
		elseif hash == "4191993645" then return "WEAPON_HATCHET"
		elseif hash == "1834241177" then return "WEAPON_RAILGUN"
		elseif hash == "3713923289" then return "WEAPON_MACHETE"
		elseif hash == "3675956304" then return "WEAPON_MACHINEPISTOL"
		elseif hash == "738733437" then return "WEAPON_AIR_DEFENCE_GUN"
		elseif hash == "3756226112" then return "WEAPON_SWITCHBLADE"
		elseif hash == "3249783761" then return "WEAPON_REVOLVER"
		elseif hash == "4019527611" then return "WEAPON_DBSHOTGUN"
		elseif hash == "1649403952" then return "WEAPON_COMPACTRIFLE"
		elseif hash == "317205821" then return "WEAPON_AUTOSHOTGUN"
		elseif hash == "3441901897" then return "WEAPON_BATTLEAXE"
		elseif hash == "125959754" then return "WEAPON_COMPACTLAUNCHER"
		elseif hash == "3173288789" then return "WEAPON_MINISMG"
		elseif hash == "3125143736" then return "WEAPON_PIPEBOMB"
		elseif hash == "2484171525" then return "WEAPON_POOLCUE"
		elseif hash == "419712736" then return "WEAPON_WRENCH"
		else return "<ARMA DESCONHECIDA - "..hash..">" end
	elseif hash then
		return "<ARMA DESCONHECIDA - "..hash..">"
	else
		return "SUICIDIO"
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local fov_max = 80.0
local fov_min = 5.0 -- max zoom level (smaller fov is more zoom)
local zoomspeed = 3.0 -- camera zoom speed
local speed_lr = 4.0 -- speed by which the camera pans left-right 
local speed_ud = 4.0 -- speed by which the camera pans up-down
local toggle_helicam = 51 -- control id of the button by which to toggle the helicam mode. Default: INPUT_CONTEXT (E)
local toggle_rappel = 154 -- control id to rappel out of the heli. Default: INPUT_DUCK (X)
local toggle_spotlight = 183 -- control id to toggle the various spotlight states Default: INPUT_PhoneCameraGrid (G)
local toggle_display = 44 -- control id to toggle vehicle info display. Default: INPUT_COVER (Q)
local radiusup_key = 137 -- control id to increase manual spotlight radius. Default: INPUT_VEH_PUSHBIKE_SPRINT (CAPSLOCK)
local radiusdown_key = 21 -- control id to decrease spotlight radius. Default: INPUT_SPRINT (LEFT-SHIFT)
local maxtargetdistance = 700 -- max distance at which target lock is maintained
local brightness = 1.0 -- default spotlight brightness
local spotradius = 4.0 -- default manual spotlight radius

local target_vehicle = nil
local manual_spotlight = false
local tracking spotlight = false
local vehicle_display = 0
local helicam = false
local polmav_hash = GetHashKey("policiaheli")
local fov = (fov_max+fov_min)*0.5
local vision_state = 0

Citizen.CreateThread(function()
	DecorRegister("SpotvectorX",3)
	DecorRegister("SpotvectorY",3)
	DecorRegister("SpotvectorZ",3)
	DecorRegister("Target",3)
end)

Citizen.CreateThread(function()
	while true do
		local timeDistance = 1500
		if IsPlayerInPolmav() then
			timeDistance = 4
			local ped = PlayerPedId()
			local heli = GetVehiclePedIsUsing(ped)
			
			if IsHeliHighEnough(heli) then
				if IsControlJustPressed(1,toggle_helicam) then
					PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					helicam = true
				end
				
				if IsControlJustPressed(1,toggle_rappel) then
					if GetPedInVehicleSeat(heli,1) == ped or GetPedInVehicleSeat(heli,2) == ped then
						PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
						TaskRappelFromHeli(ped,1)
					end
				end
			end

			if IsControlJustPressed(1,toggle_spotlight) and GetPedInVehicleSeat(heli,-1) == ped and not helicam then
				if target_vehicle then
					if tracking_spotlight then
						if not pause_Tspotlight then
							pause_Tspotlight = true
							TriggerServerEvent("heli:pause.tracking.spotlight",pause_Tspotlight)
						else
							pause_Tspotlight = false
							TriggerServerEvent("heli:pause.tracking.spotlight",pause_Tspotlight)
						end
						PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					else
						if Fspotlight_state then
							Fspotlight_state = false
							TriggerServerEvent("heli:forward.spotlight",Fspotlight_state)
						end
						local target_netID = VehToNet(target_vehicle)
						local target_plate = GetVehicleNumberPlateText(target_vehicle)
						local targetposx,targetposy,targetposz = table.unpack(GetEntityCoords(target_vehicle))
						pause_Tspotlight = false
						tracking_spotlight = true
						TriggerServerEvent("heli:tracking.spotlight",target_netID,target_plate,targetposx,targetposy,targetposz)
						PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					end
				else
					if tracking_spotlight then
						pause_Tspotlight = false
						tracking_spotlight = false
						TriggerServerEvent("heli:tracking.spotlight.toggle")
					end
					Fspotlight_state = not Fspotlight_state
					TriggerServerEvent("heli:forward.spotlight",Fspotlight_state)
					PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
				end
			end

			if IsControlJustPressed(1,toggle_display) and GetPedInVehicleSeat(heli,-1) == ped then 
				ChangeDisplay()
			end
		end
		
		if helicam then
			SetTimecycleModifier("heliGunCam")
			SetTimecycleModifierStrength(0.3)
			local scaleform = RequestScaleformMovie("HELI_CAM")
			while not HasScaleformMovieLoaded(scaleform) do
				Citizen.Wait(10)
			end

			local ped = PlayerPedId()
			local heli = GetVehiclePedIsUsing(ped)
			local cam = CreateCam("DEFAULT_SCRIPTED_FLY_CAMERA",true)
			AttachCamToEntity(cam,heli,0.0,0.0,-1.5,true)
			SetCamRot(cam,0.0,0.0,GetEntityHeading(heli))
			SetCamFov(cam,fov)
			RenderScriptCams(true,false,0,1,0)
			PushScaleformMovieFunction(scaleform,"SET_CAM_LOGO")
			PushScaleformMovieFunctionParameterInt(0)
			PopScaleformMovieFunctionVoid()
			while helicam and not IsEntityDead(ped) and (GetVehiclePedIsUsing(ped) == heli) and IsHeliHighEnough(heli) do
				if IsControlJustPressed(1,toggle_helicam) then
					PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					if manual_spotlight and target_vehicle then
						TriggerServerEvent("heli:manual.spotlight.toggle")
						local target_netID = VehToNet(target_vehicle)
						local target_plate = GetVehicleNumberPlateText(target_vehicle)
						local targetposx,targetposy,targetposz = table.unpack(GetEntityCoords(target_vehicle))
						pause_Tspotlight = false
						tracking_spotlight = true
						TriggerServerEvent("heli:tracking.spotlight",target_netID,target_plate,targetposx,targetposy,targetposz)
						PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
					end
					manual_spotlight = false
					helicam = false
				end

				if IsControlJustPressed(1,toggle_spotlight) then
					if tracking_spotlight then
						pause_Tspotlight = true
						TriggerServerEvent("heli:pause.tracking.spotlight",pause_Tspotlight)
						manual_spotlight = not manual_spotlight
						if manual_spotlight then
							local rotation = GetCamRot(cam, 2)
							local forward_vector = RotAnglesToVec(rotation)
							local SpotvectorX,SpotvectorY,SpotvectorZ = table.unpack(forward_vector)
							DecorSetInt(ped,"SpotvectorX",SpotvectorX)
							DecorSetInt(ped,"SpotvectorY",SpotvectorY)
							DecorSetInt(ped,"SpotvectorZ",SpotvectorZ)
							PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
							TriggerServerEvent("heli:manual.spotlight")
						else
							TriggerServerEvent("heli:manual.spotlight.toggle")
						end
					elseif Fspotlight_state then
						Fspotlight_state = false
						TriggerServerEvent("heli:forward.spotlight",Fspotlight_state)
						manual_spotlight = not manual_spotlight
						if manual_spotlight then
							PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
							TriggerServerEvent("heli:manual.spotlight")
						else
							TriggerServerEvent("heli:manual.spotlight.toggle")
						end
					else
						manual_spotlight = not manual_spotlight
						if manual_spotlight then
							PlaySoundFrontend(-1,"SELECT","HUD_FRONTEND_DEFAULT_SOUNDSET",false)
							TriggerServerEvent("heli:manual.spotlight")
						else
							TriggerServerEvent("heli:manual.spotlight.toggle")
						end
					end
				end

				if IsControlJustPressed(1,radiusup_key) then
					TriggerServerEvent("heli:radius.up")
				end

				if IsControlJustPressed(1,radiusdown_key) then
					TriggerServerEvent("heli:radius.down")
				end

				if IsControlJustPressed(1,toggle_display) then 
					ChangeDisplay()
				end

				local zoomvalue = (1.0/(fov_max-fov_min))*(fov-fov_min)
				CheckInputRotation(cam, zoomvalue)
				local vehicle_detected = GetVehicleInView(cam)
				if DoesEntityExist(vehicle_detected) then
					RenderVehicleInfo(vehicle_detected)
				end

				HandleZoom(cam)
				HideHudAndRadarThisFrame()
				PushScaleformMovieFunction(scaleform,"SET_ALT_FOV_HEADING")
				PushScaleformMovieFunctionParameterFloat(GetEntityCoords(heli).z)
				PushScaleformMovieFunctionParameterFloat(zoomvalue)
				PushScaleformMovieFunctionParameterFloat(GetCamRot(cam,2).z)
				PopScaleformMovieFunctionVoid()
				DrawScaleformMovieFullscreen(scaleform,255,255,255,255)
				Citizen.Wait(0)

				if manual_spotlight then
					local rotation = GetCamRot(cam, 2)
					local forward_vector = RotAnglesToVec(rotation)
					local SpotvectorX, SpotvectorY, SpotvectorZ = table.unpack(forward_vector)
					local camcoords = GetCamCoord(cam)

					DecorSetInt(ped,"SpotvectorX",SpotvectorX)
					DecorSetInt(ped,"SpotvectorY",SpotvectorY)
					DecorSetInt(ped,"SpotvectorZ",SpotvectorZ)
					DrawSpotLight(camcoords,forward_vector,255,255,255,800.0,10.0,brightness,spotradius,1.0,1.0)
				else
					TriggerServerEvent("heli:manual.spotlight.toggle")
				end

			end
			if manual_spotlight then
				manual_spotlight = false
				TriggerServerEvent("heli:manual.spotlight.toggle")
			end
			helicam = false
			ClearTimecycleModifier()
			fov = (fov_max+fov_min)*0.5
			RenderScriptCams(false,false,0,1,0)
			SetScaleformMovieAsNoLongerNeeded(scaleform)
			DestroyCam(cam,false)
			SetNightvision(false)
			SetSeethrough(false)
		end

		if IsPlayerInPolmav() and target_vehicle and not helicam and vehicle_display ~=2 then
			RenderVehicleInfo(target_vehicle)
		end

		Citizen.Wait(timeDistance)
	end
end)

RegisterNetEvent('heli:forward.spotlight')
AddEventHandler('heli:forward.spotlight',function(serverID,state)
	local heli = GetVehiclePedIsUsing(GetPlayerPed(GetPlayerFromServerId(serverID)))
	SetVehicleSearchlight(heli,state,false)
end)

RegisterNetEvent('heli:Tspotlight')
AddEventHandler('heli:Tspotlight',function(serverID,target_netID,target_plate,targetposx,targetposy,targetposz)
	if GetVehicleNumberPlateText(NetToVeh(target_netID)) == target_plate then
		Tspotlight_target = NetToVeh(target_netID)
	elseif GetVehicleNumberPlateText(DoesVehicleExistWithDecorator("Target")) == target_plate then
		Tspotlight_target = DoesVehicleExistWithDecorator("Target")
	elseif GetVehicleNumberPlateText(GetClosestVehicle(targetposx,targetposy,targetposz,25.0,0,70)) == target_plate then
		Tspotlight_target = GetClosestVehicle(targetposx,targetposy,targetposz,25.0,0,70)
	else 
		vehicle_match = FindVehicleByPlate(target_plate)
		if vehicle_match then
			Tspotlight_target = vehicle_match
		else 
			Tspotlight_target = nil
		end
	end

	local heli = GetVehiclePedIsUsing(GetPlayerPed(GetPlayerFromServerId(serverID)),false)
	local heliPed = GetPlayerPed(GetPlayerFromServerId(serverID))
	Tspotlight_toggle = true
	Tspotlight_pause = false
	tracking_spotlight = true
	while not IsEntityDead(heliPed) and (GetVehiclePedIsUsing(heliPed) == heli) and Tspotlight_target and Tspotlight_toggle do
		Citizen.Wait(1)
		local helicoords = GetEntityCoords(heli)
		local targetcoords = GetEntityCoords(Tspotlight_target)
		local spotVector = targetcoords - helicoords
		local target_distance = Vdist(targetcoords,helicoords)
		if Tspotlight_target and Tspotlight_toggle and not Tspotlight_pause then
			DrawSpotLight(helicoords['x'],helicoords['y'],helicoords['z'],spotVector['x'],spotVector['y'],spotVector['z'],255,255,255,(target_distance+20),10.0,brightness,4.0,1.0,0.0)
		end
		if Tspotlight_target and Tspotlight_toggle and target_distance > maxtargetdistance then
			DecorRemove(Tspotlight_target,"Target")			
			target_vehicle = nil
			tracking_spotlight = false
			TriggerServerEvent("heli:tracking.spotlight.toggle")
			Tspotlight_target = nil
			break
		end
	end
	Tspotlight_toggle = false
	Tspotlight_pause = false
	Tspotlight_target = nil
	tracking_spotlight = false
end)

RegisterNetEvent('heli:Tspotlight.toggle')
AddEventHandler('heli:Tspotlight.toggle',function(serverID)
	Tspotlight_toggle = false
	tracking_spotlight = false
end)

RegisterNetEvent('heli:pause.Tspotlight')
AddEventHandler('heli:pause.Tspotlight',function(serverID,pause_Tspotlight)
	if pause_Tspotlight then
		Tspotlight_pause = true
	else
		Tspotlight_pause = false
	end
end)

RegisterNetEvent('heli:Mspotlight')
AddEventHandler('heli:Mspotlight',function(serverID)
	if GetPlayerServerId(PlayerId()) ~= serverID then
		local heli = GetVehiclePedIsUsing(GetPlayerPed(GetPlayerFromServerId(serverID)), false)
		local heliPed = GetPlayerPed(GetPlayerFromServerId(serverID))
		Mspotlight_toggle = true
		while not IsEntityDead(heliPed) and (GetVehiclePedIsUsing(heliPed) == heli) and Mspotlight_toggle do
			Citizen.Wait(0) 
			local helicoords = GetEntityCoords(heli)
			spotoffset = helicoords + vector3(0.0,0.0,-1.5)
			SpotvectorX = DecorGetInt(heliPed,"SpotvectorX")
			SpotvectorY = DecorGetInt(heliPed,"SpotvectorY")
			SpotvectorZ = DecorGetInt(heliPed,"SpotvectorZ")
			if SpotvectorX then
				DrawSpotLight(spotoffset['x'],spotoffset['y'],spotoffset['z'],SpotvectorX,SpotvectorY,SpotvectorZ,255,255,255,800.0,10.0,brightness,spotradius,1.0,1.0)
			end
		end
		Mspotlight_toggle = false
		DecorSetInt(heliPed,"SpotvectorX",nil)
		DecorSetInt(heliPed,"SpotvectorY",nil)
		DecorSetInt(heliPed,"SpotvectorZ",nil)
	end
end)

RegisterNetEvent('heli:Mspotlight.toggle')
AddEventHandler('heli:Mspotlight.toggle',function(serverID)
	Mspotlight_toggle = false
end)

RegisterNetEvent('heli:radius.up')
AddEventHandler('heli:radius.up',function(serverID)
	if spotradius < 10.0 then
		spotradius = spotradius + 1.0
	end
end)

RegisterNetEvent('heli:radius.down')
AddEventHandler('heli:radius.down',function(serverID)
	if spotradius > 4.0 then
		spotradius = spotradius - 1.0
	end
end)

function IsPlayerInPolmav()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	return IsVehicleModel(vehicle,polmav_hash)
end

function IsHeliHighEnough(heli)
	return GetEntityHeightAboveGround(heli) > 1.5
end

function ChangeDisplay()
	if vehicle_display == 0 then
		vehicle_display = 1
	elseif vehicle_display == 1 then
		vehicle_display = 2
	else
		vehicle_display = 0
	end
end

local alreadyDead = false
Citizen.CreateThread(function()
    while true do
		if GetEntityHealth(PlayerPedId()) > 102 then
			alreadyDead = false
		end
        Citizen.Wait(5000)
    end
end)

AddEventHandler("gameEventTriggered",function(event,args)
    if event == "CEventNetworkEntityDamage" then
        local data = { victim = args[1], attacker = args[2], weapon = args[7] }
        if IsEntityAPed(data.victim) then
            local ped = PlayerPedId()
            if data.victim == ped then
                local killerSource = -1
                if GetEntityHealth(ped) <= 101 and not alreadyDead then
					if DoesEntityExist(data.attacker) and IsPedAPlayer(data.attacker) and data.attacker ~= data.victim then
						killerSource = GetPlayerServerId(NetworkGetPlayerIndexFromPed(data.attacker))
					end
                    alreadyDead = true
					TriggerServerEvent("logplayerDied",killerSource,getWeaponHashName(weapon))
                end
            end
        end
    end
end)

function CheckInputRotation(cam, zoomvalue)
	local rightAxisX = GetDisabledControlNormal(0,220)
	local rightAxisY = GetDisabledControlNormal(0,221)
	local rotation = GetCamRot(cam,2)
	if rightAxisX ~= 0.0 or rightAxisY ~= 0.0 then
		new_z = rotation.z + rightAxisX*-1.0*(speed_ud)*(zoomvalue+0.1)
		new_x = math.max(math.min(20.0,rotation.x+rightAxisY*-1.0*(speed_lr)*(zoomvalue+0.1)),-89.5)
		SetCamRot(cam,new_x,0.0,new_z,2)
	end
end

function HandleZoom(cam)
	if IsControlJustPressed(1,241) then
		fov = math.max(fov - zoomspeed, fov_min)
	end

	if IsControlJustPressed(1,242) then
		fov = math.min(fov + zoomspeed, fov_max)
	end

	local current_fov = GetCamFov(cam)
	if math.abs(fov-current_fov) < 0.1 then
		fov = current_fov
	end

	SetCamFov(cam,current_fov+(fov-current_fov)*0.05)
end

function GetVehicleInView(cam)
	local coords = GetCamCoord(cam)
	local forward_vector = RotAnglesToVec(GetCamRot(cam,2))
	local rayhandle = CastRayPointToPoint(coords,coords+(forward_vector*200.0),10,GetVehiclePedIsUsing(PlayerPedId()),0)
	local _,_,_,_,entityHit = GetRaycastResult(rayhandle)
	if entityHit > 0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RenderVehicleInfo(vehicle)
	if DoesEntityExist(vehicle) then
		local model = GetEntityModel(vehicle)
		local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
		local licenseplate = GetVehicleNumberPlateText(vehicle)
		local vehspeed = GetEntitySpeed(vehicle)*2.236936
		SetTextFont(0)
		SetTextProportional(1)

		if vehicle_display == 0 then
			SetTextScale(0.0,0.49)
		elseif vehicle_display == 1 then
			SetTextScale(0.0,0.55)
		end

		SetTextColour(255,255,255,255)
		SetTextDropshadow(0,0,0,0,255)
		SetTextEdge(1,0,0,0,255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		if vehicle_display == 0 then
			AddTextComponentString("SPEED: " .. math.ceil(vehspeed) .. " KM/H\nMODEL: " .. vehname .. "\nPLATE: " .. licenseplate)
		elseif vehicle_display == 1 then
			AddTextComponentString("MODDEL: " .. vehname .. "\nPLATE: " .. licenseplate)
		end
		DrawText(0.45,0.9)
	end
end

function RotAnglesToVec(rot)
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num,math.cos(z)*num,math.sin(x))
end

local entityEnumerator = {
	__gc = function(enum)
		if enum.destructor and enum.handle then
			enum.destructor(enum.handle)
		end
		enum.destructor = nil
		enum.handle = nil
	end
}

local function EnumerateEntities(initFunc,moveFunc,disposeFunc)
	return coroutine.wrap(function()
		local iter,id = initFunc()
		if not id or id == 0 then
			disposeFunc(iter)
			return
		end

		local enum = { handle = iter, destructor = disposeFunc }
		setmetatable(enum,entityEnumerator)

		local next = true
		repeat
			Citizen.Wait(1)
			coroutine.yield(id)
			next,id = moveFunc(iter)
		until not next

		enum.destructor,enum.handle = nil,nil
		disposeFunc(iter)
	end)
end

function EnumerateVehicles()
	return EnumerateEntities(FindFirstVehicle,FindNextVehicle,EndFindVehicle)
end

function FindVehicleByPlate(plate)
	for vehicle in EnumerateVehicles() do
		if GetVehicleNumberPlateText(vehicle) == plate then
			return vehicle
		end
	end
end

------------------------------------------------------------------------------------------------------------------------
-- FPS ON & OFF --------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
        TriggerEvent("Notify","sucesso","Boost de fps ligado!",2000)
    elseif args[1] == "off" then
        SetTimecycleModifier("default")
        TriggerEvent("Notify","sucesso","Boost de fps desligado!",2000)
    end
end) 

RegisterCommand("cruiser",function(source,args)
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	local maxspeed = GetVehicleMaxSpeed(GetEntityModel(veh))
	local vehspeed = GetEntitySpeed(veh) * 2.236936
	if GetPedInVehicleSeat(veh,-1) == ped and math.ceil(vehspeed) >= 5 and not IsEntityInAir(veh) then
		if args[1] == nil then
			SetEntityMaxSpeed(veh,maxspeed)
			TriggerEvent("Notify","sucesso","Controle de cruzeiro desativado.",3000)
		else
			SetEntityMaxSpeed(veh,0.45*args[1]-0.45)
			TriggerEvent("Notify","sucesso","Controle de cruzeiro ativado.",3000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORT
-----------------------------------------------------------------------------------------------------------------------------------------
local teleport = {
	{ 338.65,-583.87,74.17,330.34,-601.22,43.29,"DESCER" },  ----hospital parte do heli
	{ 330.34,-601.22,43.29,338.65,-583.87,74.17,"SUBIR" },

	{ 332.26,-595.6,43.29,359.55,-584.95,28.82,"DESCER" },  ---- hospital subir da rua pro hp
	{ 359.55,-584.95,28.82,332.26,-595.6,43.29,"SUBIR" },

	{ 253.96,225.2,101.88,252.3,220.23,101.69,"ENTRAR" },
	{ 252.3,220.23,101.69,253.96,225.2,101.88,"SAIR" },

	{ 4.58,-705.95,45.98,-139.85,-627.0,168.83,"ENTRAR" },
	{ -139.85,-627.0,168.83,4.58,-705.95,45.98,"SAIR" },

	{ -117.29,-604.52,36.29,-74.48,-820.8,243.39,"ENTRAR" },
	{ -74.48,-820.8,243.39,-117.29,-604.52,36.29,"SAIR" },

	{ -826.9,-699.89,28.06,-1575.14,-569.15,108.53,"ENTRAR" },
	{ -1575.14,-569.15,108.53,-826.9,-699.89,28.06,"SAIR" },

	{ -935.68,-378.77,38.97,-1386.84,-478.56,72.05,"ENTRAR" },
	{ -1386.84,-478.56,72.05,-935.68,-378.77,38.97,"SAIR" },

	{ -741.07,5593.13,41.66,446.19,5568.79,781.19,"SUBIR" },
	{ 446.19,5568.79,781.19,-741.07,5593.13,41.66,"DESCER" },

	{ -740.78,5597.04,41.66,446.37,5575.02,781.19,"SUBIR" },
	{ 446.37,5575.02,781.19,-740.78,5597.04,41.66,"DESCER" },

	{ 40.69,3715.73,39.68,28.1,3711.62,13.6,"ENTRAR" }, -- META
	{ 28.1,3711.62,13.6,40.69,3715.73,39.68,"SAIR" },

	{ 241.14,-1378.93,33.75,275.8,-1361.48,24.54,"ENTRAR" },
	{ 275.8,-1361.48,24.54,241.14,-1378.93,33.75,"SAIR" },

	{ 232.89,-411.39,48.12,224.63,-360.7,-98.78,"ENTRAR" },
	{ 224.63,-360.7,-98.78,232.89,-411.39,48.12,"SAIR" },

	{ -71.0,-801.07,44.23,-72.09,-808.11,324.02,"ENTRAR" }, -- Mazebank
	{ -72.09,-808.11,324.02,-71.0,-801.07,44.23,"SAIR" },

	{ 110.8,-1297.14,29.27,1138.82,-3198.88,-39.66,"ENTRAR" },  ----- lavagem
	{ 1138.82,-3198.88,-39.66,110.8,-1297.14,29.27,"SAIR" },

	{ 967.4,7.49,81.16,964.98,58.48,112.56,"ENTRAR" },  ------CASSINO
	{ 964.98,58.48,112.56,967.4,7.49,81.16,"SAIR"},

	{ 850.93,1823.49,148.31,852.43,1821.4,148.52,"ENTRAR" },  ------CASSINO
	{ 852.43,1821.4,148.52,850.43,1823.4,148.52,"SAIR"},

	{ 234.33,-387.57,-98.78,244.34,-429.14,-98.78,"ENTRAR" },
	{ 244.34,-429.14,-98.78,234.33,-387.57,-98.78,"SAIR" },

	{ -419.0,-344.73,24.24,-436.09,-359.74,34.95,"ENTRAR" },
	{ -436.09,-359.74,34.95,-419.0,-344.73,24.24,"SAIR" },

}

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(teleport) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 1 then
					timeDistance = 4
					DrawText3D(v[1],v[2],v[3],"~g~E~w~   "..v[7])
					if IsControlJustPressed(1,38) then
						DoScreenFadeOut(1000)
						Citizen.Wait(1200)
						SetEntityCoords(ped,v[4],v[5],v[6])
						Citizen.Wait(1200)
						DoScreenFadeIn(1000)
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.3,0.3)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end

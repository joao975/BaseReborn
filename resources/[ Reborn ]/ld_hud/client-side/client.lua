-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPS = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
src = Tunnel.getInterface("ld_hud",src)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
beltLock = 0
local voice = 2
hardness = {}
local clientStress = 0
local clientHunger = 100
local clientThirst = 100
showHud = true
local talking = false
local showMovie = false
local radioDisplay = ""
local ammoDisplay = ""
local homeInterior = false
local hour = nil
local minute = nil
local updateFoods = GetGameTimer()
local playerActive = true

local gpsEnabled = false

RegisterCommand('togglegps',function(source,args,rawCommand)
	-- if not src.isAuth() then return end
	if gpsEnabled then
		TriggerEvent("Notify","importante","Você desativou gps! Você não o verá mais, enquanto estiver a pé.",5000)
		gpsEnabled = false
	else
		TriggerEvent("Notify","sucesso","Você ativou o gps! Agora você o verá, mesmo a pé.",5000)
		gpsEnabled = true
	end
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- Lights Car
-----------------------------------------------------------------------------------------------------------------------------------------
local lightState = "off"
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
beltSpeed = 0
beltVelocity = 0
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEDISPLAYHUD
-----------------------------------------------------------------------------------------------------------------------------------------

local streetLast = 0
local flexDirection = "Norte"
function updateDisplayHud()
	-- if not src.isAuth() then return end
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local heading = GetEntityHeading(ped)
	local armour = GetPedArmour(ped)
	
	local health = (((GetEntityHealth(ped)-100) / 300) * 100) * 2
	local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(coords["x"],coords["y"],coords["z"]))
	talking = NetworkIsPlayerTalking(PlayerId())
	
	if heading >= 315 or heading < 45 then
		flexDirection = "Norte"
	elseif heading >= 45 and heading < 135 then
		flexDirection = "Oeste"
	elseif heading >= 135 and heading < 225 then
		flexDirection = "Sul"
	elseif heading >= 225 and heading < 315 then
		flexDirection = "Leste"
	end
	
    local bool, ammo = GetAmmoInClip(GetPlayerPed(PlayerId()), GetSelectedPedWeapon(GetPlayerPed(PlayerId())))
	if Config.showBullets and ammo > 0 then
		ammoDisplay = ammo.."/"..(GetAmmoInPedWeapon(GetPlayerPed(PlayerId()), GetSelectedPedWeapon(GetPlayerPed(PlayerId())))) - ammo
	else
		ammoDisplay = ""
	end
	
	water = IsPedSwimming(ped)
	oxygen = (GetPlayerUnderwaterTimeRemaining(PlayerId()) * 10)
	if oxygen < 0 then oxygen = 0 end
	
	hours = GetClockHours()
	minutes = GetClockMinutes()

	if hours <= 9 then
		hours = "0"..hours
	end

	if minutes <= 9 then
		minutes = "0"..minutes
	end
	
	clientStress = 100 - GetPlayerSprintStaminaRemaining(PlayerId())

	local horario = hours..":"..minutes
	local logo = Config.logo
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		local fuel = GetVehicleFuelLevel(vehicle)
		local vehicleGear = GetVehicleCurrentGear(vehicle)
		local plate = GetVehicleNumberPlateText(vehicle)
		local vehicleHealth = GetVehicleEngineHealth(vehicle)
		local lataria = GetVehicleBodyHealth(vehicle)
		local speed = GetEntitySpeed(vehicle) * 3.6
		local showBelt = true
		local engine = GetVehicleEngineHealth(vehicle)

		local farol = "off"
		local _,lights,highlights = GetVehicleLightsState(vehicle)
		if lights == 1 and highlights == 0 then 
			farol = "normal"
		elseif (lights == 1 and highlights == 1) or (lights == 0 and highlights == 1) then 
			farol = "alto"
		end

		if speed > 0 and vehicleGear == 0 then
			vehicleGear = 7
		end
		
		if GetVehicleClass(vehicle) == 8 and (GetVehicleClass(vehicle) >= 13 and GetVehicleClass(vehicle) <= 16) and GetVehicleClass(vehicle) == 21 then
			showBelt = false
		end
		if not IsMinimapRendering() then
			DisplayRadar(true)
		end
		SendNUIMessage({ hudEvent = true, onwater = water, vehicle = true, logo = logo, farol = farol, engine = parseInt(engine/10), talking = talking, health = health, lataria = lataria, armour = armour, oxygen = oxygen, thirst = clientThirst, hunger = clientHunger, stress = clientStress, oxigen = clientOxigen, suit = divingMask, street = streetName, direction = flexDirection, ammo = ammoDisplay, voice = voice, fuel = fuel, speed = speed, time = horario, showbelt = showBelt, seatbelt = beltLock, hardness = (hardness[plate] or 0), vehicleEngine = parseInt(vehicleHealth), lightState = lightState, gear = vehicleGear })
	else
		if gpsEnabled then
			if not IsMinimapRendering() then
				DisplayRadar(true)
			end
		else
			if IsMinimapRendering() and not gpsEnabled then
				DisplayRadar(false)
			end
		end
		SendNUIMessage({ hudEvent = true, onwater = water, vehicle = false, logo = logo, talking = talking, health = health, armour = armour, oxygen = oxygen, thirst = clientThirst, hunger = clientHunger, stress = clientStress, oxigen = clientOxigen, suit = divingMask, street = streetName, direction = flexDirection, ammo = ammoDisplay, voice = voice, time = horario })
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hud",function(source,args)
	-- if not src.isAuth() then return end
	showHud = not showHud

	updateDisplayHud()
	SendNUIMessage({ hud = showHud })
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	DisplayRadar(false)

	RequestStreamedTextureDict("circlemap",false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Citizen.Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics","radarmasksm","circlemap","radarmasksm")

	SetMinimapClipType(1)

	SetMinimapComponentPosition("minimap","L","B",0.0,0.0,0.158,0.28)
	SetMinimapComponentPosition("minimap_mask","L","B",0.155,0.12,0.080,0.164)
	SetMinimapComponentPosition("minimap_blur","L","B",-0.005,0.021,0.240,0.302)
	Citizen.Wait(600)
	SendNUIMessage({ radioUpdate = true, radio = nil })
	
	-----------------------------------------------------------------------------------------------------------------------------------------
	-- EVENTOS
	-----------------------------------------------------------------------------------------------------------------------------------------
	
	RegisterNetEvent(Config.events.voiceTalking)
	RegisterNetEvent(Config.events.voiceTalking, function(boolean)
	   boolean = boolean
	end)

	RegisterNetEvent(Config.events.hunger)
	AddEventHandler(Config.events.hunger,function(number)
		clientHunger = parseInt(number)
	end)

	RegisterNetEvent(Config.events.thirst)
	AddEventHandler(Config.events.thirst,function(number)
		clientThirst = parseInt(number)
	end)

	RegisterNetEvent(Config.events.talkingMode)
	AddEventHandler(Config.events.talkingMode,function(status)
		voice = status
	end)

	RegisterNetEvent(Config.events.radioChange)
	AddEventHandler(Config.events.radioChange,function(text)
		if text ~= radioDisplay then
			radioDisplay = text
			SendNUIMessage({ radioUpdate = true, radio = radioDisplay, voice = voice })
		end
	end)
	
	-----------------------------------------------------------------------------------------------------------------------------------------

	SetBigmapActive(false,false)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUDACTIVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("hudActived")
AddEventHandler("hudActived",function(status)
	showHud = status
	
	updateDisplayHud()

	SendNUIMessage({ hud = showHud })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FOWARDPED
-----------------------------------------------------------------------------------------------------------------------------------------
function fowardPed(ped)
	local heading = GetEntityHeading(ped) + 90.0
	if heading < 0.0 then
		heading = 360.0 + heading
	end

	heading = heading * 0.0174533

	return { x = math.cos(heading) * 2.0, y = math.sin(heading) * 2.0 }
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SEATBELT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("seatbelt",function(source,args)
	-- if not src.isAuth() then return end
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		if not IsPedOnAnyBike(ped) then
			if beltLock == 1 then
				TriggerEvent("vrp_sound:source","unbelt",0.5)
				beltLock = 0
			else
				TriggerEvent("vrp_sound:source","belt",0.5)
				beltLock = 1
			end
		end
	end
end)

RegisterCommand('+indicatorlights',function(source,args)
	local ped = PlayerPedId()
	local isIn = IsPedInAnyVehicle(ped,false)
	if isIn then
	local vehicle = GetVehiclePedIsIn(ped, false)
	local lights = GetVehicleIndicatorLights(vehicle)
			if args[1] == 'up' then
				lightState = 'up'
				SetVehicleIndicatorLights(vehicle,0,true)
				SetVehicleIndicatorLights(vehicle,1,true)
			elseif args[1] == 'left' then
				lightState = 'left'
				SetVehicleIndicatorLights(vehicle,1,true)
				SetVehicleIndicatorLights(vehicle,0,false)
			elseif args[1] == 'right' then
				lightState = 'right'
				SetVehicleIndicatorLights(vehicle,0,true)
				SetVehicleIndicatorLights(vehicle,1,false)
			elseif args[1] == 'off' and lights >= 0 then
				lightState = 'off'
				SetVehicleIndicatorLights(vehicle,0,false)
				SetVehicleIndicatorLights(vehicle,1,false)
			end
	end
end)

RegisterKeyMapping("+indicatorlights up","Ambas setas.","keyboard","UP")
RegisterKeyMapping("+indicatorlights left","Seta para esquerda.","keyboard","LEFT")
RegisterKeyMapping("+indicatorlights right","Seta para direita.","keyboard","RIGHT")
RegisterKeyMapping("+indicatorlights off","Desligar setas.","keyboard","BACK")

-----------------------------------------------------------------------------------------------------------------------------------------
-- KEYMAPPING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterKeyMapping("seatbelt","Colocar/Retirar o cinto.","keyboard","g")
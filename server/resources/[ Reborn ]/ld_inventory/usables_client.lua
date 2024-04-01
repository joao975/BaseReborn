-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vCU = {}
Tunnel.bindInterface("inventory_client",vCU)
vSERVER = Tunnel.getInterface("ld_inventory-usables")

-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKFOUNTAIN
-----------------------------------------------------------------------------------------------------------------------------------------
function vCU.checkFountain()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	if DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler"),true) or DoesObjectOfTypeExistAtCoords(coords,0.7,GetHashKey("prop_watercooler_dark"),true) then
		return true,"fountain"
	end

	if IsEntityInWater(ped) then
		return true,"floor"
	end

	return false
end

function vCU.parachuteColors()
	--AddPlayerWeapon(PlayerPedId(),"GADGET_PARACHUTE",1,false,true)
	-- vRP.giveWeapons({["GADGET_PARACHUTE"] = { ammo = 1 }})
	GiveWeaponToPed(PlayerPedId(),GetHashKey("GADGET_PARACHUTE"),1,false,true)
	SetPedParachuteTintIndex(PlayerPedId(),math.random(7))
end

function vCU.plateApply(plate)
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsUsing(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleNumberPlateText(vehicle,plate)
		FreezeEntityPosition(vehicle,false)
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CASHREGISTER
-----------------------------------------------------------------------------------------------------------------------------------------
local registerCoords = {}
function vCU.cashRegister()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(registerCoords) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 1 then
			return false,v[1],v[2],v[3]
		end
	end

	local object = GetClosestObjectOfType(coords,0.4,GetHashKey("prop_till_01"),0,0,0)
	if DoesEntityExist(object) then
		SetEntityHeading(ped,GetEntityHeading(object)-360.0)
		SetPedComponentVariation(ped,5,45,0,2)
		local coords = GetEntityCoords(object)
		return true,coords.x,coords.y,coords.z
	end

	return false
end

RegisterNetEvent("vrp_inventory:repairTires")
AddEventHandler("vrp_inventory:repairTires",function(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			if IsVehicleTyreBurst(v,0) then
				SetVehicleTyreFixed(v,0)
			elseif IsVehicleTyreBurst(v,1) then
				SetVehicleTyreFixed(v,1)
			elseif IsVehicleTyreBurst(v,4) then
				SetVehicleTyreFixed(v,4)
				
			else
				SetVehicleTyreFixed(v,5)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGSTATUS
-----------------------------------------------------------------------------------------------------------------------------------------
function vCU.fishingStatus()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(-1202.71,2714.76,4.11))
	if distance <= 20 then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FISHINGANIM
-----------------------------------------------------------------------------------------------------------------------------------------
function vCU.fishingAnim()
	local ped = PlayerPedId()
	if IsEntityPlayingAnim(ped,"amb@world_human_stand_fishing@idle_a","idle_c",3) then
		return true
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local plateX = -1133.31
local plateY = 2694.2
local plateZ = 18.81
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - THREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(plateX,plateY,plateZ))
			if distance <= 50.0 then
				timeDistance = 4
				DrawMarker(23,plateX,plateY,plateZ-0.98,0,0,0,0,0,0,5.0,5.0,1.0,255,0,0,50,0,0,0,0)
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLATE - FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function vCU.plateDistance()
	local ped = PlayerPedId()
	if IsPedInAnyVehicle(ped) then
		local vehicle = GetVehiclePedIsUsing(ped)
		if GetPedInVehicleSeat(vehicle,-1) == ped then
			local coords = GetEntityCoords(ped)
			local distance = #(coords - vector3(plateX,plateY,plateZ))
			if distance <= 3.0 then
				FreezeEntityPosition(vehicle,true)
				return true
			end
		end
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TECHDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
function vCU.techDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local distance = #(coords - vector3(1174.66,2640.45,37.82))
	if distance <= 10 then
		return true
	end
	return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADRENALINEDISTANCE
-----------------------------------------------------------------------------------------------------------------------------------------
local adrenalineCds = {
	{ 1978.76,5171.11,47.64 },
	{ 707.86,4183.95,40.71 },
	{ 436.64,6462.23,28.75 },
	{ -2173.5,4291.73,49.04 }
}

function vCU.adrenalineDistance()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	for k,v in pairs(adrenalineCds) do
		local distance = #(coords - vector3(v[1],v[2],v[3]))
		if distance <= 5 then
			return true
		end
	end
	return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTANIMHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
local anim = "machinic_loop_mechandplayer"
local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"

function vCU.startAnimHotwired()
	vehHotwired = true
	while not HasAnimDictLoaded(animDict) do
		RequestAnimDict(animDict)
		Citizen.Wait(10)
	end
	TaskPlayAnim(PlayerPedId(),animDict,anim,3.0,3.0,-1,49,5.0,0,0,0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPANIMHOTWIRED
-----------------------------------------------------------------------------------------------------------------------------------------
function vCU.stopAnimHotwired(vehicle)
	while not HasAnimDictLoaded(animDict) do
		RequestAnimDict(animDict)
		Citizen.Wait(10)
	end
	vehHotwired = false
	StopAnimTask(PlayerPedId(),animDict,anim,2.0)
	SetEntityAsMissionEntity(vehicle,true,true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text,size)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/size
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end


-----------------------------------------------------------------------------------------------------------------------------------------
-- SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
local RCCar = {}


-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENT SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ RegisterNetEvent('skate')
AddEventHandler('skate',function()
	local ped = PlayerPedId()
	if DoesEntityExist(RCCar.Entity) then return end
	RCCar.Spawn()
	while DoesEntityExist(RCCar.Entity) and DoesEntityExist(RCCar.Driver) do
		Citizen.Wait(1)
		local distanceCheck = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(RCCar.Entity),true)
		RCCar.HandleKeys(distanceCheck)
		if distanceCheck <= 3 then
			if not NetworkHasControlOfEntity(RCCar.Driver) then
				NetworkRequestControlOfEntity(RCCar.Driver)
			elseif not NetworkHasControlOfEntity(RCCar.Entity) then
				NetworkRequestControlOfEntity(RCCar.Entity)
			end
		else
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,6,2500)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION CONTROL SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
Attached = false
function RCCar.HandleKeys(distanceCheck)
	local ped = PlayerPedId()
	if distanceCheck <= 1.5 then
		if IsControlJustPressed(0,38) and IsInputDisabled(0) and not Attached then
			RCCar.Attach("pick")
		end
		if Attached then
			drawTxt("PRESSIONE ~g~M ~w~PARA DESCER DO SKATE",4,0.500,0.950,0.5,255,255,255,200)
		end
		if IsControlJustReleased(0,244) and IsInputDisabled(0) then
			if Attached then
				RCCar.AttachPlayer(false)
			else
				RCCar.AttachPlayer(true)
			end
		end
		if not Attached then
			DrawText3Ds(GetEntityCoords(RCCar.Entity).x,GetEntityCoords(RCCar.Entity).y,GetEntityCoords(RCCar.Entity).z+0.5,"~r~E ~w~ PEGAR      ~g~M ~w~ SUBIR",500)
		end
	end
	if distanceCheck <= 1.5 and Attached then
		if IsControlPressed(0,32) and IsInputDisabled(0) and not IsControlPressed(0,33)  and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,9,1)
		end
		if IsControlJustReleased(0,22) and IsInputDisabled(0) and Attached then
			local vel = GetEntityVelocity(RCCar.Entity)
			if not IsEntityInAir(RCCar.Entity) then
				SetEntityVelocity(RCCar.Entity,vel.x,vel.y,vel.z+5.0)
				Citizen.Wait(20)
			end
		end
		if IsControlJustReleased(0,32) or IsControlJustReleased(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,6,2500)
		end
		if IsControlPressed(0,33) and not IsControlPressed(0,32) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,22,1)
		end
		if IsControlPressed(0,34) and IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,13,1)
		end
		if IsControlPressed(0,35) and IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,14,1)
		end
		if IsControlPressed(0,32) and IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,30,100)
		end
		if IsControlPressed(0,34) and IsControlPressed(0,32) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,7,1)
		end
		if IsControlPressed(0,35) and IsControlPressed(0,32) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,8,1)
		end
		if IsControlPressed(0,34) and not IsControlPressed(0,32) and not IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,4,1)
		end
		if IsControlPressed(0,35) and not IsControlPressed(0,32) and not IsControlPressed(0,33) and IsInputDisabled(0) then
			TaskVehicleTempAction(RCCar.Driver,RCCar.Entity,5,1)
		end
	end
	Citizen.CreateThread(function()
    	Citizen.Wait(1)
    	if Attached then
	        local x = GetEntityRotation(RCCar.Entity).x
	        local y = GetEntityRotation(RCCar.Entity).y

	        if (-60.0 < x and x > 60.0) or (-60.0 < y and y > 60.0) or (HasEntityCollidedWithAnything(RCCar.Entity) and GetEntitySpeed(RCCar.Entity) > 12.6) then
	        	RCCar.AttachPlayer(false)
	        	SetPedToRagdoll(ped,4000,4000,0,true,true,false)
	        elseif IsPedArmed(ped,7) or IsEntityInWater(RCCar.Entity) or GetEntityHealth(ped) <= 101 then
	        	RCCar.AttachPlayer(false)
	        	DetachEntity(RCCar.Entity)
			end
	    end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION SPAWN SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
function RCCar.Spawn()
	local ped = PlayerPedId()
	if not IsPedInAnyVehicle(ped) then
		RCCar.LoadModels({ GetHashKey("rcbandito"),68070371,GetHashKey("p_defilied_ragdoll_01_s"),"pickup_object","move_strafe@stealth" })
		local spawnCoords,spawnHeading = GetEntityCoords(ped)+GetEntityForwardVector(ped)*2.0,GetEntityHeading(ped)
		RCCar.Entity = CreateVehicle(GetHashKey("rcbandito"),spawnCoords,spawnHeading,true)
		SetVehicleNumberPlateText(RCCar.Entity,vRP.getRegistrationNumber())
		RCCar.Skate = CreateObject(GetHashKey("p_defilied_ragdoll_01_s"),0.0,0.0,0.0,true,true,true)
		while not DoesEntityExist(RCCar.Entity) do
			Citizen.Wait(5)
		end
		while not DoesEntityExist(RCCar.Skate) do
			Citizen.Wait(5)
		end
		SetVehicleHandlingFloat(RCCar.Entity,"CHandlingData","fSuspensionForce",1.5)
		SetVehicleEngineTorqueMultiplier(RCCar.Entity,0.1)
		SetEntityNoCollisionEntity(RCCar.Entity,ped,false)
		SetEntityVisible(RCCar.Entity,false)
		SetAllVehiclesSpawn(RCCar.Entity,true,true,true,true)
		AttachEntityToEntity(RCCar.Skate,RCCar.Entity,GetPedBoneIndex(ped,28422),0.0,0.0,-0.15,0.0,0.0,90.0,true,true,true,true,1,true)
		SetEntityCollision(RCCar.Skate,true,true)
		RCCar.Driver = CreatePed(5,68070371,spawnCoords,spawnHeading,true)
		SetEntityInvincible(RCCar.Driver,true)
		SetEntityVisible(RCCar.Driver,false)
		FreezeEntityPosition(RCCar.Driver,true)
		SetPedAlertness(RCCar.Driver,0.0)
		TaskWarpPedIntoVehicle(RCCar.Driver,RCCar.Entity,-1)
		while not IsPedInVehicle(RCCar.Driver,RCCar.Entity) do
			Citizen.Wait(0)
		end
		RCCar.Attach("place")
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION ATTACH SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
function RCCar.Attach(param)
	local ped = PlayerPedId()
	if not DoesEntityExist(RCCar.Entity) or GetEntityHealth(ped) <= 101 then
		return
	end
	if param == "place" then
		AttachEntityToEntity(RCCar.Entity,ped,GetPedBoneIndex(ped,28422),-0.1,0.0,-0.2,70.0,0.0,270.0,1,1,0,0,2,1)
		TaskPlayAnim(ped,"pickup_object","pickup_low",8.0,-8.0,-1,0,0,false,false,false)
		Citizen.Wait(800)
		DetachEntity(RCCar.Entity,false,true)
		PlaceObjectOnGroundProperly(RCCar.Entity)
	elseif param == "pick" then
		Citizen.Wait(100)
		TaskPlayAnim(ped,"pickup_object","pickup_low",8.0,-8.0,-1,0,0,false,false,false)
		Citizen.Wait(600)
		AttachEntityToEntity(RCCar.Entity,ped,GetPedBoneIndex(ped,28422),-0.1,0.0,-0.2,70.0,0.0,270.0,1,1,0,0,2,1)
		Citizen.Wait(900)
		DetachEntity(RCCar.Entity)
		DeleteEntity(RCCar.Skate)
		DeleteVehicle(RCCar.Entity)
		DeleteEntity(RCCar.Driver)
		local rand = math.random(1,100)
		if rand > 40 then
			if vSERVER.giveItem("skate", 1) then
				TriggerEvent("Notify","sucesso","Você pegou seu skate de volta.",6000)
			end
		else
			TriggerEvent("Notify","negado","Seu skate quebrou! :(",6000)
		end
		for modelIndex = 1,#RCCar.CachedModels do
			local model = RCCar.CachedModels[modelIndex]
			if IsModelValid(model) then
				SetModelAsNoLongerNeeded(model)
			else
				RemoveAnimDict(model)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION LOADMODEL SKATE
-----------------------------------------------------------------------------------------------------------------------------------------
function RCCar.LoadModels(models)
	for modelIndex = 1, #models do
		local model = models[modelIndex]
		if not RCCar.CachedModels then
			RCCar.CachedModels = {}
		end
		table.insert(RCCar.CachedModels,model)
		if IsModelValid(model) then
			while not HasModelLoaded(model) do
				RequestModel(model)
				Citizen.Wait(10)
			end
		else
			while not HasAnimDictLoaded(model) do
				RequestAnimDict(model)
				Citizen.Wait(10)
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION ATTACH SKATE TO PLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function RCCar.AttachPlayer(toggle)
	local ped = PlayerPedId()
	if toggle then
		TaskPlayAnim(ped,"move_strafe@stealth","idle",8.0,8.0,-1,1,1.0,false,false,false)
		AttachEntityToEntity(ped,RCCar.Entity,20,0.0,0.0,0.98,0.0,0.0,-15.0,true,true,true,true,true,true)
		SetEntityCollision(ped,true,false)
		Attached = true
	elseif not toggle then
		DetachEntity(ped,false,false)
		Attached = false
		StopAnimTask(ped,"move_strafe@stealth","idle",1.0)
	end
end ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blockButtons = false
function vCU.blockButtons(status)
	blockButtons = status
end

Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if blockButtons then
			timeDistance = 4
			DisableControlAction(1,73,true)
			DisableControlAction(1,75,true)
			DisableControlAction(1,29,true)
			DisableControlAction(1,47,true)
			DisableControlAction(1,105,true)
			DisableControlAction(1,187,true)
			DisableControlAction(1,189,true)
			DisableControlAction(1,190,true)
			DisableControlAction(1,188,true)
			DisableControlAction(1,311,true)
			DisableControlAction(1,245,true)
			DisableControlAction(1,257,true)
			DisableControlAction(1,288,true)
			--DisableControlAction(1,37,true)
			DisablePlayerFiring(PlayerPedId(),true)
		end
		Citizen.Wait(timeDistance)
	end
end)
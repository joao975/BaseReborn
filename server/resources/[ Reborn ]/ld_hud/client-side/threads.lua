-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timings = 1000
		if beltLock >= 1 then
			timings = 1
			DisableControlAction(1,75,true)
		end
		
		Citizen.Wait(timings)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHUD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timings = Config.userms
		if IsPedInAnyVehicle(PlayerPedId()) then timings = Config.usermscar end
		if showHud then
			updateDisplayHud()
		end
		Citizen.Wait(timings)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBELT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			if not IsPedOnAnyBike(ped) and not IsPedInAnyHeli(ped) and not IsPedInAnyPlane(ped) then
				timeDistance = 1

				local vehicle = GetVehiclePedIsUsing(ped)
				local speed = GetEntitySpeed(vehicle) * 3.6
				if speed ~= beltSpeed then
					local plate = GetVehicleNumberPlateText(vehicle)

					if ((beltSpeed - speed) >= 75 and beltLock == 0) then
						local fowardVeh = fowardPed(ped)
						local coords = GetEntityCoords(ped)
						SetEntityCoords(ped,coords["x"] + fowardVeh["x"],coords["y"] + fowardVeh["y"],coords["z"] + 1,1,0,0,0)
						SetEntityVelocity(ped,beltVelocity["x"],beltVelocity["y"],beltVelocity["z"])
						ApplyDamageToPed(ped,50,false)

						Citizen.Wait(1)

						SetPedToRagdoll(ped,5000,5000,0,0,0,0)
					end

					beltVelocity = GetEntityVelocity(vehicle)
					beltSpeed = speed
				end
			end
		else
			if beltSpeed ~= 0 then
				beltSpeed = 0
			end

			if beltLock == 1 then
				beltLock = 0
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSHUNGER
-----------------------------------------------------------------------------------------------------------------------------------------
local hunger = 100
AddEventHandler("statusHunger",function(number)
	hunger = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUSTHIRST
-----------------------------------------------------------------------------------------------------------------------------------------
local thirst = 100
AddEventHandler("statusThirst",function(number)
	thirst = parseInt(number)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HUNGER/THIRST
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		local health = GetEntityHealth(ped)

		if health > 101 then
			if hunger >= 10 and hunger <= 20 then
				SetFlash(0,0,500,1000,500)
				SetEntityHealth(ped,health-1)
			elseif hunger <= 9 then
				SetFlash(0,0,500,1000,500)
				SetEntityHealth(ped,health-2)
			end

			if thirst >= 10 and thirst <= 20 then
				SetFlash(0,0,500,1000,500)
				SetEntityHealth(ped,health-1)
			elseif thirst <= 9 then
				SetFlash(0,0,500,1000,500)
				SetEntityHealth(ped,health-2)
			end
		end

		Citizen.Wait(5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MINIMAP
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	Citizen.Wait(5000)
	RequestStreamedTextureDict("circlemap",false)
	while not HasStreamedTextureDictLoaded("circlemap") do
		Citizen.Wait(100)
	end

	AddReplaceTexture("platform:/textures/graphics","radarmasksm","circlemap","radarmasksm")

	SetMinimapClipType(1)

	SetMinimapComponentPosition("minimap","L","B",0.0,0.0,0.158,0.28)
	SetMinimapComponentPosition("minimap_mask","L","B",0.155,0.12,0.080,0.164)
	SetMinimapComponentPosition("minimap_blur","L","B",-0.005,0.021,0.240,0.302)
end)

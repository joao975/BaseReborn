-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 10
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetAudioFlag("DisableFlightMusic",true)
	SetAudioFlag("PoliceScannerDisabled",true)
	local npcControl = Reborn.npcControl()
	while true do
		Citizen.Wait(0)
		SetRandomBoats(false)
		SetGarbageTrucks(false)
		DisableVehicleDistantlights(true)

		-- peds
		SetPedDensityMultiplierThisFrame(npcControl['PedDensity'])
		SetVehicleDensityMultiplierThisFrame(npcControl['VehicleDensity'])
		SetParkedVehicleDensityMultiplierThisFrame(npcControl['ParkedVehicle'])
		
		-- remove Q
		local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        if health >= 101 then
        	DisableControlAction(0,44,true)
        end

		-- agachar
        DisableControlAction(0,36,true)
        if not IsPedInAnyVehicle(ped) then
            RequestAnimSet("move_ped_crouched")
            RequestAnimSet("move_ped_crouched_strafing")
            if IsDisabledControlJustPressed(0,36) then
                if agachar then
                    ResetPedStrafeClipset(ped)
                    ResetPedMovementClipset(ped,0.25)
                    agachar = false
                else
                    SetPedStrafeClipset(ped,"move_ped_crouched_strafing")
                    SetPedMovementClipset(ped,"move_ped_crouched",0.25)
                    agachar = true
                end
            end
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TASERTIME
-----------------------------------------------------------------------------------------------------------------------------------------
local tasertime = false
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		local ped = PlayerPedId()

		if IsPedBeingStunned(ped) then
			timeDistance = 4
			SetPedToRagdoll(ped,7500,7500,0,0,0,0)
		end

		if IsPedBeingStunned(ped) and not tasertime then
			tasertime = true
			timeDistance = 4
			TriggerEvent("cancelando",true)
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE",1.0)
		elseif not IsPedBeingStunned(ped) and tasertime then
			tasertime = false
			Citizen.Wait(7500)
			StopGameplayCamShaking()
			TriggerEvent("cancelando",false)
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS DO DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
    while true do
        SetDiscordAppId(0)
        SetDiscordRichPresenceAsset('nomedoserver')
        SetDiscordRichPresenceAssetText('nomedoserver(aparecer no discord)')
		SetDiscordRichPresenceAction(0, "Conectar No Servidor", "fivem://connect/(ip))")         
		SetDiscordRichPresenceAction(1, "Entrar No Discord", "https://discord.com/...")
		
		local playerCount = 0

		for _, player in ipairs(GetActivePlayers()) do
			if GetPlayerPed(player) then
				playerCount = playerCount+1
			end
		end

		SetRichPresence(playerCount.." jogadores online")

        Citizen.Wait(30000)
    end
end)


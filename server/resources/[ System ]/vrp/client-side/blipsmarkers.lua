-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 10
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	SetAudioFlag("DisableFlightMusic",true)
	SetAudioFlag("PoliceScannerDisabled",true)
	local npcControl = Reborn.npcControl()
	while true do
		Wait(0)
		SetRandomBoats(false)
		SetGarbageTrucks(false)
		DisableVehicleDistantlights(true)

		-- NPC CONTROL
		SetPedDensityMultiplierThisFrame(npcControl['PedDensity'])
		SetVehicleDensityMultiplierThisFrame(npcControl['VehicleDensity'])
		SetParkedVehicleDensityMultiplierThisFrame(npcControl['ParkedVehicle'])
		
		-- REMOVE Q
		local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        if health >= 101 then
        	DisableControlAction(0,44,true)
        end

		-- AGACHAR
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
CreateThread(function()
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
			Wait(7500)
			StopGameplayCamShaking()
			TriggerEvent("cancelando",false)
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS DO DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	local licenseData = Reborn.license()
    while true do
        SetDiscordAppId(0) 						-- Discord API App Id - Pode gerar aqui: https://discord.com/developers/applications/
        SetDiscordRichPresenceAsset("") 		-- Nome do asset registrado do Discordapp Desenvolvedor
        SetDiscordRichPresenceAssetText(GlobalState['Basics']['ServerName'])
		SetDiscordRichPresenceAction(0, "Conectar No Servidor", "fivem://connect/"..(licenseData and licenseData['ip'] or "(IP)"))         
		SetDiscordRichPresenceAction(1, "Entrar No Discord", GlobalState['Basics']['Discord'])
		local playerCount = 0
		for _, player in ipairs(GetActivePlayers()) do
			if GetPlayerPed(player) then
				playerCount = playerCount + 1
			end
		end
		SetRichPresence(playerCount.." jogadores online")
        Wait(30000)
    end
end)


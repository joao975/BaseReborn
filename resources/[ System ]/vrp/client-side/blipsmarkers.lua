-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPATCH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	for i = 1,12 do
		EnableDispatchService(i,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {
	{ 826.79,-972.39,26.25,544,75,"Sport Race",0.4 },
	{ -326.88,-144.29,39.02,544,75,"Bennys",0.4 },
	{ 265.05,-1262.65,29.3,361,4,"Posto de Gasolina",0.4 },
	{ 819.02,-1027.96,26.41,361,4,"Posto de Gasolina",0.4 },
	{ 1208.61,-1402.43,35.23,361,4,"Posto de Gasolina",0.4 },
	{ 1181.48,-330.26,69.32,361,4,"Posto de Gasolina",0.4 },
	{ 621.01,268.68,103.09,361,4,"Posto de Gasolina",0.4 },
	{ 2581.09,361.79,108.47,361,4,"Posto de Gasolina",0.4 },
	{ 175.08,-1562.12,29.27,361,4,"Posto de Gasolina",0.4 },
	{ -319.76,-1471.63,30.55,361,4,"Posto de Gasolina",0.4 },
	{ 1782.33,3328.46,41.26,361,4,"Posto de Gasolina",0.4 },
	{ 49.42,2778.8,58.05,361,4,"Posto de Gasolina",0.4 },
	{ 264.09,2606.56,44.99,361,4,"Posto de Gasolina",0.4 },
	{ 1039.38,2671.28,39.56,361,4,"Posto de Gasolina",0.4 },
	{ 1207.4,2659.93,37.9,361,4,"Posto de Gasolina",0.4 },
	{ 2539.19,2594.47,37.95,361,4,"Posto de Gasolina",0.4 },
	{ 2679.95,3264.18,55.25,361,4,"Posto de Gasolina",0.4 },
	{ 2005.03,3774.43,32.41,361,4,"Posto de Gasolina",0.4 },
	{ 1687.07,4929.53,42.08,361,4,"Posto de Gasolina",0.4 },
	{ 1701.53,6415.99,32.77,361,4,"Posto de Gasolina",0.4 },
	{ 180.1,6602.88,31.87,361,4,"Posto de Gasolina",0.4 },
	{ -94.46,6419.59,31.48,361,4,"Posto de Gasolina",0.4 },
	{ -2555.17,2334.23,33.08,361,4,"Posto de Gasolina",0.4 },
	{ -1800.09,803.54,138.72,361,4,"Posto de Gasolina",0.4 },
	{ -1437.0,-276.8,46.21,361,4,"Posto de Gasolina",0.4 },
	{ -2096.3,-320.17,13.17,361,4,"Posto de Gasolina",0.4 },
	{ -724.56,-935.97,19.22,361,4,"Posto de Gasolina",0.4 },
	{ -525.26,-1211.19,18.19,361,4,"Posto de Gasolina",0.4 },
	{ -70.96,-1762.21,29.54,361,4,"Posto de Gasolina",0.4 },
	{ -434.09,-348.49,34.92,80,35,"Hospital",0.5 },
	{ -1077.14,-845.3,4.89,60,4,"Departamento Policial",0.6 },
	--{ 1851.45,3686.71,34.26,60,4,"Departamento Policial",0.6 },
	--{ -448.18,6011.68,31.71,60,4,"Departamento Policial",0.6 },
	{ 25.68,-1346.6,29.5,52,36,"Loja de Departamento",0.5 },
	{ 2556.47,382.05,108.63,52,36,"Loja de Departamento",0.5 },
	{ 1163.55,-323.02,69.21,52,36,"Loja de Departamento",0.5 },
	{ -707.31,-913.75,19.22,52,36,"Loja de Departamento",0.5 },
	{ -47.72,-1757.23,29.43,52,36,"Loja de Departamento",0.5 },
	{ 373.89,326.86,103.57,52,36,"Loja de Departamento",0.5 },
	{ -3242.95,1001.28,12.84,52,36,"Loja de Departamento",0.5 },
	{ 1729.3,6415.48,35.04,52,36,"Loja de Departamento",0.5 },
	{ 548.0,2670.35,42.16,52,36,"Loja de Departamento",0.5 },
	{ 1960.69,3741.34,32.35,52,36,"Loja de Departamento",0.5 },
	{ 2677.92,3280.85,55.25,52,36,"Loja de Departamento",0.5 },
	{ 1698.5,4924.09,42.07,52,36,"Loja de Departamento",0.5 },
	{ -1820.82,793.21,138.12,52,36,"Loja de Departamento",0.5 },
	{ 1393.21,3605.26,34.99,52,36,"Loja de Departamento",0.5 },
	{ -2967.78,390.92,15.05,52,36,"Loja de Departamento",0.5 },
	{ -3040.14,585.44,7.91,52,36,"Loja de Departamento",0.5 },
	{ 1135.56,-982.24,46.42,52,36,"Loja de Departamento",0.5 },
	{ 1166.0,2709.45,38.16,52,36,"Loja de Departamento",0.5 },
	{ -1487.21,-378.99,40.17,52,36,"Loja de Departamento",0.5 },
	{ -1222.76,-907.21,12.33,52,36,"Loja de Departamento",0.5 },
	{ 1692.62,3759.50,34.70,76,6,"Loja de Armas",0.4 },
	{ 252.89,-49.25,69.94,76,6,"Loja de Armas",0.4 },
	{ 843.28,-1034.02,28.19,76,6,"Loja de Armas",0.4 },
	{ -331.35,6083.45,31.45,76,6,"Loja de Armas",0.4 },
	{ -663.15,-934.92,21.82,76,6,"Loja de Armas",0.4 },
	{ -1305.18,-393.48,36.69,76,6,"Loja de Armas",0.4 },
	{ -1118.80,2698.22,18.55,76,6,"Loja de Armas",0.4 },
	{ 2568.83,293.89,108.73,76,6,"Loja de Armas",0.4 },
	{ -3172.68,1087.10,20.83,76,6,"Loja de Armas",0.4 },
	{ 21.32,-1106.44,29.79,76,6,"Loja de Armas",0.4 },
	{ 811.19,-2157.67,29.61,76,6,"Loja de Armas",0.4 },
	{ -1213.44,-331.02,37.78,207,46,"Banco",0.5 },
	{ -351.59,-49.68,49.04,207,46,"Banco",0.5 },
	{ 313.47,-278.81,54.17,207,46,"Banco",0.5 },
	{ 149.35,-1040.53,29.37,207,46,"Banco",0.5 },
	{ -2962.60,482.17,15.70,207,46,"Banco",0.5 },
	{ -112.81,6469.91,31.62,207,46,"Banco",0.5 },
	{ 1175.74,2706.80,38.09,207,46,"Banco",0.5 },
	{ -51.82,-1111.38,26.44,225,4,"Concessionaria",0.5 },
	--{ 471.99,-1114.81,29.4,225,22,"Concessionaria Importados",0.5 },
	{ -815.12,-184.15,37.57,71,4,"Barbearia",0.5 },
	{ 138.13,-1706.46,29.3,71,4,"Barbearia",0.5 },
	{ -1280.92,-1117.07,7.0,71,4,"Barbearia",0.5 },
	{ 1930.54,3732.06,32.85,71,4,"Barbearia",0.5 },
	{ 1214.2,-473.18,66.21,71,4,"Barbearia",0.5 },
	{ -33.61,-154.52,57.08,71,4,"Barbearia",0.5 },
	{ -276.65,6226.76,31.7,71,4,"Barbearia",0.5 },
	{ 75.35,-1392.92,29.38,73,4,"Loja de Roupas",0.5 },
	{ -710.15,-152.36,37.42,73,4,"Loja de Roupas",0.5 },
	{ -163.73,-303.62,39.74,73,4,"Loja de Roupas",0.5 },
	{ -822.38,-1073.52,11.33,73,4,"Loja de Roupas",0.5 },
	{ -1193.13,-767.93,17.32,73,4,"Loja de Roupas",0.5 },
	{ -1449.83,-237.01,49.82,73,4,"Loja de Roupas",0.5 },
	{ 4.83,6512.44,31.88,73,4,"Loja de Roupas",0.5 },
	{ 1693.95,4822.78,42.07,73,4,"Loja de Roupas",0.5 },
	{ 125.82,-223.82,54.56,73,4,"Loja de Roupas",0.5 },
	{ 614.2,2762.83,42.09,73,4,"Loja de Roupas",0.5 },
	{ 1196.72,2710.26,38.23,73,4,"Loja de Roupas",0.5 },
	{ -3170.53,1043.68,20.87,73,4,"Loja de Roupas",0.5 },
	{ -1101.42,2710.63,19.11,73,4,"Loja de Roupas",0.5 },
	{ 425.6,-806.25,29.5,73,4,"Loja de Roupas",0.5 },
	--{ -1082.22,-247.54,37.77,617,4,"Premium Store",0.6 }, 3407.3,-24.55,2.63

	{1322.88,-1652.58,52.28,75,4,"Tatuagens",0.4},
	{-1151.05,-1425.83,4.95,75,4,"Tatuagens",0.4 },
	{-1152.37,-1426.59,4.95,75,4,"Tatuagens",0.4 },
	{320.71,182.87,103.58,75,4,"Tatuagens",0.4 },
	{322.64,182.25,103.58,75,4,"Tatuagens",0.4 },
	{-3172.58,1074.11,20.82,75,4,"Tatuagens",0.4 },
	{-3171.56,1075.73,20.82,75,4,"Tatuagens",0.4 },
	{1863.28,3747.38,33.03,75,4,"Tatuagens",0.4 },
	{1864.95,3747.55,33.03,75,4,"Tatuagens",0.4 },
	{-293.07,6200.77,31.48,75,4,"Tatuagens",0.4 },
	{-294.64,6200.20,31.48,75,4,"Tatuagens",0.4 },
	{-293.36,6198.48,31.48,75,4,"Tatuagens",0.4 },

	{ -1728.06,-1050.69,1.71,266,4,"Embarcações",0.5 },
	{ 1966.36,3975.86,31.51,266,4,"Embarcações",0.5 },
	{ -776.72,-1495.02,2.29,266,4,"Embarcações",0.5 },
	{ -893.97,5687.78,3.29,266,4,"Embarcações",0.5 },
	{ 453.04,-608.15,28.6,513,4,"Motorista",0.5 },
	{ 239.31,242.81,106.69,67,4,"Transportador",0.5 },
	{ -837.97,5406.55,34.59,285,4,"Lenhador",0.5 },
	{ -1563.32,-975.79,13.02,68,4,"Pescador",0.5 },
	{ -1188.27,2727.94,2.4,68,4,"Pescador",0.5 },
	-- { -1592.68,-1005.43,13.03,68,4,"Venda De Peixes",0.5 },
	{ 11.27,-1599.34,29.38,540,4,"Food Grill",0.5},
	{ 132.6,-1305.06,29.2,93,4,"Bar",0.5 },
	{ -565.14,271.56,83.02,93,4,"Bar",0.5 },
	{ -469.3,-1721.89,18.69,318,4,"Lixeiro",0.7 },
	{ -1482.8, -1029.82, 6.14,489,1,"Salva-vidas",0.7 },
	{ 4.58,-705.95,45.98,351,4,"Escritório",0.7 },
	{ -117.29,-604.52,36.29,351,4,"Escritório",0.7 },
	--{ -826.9,-699.89,28.06,351,4,"Escritório",0.7 }, -- Arrumar mesa
	{ -935.68,-378.77,38.97,351,4,"Escritório",0.7 },
	{ -428.56,-1728.33,19.79,467,11,"Reciclagem",0.6 },
	{ -741.56,5594.94,41.66,36,4,"Teleférico",0.6 },
	{ 454.46,5571.95,781.19,36,4,"Teleférico",0.6 },
	--[[ { -653.38,-852.87,24.51,459,11,"Eletrônicos",0.6 },
	{ 392.7,-831.61,29.3,459,11,"Eletrônicos",0.6 },
	{ -41.37,-1036.79,28.49,459,11,"Eletrônicos",0.6 },
	{ -509.38,278.8,83.33,459,11,"Eletrônicos",0.6 },
	{ 1137.52,-470.69,66.67,459,11,"Eletrônicos",0.6 }, ]]
	{ 408.17,-1635.57,29.3,515,4,"Reboque",0.7 },
	{ 1706.07,4791.75,41.98,515,4,"Reboque",0.7 }

}

Citizen.CreateThread(function()
	for _,v in pairs(blips) do
		local blip = AddBlipForCoord(v[1],v[2],v[3])
		SetBlipSprite(blip,v[4])
		SetBlipAsShortRange(blip,true)
		SetBlipColour(blip,v[5])
		SetBlipScale(blip,v[7])
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(v[6])
		EndTextCommandSetBlipName(blip)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 10
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	StartAudioScene("CHARACTER_CHANGE_IN_SKY_SCENE")
	SetAudioFlag("PoliceScannerDisabled",true)
	local npcControl = Reborn.npcControl()
	while true do
		Citizen.Wait(0)
		RemoveVehiclesFromGeneratorsInArea(65.95 - 5.0,-1719.34 - 5.0,29.32 - 5.0,65.95 + 5.0,-1719.34 + 5.0,29.32 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(115.57 - 5.0,-1758.6 - 5.0,29.34 - 5.0,115.57 + 5.0,-1758.6 + 5.0,29.34 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(-4.02 - 5.0,-1533.7 - 5.0,29.63 - 5.0,-4.02 + 5.0,-1533.7 + 5.0,29.63 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(100.79 - 5.0,-1605.9 - 5.0,29.52 - 5.0,100.79 + 5.0,-1605.9 + 5.0,29.52 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(43.77 - 5.0,-1288.61 - 5.0,29.15 - 5.0,43.77 + 5.0,-1288.61 + 5.0,29.15 + 5.0)
		RemoveVehiclesFromGeneratorsInArea(468.64 - 5.0,-618.07 - 5.0,28.5,468.64 + 5.0,-618.07 + 5.0,28.5)
		ClearAreaOfCops(28.07,-778.45,51.91,2000.0)
		SetRandomBoats(false)
		SetGarbageTrucks(false)
		SetCreateRandomCops(false)
		ClearPlayerWantedLevel(PlayerId())
		SetCreateRandomCopsOnScenarios(false)
		SetCreateRandomCopsNotOnScenarios(false)
		
		DisableVehicleDistantlights(true)
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
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHICLESUPPRESSED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	local SUPPRESSED_MODELS = { "SHAMAL","LUXOR","LUXOR2","JET","LAZER","TITAN","BARRACKS","BARRACKS2","CRUSADER","RHINO","AIRTUG","RIPLEY","PHANTOM","HAULER","RUBBLE","BIFF","TACO","PACKER","TRAILERS","TRAILERS2","TRAILERS3","TRAILERS4","BLIMP","POLMAV","MULE","MULE2","MULE3","MULE4" }
	while true do
		for _,model in next,SUPPRESSED_MODELS do
			SetVehicleModelIsSuppressed(GetHashKey(model),true)
		end
		Wait(10000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STATUS DO DISCORD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
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


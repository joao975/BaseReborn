safeg = Tunnel.getInterface("salvavidas")

----------------------------------------------------------------------------------------
--VARIABLES
----------------------------------------------------------------------------------------

local step = 0;
local car = false
local working = false
local point = 0
local blips = false
local blipssv = false
local has_npc = false
local npc
local roupa = {}
local notifys = false

----------------------------------------------------------------------------------------
--PRINCIPAL THREAD
----------------------------------------------------------------------------------------

Citizen.CreateThread(function ()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        local player_cds = GetEntityCoords(ped)
        local drowning_ped_cds = GetEntityCoords(npc)
        local distance_player_safe = #(player_cds - configs.blipSafeGuard)
        local distance_player_drowning_ped = #(player_cds - drowning_ped_cds)
        if not IsPedInAnyVehicle(ped) then
            if distance_player_safe <= 3 then
                timeDistance = 4
                DrawMarker(27,-1482.82, -1029.91, 6.14-1.0,0,0, 0, 0, 180.0, 130.0, 0.5, 0.5, 0.0, 184, 0, 0, 100, 0, 0, 0, 1)

                if distance_player_safe <= 2 and IsControlJustPressed(0, 38) and not working then
                    startJob()
                    step = 1;
                end
            end
        end

    
        if working then
            local chance_incident = math.random(1, 100)

            if step == 1 then
                safeg.setPlayerObserve()
                point = math.random(#configs.locsSafeGuard)
                blipmapa()
                step = 2;
            elseif step == 2 then
                local x,y,z = table.unpack(GetEntityCoords(ped))
                local dist = Vdist(configs.locsSafeGuard[point][1],configs.locsSafeGuard[point][2],configs.locsSafeGuard[point][3],x,y,z)
                local ultimoveh = GetEntityModel(GetPlayersLastVehicle())
                
                if dist <= 7 then
                    timeDistance = 4
                    DrawText3D(configs.locsSafeGuard[point][1], configs.locsSafeGuard[point][2], configs.locsSafeGuard[point][3], "Pressione ~r~E~w~ para observar!")
                end
                if dist <= 2 then
                    timeDistance = 4
                    if IsControlJustPressed(0, 38) and ultimoveh == -48031959 then
                        safeg.pointObserved()
                        vRP.CarregarObjeto("amb@world_human_binoculars@male@enter" ,"enter" ,"prop_binoc_01" ,50 ,28422)
                        FreezeEntityPosition(ped, true)
                        SetEntityHeading(ped, configs.locsSafeGuard[point][4])
                        Citizen.Wait(5000)
                        ClearPedTasks(ped)
                        FreezeEntityPosition(ped, false)
                        vRP._DeletarObjeto()
                        if chance_incident <= 50 then
                            
                            TriggerEvent("Notify","aviso","Um americano está se afogando, salve-o!",5000)
                            createNpcDrowning()
                            RemoveBlip(blips)
                            blipIncident(npc)
                            safeg.setPlayerIncident()

                            step = 4                           

                        else
                            TriggerEvent("Notify","importante","Nenhum incidente.",5000)
                            step = 3;
                        end
                    elseif IsControlJustPressed(0, 38) then
                        TriggerEvent("Notify","negado","Você precisa estar com uma veiculo de trabalho!",5000)
                    end
                end
                
            elseif step == 3 then
                Citizen.Wait(0)
                RemoveBlip(blips)
                Citizen.Wait(2000)
                TriggerEvent("Notify","importante","Novo local marcado em seu <b>GPS</b>.",5000)
                step = 1;   

            elseif step == 4 then
                timeDistance = 4
                if distance_player_drowning_ped <= 4.0 and IsControlJustPressed(0, 38) then
                    SetEntityAsMissionEntity(npc, true,true)
                    FreezeEntityPosition(npc, false)
                    AttachEntityToEntity(npc, ped, 0, 0.27, -0.12, 0.63-0.4, 0.5, 0.5, 180, false, false, false, false, 2, false)
                    
                    loadAnim("missfinale_c2mcs_1")
                    
                    TaskPlayAnim(ped, dict, anim, 8.0, -8.0, 100000, 49, 0, false, false, false)
                    step = 5
                    TriggerEvent("Notify", "importante", "Saia da água para salvar a vítima.")
                end
                    
            elseif step == 5 then
                timeDistance = 4
                if not IsEntityInWater(ped) and not notifys then
                    TriggerEvent("Notify", "importante", "Pressione <b>E</b> para reanimá-la.")
                    notifys = true
                end

                if not IsEntityInWater(ped) and IsControlJustPressed(0, 38) then
                    -- step = 6 
                    notifys = false
                    DetachEntity(npc,true,true)
                    Citizen.Wait(500)
                    ClearPedTasksImmediately(ped)
                    ClearPedTasksImmediately(npc)
    
                    loadAnim("mini@cpr@char_a@cpr_str")
                    loadAnim("switch@trevor@annoys_sunbathers")
    
                    SetEntityHeading(npc, GetEntityHeading(ped)+90.0)
                    SetEntityHeading(ped, GetEntityHeading(ped)+180.0)
                    SetEntityCoords(npc, player_cds.x-0.75, player_cds.y, player_cds.z)
                    TaskPlayAnim(ped, "mini@cpr@char_a@cpr_str","cpr_pumpchest", 8.0, -8.0, 6000, 15, 0.0, false, false, false)
                    TaskPlayAnim(npc, "switch@trevor@annoys_sunbathers","trev_annoys_sunbathers_loop_guy", 8.0, -8.0, 6000, 15, 0.0, false, false, false)
                    Citizen.Wait(5000)
		            ClearPedTasksImmediately(ped)
		            ClearPedTasksImmediately(npc)
                    TaskWanderStandard(npc,10.0,10)

                    RemoveBlip(blips)
                    Citizen.Wait(500)
                    safeg.incidents()
                    TriggerEvent("Notify","importante","Novo local marcado em seu <b>GPS</b>.",5000) 

                    step = 1

                end

            end
        end
        Citizen.Wait(timeDistance)
    end
end)
----------------------------------------------------------------------------------------
--TEXT FUNCTIONS
----------------------------------------------------------------------------------------

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.20, 0.20)
    SetTextFont(8)
    SetTextOutline()
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end
----------------------------------------------------------------------------------------
--NPC FUNCTIONS
----------------------------------------------------------------------------------------
function createNpcDrowning()
    local npc_drowning = {"a_f_m_beach_01", "a_f_m_bodybuild_01", "a_f_m_fatcult_01", "a_f_y_beach_01", "a_f_y_topless_01", "a_m_m_beach_02", "a_m_y_beach_03", "a_m_y_jetski_01"}
    local random_ped = math.random(1, #npc_drowning)
    local dict = "dam_ko"
    local anim = "drown"

    RequestModel(npc_drowning[random_ped])

    while not HasModelLoaded(npc_drowning[random_ped]) do
        Citizen.Wait(100)
    end
    
    npc = CreatePed(1, npc_drowning[random_ped], configs.drownings[point][1], configs.drownings[point][2], configs.drownings[point][3], 231.68, false, true)--SOS
    SetBlockingOfNonTemporaryEvents(npc, true)
    
    RequestAnimDict(dict)
    
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
    
    TaskPlayAnim(npc, dict, anim, 8.0, 8.0, -1, 1, 10, 0, 0, 0)
    FreezeEntityPosition(npc, true)
    SetEntityInvincible(npc, true)
end

----------------------------------------------------------------------------------------
--BLIP FUNCTIONS
----------------------------------------------------------------------------------------

function blipmapa()
	blips = AddBlipForCoord(configs.locsSafeGuard[point][1],configs.locsSafeGuard[point][2],configs.locsSafeGuard[point][3])
	SetBlipSprite(blips,472)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.8)
	SetBlipAsShortRange(blips,false)
	SetBlipRoute(blips,true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Base")
	EndTextCommandSetBlipName(blips)
end

function blipIncident(npc)
    x,y,z = table.unpack(GetEntityCoords(npc))
	blips = AddBlipForCoord(x,y,z)
	SetBlipSprite(blips,280)
	SetBlipColour(blips,1)
	SetBlipScale(blips,0.8)
	SetBlipAsShortRange(blips,false)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Ocorrência!")
	EndTextCommandSetBlipName(blips)
end
----------------------------------------------------------------------------------------
--VEHICLE FUNCTIONS
----------------------------------------------------------------------------------------

function spawnGuardVehicle(name,x,y,z)
	local mhash = GetHashKey(name)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end 
	
	if HasModelLoaded(mhash) then
		local checkPos = GetClosestVehicle(x,y,z,2.502,0,71)
		if DoesEntityExist(checkPos) and checkPos ~= nil then
			TriggerEvent("Notify","aviso","Todas as vagas estão ocupadas no momento.",10000)
			return false
		else	
			local nveh = CreateVehicle(mhash,x,y,z,229.9898223877,true,false)
			local netveh = VehToNet(nveh)
			local id = NetworkGetNetworkIdFromEntity(nveh)

			NetworkRegisterEntityAsNetworked(nveh)
			while not NetworkGetEntityIsNetworked(nveh) do
				NetworkRegisterEntityAsNetworked(nveh)
				Citizen.Wait(1)
			end

			if NetworkDoesNetworkIdExist(netveh) then
				SetEntitySomething(nveh,true)
				if NetworkGetEntityIsNetworked(nveh) then
					SetNetworkIdExistsOnAllMachines(netveh,true)
				end
			end

			SetNetworkIdCanMigrate(id,true)
            local plate = "SAFEGUAD"
            SetVehicleEngineHealth(nveh,1000.0)
            SetVehicleBodyHealth(nveh,1000.0)
            SetVehicleFuelLevel(nveh,100.0)
			SetVehicleNumberPlateText(NetToVeh(netveh),plate)
            TriggerServerEvent("setPlateEveryone",plate)
			Citizen.InvokeNative(0xAD738C3085FE7E11,NetToVeh(netveh),true,true)
			SetVehicleHasBeenOwnedByPlayer(NetToVeh(netveh),true)
			SetVehicleNeedsToBeHotwired(NetToVeh(netveh),false)
			SetModelAsNoLongerNeeded(mhash)
			return true
		end
	end
end


function loadAnim(dict) 
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(100)
    end
end
----------------------------------------------------------------------------------------
--FUNCTIONS 
----------------------------------------------------------------------------------------
function startJob()

    local checkPos = GetClosestVehicle(-1480.03, -1033.39, 5.99,2.502,0,71)
	if DoesEntityExist(checkPos) and checkPos ~= nil then
		TriggerEvent("Notify","aviso","Todas as vagas estão ocupadas no momento.",10000)
        TriggerEvent("Notify", "negado", "Você precisa do veículo para trabalhar!", 5000)

		return false
    else
        working = true        
        vehicle = spawnGuardVehicle('blazer2',-1480.03, -1033.39, 5.99)
    end

    roupas = getCustomizationPlayer()
end

Citizen.CreateThread(function()
	while true do
        local otimizadasso = 1000

		if working then
            otimizadasso = 1
            drawTxt_le("PRESSIONE ~r~F7~w~ SE DESEJA FINALIZAR O EXPEDIENTE",4,0.24,0.922,0.4,255,255,255,237)
			if IsControlJustPressed(0,168) then
                safeg.paymentsv()
                working = false
                RemoveBlip(blips)
                TriggerEvent("Notify", "aviso", "Serviço finalizado.", 5000)
                vehicle = GetClosestVehicle(-1480.03, -1033.39, 5.99,2.502,'blazer2',71)
                if DoesEntityExist(vehicle) and vehicle ~= nil then
                    DeleteVehicle(vehicle)
                end
                step = 0
                originalClothes()
			end
		end

        Citizen.Wait(otimizadasso)
	end
end)

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then
        ClearPedTasksImmediately(npc)
        DetachEntity(npc,true,true)
        TaskWanderStandard(npc,10.0,10)
    end
end)

compvalue = {
    [1] = 'mascara',
    [3] = 'maos',
    [4] = 'calca',
    [5] = 'mochila',
    [6] = 'sapato',
    [7] = 'acessorios',
    [8] = 'blusa',
    [9] = 'colete',
    [10] = 'adesivo',
    [11] = 'jaquetas',
    ['p0'] = 'chapeu',
    ['p1'] = 'oculos',
}
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION COSTUMIZE CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function getCustomizationPlayer()
    TriggerEvent("Notify", "aviso", "Aqui está seu uniforme. Quando finalizar te entregarei suas roupas.", 5000)
    local ped = PlayerPedId()
    local custom = {}

    for i = 0,20 do
        custom[i] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
    end

    for i = 0,10 do
        custom["p"..i] = { GetPedPropIndex(ped,i),math.max(GetPedPropTextureIndex(ped,i),0) }
    end
    vRP._playAnim(false, {{'clothingshirt','try_shirt_positive_d'}}, true)

    local pealado = {
        ['male'] = {
            [1] = {0,0},
            [3] = {15,0},
            [4] = {18, 3},
            [5] = {0,0},
            [6] = {67,3},
            [7] = {0,0},
            [8] = {135,0},
            [9] = {0,0},
            [10] = {0,0},
            [11] = {15,0},
            ['p0'] = {-1,0},
            ['p1'] = {5,0},
        },
        ['female'] = {
            [1] = {0,0},
            [3] = {15,0},
            [4] = {10,15},
            [5] = {-1,0},
            [6] = {16,0},
            [7] = {0,0},
            [8] = {6,0},
            [9] = {0,0},
            [10] = {18,0},
            [11] = {18,0},
            ['p0'] = {-1,0},
            ['p1'] = {-1,0},
        }
    }
    for k,v in next,custom do
        if compvalue[k] then
            if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
                if tonumber(k) then
                    SetPedComponentVariation(ped,k,pealado['male'][k][1],pealado['male'][k][2],0)
                -- elseif k == "p1" then
                --     ClearPedProp(ped,1)
                elseif k == "p0" then
                    ClearPedProp(ped,0)
                end
            elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
                if tonumber(k) then
                    SetPedComponentVariation(ped,k,pealado['female'][k][1],pealado['female'][k][2],0)
                -- elseif k == "p1" then
                --     ClearPedProp(ped,1)
                elseif k == "p0" then
                    ClearPedProp(ped,0)
                end
            end
            Citizen.Wait(500)
        end
    end
    vRP._stopAnim(false)
    TriggerEvent("vrp_clothes:updateClothes")
    return custom
end


function originalClothes()
    local ped = PlayerPedId()
    vRP._playAnim(false, {{'clothingshirt','try_shirt_positive_d'}}, true)

    for k,v in next,roupas do
        if compvalue[k] then
            if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
                if tonumber(k) then
                    SetPedComponentVariation(ped,k,roupas[k][1],roupas[k][2],0)
                elseif k == "p1" then
                    SetPedPropIndex(ped,1,roupas[k][1],roupas[k][2],2)
                elseif k == "p0" then
                    SetPedPropIndex(ped,0,roupas[k][1],roupas[k][2],2)
                end
            elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
                if tonumber(k) then
                    SetPedComponentVariation(ped,k,roupas[k][1],roupas[k][2],0)
                elseif k == "p1" then
                    SetPedPropIndex(ped,1,roupas[k][1],roupas[k][2],2)
                elseif k == "p0" then
                    SetPedPropIndex(ped,0,roupas[k][1],roupas[k][2],2)
                end
            end
            Citizen.Wait(500)
        end
    end
    TriggerEvent("vrp_clothes:updateClothes")
    vRP._stopAnim(false)
end

function drawTxt_le(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

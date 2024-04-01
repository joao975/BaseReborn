local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")

dvSERVER = Tunnel.getInterface("Desmanche")

rbn = {}
Tunnel.bindInterface("Desmanche", rbn)

vRP = Proxy.getInterface("vRP")
vRPclient = Proxy.getInterface("vRP")

---------------------------------------------------------------------
-- CONFIG
---------------------------------------------------------------------
-- FV
local IniciarServico = Farms.desmanche.IniciarServico
local LocalDesmancharCarro = Farms.desmanche.LocalDesmancharCarro
local LocalFerramentas = Farms.desmanche.LocalFerramentas
local AnuncioChassi = Farms.desmanche.AnuncioChassi
local Computador = Farms.desmanche.Computador
---------------------------------------------------------------------
--VARIAVEIS
---------------------------------------------------------------------
local blips = {}

local permitido = true
local etapa = 0 
local PosVeh = {}
local PecasRemovidas = {}
local TipoVeh = ''
local qtdPecasRemovidas = 0
local PecasVeh = 0
local placa = nil
    local veh = nil
---------------------------------------------------------------------
-- CODIGO
---------------------------------------------------------------------

Citizen.CreateThread(function() 
    lepitopi = CreateObject(GetHashKey("prop_laptop_lester"),Computador[1], Computador[2], Computador[3]-0.97,true,true,true)
    SetEntityHeading(lepitopi, Computador[4])
    while true do
        local trava = 3000
        local ped = PlayerPedId()
        local pedCoords = GetEntityCoords(ped)
        if etapa == 0 then
            local dist = Vdist(pedCoords, IniciarServico[1], IniciarServico[2], IniciarServico[3])
            if dist < 10 then
                trava = 4
                --DrawMarker(21, IniciarServico[1], IniciarServico[2], IniciarServico[3]-0.5, 0, 0, 0, 180.0, 0, 0, 0.4, 0.4, 0.4, 207, 158, 25, 150, 0, 0, 0, 1)
                if dist < 1 then
                    trava = 4
                    text3D(IniciarServico[1], IniciarServico[2], IniciarServico[3]-0.5, '~y~[E] ~w~PARA DESMANCHAR O VEÍCULO')
                    if IsControlJustPressed(1,38) then
                        veh = CheckVeiculo(LocalDesmancharCarro[1], LocalDesmancharCarro[2], LocalDesmancharCarro[3])
                        if veh and dvSERVER.CheckPerm() then
                            local VehPermitido, ClasseVeh = CheckClasse(veh)
                            placa = GetVehicleNumberPlateText(veh)
                            nomeCarro = GetDisplayNameFromVehicleModel(GetEntityModel(veh))
                            modeloCarro = GetLabelText(nomeCarro)
                            if VehPermitido then 
                                if CheckVehPermitido(nomeCarro) then
                                    if dvSERVER.CheckItem() then    
                                        if ClasseVeh == 8 then
                                            TipoVeh = 'moto'
                                        else
                                            TipoVeh = 'carro'
                                        end
                                        TriggerEvent('Notify', 'sucesso', 'Veículo identificado: <br>Veículo: <b>' .. modeloCarro .. ' (' .. nomeCarro.. ')</b><br>Placa: <b>'..placa..'</b><br><br>Continue. Pegue as ferramentas para desmanchar o veículo.', 8000)
                                        etapa = 1
                                        FreezeEntityPosition(veh, true)
                                        SetVehicleDoorsLocked(veh, 4)
                                    else
                                        TriggerEvent('Notify', 'negado', 'Você necessita de um <b>'..Farms.desmanche.ItemNecessario..'</b> para iniciar o serviço.', 6000)
                                    end
                                else
                                    TriggerEvent('Notify', 'negado', 'Esse veículo não pode ser desmanchado.', 6000)
                                    etapa = 0
                                    dvSERVER.backIniciado()
                                end
                            else
                                TriggerEvent('Notify', 'negado', 'Esse veículo não pode ser desmanchado.', 6000)
                                etapa = 0
                                dvSERVER.backIniciado()
                            end
                        else 
                            TriggerEvent('Notify', 'negado', 'Não há nenhum carro próximo para ser desmanchado.', 4000)
                        end
                    end
                end
            end
        elseif etapa == 1 then
            local dist = Vdist(pedCoords, LocalFerramentas[1], LocalFerramentas[2], LocalFerramentas[3])
            if dist < 10 then
                trava = 4
                DrawMarker(21, LocalFerramentas[1], LocalFerramentas[2], LocalFerramentas[3]-0.5, 0, 0, 0, 180.0, 0, 0, 0.4, 0.4, 0.4, 207, 158, 25, 150, 0, 0, 0, 1)
                if dist < 1 then
                    trava = 4
                    text3D(LocalFerramentas[1], LocalFerramentas[2], LocalFerramentas[3]-0.5, '~y~[E] ~w~PARA PEGAR AS ~y~FERRAMENTAS')
                    if IsControlJustPressed(0,38) then
                        if TipoVeh == 'carro' then
                            PosVeh['Porta_Direita'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"handle_dside_f"))
                            PosVeh['Porta_Esquerda'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"handle_pside_f"))
                            PosVeh['Roda_EsquerdaFrente'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lf"))
                            PosVeh['Roda_DireitaFrente'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_rf"))
                            PosVeh['Roda_EsquerdaTras'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lr"))
                            PosVeh['Roda_DireitaTras'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_rr"))
                            PosVeh['Capo'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"bumper_f"))
                            PecasVeh = 6
                        else
                            PosVeh['Roda_Frente'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lf"))
                            PosVeh['Roda_Tras'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"wheel_lr"))
                            PosVeh['Banco'] = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh,"chassis_dummy"))
                            PecasVeh = 3
                        end
                        FreezeEntityPosition(ped, true)
                        SetEntityCoords(ped, LocalFerramentas[1], LocalFerramentas[2], LocalFerramentas[3]-0.97)
                        SetEntityHeading(ped, LocalFerramentas[4])
                        vRP._playAnim(false, {"amb@medic@standing@kneel@idle_a", "idle_a"}, true)
                        TriggerEvent('Progress', 5000, 'PEGANDO FERRAMENTAS')

                        Wait(5000)  

                        etapa = 2
                        TriggerEvent('Notify', 'sucesso', 'Você pegou todas as ferramentas, vá e desmanche o veículo.', 6000)
                        FreezeEntityPosition(ped, false)
                        ClearPedTasks(ped)
                    end
                end
            end
        elseif etapa == 2 then
            if qtdPecasRemovidas == PecasVeh then
                etapa = 3
                TriggerEvent('Notify', 'sucesso', 'Veículo desmanchado, vá até a bancada e anuncie o chassi do veículo.', 6000)
            end
            for k , v in pairs(PosVeh) do
                local x,y,z = table.unpack(v)
                if not PecasRemovidas[k] then
                    local dist = Vdist(pedCoords, x,y,z)
                    if dist < 10 then
                        trava = 4
                        DrawMarker(21, x, y, z+1, 0, 0, 0, 180.0, 0, 0, 0.4, 0.4, 0.4, 207, 158, 25, 150, 0, 0, 0, 1)
                        if dist < 1.0 then
                            trava = 4
                            if IsControlJustPressed(0, 38) then
                                TaskTurnPedToFaceEntity(ped,veh,500)
                                Citizen.Wait(500)
                                if k == 'Capo' or k == 'pMalas' then
                                    vRP._playAnim(false, {"mini@repair" , "fixing_a_player"}, true)
                                elseif k == 'Porta_Direita' or k == 'Porta_Esquerda' or k == 'Banco' then
                                    vRP._playAnim(false,{task='WORLD_HUMAN_WELDING'},true)
                                else
                                    vRP._playAnim(false, {"amb@medic@standing@tendtodead@idle_a" , "idle_a"}, true)
                                end
                                Wait(5000)
                                ClearPedTasks(ped)
                                PecasRemovidas[k] = true
                                qtdPecasRemovidas = qtdPecasRemovidas + 1
                                if TipoVeh == 'carro' then
                                    if k == 'Roda_EsquerdaFrente' then
                                        SetVehicleTyreBurst(veh, 0, true, 1000)
                                    elseif k == 'Roda_DireitaFrente' then
                                        SetVehicleTyreBurst(veh, 1, true, 1000)
                                    elseif k == 'Roda_EsquerdaTras' then
                                        SetVehicleTyreBurst(veh, 4, true, 1000)
                                    elseif k == 'Roda_DireitaTras' then
                                        SetVehicleTyreBurst(veh, 5, true, 1000)
                                    elseif k == 'Porta_Direita' then
                                        SetVehicleDoorBroken(veh, 0, true)
                                    elseif k == 'Porta_Esquerda' then
                                        SetVehicleDoorBroken(veh, 1, true)
                                    elseif k == 'Capo' then
                                        SetVehicleDoorBroken(veh, 4, true)
                                    end
                                else
                                    if k == 'Roda_Frente' then
                                        SetVehicleTyreBurst(veh, 0, true, 1000)
                                    elseif k == 'Roda_Tras' then
                                        SetVehicleTyreBurst(veh, 4, true, 1000)
                                    end
                                end
                            end
                        end
                    end
                end
            end
        elseif etapa == 3 then
            local dist = Vdist(pedCoords, AnuncioChassi[1], AnuncioChassi[2], AnuncioChassi[3])
            if dist < 10 then
                trava = 4
                DrawMarker(21, AnuncioChassi[1], AnuncioChassi[2], AnuncioChassi[3]-0.5, 0, 0, 0, 180.0, 0, 0, 0.4, 0.4, 0.4, 207, 158, 25, 150, 0, 0, 0, 1)
                if dist < 1 then
                    trava = 4
                    text3D(AnuncioChassi[1], AnuncioChassi[2], AnuncioChassi[3]-0.5, '~y~[E] ~w~PARA ANUNCIAR O ~y~CHASSI')
                    if IsControlJustPressed(0,38) then
                        FreezeEntityPosition(ped, true)
                        SetEntityCoords(ped, AnuncioChassi[1], AnuncioChassi[2], AnuncioChassi[3]-0.97)
                        SetEntityHeading(ped, AnuncioChassi[4])
                        vRP._playAnim(false, {"anim@heists@prison_heistig1_p1_guard_checks_bus", "loop"}, true)
                        TriggerEvent('Progress', 5000, 'ANUNCIANDO CHASSI DO VEÍCULO')
                        Wait(5000)
                        FreezeEntityPosition(ped, false)
                        ClearPedTasks(ped)
                        dvSERVER.GerarPagamento(placa, nomeCarro, modeloCarro)
                        DeletarVeiculo(veh)
                        etapa = 0 
                        permitido = true
                        PosVeh = {}
                        PecasRemovidas = {}
                        TipoVeh = ''
                        qtdPecasRemovidas = 0
                        PecasVeh = 0
                    end
                end
            end
        end



        if etapa > 0 then
            if IsControlJustPressed(0,168) then
                -- REMOVER TUDO PARA CANCELAMENTO
                etapa = 0
                FreezeEntityPosition(PlayerPedId(), false)
                ClearPedTasks(PlayerPedId())
                if veh then
                    FreezeEntityPosition(veh, false)
                end
                dvSERVER.backIniciado()
                etapa = 0 
                PosVeh = {}
                PecasRemovidas = {}
                TipoVeh = ''
                qtdPecasRemovidas = 0
                PecasVeh = 0
                TriggerEvent('Notify', 'aviso', 'Você cancelou o serviço.', 6000)
            end
        end
        Citizen.Wait(trava)
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- Check Classe
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckClasse(veh)
    local classe = GetVehicleClass(veh)
    if classe ~= 0 and classe ~= 1 and classe ~= 2 and classe ~= 3 and classe ~= 4 and classe ~= 5 and classe ~= 6 and classe ~= 7 and classe ~= 8 and classe ~= 9 and classe ~= 11 and classe ~= 12 then
        return false, 0
    else
        return true, classe
    end
end

function CheckVehPermitido(nomeCarro)
    local vehs = dvSERVER.GetVehs()
    for k , v in pairs(vehs) do
        if string.upper(nomeCarro) == string.upper(k) then
            return true
        end
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function text3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)

	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/370
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,80)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VERIFICAR VAGA VAGA
-----------------------------------------------------------------------------------------------------------------------------------------
function CheckVeiculo(x,y,z)
    local check = GetClosestVehicle(x,y,z,5.001,0,71)
    if DoesEntityExist(check) then
        return check
    end
    return false
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETAR VEICULO
-----------------------------------------------------------------------------------------------------------------------------------------
function DeletarVeiculo( veh )
    TriggerServerEvent("will_garages_v2:syncDeleteVehicle",VehToNet(veh))
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAW TXT
-----------------------------------------------------------------------------------------------------------------------------------------
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

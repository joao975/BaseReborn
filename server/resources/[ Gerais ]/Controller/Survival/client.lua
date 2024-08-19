-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
svVRP = {}
Tunnel.bindInterface("Survival",svVRP)
svSERVER = Tunnel.getInterface("Survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local deadPlayer = false
local finalizado = false
local deathtimer = 50
local blockControls = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADHEALTH
-----------------------------------------------------------------------------------------------------------------------------------------
local inGame = false
RegisterNetEvent("will_pvp:inGame")
AddEventHandler("will_pvp:inGame",function(status)
	inGame = status
end)

CreateThread(function()
	SetPedMaxHealth(PlayerPedId(),400)
	while true do
		local timeDistance = 200
		local ped = PlayerPedId()
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		if GetEntityHealth(ped) <= 101 and deathtimer >= 0 then
			if not deadPlayer then
				timeDistance = 100
				deadPlayer = true
				local coords = GetEntityCoords(ped)
				NetworkResurrectLocalPlayer(coords,true,true,false)
				deathtimer = 60

				if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
					vRP.playAnim(false,{"dead","dead_a"},true)
				end
				SetEntityHealth(ped,101)
				SetEntityInvincible(ped,true)

				TriggerEvent("radio:outServers")
				TriggerServerEvent("vrp_inventory:Cancel")
				TriggerServerEvent("pma-voice:toggleMute",true)
			else
				if deathtimer > 0 then
					timeDistance = 4
					SetEntityHealth(ped,101)
					drawTxt("AGUARDE: ~r~"..deathtimer.."~w~ SEGUNDOS.",4,0.5,0.93,0.50,255,255,255,120)
					if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
						vRP.playAnim(false,{"dead","dead_a"},true)
					end
				else
					timeDistance = 4
					drawTxt("DIGITE ~r~/GG~w~.",4,0.5,0.93,0.50,255,255,255,120)
					if not IsEntityPlayingAnim(ped,"dead","dead_a",3) and not IsPedInAnyVehicle(ped) then
						vRP.playAnim(false,{"dead","dead_a"},true)
					end
				end
			end
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEATHTIMER
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		Wait(1000)
		if deadPlayer and deathtimer > 0 then
			deathtimer = deathtimer - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("gg",function(source,args,rawCommand)
	if deathtimer <= 0 then
		svSERVER.ResetPedToHospital()
	else
		TriggerEvent("Notify","aviso","AGUARDE: <b>"..deathtimer.."</b> OU CHAME OS <b>PARAMÉDICOS</b>.",5000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHDEATH
-----------------------------------------------------------------------------------------------------------------------------------------
function svVRP.finishDeath()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) <= 101 then
		deadPlayer = false
		TriggerServerEvent("pma-voice:toggleMute",false)
		ClearPedBloodDamage(ped)
		SetEntityHealth(ped,400)
		SetEntityInvincible(ped,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function svVRP.deadPlayer()
	return deadPlayer
end

function svVRP.finalizado()
	return finalizado
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REVIVEPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function svVRP.revivePlayer(health)
	SetEntityHealth(PlayerPedId(),health)
	SetEntityInvincible(PlayerPedId(),false)
	TriggerServerEvent("pma-voice:toggleMute",false)
	if deadPlayer then
		deadPlayer = false
		ClearPedTasks(PlayerPedId())
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_survival:CheckIn")
AddEventHandler("vrp_survival:CheckIn",function()
	SetEntityHealth(PlayerPedId(),102)
	SetEntityInvincible(PlayerPedId(),false)

	Wait(500)
	TriggerServerEvent("pma-voice:toggleMute",false)
	deadPlayer = false
	blockControls = true
end)

RegisterNetEvent("vrp_survival:finalizado")
AddEventHandler("vrp_survival:finalizado",function()
	deadPlayer = true
	deathtimer = 30
	finalizado = true
end)

RegisterNetEvent("vrp_survival:royaleDead")
AddEventHandler("vrp_survival:royaleDead",function()
	deathtimer = 30
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLOCKCONTROLS
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if blockControls or (deadPlayer and not inGame and not LocalPlayer.state.inPvp) then
			timeDistance = 4
			DisablePlayerFiring(ped,true)
			DisableControlAction(1,22,true) -- SPACEBAR
			DisableControlAction(1,29,true) -- B
			DisableControlAction(1,47,true) -- G
			DisableControlAction(1,73,true) -- X
			DisableControlAction(1,75,true) -- F
			DisableControlAction(1,105,true) -- X
			DisableControlAction(1,167,true) -- F6
			DisableControlAction(1,182,true) -- L
			DisableControlAction(1,187,true) -- ARROW DOWN
			DisableControlAction(1,188,true) -- ARROW UP
			DisableControlAction(1,189,true) -- ARROW LEFT
			DisableControlAction(1,190,true) -- ARROW RIGHT
			DisableControlAction(1,257,true) -- LEFT MOUSE
			DisableControlAction(1,288,true) -- F1
			DisableControlAction(1,311,true) -- K
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTCURE
-----------------------------------------------------------------------------------------------------------------------------------------
local cure = false
function svVRP.startCure()
	local ped = PlayerPedId()
	if cure then
		return
	end
	cure = true
	TriggerEvent("Notify","sucesso","O tratamento começou, espere o paramédico libera-lo.",3000)
	if cure then
		repeat
			Wait(1000)
			if GetEntityHealth(ped) > 101 then
				SetEntityHealth(ped,GetEntityHealth(ped)+1)
			end
		until GetEntityHealth(ped) >= 400 or GetEntityHealth(ped) <= 101
			TriggerEvent("Notify","sucesso","Tratamento concluído.",3000)
			deadPlayer = false
			cure = false
			blockControls = false
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BEDS
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	{ GetHashKey("v_med_bed1"),0.0,0.0 },
	{ GetHashKey("v_med_bed2"),0.0,0.0 },
	{ -1498379115,1.0,90.0 },
	{ -1519439119,1.0,0.0 },
	{ -289946279,1.0,0.0 }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETPEDINBED
-----------------------------------------------------------------------------------------------------------------------------------------
function svVRP.SetPedInBed()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(x,y,z,0.9,v[1],0,0,0)
		if DoesEntityExist(object) then
			local x2,y2,z2 = table.unpack(GetEntityCoords(object))
			
			SetEntityCoords(ped,x2,y2,z2+v[2])
			SetEntityHeading(ped,GetEntityHeading(object)+v[3]-180.0)

			vRP.playAnim(false,{"dead","dead_a"},true)

			SetTimeout(7000,function()
				TriggerServerEvent("vrp_inventory:Cancel")
			end)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SCREENFADEINOUT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_survival:FadeOutIn")
AddEventHandler("vrp_survival:FadeOutIn",function()
	DoScreenFadeOut(1000)
	Wait(5000)
	DoScreenFadeIn(1000)
end)

RegisterNetEvent("vrp_survival:desbugar")
AddEventHandler("vrp_survival:desbugar",function()
	blockControls = false
	deadPlayer = false
	if GetScreenEffectIsActive("DeathFailOut") then
		StopScreenEffect("DeathFailOut")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTXT
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
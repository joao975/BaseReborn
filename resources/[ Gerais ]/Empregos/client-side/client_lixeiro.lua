-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
lxVRP = {}
Tunnel.bindInterface("lixeiro",lxVRP)
vlSERVER = Tunnel.getInterface("lixeiro")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local blips = {}
local timeSeconds = 0
local garbageList = {}
local inService = false
local vehModel = 1917016601
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGARBAGE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadgarbage()
	Citizen.CreateThread(function()
		while true do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if not IsPedInAnyVehicle(ped) then
					local coords = GetEntityCoords(ped)

					for k,v in pairs(garbageList) do
						local distance = #(coords - vector3(v[1],v[2],v[3]))
						if distance <= 30 then
							timeDistance = 4
							DrawMarker(21,v[1],v[2],v[3]-0.6,0,0,0,0.0,0,0,0.5,0.5,0.4,100,185,230,50,0,0,0,1)
							if distance <= 0.6 and IsControlJustPressed(1,38) and timeSeconds <= 0 and GetEntityModel(GetPlayersLastVehicle()) == vehModel then
								timeSeconds = 2
								vlSERVER.paymentMethodGarbage(parseInt(k))
							end
						end
					end
				end
			end

			Citizen.Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
function lxVRP.getGarbageStatus()
	return inService
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped) and not inService then
			local coords = GetEntityCoords(ped)
			local garbageCoord = configs.garbage.init
			local distance = #(coords - vector3(garbageCoord[1],garbageCoord[2],garbageCoord[3]))
			if distance <= 2.5 then
				timeDistance = 4
				DrawText3D(garbageCoord[1],garbageCoord[2],garbageCoord[3],"~g~E~w~ INICIAR LIXEIRO",450)
				if distance <= 1.5 and IsControlJustPressed(1,38) then
					inService = true
					startthreadgarbage()
					startthreadgarbageseconds()
					vlSERVER.startGargage()
					Citizen.Wait(5000)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- STOPGARBAGEMAN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local will = 500
		if inService then
			will = 4
			drawTxt_le("PRESSIONE ~r~F7~w~ SE DESEJA FINALIZAR O EXPEDIENTE",4,0.24,0.922,0.4,255,255,255,237)
			if IsControlJustPressed(1,168) then
				inService = false
				for k,v in pairs(blips) do
					if DoesBlipExist(blips[k]) then
						RemoveBlip(blips[k])
						blips[k] = nil
					end
				end
				TriggerEvent("Notify","negado","Emprego de lixeiro finalizado.",5000)
			end
		end
		Citizen.Wait(will)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEGARBAGELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_garbageman:updateGarbageList")
AddEventHandler("vrp_garbageman:updateGarbageList",function(status)
	garbageList = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATEGARBAGELIST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_garbageman:removeGarbageBlips")
AddEventHandler("vrp_garbageman:removeGarbageBlips",function(number)
	if DoesBlipExist(blips[number]) then
		RemoveBlip(blips[number])
		blips[number] = nil
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INSERTBLIPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_garbageman:insertBlips")
AddEventHandler("vrp_garbageman:insertBlips",function(statusList)
	if inService then
		for k,v in pairs(blips) do
			if DoesBlipExist(blips[k]) then
				RemoveBlip(blips[k])
				blips[k] = nil
			end
		end

		Citizen.Wait(1000)

		for k,v in pairs(statusList) do
			blips[k] = AddBlipForRadius(v[1],v[2],v[3],10.0)
			SetBlipAlpha(blips[k],255)
			SetBlipColour(blips[k],57)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadgarbageseconds()
	Citizen.CreateThread(function()
		while true do
			if timeSeconds > 0 then
				timeSeconds = timeSeconds - 1
			end
			Citizen.Wait(1000)
		end
	end)
end
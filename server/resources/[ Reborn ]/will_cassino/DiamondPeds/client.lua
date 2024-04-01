local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

local npcLocal = Config.npcLocal
local wantNpc = Config.npc
local wantAll = Config.details

Citizen.CreateThread(function()
	if wantAll then
		if wantNpc then
			for _,v in pairs(npcLocal) do
                RequestModel(v[5])
                while not HasModelLoaded(v[5]) do
                    Wait(1)
                end
            
                RequestAnimDict("mini@strip_club@idles@bouncer@base")
                while not HasAnimDictLoaded("mini@strip_club@idles@bouncer@base") do
                    Wait(1)
                end
                ped =  CreatePed(4, v[5],v[1],v[2],v[3]-1, 3374176, false, true)
                SetEntityHeading(ped, v[4])
                FreezeEntityPosition(ped, true)
                SetEntityInvincible(ped, true)
                SetBlockingOfNonTemporaryEvents(ped, true)
                TaskPlayAnim(ped,"mini@strip_club@idles@bouncer@base","base", 8.0, 0.0, -1, 1, 0, 0, 0, 0)
			end
		end
	end
end)

local heading = 254.5
local vehicle = nil

Citizen.CreateThread(function()
	if wantAll then
		while true do
			Citizen.Wait(4)
			if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 935.08,42.41,72.53, true) < 20 then
				if DoesEntityExist(vehicle) == false then
					RequestModel(GetHashKey(Config.car))
					while not HasModelLoaded(GetHashKey(Config.car)) do
						Wait(1)
					end
					vehicle = CreateVehicle(GetHashKey(Config.car), 935.08,42.41,72.53, heading, false, false)
					FreezeEntityPosition(vehicle, true)
					SetEntityInvincible(vehicle, true)
					SetEntityCoords(vehicle,935.08,42.41,72.53, false, false, false, true)
				else
					SetEntityHeading(vehicle, heading)
					heading = heading+0.2
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	if wantAll then
		while true do
			Citizen.Wait(10000)
			if vehicle ~= nil and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), 935.08,42.41,72.53, true) < 20 then
				SetEntityCoords(vehicle, 935.08,42.41,72.53, false, false, false, true)
			end
		end
	end
end)
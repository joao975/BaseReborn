-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
robRP = {}
Tunnel.bindInterface("Roubos",robRP)
vgSERVER = Tunnel.getInterface("Roubos")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local startRobbery = false
local robberyTimer = 0
local robberyId = 0
local vars = Config.gerais
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADINIT
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(vars) do
				local distance = #(coords - vector3(v.x,v.y,v.z))
				if distance <= v.distance then
					timeDistance = 4

					--[[ if not startRobbery then
						if distance <= 2 then
							DrawText3D(v.x,v.y,v.z-0.4,"~g~E~w~   ROUBAR",400)
							if distance <= 1.5 and IsControlJustPressed(1,38) and vgSERVER.checkPolice(k,coords) then
								robberyId = k
								startRobbery = true
								robberyTimer = v.time
								SetPedComponentVariation(ped,5,45,0,2)
							end
						end
					else
						DrawText3D(v.x,v.y,v.z-0.4,"AGUARDE  ~b~"..robberyTimer.."~w~  SEGUNDOS",370)
					end ]]
				end
			end

			if startRobbery then
				local distance = #(coords - vector3(vars[robberyId].x,vars[robberyId].y,vars[robberyId].z))
				if distance > vars[robberyId].distance or GetEntityHealth(ped) <= 101 then
					startRobbery = false
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)

Citizen.CreateThread(function()
	for k,v in pairs(vars) do
		exports["target"]:AddCircleZone("Robbery:0"..k,vector3(v.x,v.y,v.z),0.75,{
			name = "Robbery:0"..k,
			heading = 3374176
		},{
			distance = 2.5,
			options = {
				{
					event = "robbery:startRobbery",
					label = "Roubar",
					tunnel = "robbery",
					service = k
				}
			}
		})
	end
end)

RegisterNetEvent("robbery:startRobbery")
AddEventHandler("robbery:startRobbery",function(k)
	if not startRobbery then
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if vgSERVER.checkPolice(parseInt(k),coords) then
			local v = vars[k]
			robberyId = parseInt(k)
			startRobbery = true
			robberyTimer = v.time
			TriggerEvent("Progress",parseInt(v.time)*1000)
			SetPedComponentVariation(ped,5,45,0,2)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		if startRobbery then
			if robberyTimer > 0 then
				robberyTimer = robberyTimer - 1
				if robberyTimer <= 0 then
					startRobbery = false
					vgSERVER.paymentMethod(robberyId)
				end
			end
		end
		Citizen.Wait(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text,height)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / height
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
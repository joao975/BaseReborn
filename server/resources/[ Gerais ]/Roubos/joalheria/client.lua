-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vjSERVER = Tunnel.getInterface("joalheria")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local jewelryStart = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- JEWELRYROBBERY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)

		if not jewelryStart then

			for k,v in pairs(Config.jewelry.bombLocs) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 4
					DrawText3Ds(v[1],v[2],v[3],"~g~G~w~   ROUBAR")
					if IsControlJustPressed(1,47) and vjSERVER.jewelryCheckItens() then
						SetEntityHeading(ped,v[4])
						TriggerEvent("cancelando",true)
						SetEntityCoords(ped,v[1]-0.45,v[2]-0.45,v[3]-1)
						vRP._playAnim(false,{"anim@amb@clubhouse@tutorial@bkr_tut_ig3@","machinic_loop_mechandplayer"},true)
						Citizen.Wait(10000)
						vRP.removeObjects()
						TriggerEvent("cancelando",false)

						local mHash = GetHashKey("prop_c4_final_green")

						RequestModel(mHash)
						while not HasModelLoaded(mHash) do
							RequestModel(mHash)
							Citizen.Wait(10)
						end

						local bomb = CreateObjectNoOffset(mHash,v[1],v[2],v[3]-0.3,true,false,false)
						SetEntityAsMissionEntity(bomb,true,true)
						FreezeEntityPosition(bomb,true)
						SetEntityHeading(bomb,v[4])
						SetModelAsNoLongerNeeded(mHash)

						Citizen.Wait(20000)

						TriggerServerEvent("doors:doorsStatistics",20,false)
						TriggerServerEvent("tryDeleteEntity",ObjToNet(bomb))
						AddExplosion(v[1],v[2],v[3],2,100.0,true,false,true)
						vjSERVER.jewelryUpdateStatus(true)
					end
				end
			end
		--[[ else
			for k,v in pairs(Config.jewelry.safeLocs) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2 then
					timeDistance = 4
					DrawText3Ds(v[1],v[2],v[3],"~g~E~w~   ROUBAR")
					if distance <= 0.6 and IsControlJustPressed(1,38) then
						SetEntityHeading(ped,v[4])
						vjSERVER.openDrawer(k)
						SetPedComponentVariation(ped,5,45,0,2)
					end
				end
			end ]]
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JEWELRYFUNCTIONSTART
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vrp_jewelry:jewelryFunctionStart")
AddEventHandler("vrp_jewelry:jewelryFunctionStart",function(status)
	jewelryStart = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3Ds(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/400
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end
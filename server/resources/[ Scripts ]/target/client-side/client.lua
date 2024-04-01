-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Zones = {}
local Models = {}
local innerEntity = {}
local sucessTarget = false
local targetActive = false

local LocalPlayer = {}
LocalPlayer["state"] = {}

RegisterNetEvent("target:setState")
AddEventHandler("target:setState",function(state, status)
	LocalPlayer["state"][state] = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSYSTEM
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	RegisterCommand("+entityTarget",playerTargetEnable)
	RegisterCommand("-entityTarget",playerTargetDisable)
	RegisterKeyMapping("+entityTarget","Interação auricular.","keyboard","LMENU")

	AddCircleZone("bankSalary01",vector3(241.43,225.46,106.29),0.75,{
		name = "bankSalary01",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary02",vector3(243.21,224.77,106.29),0.75,{
		name = "bankSalary02",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary03",vector3(246.62,223.61,106.29),0.75,{
		name = "bankSalary03",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary04",vector3(248.43,222.95,106.29),0.75,{
		name = "bankSalary04",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary05",vector3(251.79,221.73,106.29),0.75,{
		name = "bankSalary05",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary06",vector3(253.59,221.08,106.29),0.75,{
		name = "bankSalary06",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary07",vector3(-113.01,6470.21,31.63),0.75,{
		name = "bankSalary07",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary08",vector3(-111.99,6469.15,31.63),0.75,{
		name = "bankSalary08",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("bankSalary09",vector3(-110.92,6468.1,31.63),0.75,{
		name = "bankSalary09",
		heading = 3374176
	},{
		distance = 1.0,
		options = {
			{
				event = "bank:openSystem",
				label = "Abrir",
				tunnel = "client"
			},{
				event = "vRP:receiveSalary",
				label = "Receber",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("treatment01",vector3(-253.92,6331.07,32.42),0.75,{
		name = "treatment01",
		heading = 3374176
	},{
		shop = "Paleto",
		distance = 1.0,
		options = {
			{
				event = "emotes",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment02",vector3(1833.21,3676.09,34.27),0.75,{
		name = "treatment02",
		heading = 3374176
	},{
		shop = "Sandy",
		distance = 1.0,
		options = {
			{
				event = "emotes",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment03",vector3(307.03,-595.12,43.29),0.75,{
		name = "treatment03",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "emotes",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment04",vector3(350.92,-587.68,28.8),0.75,{
		name = "treatment04",
		heading = 3374176
	},{
		shop = "Santos",
		distance = 1.0,
		options = {
			{
				event = "emotes",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment05",vector3(1768.67,2570.59,45.73),0.75,{
		name = "treatment05",
		heading = 3374176
	},{
		shop = "Bolingbroke",
		distance = 1.0,
		options = {
			{
				event = "emotes",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddCircleZone("treatment06",vector3(-469.26,6289.48,13.61),0.75,{
		name = "treatment06",
		heading = 3374176
	},{
		shop = "Clandestine",
		distance = 1.0,
		options = {
			{
				event = "emotes",
				label = "Tratamento",
				tunnel = "shop"
			}
		}
	})

	AddTargetModel({ -1691644768,-742198632 },{
		options = {
			{
				event = "inventory:makeWater",
				label = "Encher",
				tunnel = "server",
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1631638868,2117668672,-1498379115,-1519439119,-289946279 },{
		options = {
			{
				event = "target:animDeitar",
				label = "Deitar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ -171943901,-109356459,1805980844,-99500382,1262298127,1737474779,2040839490,1037469683,867556671,-1521264200,-741944541,-591349326,-293380809,-628719744,-1317098115,1630899471,38932324,-523951410,725259233,764848282,2064599526,536071214,589738836,146905321,47332588,-1118419705,538002882,-377849416,96868307,-1195678770,-853526657,652816835 },{
		options = {
			{
				event = "target:animSentar",
				label = "Sentar",
				tunnel = "client"
			}
		},
		distance = 1.0
	})

	AddTargetModel({ 690372739 },{
		options = {
			{
				event = "shops:coffeeMachine",
				label = "Comprar",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -654402915,1421582485 },{
		options = {
			{
				event = "shops:donutMachine",
				label = "Comprar",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 992069095,1114264700 },{
		options = {
			{
				event = "shops:sodaMachine",
				label = "Comprar",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1129053052 },{
		options = {
			{
				event = "shops:hamburgerMachine",
				label = "Comprar",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ -1581502570 },{
		options = {
			{
				event = "shops:hotdogMachine",
				label = "Comprar",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1099892058 },{
		options = {
			{
				event = "shops:waterMachine",
				label = "Comprar",
				tunnel = "server"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ GetHashKey("prop_till_01") },{
		options = {
			{
				event = "cashRegister:robberyMachine",
				label = "Roubar",
				tunnel = "client"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 684586828,577432224,-206690185,-1587184881,666561306,218085040,-58485588,-1426008804,-228596739,1437508529,-1096777189,1511880420,-468629664,1143474856,-2096124444,682791951,-115771139,1329570871,-130812911, },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Lixeiro"
			}
		},
		distance = 0.75
	})

	AddTargetModel({ 1211559620,1363150739,-1186769817,261193082,-756152956,-1383056703,720581693 },{
		options = {
			{
				event = "inventory:verifyObjects",
				label = "Vasculhar",
				tunnel = "police",
				service = "Jornaleiro"
			}
		},
		distance = 0.75
	})

	AddCircleZone("jewelry01",vector3(-626.67,-238.58,38.05),0.75,{
		name = "jewelry01",
		heading = 3374176
	},{
		shop = "1",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry02",vector3(-625.66,-237.86,38.05),0.75,{
		name = "jewelry02",
		heading = 3374176
	},{
		shop = "2",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry03",vector3(-626.84,-235.35,38.05),0.75,{
		name = "jewelry03",
		heading = 3374176
	},{
		shop = "3",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry04",vector3(-625.83,-234.6,38.05),0.75,{
		name = "jewelry04",
		heading = 3374176
	},{
		shop = "4",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry05",vector3(-626.9,-233.15,38.05),0.75,{
		name = "jewelry05",
		heading = 3374176
	},{
		shop = "5",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry06",vector3(-627.94,-233.92,38.05),0.75,{
		name = "jewelry06",
		heading = 3374176
	},{
		shop = "6",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry07",vector3(-620.22,-234.44,38.05),0.75,{
		name = "jewelry07",
		heading = 3374176
	},{
		shop = "7",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry08",vector3(-619.16,-233.7,38.05),0.75,{
		name = "jewelry08",
		heading = 3374176
	},{
		shop = "8",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry09",vector3(-617.56,-230.57,38.05),0.75,{
		name = "jewelry09",
		heading = 3374176
	},{
		shop = "9",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry10",vector3(-618.29,-229.49,38.05),0.75,{
		name = "jewelry10",
		heading = 3374176
	},{
		shop = "10",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry11",vector3(-619.68,-227.63,38.05),0.75,{
		name = "jewelry11",
		heading = 3374176
	},{
		shop = "11",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry12",vector3(-620.43,-226.56,38.05),0.75,{
		name = "jewelry12",
		heading = 3374176
	},{
		shop = "12",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry13",vector3(-623.92,-227.06,38.05),0.75,{
		name = "jewelry13",
		heading = 3374176
	},{
		shop = "13",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry14",vector3(-624.97,-227.84,38.05),0.75,{
		name = "jewelry14",
		heading = 3374176
	},{
		shop = "14",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry15",vector3(-624.42,-231.08,38.05),0.75,{
		name = "jewelry15",
		heading = 3374176
	},{
		shop = "15",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry16",vector3(-623.98,-228.18,38.05),0.75,{
		name = "jewelry16",
		heading = 3374176
	},{
		shop = "16",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry17",vector3(-621.08,-228.58,38.05),0.75,{
		name = "jewelry17",
		heading = 3374176
	},{
		shop = "17",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry18",vector3(-619.72,-230.43,38.05),0.75,{
		name = "jewelry18",
		heading = 3374176
	},{
		shop = "18",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry19",vector3(-620.14,-233.31,38.05),0.75,{
		name = "jewelry19",
		heading = 3374176
	},{
		shop = "19",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})

	AddCircleZone("jewelry20",vector3(-623.05,-232.95,38.05),0.75,{
		name = "jewelry20",
		heading = 3374176
	},{
		shop = "20",
		distance = 1.0,
		options = {
			{
				event = "robberys:jewelry",
				label = "Roubar",
				tunnel = "server"
			}
		}
	})
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICEMENU
-----------------------------------------------------------------------------------------------------------------------------------------
local policeMenu = {
	{
		event = "ld-inventory:revistar",
		label = "Revistar",
		tunnel = "police"
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARAMEDICMENU
-----------------------------------------------------------------------------------------------------------------------------------------
local paramedicMenu = {
	{
		event = "paramedic:Revive",
		label = "Reanimar",
		tunnel = "paramedic"
	},{
		event = "hospital:diagnostico",
		label = "Diagnóstico",
		tunnel = "paramedic"
	},{
		event = "hospital:tratamento",
		label = "Tratamento",
		tunnel = "paramedic"
	},{
		event = "hospital:sangramento",
		label = "Sangramento",
		tunnel = "paramedic"
	},
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- POLICEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local policeVeh = {
	{
		event = "police:runPlate",
		label = "Verificar Placa",
		tunnel = "police"
	},{
		event = "player:CheckTrunk",
		label = "Vasculhar Porta-Malas",
		tunnel = "server"
	},{
		event = "player:EnterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "server"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERVEH
-----------------------------------------------------------------------------------------------------------------------------------------
local playerVeh = {
	{
		event = "player:CheckTrunk",
		label = "Vasculhar Porta-Malas",
		tunnel = "server"
	},{
		event = "player:EnterTrunk",
		label = "Entrar no Porta-Malas",
		tunnel = "server"
	},{
		event = "enterVehmenus",
		label = "Veiculo menu",
		tunnel = "client"
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETENABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetEnable()
	local ped = PlayerPedId()

	if sucessTarget or IsPedArmed(ped,6) or IsPedInAnyVehicle(ped) then
		return
	end

	SendNUIMessage({ response = "openTarget" })

	targetActive = true
	while targetActive do
		local coords = GetEntityCoords(ped)
		local hit,entCoords,entity = RayCastGamePlayCamera(10.0)

		if hit == 1 then
			if GetEntityType(entity) ~= 0 then
				if IsEntityAVehicle(entity) then
					local vehPlate = GetVehicleNumberPlateText(entity)
					if #(coords - entCoords) <= 1.0 and vehPlate ~= "PDMSPORT" then
						local vehNet = nil
						local vehModel = GetEntityModel(entity)
						SetEntityAsMissionEntity(entity,true,true)

						if NetworkGetEntityIsNetworked(entity) then
							vehNet = VehToNet(entity)
						end

						innerEntity = { vehPlate,vRP.vehicleModel(vehModel),entity,vehNet }

						if LocalPlayer["state"]["Police"] then
							SendNUIMessage({ response = "validTarget", data = policeVeh })
						else
							SendNUIMessage({ response = "validTarget", data = playerVeh })
						end

						sucessTarget = true
						while sucessTarget and targetActive do
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							local _,entCoords,entity = RayCastGamePlayCamera(10.0)

							DisablePlayerFiring(ped,true)

							if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
								SetCursorLocation(0.5,0.5)
								SetNuiFocus(true,true)
							end

							if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
								sucessTarget = false
							end

							Citizen.Wait(1)
						end

						SendNUIMessage({ response = "leftTarget" })
					end
				elseif IsPedAPlayer(entity) and (LocalPlayer["state"]["Police"] or LocalPlayer["state"]["Paramedic"]) then
					if #(coords - entCoords) <= 1.0 then
						local index = NetworkGetPlayerIndexFromPed(entity)
						local source = GetPlayerServerId(index)

						innerEntity = { source }

						if LocalPlayer["state"]["Police"] then
							SendNUIMessage({ response = "validTarget", data = policeMenu })
						elseif LocalPlayer["state"]["Paramedic"] then
							SendNUIMessage({ response = "validTarget", data = paramedicMenu })
						end

						sucessTarget = true
						while sucessTarget and targetActive do
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							local _,entCoords,entity = RayCastGamePlayCamera(10.0)

							DisablePlayerFiring(ped,true)

							if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
								SetCursorLocation(0.5,0.5)
								SetNuiFocus(true,true)
							end

							if GetEntityType(entity) == 0 or #(coords - entCoords) > 1.0 then
								sucessTarget = false
							end

							Citizen.Wait(1)
						end

						SendNUIMessage({ response = "leftTarget" })
					end
				else
					for k,v in pairs(Models) do
						if DoesEntityExist(entity) then
							if k == GetEntityModel(entity) then
								if #(coords - entCoords) <= Models[k]["distance"] then
									local objNet = nil
									if NetworkGetEntityIsNetworked(entity) then
										objNet = ObjToNet(entity)
									end

									innerEntity = { entity,k,objNet,GetEntityCoords(entity) }

									SendNUIMessage({ response = "validTarget", data = Models[k]["options"] })

									sucessTarget = true
									while sucessTarget and targetActive do
										local ped = PlayerPedId()
										local coords = GetEntityCoords(ped)
										local _,entCoords,entity = RayCastGamePlayCamera(10.0)

										DisablePlayerFiring(ped,true)

										if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
											SetCursorLocation(0.5,0.5)
											SetNuiFocus(true,true)
										end

										if GetEntityType(entity) == 0 or #(coords - entCoords) > Models[k]["distance"] then
											sucessTarget = false
										end

										Citizen.Wait(1)
									end

									SendNUIMessage({ response = "leftTarget" })
								end
							end
						end
					end
				end
			end

			for k,v in pairs(Zones) do
				if Zones[k]:isPointInside(entCoords) then
					if #(coords - Zones[k]["center"]) <= v["targetoptions"]["distance"] then
						SendNUIMessage({ response = "validTarget", data = Zones[k]["targetoptions"]["options"] })

						if v["targetoptions"]["shop"] ~= nil then
							innerEntity = { v["targetoptions"]["shop"] }
						end

						sucessTarget = true
						while sucessTarget and targetActive do
							local ped = PlayerPedId()
							local coords = GetEntityCoords(ped)
							local _,entCoords = RayCastGamePlayCamera(10.0)

							DisablePlayerFiring(ped,true)

							if (IsControlJustReleased(1,24) or IsDisabledControlJustReleased(1,24)) then
								SetCursorLocation(0.5,0.5)
								SetNuiFocus(true,true)
							end

							if not Zones[k]:isPointInside(entCoords) or #(coords - Zones[k]["center"]) > v["targetoptions"]["distance"] then
								sucessTarget = false
							end

							Citizen.Wait(1)
						end

						SendNUIMessage({ response = "leftTarget" })
					end
				end
			end
		end

		Citizen.Wait(250)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:ANIMDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
local beds = {
	[1631638868] = { 0.0,0.0 },
	[2117668672] = { 0.0,0.0 },
	[-1498379115] = { 1.0,90.0 },
	[-1519439119] = { 1.0,0.0 },
	[-289946279] = { 1.0,0.0 }
}

RegisterNetEvent("target:animDeitar")
AddEventHandler("target:animDeitar",function()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		local objCoords = GetEntityCoords(innerEntity[1])

		SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + beds[innerEntity[2]][1],1,0,0,0)
		SetEntityHeading(ped,GetEntityHeading(innerEntity[1]) + beds[innerEntity[2]][2] - 180.0)

		vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:PACIENTEDEITAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:pacienteDeitar")
AddEventHandler("target:pacienteDeitar",function()
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)

	for k,v in pairs(beds) do
		local object = GetClosestObjectOfType(coords["x"],coords["y"],coords["z"],0.9,k,0,0,0)
		if DoesEntityExist(object) then
			local objCoords = GetEntityCoords(object)

			SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + v[1],1,0,0,0)
			SetEntityHeading(ped,GetEntityHeading(object) + v[2] - 180.0)

			vRP.playAnim(false,{"anim@gangops@morgue@table@","body_search"},true)
			break
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TARGET:SENTAR
-----------------------------------------------------------------------------------------------------------------------------------------
local chairs = {
	[-171943901] = 0.0,
	[-109356459] = 0.5,
	[1805980844] = 0.5,
	[-99500382] = 0.3,
	[1262298127] = 0.0,
	[1737474779] = 0.5,
	[2040839490] = 0.0,
	[1037469683] = 0.4,
	[867556671] = 0.4,
	[-1521264200] = 0.0,
	[-741944541] = 0.4,
	[-591349326] = 0.5,
	[-293380809] = 0.5,
	[-628719744] = 0.5,
	[-1317098115] = 0.5,
	[1630899471] = 0.5,
	[38932324] = 0.5,
	[-523951410] = 0.5,
	[725259233] = 0.5,
	[764848282] = 0.5,
	[2064599526] = 0.5,
	[536071214] = 0.5,
	[589738836] = 0.5,
	[146905321] = 0.5,
	[47332588] = 0.5,
	[-1118419705] = 0.5,
	[538002882] = -0.1,
	[-377849416] = 0.5,
	[96868307] = 0.5,
	[-1195678770] = 0.7,
	[-853526657] = -0.1,
	[652816835] = 0.8
}

RegisterNetEvent("target:animSentar")
AddEventHandler("target:animSentar",function()
	local ped = PlayerPedId()
	if GetEntityHealth(ped) > 101 then
		local objCoords = GetEntityCoords(innerEntity[1])

		FreezeEntityPosition(innerEntity[1],true)
		SetEntityCoords(ped,objCoords["x"],objCoords["y"],objCoords["z"] + chairs[innerEntity[2]],1,0,0,0)
		if chairs[innerEntity[2]] == 0.7 then
			SetEntityHeading(ped,GetEntityHeading(innerEntity[1]))
		else
			SetEntityHeading(ped,GetEntityHeading(innerEntity[1]) - 180.0)
		end

		vRP.playAnim(false,{ task = "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER" },false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERTARGETDISABLE
-----------------------------------------------------------------------------------------------------------------------------------------
function playerTargetDisable()
	if sucessTarget or not targetActive then
		return
	end

	targetActive = false
	SendNUIMessage({ response = "closeTarget" })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SELECTTARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("selectTarget",function(data)
	sucessTarget = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })

	if data["tunnel"] == "client" then
		TriggerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "server" then
		TriggerServerEvent(data["event"],innerEntity)
	elseif data["tunnel"] == "shop" then
		TriggerEvent(data["event"],"checkin")
	elseif data["tunnel"] == "boxes" then
		TriggerServerEvent(data["event"],innerEntity[1],data["service"])
	elseif data["tunnel"] == "paramedic" then
		TriggerServerEvent(data["event"],innerEntity[1])
	elseif data["tunnel"] == "police" then
		TriggerServerEvent(data["event"],innerEntity,data["service"])
	elseif data["tunnel"] == "objects" then
		TriggerServerEvent(data["event"],innerEntity[3])
	elseif data["tunnel"] == "robbery" then
		TriggerEvent(data["event"],data["service"])
	else
		TriggerServerEvent(data["event"])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSETARGET
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeTarget",function()
	sucessTarget = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESETDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("target:resetDebug")
AddEventHandler("target:resetDebug",function()
	sucessTarget = false
	targetActive = false
	SetNuiFocus(false,false)
	SendNUIMessage({ response = "closeTarget" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATIONTODIRECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function RotationToDirection(rotation)
	local adjustedRotation = {
		x = (math.pi / 180) * rotation["x"],
		y = (math.pi / 180) * rotation["y"],
		z = (math.pi / 180) * rotation["z"]
	}

	local direction = {
		x = -math.sin(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
		y = math.cos(adjustedRotation["z"]) * math.abs(math.cos(adjustedRotation["x"])),
		z = math.sin(adjustedRotation["x"])
	}

	return direction
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RAYCASTGAMEPLAYCAMERA
-----------------------------------------------------------------------------------------------------------------------------------------
function RayCastGamePlayCamera(distance)
	local cameraCoord = GetGameplayCamCoord()
	local cameraRotation = GetGameplayCamRot()
	local direction = RotationToDirection(cameraRotation)

	local destination = {
		x = cameraCoord["x"] + direction["x"] * distance,
		y = cameraCoord["y"] + direction["y"] * distance,
		z = cameraCoord["z"] + direction["z"] * distance
	}

	local a,b,c,d,e = GetShapeTestResult(StartShapeTestRay(cameraCoord["x"],cameraCoord["y"],cameraCoord["z"],destination["x"],destination["y"],destination["z"],-1,PlayerPedId(),0))

	return b,c,e
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddCircleZone(name,center,radius,options,targetoptions)
	Zones[name] = CircleZone:Create(center,radius,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REMCIRCLEZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function RemCircleZone(name)
	if Zones[name] then
		Zones[name] = nil
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDPOLYZONE
-----------------------------------------------------------------------------------------------------------------------------------------
function AddPolyzone(name,points,options,targetoptions)
	Zones[name] = PolyZone:Create(points,options)
	Zones[name]["targetoptions"] = targetoptions
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDTARGETMODEL
-----------------------------------------------------------------------------------------------------------------------------------------
function AddTargetModel(models,parameteres)
	for k,v in pairs(models) do
		Models[v] = parameteres
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LABELTEXT
-----------------------------------------------------------------------------------------------------------------------------------------
function LabelText(Name,Title)
	if Zones[Name] then
		Zones[Name]["targetoptions"]["options"][1]["label"] = Title
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports("LabelText",LabelText)
exports("AddPolyzone",AddPolyzone)
exports("RemCircleZone",RemCircleZone)
exports("AddCircleZone",AddCircleZone)
exports("AddTargetModel",AddTargetModel)
local localPeds = {}
local pedList = {
	{ -- Lixeiro
		Distance = 50,
		Coords = { -469.95,-1722.21,18.69,288.12 },
		Model = "s_m_y_garbage",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Taxi
		Distance = 50,
		Coords = { 894.98,-179.04,74.71,239.28 },
		Model = "s_m_m_lsmetro_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Entregador
		Distance = 50,
		Coords = { 151.8,-1478.17,29.36,228.54 },
		Model = "u_m_m_bikehire_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
    { -- Lenhador
		Distance = 50,
		Coords = { -843.63,5407.52,34.62,301.0 },
		Model = "a_m_m_farmer_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Motorista
		Distance = 50,
		Coords = { 452.95,-607.92,28.6,272.22 },
		Model = "csb_prologuedriver",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Transportador
		Distance = 50,
		Coords = { 239.45,243.0,106.69,68.97 },
		Model = "s_m_y_hwaycop_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Caminhoneiro
		Distance = 50,
		Coords = { 1181.57,-3113.83,6.03,86.75 },
		Model = "s_m_m_trucker_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Bombeiro
		Distance = 50,
		Coords = { 215.68,-1649.03,29.81,48.84 },
		Model = "s_m_y_fireman_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	
	{ -- Mergulhador
		Distance = 50,
		Coords = { -848.1,-1369.16,1.61,287.27 },
		Model = "s_m_m_trucker_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},
	{ -- Salva-vidas
		Distance = 50,
		Coords = { -1483.17,-1029.64,6.13,232.31 },
		Model = "s_m_y_baywatch_01",
		anim = { "anim@heists@heist_corona@single_team","single_team_loop_boss" }
	},	
}

CreateThread(function()
	while true do
		local Ped = PlayerPedId()
		local Coords = GetEntityCoords(Ped)

		for Number = 1,#pedList do
			local Distance = #(Coords - vec3(pedList[Number]["Coords"][1],pedList[Number]["Coords"][2],pedList[Number]["Coords"][3]))
			if Distance <= pedList[Number]["Distance"] then
				if not localPeds[Number] then
					localPeds[Number] = spawnPed(pedList[Number]["Model"], pedList[Number]["Coords"])
					SetPedArmour(localPeds[Number],100)
					FreezeEntityPosition(localPeds[Number],true)
					SetBlockingOfNonTemporaryEvents(localPeds[Number],true)
					if pedList[Number]["anim"] ~= nil then
						if loadAnimSet(pedList[Number]["anim"][1]) then
							TaskPlayAnim(localPeds[Number],pedList[Number]["anim"][1],pedList[Number]["anim"][2],4.0,4.0,-1,1,0,0,0,0)
						end
					end
				end
			else
				if localPeds[Number] then
					if DoesEntityExist(localPeds[Number]) then
						DeleteEntity(localPeds[Number])
					end
					localPeds[Number] = nil
				end
			end
		end

		Wait(1000)
	end
end)

function spawnPed(model, coords)
	local hash = GetHashKey(model)
	RequestModel(hash) while not HasModelLoaded(hash) do Wait(1) end
	local ped = CreatePed(2, hash, coords[1], coords[2], coords[3] - 1.0, coords[4] or 0.0, false, true)
	SetEntityInvincible(ped, true)
    return ped
end

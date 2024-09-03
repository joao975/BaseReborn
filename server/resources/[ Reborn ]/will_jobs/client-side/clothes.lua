
--######################--
--##  JOB CLOTHES ###--
--######################--
local pedClothes = {}
jobClothes = {
	['Lixeiro'] = {
		[`mp_m_freemode_01`] = {
			[1] = {0,0},
			[3] = {0,0},
			[4] = {36, 0},
			[5] = {0,0},
			[6] = {54,0},
			[7] = {-1,0},
			[8] = {59,0},
			[9] = {0,0},
			[10] = {0,0},
			[11] = {57,0},
			['p0'] = {-1,0},
			['p1'] = {-1,0},
		},
		[`mp_f_freemode_01`] = {
			[1] = {0,0},
			[3] = {3,0},
			[4] = {35,0},
			[5] = {-1,0},
			[6] = {52,0},
			[7] = {-1,0},
			[8] = {36,0},
			[9] = {0,0},
			[10] = {0,0},
			[11] = {50,0},
			['p0'] = {-1,0},
			['p1'] = {-1,0},
		}
	},
	['Taxi'] = {
		[`mp_m_freemode_01`] = {
			[1] = {0,0},
			[3] = {1,0},		-- Camisa	
			[4] = {28, 0}, 		-- Calças
			[5] = {0,0},		-- Mãos
			[6] = {21,0},		-- Sapato
			[8] = {15,0},		-- Acessorios
			[11] = {12,5},		-- Jaqueta
			['p0'] = {-1,0},	-- Chapeu
			['p1'] = {-1,0},
		},
		[`mp_f_freemode_01`] = {
			[1] = {0,0},
			[3] = {3,0},
			[4] = {47,0},
			[5] = {0,0},
			[6] = {13,0},
			[7] = {-1,0},
			[8] = {37,0},
			[9] = {0,0},
			[10] = {0,0},
			[11] = {58,0},
			['p0'] = {-1,0},
			['p1'] = {-1,0},
		}
	},
	['Lenhador'] = {
        [`mp_m_freemode_01`] = {
			[1] = {0,0},
			[3] = {1,0},
			[4] = {47, 1},
			[5] = {0,0},
			[6] = {71,0},
			[7] = {-1,0},
			[8] = {15,0},
			[9] = {0,0},
			[10] = {0,0},
			[11] = {251,0},
			['p0'] = {-1,0},
			['p1'] = {5,0},
		},
		[`mp_f_freemode_01`] = {
			[1] = {0,0},
			[3] = {3,0},
			[4] = {101,0},
			[5] = {-1,0},
			[6] = {74,0},
			[7] = {0,0},
			[8] = {3,0},
			[9] = {0,0},
			[10] = {0,0},
			[11] = {259,0},
			['p0'] = {-1,0},
			['p1'] = {-1,0},
		}
    },
	['Motorista'] = {
		[`mp_m_freemode_01`] = {
			[1] = {0,0},
			[3] = {1,0},		-- Camisa	
			[4] = {28, 0}, 		-- Calças
			[5] = {0,0},		-- Mãos
			[6] = {21,0},		-- Sapato
			[8] = {15,0},		-- Acessorios
			[11] = {13,3},		-- Jaqueta
			['p0'] = {-1,0},	-- Chapeu
			['p1'] = {-1,0},
		},
		[`mp_f_freemode_01`] = {
			[1] = {0,0},
			[3] = {3,0},
			[4] = {47,0},
			[5] = {0,0},
			[6] = {13,0},
			[7] = {-1,0},
			[8] = {37,0},
			[9] = {0,0},
			[10] = {0,0},
			[11] = {58,0},
			['p0'] = {-1,0},
			['p1'] = {-1,0},
		}
	},
	['Transportador'] = {
		[`mp_m_freemode_01`] = {
			[1] = {0,0},
			[3] = {1,0},		-- Camisa	
			[4] = {126, 0}, 	-- Calças
			[5] = {0,0},		-- Mãos
			[6] = {61,0},		-- Sapato
			[8] = {15,0},		-- Acessorios
			[11] = {316,0},		-- Jaqueta
			['p0'] = {-1,0},	-- Chapeu
			['p1'] = {-1,0},
		},
		[`mp_f_freemode_01`] = {
			[1] = {0,0},
			[3] = {3,0},
			[4] = {109,0},
			[5] = {-1,0},
			[6] = {76,0},
			[7] = {0,0},
			[8] = {3,0},
			[9] = {0,0},
			[10] = {0,0},
			[11] = {256,0},
			['p0'] = {-1,0},
			['p1'] = {-1,0},
		}
	},
	['Bombeiro'] = {
		[`mp_m_freemode_01`] = {
			[1] = {0,0},
			[3] = {1,0},		-- Camisa	
			[4] = {120, 0}, 	-- Calças
			[5] = {0,0},		-- Mãos
			[6] = {12,0},		-- Sapato
			[8] = {15,0},		-- Acessorios
			[11] = {315,0},		-- Jaqueta
			['p0'] = {126,20},	-- Chapeu
			['p1'] = {-1,0},
		},
		[`mp_f_freemode_01`] = {
			[1] = {0,0},
			[3] = {3,0},
			[4] = {126,0},
			[5] = {-1,0},
			[6] = {24,0},
			[7] = {0,0},
			[8] = {3,0},
			[9] = {0,0},
			[10] = {0,0},
			[11] = {325,0},
			['p0'] = {125,20},
			['p1'] = {-1,0},
		}
	},
	['Mergulhador'] = {
		[`mp_m_freemode_01`] = {
			[1] = {36,0},
			[3] = {1,0},		-- Camisa	
			[4] = {94, 0}, 	-- Calças
			[5] = {0,0},		-- Mãos
			[6] = {67,0},		-- Sapato
			[8] = {15,0},		-- Acessorios
			[11] = {53,0},		-- Jaqueta
			['p0'] = {11,0},	-- Chapeu
			['p1'] = {-1,0},
		},
		[`mp_f_freemode_01`] = {
			[1] = {36,0},
			[3] = {3,0},
			[4] = {97,15},
			[5] = {-1,0},
			[6] = {70,0},
			[7] = {0,0},
			[8] = {3,0},
			[9] = {0,0},
			[10] = {0,0},
			[11] = {55,0},
			['p0'] = {-1,0},
			['p1'] = {-1,0},
		}
	},
    ['Salva_vidas'] = {
        [`mp_m_freemode_01`] = {
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
		[`mp_f_freemode_01`] = {
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
    },
}

CreateThread(function() 
    if Config.debug then
		vRP = module("vrp","lib/Proxy").getInterface("vRP")

		-- Auxilio para pegar roupas
        RegisterCommand("getclothes",function()
			local custom = {}
			local ped = PlayerPedId()
			for i = 0,11 do
				custom[i] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
			end
			for i = 0,1 do
				custom["p"..i] = { GetPedPropIndex(ped,i),math.max(GetPedPropTextureIndex(ped,i),0) }
			end
			vRP.prompt("Roupas:",json.encode(custom))
		end)
    end
end)

function setCustomizationPlayer(job)
    local ped = PlayerPedId()
    local custom = {}
    for i = 0,11 do
        custom[i] = { GetPedDrawableVariation(ped,i),GetPedTextureVariation(ped,i),GetPedPaletteVariation(ped,i) }
    end
    for i = 0,10 do
        custom["p"..i] = { GetPedPropIndex(ped,i),math.max(GetPedPropTextureIndex(ped,i),0) }
    end

	pedClothes = custom

	createObjects("clothingshirt","try_shirt_positive_d",nil,1)
	if jobClothes[job][GetEntityModel(ped)] then
    	for k,v in next,jobClothes[job][GetEntityModel(ped)] do
			if tonumber(k) then
				SetPedComponentVariation(ped,k,v[1],v[2],0)
			elseif k == "p0" then
				ClearPedProp(ped,0)
			end
			Wait(150)
		end
    end
    removeObjects()
end

function originalClothes()
    local ped = PlayerPedId()
	createObjects("clothingshirt","try_shirt_positive_d",nil,1)
    for k,v in next,pedClothes do
		if tonumber(k) then
			SetPedComponentVariation(ped,k,pedClothes[k][1],pedClothes[k][2],0)
		elseif k == "p1" then
			SetPedPropIndex(ped,1,pedClothes[k][1],pedClothes[k][2],2)
		elseif k == "p0" then
			SetPedPropIndex(ped,0,pedClothes[k][1],pedClothes[k][2],2)
		end
		Wait(100)
    end
    removeObjects()
end

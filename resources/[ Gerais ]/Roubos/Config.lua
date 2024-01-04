Config = {}

--###############----###########
-- ##   Roubo a carro forte
--###############----###########

Config.stockade = {
    ['stockadeItem'] = "blackcard",
	['cops'] = 3,
    ['payment'] = {
        ['item'] = "dollars",
        ['qntd'] = math.random(30000,50000),
    }
}

--###############----###########
-- ##      Roubo a joalheria
--###############----###########

Config.jewelry = {
	['cops'] = 6,
    ['bombLocs'] = {
        { -631.29,-237.43,38.08,305.32 }
    },
    ['safeLocs'] = {
        { -627.94,-233.9,38.06,212.97 },
        { -626.93,-233.13,38.06,215.44 },
        { -626.84,-235.34,38.06,32.47 },
        { -625.75,-234.55,38.06,33.49 },
        { -626.69,-238.6,38.06,214.93 },
        { -625.66,-237.85,38.06,213.92 },
        { -623.08,-232.92,38.06,302.81 },
        { -620.15,-233.33,38.06,36.1 },
        { -619.71,-230.45,38.06,125.35 },
        { -621.03,-228.58,38.06,125.23 },
        { -623.97,-228.18,38.06,215.36 },
        { -624.41,-231.09,38.06,301.78 },
        { -620.22,-234.46,38.06,216.98 },
        { -619.21,-233.68,38.06,212.31 },
        { -617.54,-230.53,38.06,303.03 },
        { -618.28,-229.51,38.06,303.19 },
        { -619.65,-227.63,38.06,304.16 },
        { -620.39,-226.6,38.06,306.91 },
        { -623.91,-227.07,38.06,33.11 },
        { -624.96,-227.83,38.06,35.16 }
    },
    ['itens'] = function(user_id)
		local aleat = math.random(100)
        if aleat >= 50 then
            vRP.giveInventoryItem(user_id,"watch",parseInt(math.random(14,16)),true)
        elseif aleat < 50 and aleat >= 10 then
            vRP.giveInventoryItem(user_id,"ring",parseInt(math.random(20,22)),true)
        elseif aleat < 10 then
            vRP.giveInventoryItem(user_id,"goldbar",parseInt(math.random(15,18)),true)
        end
    end,
}

--###############----###########
-- ##       Roubo gerais
--###############----###########

Config.gerais = {
	[1] = {
		["x"] = 28.24,
		["y"] = -1338.832,
		["z"] = 29.5,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 }
		}
	},
	[2] = {
		["x"] = 2548.883,
		["y"] = 384.850,
		["z"] = 108.63,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
			
		}
	},
	[3] = {
		["x"] = 1159.156,
		["y"] = -314.055,
		["z"] = 69.21,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		
		}
	},
	[4] = {
		["x"] = -710.067,
		["y"] = -904.091,
		["z"] = 19.22,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		
		}
	},
	[5] = {
		["x"] = -43.652,
		["y"] = -1748.122,
		["z"] = 29.43,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		
		}
	},
	[6] = {
		["x"] = 378.291,
		["y"] = 333.712,
		["z"] = 103.57,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
			
		} -- 378.291, 333.712, 103.57
	},
	[7] = {
		["x"] = -3800000.385,
		["y"] = 1004.504,
		["z"] = 12.84,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		
		}
	},
	[8] = {
		["x"] = 1734.968,
		["y"] = 6421.161,
		["z"] = 35.04,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		
		}
	},
	[9] = {
		["x"] = 546.450,
		["y"] = 2662.45,
		["z"] = 42.16,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
			
		}
	},
	[10] = {
		["x"] = 1959.113,
		["y"] = 3749.239,
		["z"] = 32.35,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
			
		}
	},
	[11] = {
		["x"] = 2672.457,
		["y"] = 3286.811,
		["z"] = 55.25,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
			
		}
	},
	[12] = {
		["x"] = 1708.095,
		["y"] = 4920.711,
		["z"] = 42.07,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		
		}
	},
	[13] = {
		["x"] = -1829.422,
		["y"] = 798.491,
		["z"] = 138.2,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		
		}
	},
	[14] = {
		["x"] = -2959.66,
		["y"] = 386.765,
		["z"] = 14.05,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
			
		}
	},
	[15] = {
		["x"] = -3048.155,
		["y"] = 585.519,
		["z"] = 7.91,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
			
		}
	},
	[16] = {
		["x"] = 1126.75,
		["y"] = -979.760,
		["z"] = 45.42,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
			
		}
	},
	[17] = {
		["x"] = 1169.631,
		["y"] = 2717.833,
		["z"] = 37.16,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 3600,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
			
		}
	},
	[18] = {
		["x"] = -1478.67,
		["y"] = -375.675,
		["z"] = 39.17,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 7200,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		}
	},
	[19] = {
		["x"] = -1221.126,
		["y"] = -916.213,
		["z"] = 11.33,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 7200,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		}
	},
	[20] = {
		["x"] = 1693.374,
		["y"] = 3761.669,
		["z"] = 34.71,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[21] = {
		["x"] = 253.061,
		["y"] = -51.643,
		["z"] = 69.95,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[22] = {
		["x"] = 841.128,
		["y"] = -1034.951,
		["z"] = 28.2,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[23] = {
		["x"] = -330.467,
		["y"] = 6085.647,
		["z"] = 31.46,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[24] = {
		["x"] = -660.987,
		["y"] = -933.901,
		["z"] = 21.83,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[25] = {
		["x"] = -1304.775,
		["y"] = -395.832,
		["z"] = 36.7,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[26] = {
		["x"] = -1117.765,
		["y"] = 2700.388,
		["z"] = 18.56,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[27] = {
		["x"] = 2566.632,
		["y"] = 292.945,
		["z"] = 108.74,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[28] = {
		["x"] = -3172.701,
		["y"] = 1089.462,
		["z"] = 20.84,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[29] = {
		["x"] = 23.733,
		["y"] = -1106.27,
		["z"] = 29.8,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[30] = {
		["x"] = 808.914,
		["y"] = -2158.684,
		["z"] = 29.62,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "ammus",
		["cooldown"] = 7200,
		["name"] = "Loja de Armas",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "WEAPON_PISTOL", ["min"] = 1, ["max"] = 1 },
			{ ["item"] = "WEAPON_SNSPISTOL", ["min"] = 1, ["max"] = 2 },
			{ ["item"] = "WEAPON_PISTOL_AMMO", ["min"] = 50, ["max"] = 75 }
		}
	},
	[31] = {
		["x"] = -1210.409,
		["y"] = -336.485,
		["z"] = 38.29,
		["cops"] = 1,
		--["cops"] = 8,
		["time"] = 300,
		["distance"] = 12,
		["type"] = "fleeca",
		["cooldown"] = 10800,
		["name"] = "Banco Fleeca",
		["required"] = "blackcard",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 800000, ["max"] = 1000000 }
		}
	},
	[32] = {
		["x"] = -353.519,
		["y"] = -55.518,
		["z"] = 49.54,
		["cops"] = 8,
		["time"] = 300,
		["distance"] = 12,
		["type"] = "fleeca",
		["cooldown"] = 10800,
		["name"] = "Banco Fleeca",
		["required"] = "blackcard",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 800000, ["max"] = 1000000 }
		}
	},
	[33] = {
		["x"] = 311.525,
		["y"] = -284.649,
		["z"] = 54.67,
		["cops"] = 8,
		["time"] = 300,
		["distance"] = 12,
		["type"] = "fleeca",
		["cooldown"] = 10800,
		["name"] = "Banco Fleeca",
		["required"] = "blackcard",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 800000, ["max"] = 1000000 }
		}
	},
	[34] = {
		["x"] = 147.210,
		["y"] = -1046.292,
		["z"] = 29.87,
		["cops"] = 8,
		["time"] = 300,
		["distance"] = 12,
		["type"] = "fleeca",
		["cooldown"] = 10800,
		["name"] = "Banco Fleeca",
		["required"] = "blackcard",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 800000, ["max"] = 1000000 }
		}
	},
	[35] = {
		["x"] = -2956.449,
		["y"] = 482.090,
		["z"] = 16.2,
		["cops"] = 8,
		["time"] = 300,
		["distance"] = 12,
		["type"] = "fleeca",
		["cooldown"] = 10800,
		["name"] = "Banco Fleeca",
		["required"] = "blackcard",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 800000, ["max"] = 1000000 }
		}
	},
	[36] = {
		["x"] = 1175.66,
		["y"] = 2712.939,
		["z"] = 38.59,
		["cops"] = 8,
		["time"] = 300,
		["distance"] = 12,
		["type"] = "fleeca",
		["cooldown"] = 10800,
		["name"] = "Banco Fleeca",
		["required"] = "blackcard",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 800000, ["max"] = 1000000 },
		}
	},
	[37] = {
		["x"] = 134.124,
		["y"] = -1708.138,
		["z"] = 29.7,
		["cops"] = 2,
		["time"] = 120,
		["distance"] = 10,
		["type"] = "barber",
		["cooldown"] = 2600,
		["required"] = "lockpick",
		["name"] = "Barbearia",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 52000, ["max"] = 54000 },
		}
	},
	[38] = {
		["x"] = -1284.667,
		["y"] = -1115.089,
		["z"] = 7.5,
		["cops"] = 2,
		["time"] = 120,
		["distance"] = 10,
		["type"] = "barber",
		["cooldown"] = 2600,
		["required"] = "lockpick",
		["name"] = "Barbearia",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 52000, ["max"] = 54000 },
		}
	},
	[39] = {
		["x"] = 1930.781,
		["y"] = 3727.585,
		["z"] = 33.35,
		["cops"] = 2,
		["time"] = 120,
		["distance"] = 10,
		["type"] = "barber",
		["required"] = "lockpick",
		["cooldown"] = 2600,
		["name"] = "Barbearia",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 52000, ["max"] = 54000 },
		}
	},
	[40] = {
		["x"] = 1211.147,
		["y"] = -470.180,
		["z"] = 66.71,
		["cops"] = 2,
		["time"] = 120,
		["distance"] = 10,
		["type"] = "barber",
		["required"] = "lockpick",
		["cooldown"] = 2600,
		["name"] = "Barbearia",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 52000, ["max"] = 54000 },
		}
	},
	[41] = {
		["x"] = -30.355,
		["y"] = -151.385,
		["z"] = 57.58,
		["cops"] = 2,
		["time"] = 120,
		["distance"] = 10,
		["type"] = "barber",
		["required"] = "lockpick",
		["cooldown"] = 2600,
		["name"] = "Barbearia",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 52000, ["max"] = 54000 },
		}
	},
	[42] = {
		["x"] = -278.047,
		["y"] = 6231.001,
		["z"] = 32.2,
		["cops"] = 2,
		["time"] = 120,
		["distance"] = 10,
		["type"] = "barber",
		["required"] = "lockpick",
		["cooldown"] = 2600,
		["name"] = "Barbearia",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 52000, ["max"] = 54000 },
		}
	},
	[43] = {
		["x"] = 265.336,
		["y"] = 220.184,
		["z"] = 102.09,
		--["cops"] = 10,
		["cops"] = 2,
		["time"] = 600,
		["distance"] = 20,
		["type"] = "bank",
		["cooldown"] = 21600,
		["name"] = "Vinewood Vault",
		["required"] = "blackcard",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 2700000, ["max"] = 3200000 }
		}
	},
	[44] = {
		["x"] = -104.386,
		["y"] = 6477.150,
		["z"] = 31.83,
		["cops"] = 2,
		["time"] = 600,
		["distance"] = 12,
		["type"] = "bank",
		["cooldown"] = 21600,
		["name"] = "Savings Bank",
		["required"] = "blackcard",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 3000000, ["max"] = 4000000 }
		}
	},
	[45] = {
		["x"] = 1982.44,
		["y"] = 3053.4,
		["z"] = 47.22,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 7200,
		["name"] = "Yellow Jack",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 100000, ["max"] = 120000 },
		}
	},
	[46] = {
		["x"] = -3249.99,
		["y"] = 1004.39,
		["z"] = 12.84,
		["cops"] = 2,
		["time"] = 240,
		["distance"] = 12,
		["type"] = "convn",
		["cooldown"] = 7200,
		["name"] = "Loja de Departamento",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 140000, ["max"] = 160000 },
		}
	},
	[47] = {
		["x"] = 987.76,
		["y"] = -2129.84,
		["z"] = 30.48,
		["cops"] = 3,
		["time"] = 400,
		["distance"] = 20,
		["type"] = "chicken",
		["cooldown"] = 14400,
		["name"] = "Açougue",
		["required"] = "lockpick",
		["itens"] = {
			{ ["item"] = "dollars2", ["min"] = 1400000, ["max"] = 1600000 },
		}
	},
}

--###############----##############
-- ##   Roubo a caixa registradora
--###############----##############

Config.cashMachine = {
	['cops'] = -1,
    ['locs'] = {
        { 147.59,-1035.76,29.35,158.22 },
        { 145.95,-1035.18,29.35,159.58 },
        { 289.11,-1256.84,29.45,272.09 },
        { 288.85,-1282.36,29.64,268.68 },
        { -56.95,-1752.06,29.43,46.38 },
        { -203.75,-861.35,30.27,25.8 },
        { -254.43,-692.46,33.61,158.32 },
        { -256.22,-716.01,33.53,67.9 },
        { -721.08,-415.53,34.99,265.41 },
        { -846.3,-341.27,38.69,115.1 },
        { -846.84,-340.21,38.69,115.17 },
        { -2072.35,-317.25,13.32,262.88 },
        { 228.18,338.4,105.57,158.25 },
        { 380.78,323.41,103.57,161.78 },
        { -30.19,-723.7,44.23,339.56 },
        { 5.27,-919.86,29.56,249.37 },
        { 24.51,-945.96,29.36,338.97 },
        { 33.19,-1348.25,29.5,177.59 },
        { 295.76,-896.13,29.22,251.01 },
        { 296.47,-894.21,29.24,252.01 },
        { 356.96,173.57,103.07,341.32 },
        { 285.48,143.38,104.18,160.1 },
        { 158.65,234.21,106.63,338.35 },
        { -165.16,234.78,94.93,90.0 },
        { -165.16,232.76,94.93,90.11 },
        { -258.82,-723.35,33.48,71.14 },
        { -301.69,-830.01,32.42,350.36 },
        { -303.25,-829.73,32.42,354.01 },
        { 129.2,-1291.15,29.27,297.55 },
        { -717.69,-915.66,19.22,87.44 },
        { -660.73,-854.06,24.49,179.16 },
        { 1153.69,-326.77,69.21,98.26 },
        { -1109.8,-1690.81,4.38,125.01 },
        { -1315.8,-834.76,16.97,307.4 },
        { -1314.77,-835.98,16.97,305.52 },
        { 527.35,-160.71,57.1,268.13 },
        { -1430.16,-211.08,46.51,112.53 },
        { -1415.95,-212.01,46.51,227.98 },
        { -1286.26,-213.42,42.45,122.23 },
        { -1289.29,-226.83,42.45,120.79 },
        { -1285.61,-224.29,42.45,301.24 },
        { -1205.03,-326.26,37.84,115.33 },
        { -1205.72,-324.77,37.86,113.88 },
        { -1282.54,-210.92,42.45,301.87 },
        { 89.73,2.47,68.31,337.43 },
        { 1077.73,-776.52,58.25,180.02 },
        { -1305.41,-706.37,25.33,127.89 },
        { -27.98,-724.52,44.23,338.4 },
        { -57.68,-92.66,57.78,291.21 },
        { -866.64,-187.78,37.85,120.99 },
        { -867.6,-186.1,37.85,117.72 },
        { 112.55,-819.38,31.34,159.55 },
        { -596.07,-1161.29,22.33,0.51 },
        { -594.53,-1161.27,22.33,358.18 },
        { 1138.26,-468.94,66.74,72.73 },
        { 1167.0,-456.08,66.8,341.24 },
        { 236.6,219.66,106.29,289.38 },
        { 236.95,218.7,106.29,290.55 },
        { 237.48,217.82,106.29,292.16 },
        { 237.89,216.91,106.29,291.38 },
        { 238.32,215.98,106.29,289.65 },
        { 129.68,-1291.94,29.27,297.52 },
        { 130.11,-1292.67,29.27,295.5 },
        { 119.07,-883.66,31.13,69.71 },
        { -1410.34,-98.76,52.43,106.76 },
        { -1409.76,-100.52,52.39,105.93 },
        { -1570.11,-546.69,34.96,215.83 },
        { -1571.04,-547.38,34.96,215.83 },
        { -821.63,-1081.9,11.14,31.81 },
        { -537.83,-854.49,29.3,179.26 },
        { 111.31,-775.26,31.44,341.09 },
        { 114.45,-776.39,31.42,340.98 },
        { 315.1,-593.67,43.29,68.07 },
        { -712.85,-818.9,23.73,0.02 },
        { -710.01,-818.99,23.73,0.56 },
        { -1316.07,-834.64,16.97,307.5 },
        { -1314.78,-836.36,16.96,305.88 }
    },
}
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Webhooks = module("Reborn/webhooks")
vRP = Proxy.getInterface("vRP")
config = {}
Proxy.addInterface("vrp_inventory_items", config)
Reborn = Proxy.getInterface("Reborn")
-------------------------------------------------------------------------------------------------------------------------
-- LISTA DE ITEMS
-------------------------------------------------------------------------------------------------------------------------
config.itemList = Reborn.itemList()

-- RETORNA A LISTA DE ITEMS (não mexa)
config.getItemList = function()
	return Reborn.itemList()
end

-------------------------------------------------------------------------------------------------------------------------
-- ARMAS
-------------------------------------------------------------------------------------------------------------------------
config.weapons = {
	-- INDEX = index da lista acima, NOMEMUNICAO = index do item da munição na lista acima, -- PERM = caso tenha esse atributo, apenas conseguirá equipar/desequipar/guardar em algum baú quem tiver essa permissão.
    ['WEAPON_COMBATPISTOL'] = {index = "glock", nomeMunicao = 'pistolammo'},
    ['WEAPON_PISTOL'] = {index = "m1911", nomeMunicao = 'pistolammo'},
    ['WEAPON_PISTOL_MK2'] = {index = "fiveseven", nomeMunicao = 'pistolammo'},
    ['WEAPON_APPISTOL'] = {index = "kochvp9", nomeMunicao = 'pistolammo'},
    ['WEAPON_HEAVYPISTOL'] = {index = "atifx45", nomeMunicao = 'pistolammo'},
    ['WEAPON_SNSPISTOL'] = {index = "amt380", nomeMunicao = 'pistolammo'},
    ['WEAPON_SNSPISTOL_MK2'] = {index = "hkp7m10", nomeMunicao = 'pistolammo'},
    ['WEAPON_VINTAGEPISTOL'] = {index = "m1922", nomeMunicao = 'pistolammo'},
    ['WEAPON_PISTOL50'] = {index = "desert", nomeMunicao = 'pistolammo'},
    ['WEAPON_REVOLVER'] = {index = "magnum", nomeMunicao = 'pistolammo'},

    ['WEAPON_COMPACTRIFLE'] = {index = "akcompact", nomeMunicao = 'smgammo'},
    ['WEAPON_MACHINEPISTOL'] = {index = "tec9", nomeMunicao = 'smgammo'},
    ['WEAPON_MICROSMG'] = {index = "uzi", nomeMunicao = 'smgammo'},
    ['WEAPON_MINISMG'] = {index = "skorpionv61", nomeMunicao = 'smgammo'},
    ['WEAPON_SMG'] = {index = "mp5", nomeMunicao = 'smgammo'},
    ['WEAPON_ASSAULTSMG'] = {index = "mtar21", nomeMunicao = 'smgammo'},
    ['WEAPON_GUSENBERG'] = {index = "thompson", nomeMunicao = 'smgammo'},

	['WEAPON_ASSAULTRIFLE'] = {index = "ak103", nomeMunicao = 'rifleammo'},
	['WEAPON_ASSAULTRIFLE_MK2'] = {index = "ak74", nomeMunicao = 'rifleammo'},
	['WEAPON_CARBINERIFLE'] = {index = "m4a1", nomeMunicao = 'rifleammo', perm = "policia.permissao"},
	
	['WEAPON_PETROLCAN'] = {index = "gallon", nomeMunicao = "fuel" },

	['WEAPON_KNIFE'] = {index = "knife", nomeMunicao = nil},
	['WEAPON_HATCHET'] = {index = "hatchet", nomeMunicao = nil},
	['WEAPON_BAT'] = {index = "bat", nomeMunicao = nil},
	['WEAPON_BOTTLE'] = {index = "bottle", nomeMunicao = nil},
	['WEAPON_CROWBAR'] = {index = "crowbar", nomeMunicao = nil},
	['WEAPON_BATTLEAXE'] = {index = "battleaxe", nomeMunicao = nil},
	['WEAPON_DAGGER'] = {index = "dagger", nomeMunicao = nil},
	['WEAPON_GOLFCLUB'] = {index = "golfclub", nomeMunicao = nil},
	['WEAPON_HAMMER'] = {index = "hammer", nomeMunicao = nil},
	['WEAPON_MACHETE'] = {index = "machete", nomeMunicao = nil},
	['WEAPON_POOLCUE'] = {index = "poolcue", nomeMunicao = nil},
	['WEAPON_STONE_HATCHET'] = {index = "stonehatchet", nomeMunicao = nil},
	['WEAPON_SWITCHBLADE'] = {index = "switchblade", nomeMunicao = nil},
	['WEAPON_WRENCH'] = {index = "wrench", nomeMunicao = nil},
	['WEAPON_KNUCKLE'] = {index = "knuckle", nomeMunicao = nil},
	['WEAPON_FLASHLIGHT'] = {index = "flashlight", nomeMunicao = nil},
	['WEAPON_NIGHTSTICK'] = {index = "nightstick", nomeMunicao = nil},
}

-------------------------------------------------------------------------------------------------------------------------
-- CRAFTS / configuração das coordenadas / Para adicionar crafts entre em ui > recipes.js
-------------------------------------------------------------------------------------------------------------------------
config.crafts = {
	coords = {
		["toolbox"] = {},
	},
	checkDistance = function(source, item)
		local playerCoords = GetEntityCoords(GetPlayerPed(source))
		local itemCoords = config.crafts['coords'][item]
		if itemCoords then
			local x,y,z = table.unpack(itemCoords)
			if #(playerCoords - vector3(x,y,z)) <= 5 then
				return true
			end
			TriggerClientEvent("Notify",source,'negado',"Você não esta em um lugar apropriado.", 5000)
			return false
		else
			return true
		end
	end,
}
-------------------------------------------------------------------------------------------------------------------------
-- BAÚS / configuração dos baús
-------------------------------------------------------------------------------------------------------------------------
config.chests = {
	config = {
		enableCustom = true,
		size = {0.7, 0.7, 0.7},
		rotate = {90.0, 90.0, 0.0},
		image = "cofre4", -- cofre,cofre2,cofre3,cofre4,cofre5
		
		blipDist = 6.0,
		buttonDist = 2.2,
		
		---------CASO ESTEJA DESATIVADO O CUSTOM---------
		notCustom = function(x,y,z,chest,distance)
			if distance < 2.5 then
				DrawText3D(x,y,z+1.0, "~b~[E]~w~ ACESSAR BAÚ ~b~"..string.upper(chest).."~w~.")
			end
		
			DrawMarker(2, x,y,z+0.75, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 255, 255, 255, 180, 0, 0, 2, 1, 0, 0, 0) -- seta
			
			DrawMarker(25, x,y,z+0.01, 0, 0, 0, 0, 0, 0, 0.9, 0.9, 0.5, 255, 255, 255, 180, 0, 0, 2, 1, 0, 0, 0) -- baixo
			DrawMarker(25, x,y,z+0.01, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 19, 126, 138, 280, 0, 0, 2, 1, 0, 0, 0) -- baixo contorno azul
		end
	},
	list = {
		['Roxos'] = { ['x'] = 161.53, ['y'] = -985.91, ['z'] = 30.1, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'ballas.permissao', ['webhook'] = '' },
		['Policia'] = { ['x'] = -1078.11, ['y'] = -815.75, ['z'] = 11.04, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'policia.permissao', ['webhook'] = '' },
		['Vermelhos'] = { ['x'] = 1278.87, ['y'] = -195.74, ['z'] = 105.08, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'vermelhos.permissao', ['webhook'] = '' },
		['Azuis'] = { ['x'] = 2250.09, ['y'] = 51.49, ['z'] = 251.42, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'azuis.permissao', ['webhook'] = '' },
		['Verdes'] = { ['x'] = 1719.06, ['y'] = 396.15, ['z'] = 245.27, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'verdes.permissao', ['webhook'] = '' },
		['Bahamas'] = { ['x'] = -1884.34, ['y'] = 2069.89, ['z'] = 145.58, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'bahamas.permissao', ['webhook'] = '' },
		['Mafia'] = { ['x'] = 1086.44, ['y'] = 3056.3, ['z'] = 51.06, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'mafia.permissao', ['webhook'] = '' },
		['Milicia'] = { ['x'] = 1392.13, ['y'] = 1134.07, ['z'] = 109.75, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'milicia.permissao', ['webhook'] = '' },
		['Motoclub'] = { ['x'] = 977.22, ['y'] = -104.03, ['z'] = 74.85, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'motoclub.permissao', ['webhook'] = '' },
		['Vanilla'] = { ['x'] = 93.37, ['y'] = -1291.34, ['z'] = 29.27, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'vanilla.permissao', ['webhook'] = '' },
		['Hospital'] = { ['x'] = -465.81, ['y'] = -293.78, ['z'] = 34.92, ['weight'] = 5000, ['slots'] = 72, ['perm'] = 'paramedico.permissao', ['webhook'] = '' },
	}
}

-------------------------------------------------------------------------------------------------------------------------
-- SHOPS / configuração dos shops
-------------------------------------------------------------------------------------------------------------------------
config.shops = {
	config = {
		enableCustom = false,
		size = {0.7, 0.7, 0.7},
		rotate = {90.0, 90.0, 0.0},
		image = "shop", -- shop, shop2
		
		blipDist = 6.0,
		buttonDist = 2.2,
		
		---------CASO ESTEJA DESATIVADO O CUSTOM---------
		notCustom = function(x,y,z,chest,distance)
			if distance < 2.5 then
				DrawText3D(x,y,z+1.0, "~b~[E] ~w~"..string.upper(chest).."~w~.")
			end
			DrawMarker(2, x,y,z+0.75, 0, 0, 0, 0, 0, 0, 0.2, 0.2, 0.2, 255, 255, 255, 180, 0, 0, 2, 1, 0, 0, 0) -- seta
		end
	},
	list = {
		["Loja de Conveniência"] = {
			mode = "Both", -- Buy (apenas compras), Sell (apenas venda), Both (compra E venda)
			payment = {
				item = "dollars", -- Caso seja SELL ou BOTH, esse será o item de pagamento.
				tax = 0.8, -- Quanto recebe do valor do item total, ao vender 
			},
			webhook = "",
			coords = {
				-- vec3(25.75, -1346.68, 29.5),
				-- vec3(-47.71, -1757.23, 29.43),
				vec3(2556.04,380.89,108.61),
				-- vec3(1164.82,-323.63,69.2),
				-- vec3(-706.16,-914.55,19.21),
				-- vec3(372.86,327.53,103.56),
				vec3(-3243.38,1000.11,12.82),
				vec3(1728.39,6416.21,35.03),
				vec3(549.2,2670.22,42.16),
				-- vec3(1959.54,3741.01,32.33),
				vec3(2677.07,3279.95,55.23),
				vec3(1697.35,4923.46,42.06),
				-- vec3(-1819.55,793.51,138.08),
				vec3(1392.03,3606.1,34.98),
				vec3(-2966.41,391.59,15.05),
				vec3(-3040.04,584.22,7.9),
				vec3(1134.33,-983.09,46.4),
				vec3(1165.26,2710.79,38.15),
				vec3(-1486.77,-377.56,40.15),
				-- vec3(-1221.42,-907.91,12.32),
				vec3(161.35,6642.39,31.69),
				vec3(-160.61,6320.88,31.58),
			},
			list = {
				["postit"] = 20,
				["energetic"] = 15,
				["hamburger"] = 25,
				["emptybottle"] = 30,
				["cigarette"] = 10,
				["lighter"] = 175,
				["chocolate"] = 15,
				["sandwich"] = 15,
				["chandon"] = 15,
				["dewars"] = 15,
				["hennessy"] = 15,
				["absolut"] = 15,
				["tacos"] = 22,
				["cola"] = 15,
				["soda"] = 15,
				["coffee"] = 20
			}
		},
		["Ammunation"] = {
			mode = "Buy", -- Buy (apenas compras), Sell (apenas venda), Both (compra E venda)
			payment = {
				item = "dollars", -- Caso seja SELL ou BOTH, esse será o item de pagamento.
				tax = 0.8, -- Quanto recebe do valor do item total, ao vender 
			},
			webhook = "",
			coords = {
				--vec3(21.76, -1106.64, 29.8),
				-- vec3(1692.28,3760.94,34.69),
				vec3(253.79,-50.5,69.94),
				vec3(842.41,-1035.28,28.19),
				vec3(-331.62,6084.93,31.46),
				vec3(-662.29,-933.62,21.82),
				vec3(-1304.17,-394.62,36.7),
				vec3(-1118.95,2699.73,18.55),
				vec3(2567.98,292.65,108.73),
				vec3(-3173.51,1088.38,20.84),
				-- vec3(810.22,-2158.99,29.62),
			},
			list = {
				["GADGET_PARACHUTE"] = 475,
				["hatchet"] = 975,
				["bat"] = 975,
				["battleaxe"] = 975,
				["golfclub"] = 975,
				["hammer"] = 725,
				["machete"] = 975,
				["poolcue"] = 975,
				["stonehatchet"] = 975,
				["knuckle"] = 975,
				["flashlight"] = 675
			}
		}, 
		["Arsenal"] = {
			mode = "Buy", -- Buy (apenas compras), Sell (apenas venda), Both (compra E venda)
			payment = {
				item = "dollars", -- Caso seja SELL ou BOTH, esse será o item de pagamento.
				tax = 0.8, -- Quanto recebe do valor do item total, ao vender 
			},
			webhook = "",
			perm = "policia.permissao",
			coords = {
				[1] = vec3(-1106.21,-822.89,14.29),
			},
			list = {
				["glock"] = 0,
				['glock'] = 0,
				['kochvp9'] = 0,
				['tec9'] = 0,
				['mp5'] = 0,
				['m4a1'] = 0,
				['flashlight'] = 0,
				['nightstick'] = 0,
				['pistolammo'] = 0,
				['smgammo'] = 0,
				['rifleammo'] = 0,
			}
		},
		["Reciclagem"] = {
			mode = "Sell", -- Buy (apenas compras), Sell (apenas venda), Both (compra E venda)
			payment = {
				item = "dollars", -- Caso seja SELL ou BOTH, esse será o item de pagamento.
				tax = 1.0, -- Quanto recebe do valor do item total, ao vender 
			},
			webhook = "",
			coords = {
				[1] = vec3(-428.79,-1728.35,19.79),
			},
			list = {
				["plastic"] = 110,
				['glass'] = 90,
				['rubber'] = 150,
				['aluminum'] = 100,
				['copper'] = 160,
			}
		},
		["Pesca"] = {
			mode = "Buy",
			payment = {
				item = "dollars",
				tax = 0.1,
			},
			webhook = "",
			coords = {
				[1] = vec3(-1559.06,-970.29,13.02),
			},
			list = {
				["fishingrod"] = 500,
				['bait'] = 20,
			}
		},
		["Cassino"] = {
			mode = "Both",
			payment = {
				item = "dollars",
				tax = 1.0,
			},
			webhook = "",
			coords = {
				[1] = vec3(948.42,33.56,71.84),
			},
			list = {
				["fichas"] = 1,
			}
		},
		['Peixes'] = {
			mode = "Sell",
			payment = {
				item = "dollars",
				tax = 1.0,
			},
			webhook = "",
			coords = {
				[1] = vec3(-1563.32,-975.79,13.02),
			},
			list = {
				["shrimp"] = 110,
				['octopus'] = 150,
				['carp'] = 100,
			}
		},
		['Delivery'] = {
			mode = "Sell",
			payment = {
				item = "dollars",
				tax = 1.0,
			},
			webhook = "",
			coords = {
				[1] = vec3(11.48,-1599.23,29.38),
			},
			list = {
				["paperbag"] = 30,
				['tacos'] = 60,
				['hamburger'] = 60,
				['hotdog'] = 60,
				['soda'] = 60,
				['chocolate'] = 60,
				['cola'] = 60,
				['sandwich'] = 60,
				['fries'] = 60,
				['absolut'] = 60,
				['chandon'] = 60,
				['dewars'] = 60,
				['donut'] = 60,
				['hennessy'] = 60,
			}
		},
	}
}
-------------------------------------------------------------------------------------------------------------------------
-- REVISTAR
-------------------------------------------------------------------------------------------------------------------------
config.revistar = {
	enableCarry = false, -- Ao revistar, carregar o player?
	time = 10 -- Tempo para efetuar a revista
}

config.blockCommands = 'cancelando' -- evento para travar os comandos do player

config.debugMode = false -- ativar mensagens do debug (não mexa)

config.base = "creative" -- defina se sua base é creative ou vrpex

config.customizationPath = 2 -- caso tenha dúvidas, consulte

config.giveWeaponType = "1" -- 1 ou 2 (1 = vRP.giveWeapons, 2 = função nativa)

config.webhooks = {
	portamalas = Webhooks.webhookportamalas,
	portaluvas = Webhooks.webhookportaluvas,
	baucasas = Webhooks.webhookbaucasas,
	dropItem = Webhooks.webhookdropItem,
	revistar = Webhooks.webhookrevistar,
	pickupItem = Webhooks.webhookpickupItem
}
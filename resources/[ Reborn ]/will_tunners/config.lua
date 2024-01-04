-----#######################################--
--##            VRP 
-----#######################################--

Tunnel = module("vrp","lib/Tunnel")
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")

-----#######################################--
--##            Config 
-----#######################################--

-- vrpex // "cn" // "summerz"
Config.base = "vrpex"

Config.adminPermission = "Admin"

-- MAIN CONFIG START
Config.RepairCost = 1500 				-- Preço de reparo
Config.DisableRepair = false 			-- Desativar opção de reparo
Config.DoNotShowEmptyMods = true 		-- Esconde as opções vazias do veiculo

-- CUSTOM END

-- PERM = Permissao para acessar a mecanica
-- RADIUS = Raio de acesso
-- SHOPCOORDS = Centro da mecânica
-- MOD.coord = Coordenadas para acessar a tunagem
-- BLIPS = BLIP infos - sprite, cor e escala.

Config.Customs = {
    ['Bennys'] = {
		perm = 'mecanico.permissao',
		radius = 30,
		shopcoord = vector4(-212.58630371094,-1325.0119628906,30.89038848877,157.28034973145),
		mod = {
			{coord = vector4(-224.20236206055,-1329.8156738281,30.21583366394,87.278968811035), taken = false},
			{coord = vector4(-213.22569274902,-1331.546875,30.215799331665,356.6969909668), taken = false},
		},
		Blips = {sprite = 446, color = 68, scale = 0.5},
    },
	['Custom Garage'] = {
		perm = 'bennys.permissao',
		radius = 30,
		shopcoord = vector4(827.41,-984.23,26.16,89.29),
		mod = {
			{coord = vector4(835.65,-977.01,25.98,89.29), taken = false},
			{coord = vector4(835.49,-985.58,25.98,88.48), taken = false},
		},
		Blips = {sprite = 446, color = 68, scale = 0.5},
    },
}

allcolors = {}
for k,v in pairs(Config.Metallic) do
	allcolors[k] = v
end

for k,v in pairs(Config.Matte) do
	allcolors[k] = v
end

for k,v in pairs(Config.Metals) do
	allcolors[k] = v
end

-- VEHICLE MODS
-- FAQ
-- multicost  = Se 'true', o preço irá multiplicar o nivel do preço original
-- type = Tipo da tuangem no menu principal
-- bone = Alvo para a camera
-- index = MOD index
-- cost = Preço da tunagem do veiculo em todos niveis (menos o multicost)
Config.VehicleMod = {

    ----------Liveries--------
	[48] = {
		label = 'Liveries',
		name = 'liveries',
        index = 48,
		cost = 15000,
		percent_cost = 7,
		bone = 'chassis',
        type = 'Exterior',
		camera = {val = 'front', x = -2.1, y = 0.6,z = 1.1},
	},
	
	----------Windows--------
	[46] = {
		label = 'Windows',
		name = 'windows',
        index = 46,
		cost = 15000,
		percent_cost = 2,
		bone = 'window_lf1',
		camera = {val = 'right', x = 0.8, y = 0.8,z = 0.8},
        type = 'Exterior',
	},
	
	----------Tank--------
	[45] = {
		label = 'Intercooler',
		name = 'tank',
        index = 45,
		cost = 15000,
		percent_cost = 4,
		bone = 'chassis',
        type = 'Exterior',
		camera = {val = 'front', x = 0.2, y = 0.3,z = 0.1},
	},
	
	----------Trim--------
	[44] = {
		label = 'Trim',
		name = 'trim',
        index = 44,
		cost = 15000,
		percent_cost = 2,
		bone = 'boot',
		camera = {val = 'middle', x = 2.1, y = 2.1,z = -0.1},
        type = 'cosmetic',
	},
	
	----------Aerials--------
	[43] = {
		label = 'Aerials',
		name = 'aerials',
        index = 42,
		cost = 15000,
		percent_cost = 2,
		camera = {val = 'front', x = 0.5, y = 0.6,z = 0.4},
        type = 'cosmetic',
	},

	----------Arch cover--------
	[42] = {
		label = 'Arch cover',
		name = 'archcover',
        index = 42,
		cost = 15000,
		percent_cost = 2.5,
		bone = 'engine',
		action = 'openhood',
		action = 'openhood',
        type = 'cosmetic',
	},

	----------Struts--------
	[41] = {
		label = 'Struts',
		name = 'struts',
        index = 41,
		cost = 15000,
		percent_cost = 2.5,
		bone = 'engine',
		action = 'openhood',
        type = 'Performance Parts',
	},
	
	----------Air filter--------
	[40] = {
		label = 'Air filter',
		name = 'airfilter',
        index = 40,
		cost = 15000,
		percent_cost = 3.5,
		bone = 'engine',
		action = 'openhood',
        type = 'Performance Parts',
	},
	
	----------Engine block--------
	[39] = {
		label = 'Engine block',
		name = 'engineblock',
        index = 39,
		cost = 15000,
		percent_cost = 3.5,
		bone = 'engine',
		action = 'openhood',
        type = 'Performance Parts',
	},

	----------Hydraulics--------
	[38] = {
		label = 'Hydraulics',
		name = 'hydraulics',
        index = 38,
		cost = 15000,
		percent_cost = 7,
		bone = 'wheel_rf',
        type = 'cosmetic',
	},
	
	----------Trunk--------
	[37] = {
		label = 'Trunk',
		name = 'trunk',
        index = 37,
		cost = 15000,
		percent_cost = 4,
        type = 'Exterior',
		bone = 'boot',
		camera = {val = 'back', x = 0.5, y = -1.6,z = 1.3},
        prop = 'imp_prop_impexp_trunk_01a',
	},

	----------Speakers--------
	[36] = {
		label = 'Speakers',
		name = 'speakers',
        index = 36,
		cost = 15000,
		percent_cost = 3,
		bone = 'door_dside_f',
        type = 'Interior',
	},

	----------Plaques--------
	[35] = {
		label = 'Plaques',
		name = 'plaques',
        index = 35,
		cost = 15000,
		percent_cost = 3,
		camera = {val = 'left', x = -0.2, y = -0.5,z = 0.9},
		bone = 'steeseat_dside_fring',
        type = 'Interior',
	},
	
	----------Shift leavers--------
	[34] = {
		label = 'Shift leavers',
		name = 'shiftleavers',
        index = 34,
		camera = {val = 'left', x = -0.2, y = -0.5,z = 0.9},
		bone = 'steeseat_dside_fring',
		cost = 15000,
		percent_cost = 3,
        type = 'Interior',
	},
	
	----------Steeringwheel--------
	[33] = {
		label = 'Steeringwheel',
		name = 'steeringwheel',
        index = 33,
		bone = 'seat_dside_f',
		cost = 15000,
		percent_cost = 3,
		camera = {val = 'left', x = -0.2, y = -0.5,z = 0.9},
        type = 'Interior',
	},
	
	----------Seats--------
	[32] = {
		label = 'Seats',
		name = 'seats',
        index = 32,
		cost = 15000,
		percent_cost = 5,
        type = 'Interior',
		bone = 'seat_dside_f',
        prop = 'prop_car_seat',
	},
	
	----------Door speaker--------
	[31] = {
		label = 'Door speaker',
		name = 'doorspeaker',
        index = 31,
		percent_cost = 3,
		bone = 'door_dside_f',
		cost = 15000,
        type = 'Interior',
	},

	----------Dial--------
	[30] = {
		label = 'Dial',
		name = 'dial',
        index = 30,
		cost = 15000,
		percent_cost = 3,
		bone = 'seat_dside_f',
		camera = {val = 'left', x = -0.2, y = -0.5,z = 0.9},
        type = 'Interior',
	},
	----------Dashboard--------
	[29] = {
		label = 'Dashboard',
		name = 'dashboard',
        index = 29,
		cost = 15000,
		percent_cost = 5,
		bone = 'seat_dside_f',
        type = 'interior',
	},
	
	----------Ornaments--------
	[28] = {
		label = 'Ornaments',
		name = 'ornaments',
        index = 28,
		cost = 15000,
		percent_cost = 4,
		bone = 'seat_dside_f',
        type = 'cosmetic',
	},
	
	----------Trim--------
	[27] = {
		label = 'Trim',
		name = 'trim',
        index = 27,
		cost = 15000,
		percent_cost = 3,
		bone = 'bumper_f',
        type = 'cosmetic',
	},
	
	----------Vanity plates--------
	[26] = {
		label = 'Vanity plates',
		name = 'vanityplates',
        index = 26,
		cost = 15000,
		percent_cost = 2,
		bone = 'exhaust',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        type = 'cosmetic',
        prop = 'p_num_plate_01',
	},
	
	----------Plate holder--------
	[25] = {
		label = 'Plate holder',
		name = 'plateholder',
        index = 25,
		cost = 15000,
		percent_cost = 3,
		bone = 'exhaust',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        type = 'cosmetic',
	},
	---------Back Wheels---------
	[24] = {
		label = 'Back Wheels',
		name = 'backwheels',
        index = 24,
		cost = 15000,
		percent_cost = 4,
        type = 'Wheel Parts',
		camera = {val = 'middle', x = 2.1, y = 2.1,z = -0.1},
		bone = 'wheel_lr',
        prop = 'imp_prop_impexp_wheel_03a',
	},
	---------Front Wheels---------
	[23] = {
		label = 'Front Wheels',
		name = 'frontwheels',
        index = 23,
		cost = 15000,
		percent_cost = 5,
		bone = 'wheel_rf',
        type = 'Wheel Parts',
		camera = {val = 'middle', x = 2.1, y = 2.1,z = -0.1},
        prop = 'imp_prop_impexp_wheel_03a',
		list = {WheelType = {Sport = 0, Muscle = 1, Lowrider = 2, SUV = 3, Offroad = 4,Tuner = 5, BikeWheel = 6, HighEnd = 7 , BennysWheel = 8, BespokeWheel = 9, Dragster = 10, Street = 11 } , WheelColor = allcolors, Accessories = { CustomTire = 1, BulletProof = 1, SmokeColor = 1, DriftTires = 1} } -- BennysWheel = 8, BespokeWheel = 9
	},
	---------Headlights---------
	[22] = {
		label = 'Headlights',
		name = 'headlights',
        index = 22,
		cost = 15000,
		percent_cost = 3,
		bone = 'headlight_r',
        type = 'cosmetic',
        prop = 'v_ind_tor_bulkheadlight',
	},
	
	----------Turbo---------
	[18] = {
		label = 'Turbo',
		name = 'turbo',
        index = 18,
		cost = 15000,
		percent_cost = 20,
		bone = 'engine',
        type = 'Performance Parts',
		list = {Default = 0, Turbo = 1}
	},
	
	-----------Armor-------------
	[16] = {
		label = 'Armor',
		name = 'armor',
        index = 16,
		cost = 15000,
		percent_cost = 25,
		bone = 'bodyshell',
		multicostperlvl = true,
        type = 'Shell',
	},

	---------Suspension-----------
	[15] = {
		label = 'Suspension',
		name = 'suspension',
        index = 15,
		cost = 15000,
		percent_cost = 6,
		bone = 'wheel_rf',
		multicostperlvl = true,
        type = 'Performance Parts',
	},
	-----------Horn----------
    [14] = {
        label = 'Horn',
		name = 'horn',
        index = 14,
		cost = 15000,
		percent_cost = 3,
		bone = 'bumper_f',
		camera = {val = 'middle', x = 2.1, y = 2.1,z = -0.1},
        type = 'cosmetic',
    },
	-----------Transmission-------------
    [13] = {
        label = 'Transmission',
		name = 'transmission',
        index = 13,
		cost = 15000,
		percent_cost = 8,
		bone = 'engine',
		multicostperlvl = true,
        type = 'Performance Parts',
        prop = 'imp_prop_impexp_gearbox_01',
	},
	
	-----------Brakes-------------
	[12] = {
        label = 'Brakes',
		name = 'brakes',
        index = 12,
		cost = 15000,
		percent_cost = 5,
		bone = 'wheel_rf',
		multicostperlvl = true,
        type = 'Performance Parts',
        prop = 'imp_prop_impexp_brake_caliper_01a',
	},
	
	------------Engine----------
	[11] = {
        label = 'Engine',
		name = 'engine',
        index = 11,
		cost = 15000,
		percent_cost = 10,
		bone = 'engine',
		action = 'openhood',
		multicostperlvl = true,
        type = 'Performance Parts',
        prop = 'prop_car_engine_01',
	},
    ---------Roof----------
	[10] = {
		label = 'Roof',
		name = 'roof',
        index = 10,
		cost = 15000,
		percent_cost = 5,
		bone = 'roof',
		camera = {val = 'front-top', x = 0.5, y = -2.6,z = 1.5},
        type = 'exterior',
	},
	
	------------Fenders---------
	[8] = {
		label = 'Fenders',
		name = 'fenders',
        index = 8,
		cost = 15000,
		percent_cost = 5,
        type = 'cosmetic',
		bone = 'wheel_rf',
        prop = 'imp_prop_impexp_car_panel_01a'
	},
	
	------------Hood----------
	[7] = {
		label = 'Hood',
		name = 'Hood',
        index = 7,
		cost = 15000,
		percent_cost = 8,
        type = 'cosmetic',
		bone = 'bumper_f',
		camera = {val = 'front', x = 0.1, y = 0.8,z = 0.8},
        prop = 'imp_prop_impexp_bonnet_02a',
	},
	
	----------Grille----------
	[6] = {
		label = 'Grille',
		name = 'grille',
        index = 6,
		percent_cost = 3,
		cost = 15000,
		bone = 'bumper_f',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        type = 'cosmetic',
	},
	
	----------Roll cage----------
	[5] = {
		label = 'Roll cage',
		name = 'rollcage',
        index = 5,
		cost = 15000,
		percent_cost = 7,
        type = 'interior',
		bone = 'seat_dside_f',
		camera = {val = 'front-top', x = 0.1, y = -1.5,z = 0.5},
        prop = 'imp_prop_impexp_rear_bars_01b'
	},
	
	----------Exhaust----------
	[4] = {
		label = 'Exhaust',
		name = 'exhaust',
        index = 4,
		cost = 15000,
		percent_cost = 6,
        type = 'exterior',
		bone = 'exhaust',
		camera = {val = 'back', x = 0.5, y = -1.6,z = 0.4},
        prop = 'imp_prop_impexp_exhaust_01',
	},
	
	----------Skirts----------
	[3] = {
		label = 'Skirts',
		name = 'skirts',
        index = 3,
		cost = 15000,
		percent_cost = 3,
		bone = 'neon_r',
        type = 'cosmetic',
        prop = 'imp_prop_impexp_rear_bumper_01a',
	},
	
	-----------Rear bumpers----------
	[2] = {
		label = 'Rear bumpers',
		name = 'rearbumpers',
        index = 2,
		cost = 15000,
		percent_cost = 3,
		bone = 'bumper_r',
		camera = {val = 'back', x = 0.5, y = -1.6,z = 0.4},
        type = 'cosmetic',
        prop = 'imp_prop_impexp_rear_bumper_03a',
	},
	
	----------Front bumpers----------
	[1] = {
		label = 'Front bumpers',
		name = 'frontbumpers',
        index = 1,
		cost = 15000,
		percent_cost = 4,
		bone = 'bumper_f',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        type = 'cosmetic',
        prop = 'imp_prop_impexp_front_bumper_01a',
	},
	
	----------Spoiler----------
	[0] = {
		label = 'Spoiler',
		name = 'spoiler',
        index = 0,
		cost = 15000,
		percent_cost = 5,
		bone = 'boot',
		camera = {val = 'back', x = 0.5, y = -1.6,z = 1.3},
        type = 'cosmetic',
        prop = 'imp_prop_impexp_spoiler_04a',
	},

	['paint1'] = {
		label = 'Primary Color',
		name = 'paint1',
        index = 99,
		cost = 15000,
		percent_cost = 8,
		bone = 'boot',
        type = 'Primary Color',
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {Chameleon = Config.Chameleon, Metallic = Config.Metallic, Matte = Config.Matte, Metals = Config.Metals, Crome = Config.Crome, Pearlescent = Config.Metallic}
	},
	['paint2'] = {
		label = 'Secondary Color',
		name = 'paint2',
        index = 100,
		cost = 15000,
		percent_cost = 5,
		bone = 'boot',
        type = 'Secondary Color',
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {Metallic = Config.Metallic, Matte = Config.Matte, Metals = Config.Metals, Crome = Config.Crome}
	},
	['headlight'] = {
		label = 'Headlights',
		name = 'headlight',
        index = 101,
		cost = 15000,
		percent_cost = 3,
		bone = 'boot',
        type = 'Headlights',
		camera = {val = 'front', x = 0.1, y = 0.6,z = 0.4},
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {Default = false, XenonLights = true, 
		XenonColor = {
				Default = -1,
				White = 0,
				Blue = 1,
				ElectricBlue = 2,
				MintGreen = 3,
				LimeGreen = 4,
				Yellow = 5,
				GoldenShower = 6,
				Orange = 7,
				Red = 8,
				PonyPink = 9,
				HotPink = 10,
				Purple = 11,
			},
		}
	},
	['plate'] = {
		label = 'Plate',
		name = 'plate',
        index = 102,
		cost = 15000,
		percent_cost = 2,
		camera = {val = 'back', x = 0.5, y = -1.6,z = 1.3},
		bone = 'boot',
        type = 'Plate',
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {BlueWhite = 0, YellowBlack = 1, YellowBlue = 2,BlueWhite1 = 3,BlueWhite2 = 4,Yankton = 5}
	},
	['neon'] = {
		label = 'Neon Lights',
		name = 'neon',
        index = 103,
		cost = 15000,
		percent_cost = 3,
		bone = 'boot',
        type = 'Neon Lights',
		camera = {val = 'middle', x = 2.1, y = 2.1,z = -0.1},
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {Default = 0, NeonKit = 1, NeonColor = 2}
	},
	['window'] = {
		label = 'Window Tints',
		name = 'window',
        index = 104,
		cost = 15000,
		percent_cost = 5,
        type = 'Window Tints',
		bone = 'boot',
		camera = {val = 'left', x = -0.3, y = -0.3,z = 0.9},
        prop = 'imp_prop_impexp_spoiler_04a',
		list = {  
			None = 0,  
			PURE_BLACK = 1,  
			DARKSMOKE = 2,  
			LIGHTSMOKE = 3,  
			STOCK = 4,  
			LIMO = 5,  
			GREEN = 6  
		}
	},
	['extra'] = {
		label = 'Vehicle Extra',
		name = 'extra',
        index = 105,
		percent_cost = 5,
		cost = 15000,
        type = 'Extras',
		bone = 'boot',
		camera = {val = 'left', x = -0.3, y = -0.3,z = 0.9},
        prop = 'imp_prop_impexp_spoiler_04a',
		['extra'] = function() GetExtras() end
	},
}

Config.Notify = {
    NotifyEvent = "Notify",
    NotifyTypes = { Sucess = "sucesso", Denied = "negado", Warning = "aviso" },
	Upgraded = "Veiculo foi tunado com sucesso",
    NotPermission = "Você não tem permissão.",
    NoMoney = "Dinheiro insuficiente",
	VehNotOwned = "Veiculo não possui dono"
}

if GetGameBuildNumber() < 2372 then
	Config.VehicleMod[23]['list'] = {WheelType = {Sport = 0, Muscle = 1, Lowrider = 2, SUV = 3, Offroad = 4,Tuner = 5, BikeWheel = 6, HighEnd = 7 } , WheelColor = allcolors, Accessories = { CustomTire = 1, BulletProof = 1, SmokeColor = 1, DriftTires = 1} } -- BennysWheel = 8, BespokeWheel = 9
	Config.VehicleMod[23]['list'].Accessories.DriftTires = nil
end

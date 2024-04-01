local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
func = Tunnel.getInterface("ld_bank")

vCLIENT = {}
Tunnel.bindInterface("ld_bank",vCLIENT)
-------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO LADO CLIENT
-------------------------------------------------------------------------------------------------------------------------
ld_smartbank = {}
ld_smartbank['config'] = {
    ['banks'] = { -- Localização dos BANCOS
        [1]     = vector3(149.88, -1040.34, 29.37),
        [2]     = vector3(-350.83, -49.6, 49.04),
        [3]     = vector3(314.36, -278.46, 54.17),
        [4]     = vector3(-1212.98, -330.26, 37.79),
        [5]     = vector3(-2963.45, 482.81, 15.7),
        [6]     = vector3(1175.15, 2706.07, 38.09),
        [7]     = vector3(1653.78, 4850.56, 41.99),
        [8]     = vector3(-1074.67, -2559.01, 13.97),
        [9]     = vector3(-112.22, 6468.92, 31.63),
        [10]    = vector3(242.1, 224.44, 106.29),
    },
	['atms'] = { -- Localização das ATMS
		{x=145.97, y=-1035.17, z=29.35},
		{x=147.63, y=-1035.69, z=29.35},
		{x=-586.48, y=-143.28, z=47.21},
		{x=-588.52, y=-141.19, z=47.21},
		{x=-587.47, y=-142.29, z=47.21},
		{x=-577.08, y=-194.81, z=38.22},
		{x=-527.75, y=-166.08, z=38.24},
		{x=-537.25, y=-171.61, z=38.22},
		{x=-386.733, y=6045.953, z=31.501},
		{x=-283.03, y=6226.09, z=31.5},
		{x=-132.99, y=6366.5, z=31.48},
		{x=-97.3, y=6455.44, z=31.47},
		{x=-95.53, y=6457.11, z=31.47},
		{x=155.91, y=6642.9, z=31.61},
		{x=174.14, y=6637.92, z=31.58},
		{x=1701.21, y=6426.56, z=32.77},
		{x=1735.27, y=6410.52, z=35.04},
		{x=1703.03, y=4933.59, z=42.07},
		{x=1968.09, y=3743.54, z=32.35},
		{x=1822.67, y=3683.1, z=34.28},
		{x=540.29, y=2671.14, z=42.16},
		{x=2564.5, y=2584.79, z=38.09},
		{x=2558.76, y=351.01, z=108.63},
		{x=2558.5, y=389.49, z=108.63},
		{x=1077.76, y=-776.54, z=58.25},
		{x=1166.96, y=-456.13, z=66.81},
		{x=1153.73, y=-326.8, z=69.21},
		{x=380.77, y=323.39, z=103.57},
		{x=285.51, y=143.42, z=104.18},
		{x=158.65, y=234.22, z=106.63},
		{x=-165.1, y=232.72, z=94.93},
		{x=-165.16, y=234.77, z=94.93},
		{x=-1827.26, y=784.89, z=138.31},
		{x=-1409.74, y=-100.47, z=52.39},
		{x=-1410.35, y=-98.75, z=52.43},
		{x=-1204.97, y=-326.33, z=37.84},
		{x=-1205.75, y=-324.82, z=37.86},
		{x=-1215.64, y=-332.231, z=37.881},
		{x=-2072.35, y=-317.24, z=13.32},
		{x=-2975.07, y=380.14, z=15.0},
		{x=-2956.82, y=487.68, z=15.47},
		{x=-2958.98, y=487.74, z=15.47},
		{x=-3043.98, y=594.57, z=7.74},
		{x=-3144.39, y=1127.58, z=20.86},
		{x=-3241.17, y=997.59, z=12.56},
		{x=-3240.57, y=1008.61, z=12.84},
		{x=-1305.36, y=-706.43, z=25.33},
		{x=-537.81, y=-854.51, z=29.3},
		{x=-712.95, y=-818.91, z=23.73},
		{x=-710.09, y=-818.91, z=23.73},
		{x=-717.71, y=-915.73, z=19.22},
		{x=-526.61, y=-1222.98, z=18.46},
		{x=-256.24, y=-716.02, z=33.53},
		{x=-203.8, y=-861.4, z=30.27},
		{x=111.22, y=-775.22, z=31.44},
		{x=114.39, y=-776.35, z=31.42},
		{x=112.62, y=-819.41, z=31.34},
		{x=119.05, y=-883.69, z=31.13},
		{x=-846.25, y=-341.33, z=38.69},
		{x=-846.84, y=-340.21, z=38.69},
		{x=-1204.98, y=-326.33, z=37.84},
		{x=-56.96, y=-1752.07, z=29.43},
		{x=-262.03, y=-2012.33, z=30.15},
		{x=-273.11, y=-2024.54, z=30.15},
		{x=24.44, y=-945.97, z=29.36},
		{x=-254.39, y=-692.46, z=33.61},
		{x=-1570.197, y=-546.651, z=34.955},
		{x=-1571.03, y=-547.37, z=34.96},
		{x=-1415.94, y=-212.02, z=46.51},
		{x=-1430.112, y=-211.014, z=46.500},
		{x=33.17, y=-1348.23, z=29.5},
		{x=288.76, y=-1282.29, z=29.65},
		{x=289.11, y=-1256.81, z=29.45},
		{x=296.48, y=-894.14, z=29.24},
		{x=295.74, y=-896.08, z=29.22},
		{x=1686.753, y=4815.809, z=42.008},
		{x=-303.28, y=-829.72, z=32.42},
		{x=5.27, y=-919.85, z=29.56},
		{x=-1074.01, y=-827.69, z=19.04},
		{x=-1110.92, y=-836.26, z=19.01},
		{x=-1074.39, y=-827.47, z=27.04},
		{x=-660.68, y=-854.05, z=24.49},
		{x=-1315.75, y=-834.68, z=16.97},
		{x=-1314.78, y=-835.99, z=16.97},
		{x=1138.23, y=-468.94, z=66.74},
		{x=-821.7, y=-1081.93, z=11.14},
		{x=236.6, y=219.66, z=106.29},
		{x=237.02, y=218.76, z=106.29},
		{x=237.48, y=217.83, z=106.29},
		{x=237.89, y=216.93, z=106.29},
		{x=238.32, y=215.98, z=106.29},
		{x=265.82, y=213.89, z=106.29},
		{x=265.51, y=212.96, z=106.29},
		{x=265.17, y=212.0, z=106.29},
		{x=264.81, y=211.06, z=106.29},
		{x=264.46, y=210.08, z=106.29},
		{x=24.45, y=-946.01, z=29.36},
		{x=-258.77, y=-723.38, z=33.47},
		{x=-611.87, y=-704.81, z=31.24},
		{x=-614.58, y=-704.84, z=31.24},
		{x=-866.65, y=-187.74, z=37.85},
		{x=-867.61, y=-186.1, z=37.85},
		{x=-567.89, y=-234.35, z=34.25},
		{x=-301.68, y=-830.05, z=32.42},
		{x=-37.81, y=-1115.22, z=26.44},
		{x=-200.63, y=-1309.54, z=31.3},
		{x=903.81, y=-164.08, z=74.17},
		{x=437.13, y=-628.34, z=28.71},
		{x=230.92, y=367.57, z=106.12},
		{x=356.97, y=173.55, z=103.08},
		{x=-45.18, y=-1665.89, z=29.5},
	},

    ['blip'] = { -- Blips no mapa (MENU DO GTA)
        enabled     = true,
        blipName    = "Banco",
        blipType    = 108,
        blipColor   = 2,
        blipScale   = 0.8
    },
	['atmModels'] = { -- PROPS QUE SERÃO RECONHECIDOS COMO ATM (CAIXINHA) (só mexa se souber o que está fazendo)
        "prop_atm_01",
        "prop_atm_02",
        "prop_atm_03",
        "prop_fleeca_atm"
    },
    ['popupText']     = false, -- Ativar texto via hud ao em vez de markers nos BANCOS (Levemente mais otimizado) 
    ['atmPopupText']  = false, -- Ativar texto via hud ao em vez de markers nas ATMS (Levemente mais otimizado)
	['blip_RGB'] = { 112, 27, 196 }, -- COR DO BLIP DO CHÃO NO BANCO
	
}

-------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES LADO CLIENT (SÓ MEXA SE SOUBER O QUE ESTÁ FAZENDO)
-------------------------------------------------------------------------------------------------------------------------
local createdBlips = {}
isPopup = false
isATMPopup = false

ld_smartbank['functions'] = {
	
	startPlayerThread = function()
		CreateThread(function()
			while true do
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				local closestBank, closestDst, banco = ld_smartbank['functions'].GetClosestBank(pos)
				local waitTime = 700

				if closestDst < 4.0 then
					waitTime = 3
					if IsControlJustPressed(0, 38) then
						ld_smartbank['functions'].OpenNui()
					end

					if ld_smartbank['config']['popupText'] and not isPopup then
						ld_smartbank['functions'].PopupText(true, 'bank', 'E')
					else
						if not ld_smartbank['config']['popupText'] then
							ld_smartbank['functions'].DrawText3D(banco.x, banco.y, banco.z, Locales['BlipText']['bank'])
							DrawMarker(23, banco.x, banco.y, banco.z-0.99, 0, 0, 0, 0, 0, 0, 0.7, 0.7, 0.5,  ld_smartbank['config']['blip_RGB'][1],ld_smartbank['config']['blip_RGB'][2],ld_smartbank['config']['blip_RGB'][3], 180, 0, 0, 0, 0)
						end
					end
				elseif isPopup then
					ld_smartbank['functions'].PopupText(false, 'bank', 'E')
				end

				Citizen.Wait(waitTime)
			end
		end)
		
		CreateThread(function()
			while true do
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				local closestBank, closestDst, banco = ld_smartbank['functions'].GetClosestATM(pos)
				local waitTime = 700

				if closestDst < 4.0 then
					waitTime = 3
					if IsControlJustPressed(0, 38) then
						ExecuteCommand('atm')
					end

					if ld_smartbank['config']['atmPopupText'] and not isATMPopup then
						ld_smartbank['functions'].PopupText(true, 'atm', 'E')
					else
						if not ld_smartbank['config']['atmPopupText'] then
							ld_smartbank['functions'].DrawText3D(banco.x, banco.y, banco.z, Locales['BlipText']['atm'])
						end
					end
				elseif isATMPopup then
					ld_smartbank['functions'].PopupText(false, 'atm', 'E')
				end

				Citizen.Wait(waitTime)
			end
		end)
	end,
	
    CreateBlips = function()
        for k, v in pairs(ld_smartbank['config']['banks']) do
            local newBlip = AddBlipForCoord(tonumber(v.x), tonumber(v.y), tonumber(v.z))
            SetBlipSprite(newBlip, ld_smartbank['config']['blip']['blipType'])
            SetBlipDisplay(newBlip, 4)
            SetBlipScale(newBlip, ld_smartbank['config']['blip']['blipScale'])
            SetBlipColour(newBlip, ld_smartbank['config']['blip']['blipColor'])
            SetBlipAsShortRange(newBlip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(ld_smartbank['config']['blip']['blipName'])
            EndTextCommandSetBlipName(newBlip)
            table.insert(createdBlips, newBlip)
        end
        return true
    end,

    DeleteBlips = function()
        for k, v in pairs(createdBlips) do
            RemoveBlip(v)
        end
        createdBlips = {}
        return true
    end,

    GetClosestBank = function(pos)
        local closestBank, closestDst = 0, 999999.9
		local banco = nil
        for k, v in pairs(ld_smartbank['config']['banks']) do
            local dst = #(pos - v)
            if dst < closestDst then
                closestDst, closestBank = dst, k
				banco = v
            end
        end
        return closestBank, closestDst, banco
    end,

	GetClosestATM = function(pos)
        local closestAtm, closestAtmDst = 0, 999999.9
		local atm = nil
        for k, v in pairs(ld_smartbank['config']['atms']) do
            local dst = #(pos - vector3(v.x, v.y, v.z))
            if dst < closestAtmDst then
                closestAtmDst, closestAtm = dst, k
				atm = v
            end
        end
        return closestAtm, closestAtmDst, atm
    end,

    OpenNui = function(message)
        local playerData = func.getPlayerData()
		while not playerData do Wait(0) end
		SetNuiFocus(true, true)
		SendNUIMessage({
			type = 'create',
			data = playerData,
			message = message,
		})
    end,

	DrawText3D = function (x,y,z, text)
		local onScreen,_x,_y=World3dToScreen2d(x,y,z)
		local px,py,pz=table.unpack(GetGameplayCamCoords())

		SetTextScale(0.28, 0.28)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 215)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 370
		DrawRect(_x,_y+0.0125, 0.005+ factor, 0.03, 41, 11, 41, 68)
	end,

    PopupText = function(enable, type, key)
        if type == 'bank' then
            isPopup = enable
            SendNUIMessage({
                type = 'popup',
                popupTrigger = enable,
                popupType = type,
                popupKey = key
            })
        elseif type == 'atm' then
            isATMPopup = enable
            SendNUIMessage({
                type = 'popup',
                popupTrigger = enable,
                popupType = type,
                popupKey = key
            })
        end
    end,

    Notify = function(txt, typ)
        TriggerEvent("Notify",typ, txt)
    end
}
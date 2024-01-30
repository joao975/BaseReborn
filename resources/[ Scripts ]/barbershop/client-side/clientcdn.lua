-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cO = {}
Tunnel.bindInterface("barbershop",cO)
Proxy.addInterface("barbershop",cO)
vSERVER = Tunnel.getInterface("barbershop")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local cam = -1
local myClothes = {}
local myOldClothes = {}
local canStartTread = 0
local canUpdate = false
local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0, eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0, noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0, cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0, jawHeight = 0, chinLength = 0, chinPosition = 0, chinWidth = 0, chinShape = 0, neckWidth = 0, hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0, beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0, blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTION
-----------------------------------------------------------------------------------------------------------------------------------------
function f (n) 
	n = n + 0.00000
     return n 
end
----------------------------------------------------------------------------------------------------------------------------------------------------
-- SETCHAR
------------------------------------------------------------------------------------------------------------------------------------------------------
custom = currentCharacterMode
cO.setCharacter = function(data)
	if data then 
		custom = data
		canStartTread = 1
		canUpdate = true
		_setCustomization()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPDATESKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("updateSkin",function(data)
	myClothes = {}
	myClothes = { tonumber(data.hairModel), tonumber(data.firstHairColor), tonumber(data.secondHairColor), tonumber(data.makeupModel), tonumber(data.makeupintensity), tonumber(data.makeupcolor), tonumber(data.lipstickModel), tonumber(data.lipstickintensity), tonumber(data.lipstickColor), tonumber(data.eyebrowsModel), tonumber(data.eyebrowintensity), tonumber(data.eyebrowsColor), tonumber(data.beardModel), tonumber(data.beardintentisy), tonumber(data.beardColor), tonumber(data.blushModel), tonumber(data.blushintentisy), tonumber(data.blushColor), tonumber(data.eyesColor), tonumber(data.frecklesModel) }
	custom.lipstickModel = tonumber(data.lipstickModel)
	custom.lipstickColor = tonumber(data.lipstickColor)
	custom.hairModel = tonumber(data.hairModel)
	custom.firstHairColor = tonumber(data.firstHairColor)
	custom.secondHairColor = tonumber(data.secondHairColor)
	custom.blushModel = tonumber(data.blushModel)
	custom.blushColor = tonumber(data.blushColor)
	custom.makeupModel = tonumber(data.makeupModel)
	custom.makeupColor = tonumber(data.makeupcolor)
	custom.eyebrowsModel = tonumber(data.eyebrowsModel)
	custom.eyebrowsColor = tonumber(data.eyebrowsColor)
	custom.beardModel = tonumber(data.beardModel)
	custom.beardColor = tonumber(data.beardColor)
	custom.eyesColor = tonumber(data.eyesColor)
	custom.frecklesModel = tonumber(data.frecklesModel)
	-- custom.blemishesModel = tonumber(data.blemishesModel)
	custom.complexionModel = tonumber(data.complexionModel)

	if data.value then
		SetNuiFocus(false)
		displayBarbershop(false)
		vSERVER.setInstance(false)

		vSERVER.updateSkin(custom)

		SendNUIMessage({ openBarbershop = false })
		myOldClothes = {}
	end

	cO.defaultCustom(myClothes)
end)

cO.updateFacial = function(data)
	if data then 
		custom = data 
		canUpdate = true
		canStartTread = 1
		_setCustomization()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROTATELEFT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("rotate",function(data,cb)
	local ped = PlayerPedId()
	local heading = GetEntityHeading(ped)
	if data == "left" then
		SetEntityHeading(ped,heading+10)
	elseif data == "right" then
		SetEntityHeading(ped,heading-10)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOSENUI
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("closeNui",function()
	SetNuiFocus(false)
	displayBarbershop(false)
	vSERVER.setInstance(false)

	SendNUIMessage({ openBarbershop = false })
	cO.resetCustom(myOldClothes)
	myClothes = { tonumber(myOldClothes.hairModel), tonumber(myOldClothes.firstHairColor), tonumber(myOldClothes.secondHairColor), tonumber(myOldClothes.makeupModel), tonumber(myOldClothes.makeupintensity), tonumber(myOldClothes.makeupColor), tonumber(myOldClothes.lipstickModel), tonumber(myOldClothes.lipstickintensity), tonumber(myOldClothes.lipstickColor), tonumber(myOldClothes.eyebrowsModel), tonumber(myOldClothes.eyebrowintensity), tonumber(myOldClothes.eyebrowsColor), tonumber(myOldClothes.beardModel), tonumber(myOldClothes.beardintentisy), tonumber(myOldClothes.beardColor), tonumber(myOldClothes.blushModel), tonumber(myOldClothes.blushintentisy), tonumber(myOldClothes.blushColor), tonumber(myOldClothes.eyesColor), tonumber(myOldClothes.frecklesModel) }
	cO.defaultCustom(myClothes)
	TaskUpdateFaceOptions()
	canUpdate = true
	myOldClothes = {}
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DISPLAYBARBERSHOP
-----------------------------------------------------------------------------------------------------------------------------------------
function displayBarbershop(enable)
    local ped = PlayerPedId()
    if enable then
        SetNuiFocus(true, true)
        SendNUIMessage(
            {
                openBarbershop = true,
                hairModel = tonumber(custom.hairModel),
                firstHairColor = tonumber(custom.firstHairColor),
                secondHairColor = tonumber(custom.secondHairColor),
                makeupModel = tonumber(custom.makeupModel),
                makeupintensity = 10,
                makeupcolor = tonumber(custom.makeupColor),
                lipstickModel = tonumber(custom.lipstickModel),
                lipstickintensity = 10,
                lipstickColor = tonumber(custom.lipstickColor),
                eyebrowsModel = tonumber(custom.eyebrowsModel),
                eyebrowintensity = 10,
                eyebrowsColor = tonumber(custom.eyebrowsColor),
                beardModel = tonumber(custom.beardModel),
                beardintentisy = 10,
                beardColor = tonumber(custom.beardColor),
                blushModel = tonumber(custom.blushModel),
                blushintentisy = 10,
                blushColor = tonumber(custom.blushColor),
                eyesColor = tonumber(custom.eyesColor),
				frecklesModel = tonumber(custom.frecklesModel)
            }
        )
        myOldClothes = {
            hairModel = tonumber(custom.hairModel),
            firstHairColor = tonumber(custom.firstHairColor),
            secondHairColor = tonumber(custom.secondHairColor),
            makeupModel = tonumber(custom.makeupModel),
            makeupintensity = 10,
            makeupcolor = tonumber(custom.makeupColor),
            lipstickModel = tonumber(custom.lipstickModel),
            lipstickintensity = 10,
            lipstickColor = tonumber(custom.lipstickColor),
            eyebrowsModel = tonumber(custom.eyebrowsModel),
            eyebrowintensity = 10,
            eyebrowsColor = tonumber(custom.eyebrowsColor),
            beardModel = tonumber(custom.beardModel),
            beardintentisy = 10,
            beardColor = tonumber(custom.beardColor),
            blushModel = tonumber(custom.blushModel),
            blushintentisy = 10,
            blushColor = tonumber(custom.blushColor),
            eyesColor = tonumber(custom.eyesColor),
			frecklesModel = tonumber(custom.frecklesModel)
        }
        canUpdate = false

        FreezeEntityPosition(ped, true)
        if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then
            SendNUIMessage({type = "click"})
        end

        SetPlayerInvincible(ped, false) -- mqcu

        if not DoesCamExist(cam) then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
            SetCamCoord(cam, GetEntityCoords(ped))
            SetCamRot(cam, 0.0, 0.0, 0.0)
            SetCamActive(cam, true)
            RenderScriptCams(true, false, 0, true, true)
            SetCamCoord(cam, GetEntityCoords(ped))
        end

        local x, y, z = table.unpack(GetEntityCoords(ped))
        SetCamCoord(cam, x + 0.2, y + 0.5, z + 0.7)
        SetCamRot(cam, 0.0, 0.0, 150.0)
    else
        FreezeEntityPosition(ped, false)
        SetPlayerInvincible(ped, false)
        RenderScriptCams(false, false, 0, 1, 0)
        DestroyCam(cam, false)
    end
end

RegisterNetEvent("will_admin:openBarbershop")
AddEventHandler("will_admin:openBarbershop", function()
	displayBarbershop(true)
	vSERVER.setInstance(true)
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- SETCUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
cO.defaultCustom = function(status)
	myClothes = {}
	myClothes = { status[1], status[2], status[3], status[4], status[5], status[6], status[7], status[8], status[9], status[10], status[11], status[12], status[13], status[14], status[15], status[16], status[17], status[18], status[19], status[20] }

	local ped = PlayerPedId()

	SetPedEyeColor(ped,status[19])

	SetPedComponentVariation(ped,2,status[1],0,2)
	SetPedHairColor(ped,status[2],status[3])
	

	SetPedHeadOverlay(ped,4,status[4],0.99)
	SetPedHeadOverlayColor(ped,4,1,status[6],status[6])

--	SetPedHeadOverlayColor(ped,4,0,status[6],status[6])

	SetPedHeadOverlay(ped,8,status[7],0.99)
	SetPedHeadOverlayColor(ped,8,1,status[9],status[9])

	SetPedHeadOverlay(ped,2,status[10],0.99)
	SetPedHeadOverlayColor(ped,2,1,status[12],status[12])

	SetPedHeadOverlay(ped,1,status[13],0.99)
	SetPedHeadOverlayColor(ped,1,1,status[15],status[15])

	SetPedHeadOverlay(ped,5,status[16],0.99)
	SetPedHeadOverlayColor(ped,5,2,status[18],status[18])

	SetPedHeadOverlay(ped, 9, status[20], 0.99)
	SetPedHeadOverlayColor(ped, 9, 0, 0, 0)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESET CUSTOM
-----------------------------------------------------------------------------------------------------------------------------------------
cO.resetCustom = function(status)
	if status then 
		custom.lipstickModel = tonumber(status.lipstickModel)
		custom.lipstickColor = tonumber(status.lipstickColor)
		custom.hairModel = tonumber(status.hairModel)
		custom.firstHairColor = tonumber(status.firstHairColor)
		custom.secondHairColor = tonumber(status.secondHairColor)
		custom.blushModel = tonumber(status.blushModel)
		custom.blushColor = tonumber(status.blushColor)
		custom.makeupModel = tonumber(status.makeupModel)
		custom.makeupColor = tonumber(status.makeupColor)
		custom.eyebrowsModel = tonumber(status.eyebrowsModel)
		custom.eyebrowsColor = tonumber(status.eyebrowsColor)
		custom.beardModel = tonumber(status.beardModel)
		custom.beardColor = tonumber(status.beardColor)
		custom.eyesColor = tonumber(status.eyesColor)
		custom.frecklesModel = tonumber(status.frecklesModel)
		-- custom.blemishesModel = tonumber(status.blemishesModel)
		custom.complexionModel = tonumber(status.complexionModel)
	end
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCATIONS
----------------------------------------------------------------------------------------------------------------------------------------------------------------
local locations = {

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- BLIPS PAYMENT SITE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- { 1743.0,428.51,222.76 }, -- favela1
	-- { -1874.09,2067.47,145.58 }, -- favela2
	-- { -1874.09,2067.47,145.58 }, -- favela3
	-- { -1874.09,2067.47,145.58 }, -- favela4
	-- { -1874.09,2067.47,145.58 }, -- favela5
	-- { -1874.09,2067.47,145.58 }, -- favela6
	-- { -1874.09,2067.47,145.58 }, -- favela7
	-- { -1874.09,2067.47,145.58 }, -- favela8
	-- { -1874.09,2067.47,145.58 }, -- favela9
	-- { -1874.09,2067.47,145.58 }, -- armas1
	-- { -1874.09,2067.47,145.58 }, -- armas2
	-- { -1874.09,2067.47,145.58 }, -- armas3
	-- { -1874.09,2067.47,145.58 }, -- bala1
	-- { -1874.09,2067.47,145.58 }, -- bala2
	{ -2615.35,1705.25,142.38 }, -- bala3
	-- { -2615.35,1705.25,142.38 }, -- desmanche1
	-- { -2615.35,1705.25,142.38 }, -- desmanche2
	-- { -2615.35,1705.25,142.38 }, -- desmanche3
	-- { -2615.35,1705.25,142.38 }, -- hpilegal
	-- { -2615.35,1705.25,142.38 }, -- hackerspace
	----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- CASAS PAYMENT SITE
----------------------------------------------------------------------------------------------------------------------------------------------------------------
	{ -1987.95,-502.45,20.74 }, -- propriedadeprivada1
	{ -702.66,628.88,159.19 }, -- propriedadeprivada2
	{ -796.71,326.3,243.38 }, -- propriedadeprivada3
	{ -1095.37,427.82,79.29 }, -- propriedadeprivada4
	{ -1424.58,6755.21,5.89 }, -- propriedadeprivada5
	{ -84.14,-814.01,243.39 }, -- propriedadeprivada6
	{ -1178.85,306.4,69.76 }, -- propriedadeprivada7
	{ -3201.43,781.23,14.09  }, -- propriedadeprivada8
	{ 1.14,525.88,170.62 }, -- propriedadeprivada9
	{ -812.55,181.43,76.75 }, -- propriedadeprivada10
	{ -283.69,-720.86,125.48 }, -- propriedadeprivada11
	{ -1514.84,107.9,52.25 }, -- propriedadeprivada12

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- EXTRAS
----------------------------------------------------------------------------------------------------------------------------------------------------------------
	{ 982.55,73.1,116.17 }, -- cassino 
----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- POLÍCIA 1BPM
----------------------------------------------------------------------------------------------------------------------------------------------------------------
	{ -785.74,-1214.89,10.39 },

----------------------------------------------------------------------------------------------------------------------------------------------------------------
-- LOCATE SHOPS
----------------------------------------------------------------------------------------------------------------------------------------------------------------
	{ -813.37,-183.85,37.57 },
	{ 138.13,-1706.46,29.3 },
	{ -1280.92,-1117.07,7.0 },
	{ 1930.54,3732.06,32.85 },
	{ 1214.2,-473.18,66.21 },
	{ -33.61,-154.52,57.08 },
	{ -276.65,6226.76,31.7 },
	{ 1247.84,-104.54,71.38 },
	{ 2201.74,17.48,247.21 },
	{ 1626.97,438.08,255.9 },
	{ 3070.26,2965.47,92.6 },
	{ 825.21,1788.17,149.39 },
	{ -127.83,3190.61,45.92 },
	{ -2587.82,1891.12,163.8 },
	{ -69.92,1001.96,239.48 },
	{ -2799.48,1442.67,100.93 },
	{ -599.75,295.94,82.75 },
	{ 108.35,-1305.67,28.77 },
	{ -851.15,-41.91,43.98 },
	{ -1371.08,-617.05,22.32 },
	{ -268.69,-736.25,125.24 },
	{ -1371.17,-617.13,22.32 },
	{ 296.53,-595.68,43.29 },
	{ -1775.8,3255.19,36.83 },
	{ 2496.39,-360.81,101.9 },

	
}
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	SendNUIMessage({ openBarbershop = false })

	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
			for k,v in pairs(locations) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2.5 then
					timeDistance = 1
					DrawText3D(v[1],v[2],v[3],"~o~E~w~   ABRIR")
					DrawMarker(27,v[1],v[2],v[3]-1,0,0, 0, 0, 180.0, 130.0, 0.5, 0.5, 0.0, 184, 0, 0, 150, 0, 0, 0, 1)	
					if IsControlJustPressed(1,38) and vSERVER.checkOpen() then
						--print(k.." Cds "..vector3(v[1],v[2],v[3]))
						vSERVER.setInstance(true)
						displayBarbershop(true)
						SetEntityHeading(ped,332.21)
					end
				end
			end
		end
		
		Citizen.Wait(timeDistance)
	end
end)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREADHOVERFY
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
--[[ Citizen.CreateThread(function()
	local innerTable = {}
	for k,v in pairs(locations) do
		table.insert(innerTable,{ v[1],v[2],v[3],2.5,"E","<b>BARBEARIA</b>","PRESSIONE PARA ABRIR" })
	end

	TriggerEvent("hoverfy:insertTable",innerTable)
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADOPEN
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ Citizen.CreateThread(function()
	SetNuiFocus(false,false)

	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)

			for k,v in pairs(locations) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 2.5 then
					timeDistance = 1

					if IsControlJustPressed(1,38) and vSERVER.checkShares() then
						print(k.." Cds "..vector3(v[1],v[2],v[3]))
						displayBarbershop(true)
					end
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end) ]]
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	SetTextFont(4)
	SetTextCentre(1)
	SetTextEntry("STRING")
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,150)
	AddTextComponentString(text)
	SetDrawOrigin(x,y,z,0)
	DrawText(0.0,0.0)
	local factor = (string.len(text) / 450) + 0.01
	DrawRect(0.0,0.0125,factor,0.03,0 ,0, 0,177)
	ClearDrawOrigin()
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- THREAD SYNC PED
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
_setCustomization = function()
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)
			
			if canStartTread > 0 then
				while not IsPedModel(PlayerPedId(),"mp_m_freemode_01") and not IsPedModel(PlayerPedId(),"mp_f_freemode_01") do
					Citizen.Wait(10)
				end

				if custom then
					TaskUpdateSkinOptions()
					TaskUpdateFaceOptions()
					TaskUpdateHeadOptions()
					canStartTread = canStartTread - 1
				end
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SYNC BODY
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TaskUpdateSkinOptions()
	local data = custom
	SetPedHeadBlendData(PlayerPedId(),data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SYNC FACE
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = custom

	-- Olhos
	SetPedEyeColor(ped,data.eyesColor)

	-- Sobrancelha
	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)

	-- Nariz
	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)

	-- Bochechas
	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)

	-- Boca/Mandibula
	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)

	-- Queixo
	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)
	
	-- Pescoço
	SetPedFaceFeature(ped,19,data.neckWidth)
end
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- SYNC HEAD
---------------------------------------------------------------------------------------------------------------------------------------------------------------------
function TaskUpdateHeadOptions()
	local ped = PlayerPedId()

	if canUpdate then 
		local data = custom

		-- Cabelo
		SetPedComponentVariation(ped,2,data.hairModel,0,0)
		SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)

		-- Sobrancelha
		SetPedHeadOverlay(ped,2,data.eyebrowsModel, 0.99)
		SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)

		-- Barba
		SetPedHeadOverlay(ped,1,data.beardModel,0.99)
		SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)

		-- Pelo Corporal
		SetPedHeadOverlay(ped,10,data.chestModel,0.99)
		SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)

		-- Blush
		SetPedHeadOverlay(ped,5,data.blushModel,0.99)
		SetPedHeadOverlayColor(ped,5,2,data.blushColor,data.blushColor)

		-- Battom
		SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
		SetPedHeadOverlayColor(ped,8,1,data.lipstickColor,data.lipstickColor)

		-- Manchas
		-- SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
		-- SetPedHeadOverlayColor(ped,0,0,0,0)
		
		-- Envelhecimento
		SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
		SetPedHeadOverlayColor(ped,3,0,0,0)

		-- Aspecto
		SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
		SetPedHeadOverlayColor(ped,6,0,0,0)

		-- Pele
		SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
		SetPedHeadOverlayColor(ped,7,0,0,0)

		-- Sardas
		SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
		SetPedHeadOverlayColor(ped,9,0,0,0)

		-- Maquiagem
		SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
		SetPedHeadOverlayColor(ped,4,1,data.makeupColor,data.makeupColor)
	end
end

function cO.setCustomization(custom)
	if custom then
		local ped = PlayerPedId()
		local mhash = nil

		if custom.modelhash then
			mhash = custom.modelhash
		elseif custom.model then
			mhash = GetHashKey(custom.model)
		end

		if mhash then
			local i = 0
			while not HasModelLoaded(mhash) and i < 10000 do
				i = i + 1
				RequestModel(mhash)
				Citizen.Wait(10)
			end

			if HasModelLoaded(mhash) then
				SetPlayerModel(PlayerId(),mhash)
				SetModelAsNoLongerNeeded(mhash)
			end
		end

		for k,v in pairs(custom) do
			if k ~= "model" and k ~= "modelhash" then
				local isprop, index = parse_part(k)
				if isprop then
					if v[1] < 0 then
						ClearPedProp(ped,index)
					else
						SetPedPropIndex(ped,index,v[1],v[2],v[3] or 2)
					end
				else
					SetPedComponentVariation(ped,index,v[1],v[2],v[3] or 2)
				end
			end
		end
		TriggerEvent("reloadtattos")
	end
end
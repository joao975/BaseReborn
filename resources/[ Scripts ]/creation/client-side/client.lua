local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
br =  Proxy.getInterface("barbershop")


local cam = nil
local isInCharacterMode = false
local currentCharacterMode = { fathersID = 0, mothersID = 0, skinColor = 0, shapeMix = 0.0, eyesColor = 0, eyebrowsHeight = 0, eyebrowsWidth = 0, noseWidth = 0, noseHeight = 0, noseLength = 0, noseBridge = 0, noseTip = 0, noseShift = 0, cheekboneHeight = 0, cheekboneWidth = 0, cheeksWidth = 0, lips = 0, jawWidth = 0, jawHeight = 0, chinLength = 0, chinPosition = 0, chinWidth = 0, chinShape = 0, neckWidth = 0, hairModel = 4, firstHairColor = 0, secondHairColor = 0, eyebrowsModel = 0, eyebrowsColor = 0, beardModel = -1, beardColor = 0, chestModel = -1, chestColor = 0, blushModel = -1, blushColor = 0, lipstickModel = -1, lipstickColor = 0, blemishesModel = -1, ageingModel = -1, complexionModel = -1, sundamageModel = -1, frecklesModel = -1, makeupModel = -1 }
local currentCharacterMode2 = { name = nil, lastname = nil, gender = nil, where = nil }

local spawnLocations = {

    { "Praça",56.45,-880.83,30.35,"" },
	{ "Hospital",-461.63,-326.24,34.51,"" },
	{ "Policia Militar",-1085.02,-791.46,19.28,"" },
	{ "Mecânica",809.6,-996.41,26.28,"" },
}

local function hairCam()
	local interpolCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
	SetCamCoord(interpolCam, GetCamCoord(cam))
	SetCamRot(interpolCam, GetCamRot(cam, 1))
	SetCamFov(interpolCam, GetCamFov(cam))
	-- PointCamAtCoord(self.interpolCam, position.x, position.y, position.z)

	
	PointCamAtPedBone(interpolCam, PlayerPedId(), 31086, 0.0, 0.0, 0.0)
	SetCamFov(interpolCam, 35.0)
	Citizen.Wait(0)
	SetCamActiveWithInterp(interpolCam, cam, 500, 1, 1)
	local oldCam = cam
	while IsCamInterpolating(interpolCam) do 
		Citizen.Wait(1)
	end
	cam = interpolCam
	interpolCam = nil
	DestroyCam(oldCam, true)
end

RegisterCommand("378jisdj", function()
	TriggerEvent("createModule:characterCreate")
end)

RegisterNetEvent("createModule:characterCreate")
AddEventHandler("createModule:characterCreate",function()
	local ped = PlayerPedId()
	-- SetEntityInvincible(ped,true)--mqcu
	SetEntityVisible(ped,true,false)
	FreezeEntityPosition(ped,true)

	Citizen.Wait(1000)
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end

  	cam  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1380.78, -469.91, 72.5, f(0), f(0), f(180), f(45),true,2)
  	SetCamActive(cam,true)
  	RenderScriptCams(true,true,20000000000000000000000000,0,0,0)

 	SetEntityCoordsNoOffset(PlayerPedId(),-1380.72,-471.07,72.05,true,true,true) 
 	SetEntityHeading(PlayerPedId(),f(360))
	-- isInCharacterMode = true

	SetTimeout(1000,function()
		TaskUpdateSkinOptions()
		TaskUpdateFaceOptions()
		TaskUpdateHeadOptions()

		-- if sex ~= nil then 
		-- 	changeGender(sex)
		-- end

		-- vRP.playAnim(true,{"move_f@multiplayer","idle"},true)

		Citizen.Wait(1000)
		DoScreenFadeIn(1000)

		SetNuiFocus(true,true)
		SendNUIMessage({ CharacterMode0 = true, CharacterMode = false, CharacterMode2 = false, CharacterMode3 = false })
		-- SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode })
		-- hairCam()

		playerClothes(false,true,"mp_m_freemode_01")
	end)
end)

function changeGender(model)
	local mhash = GetHashKey(model)
	while not HasModelLoaded(mhash) do
		RequestModel(mhash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mhash) then
		SetPlayerModel(PlayerId(),mhash)
		SetEntityHealth(PlayerPedId(),400)
		SetModelAsNoLongerNeeded(mhash)
	end
end

function ResetCamera()
	local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)

    SetTimecycleModifier("default")
    SetEntityCoords(ped, pos.x, pos.y, pos.z)
    DoScreenFadeIn(500)
    Citizen.Wait(500)

    local cam =
        CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93, -1487.78, 520.75, 300.00, 0.00, 0.00, 100.00, false, 0)
    PointCamAtCoord(cam2, pos.x, pos.y, pos.z + 200)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
    Citizen.Wait(900)

    cam =
        CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x, pos.y, pos.z + 200, 300.00, 0.00, 0.00, 100.00, false, 0)
    PointCamAtCoord(cam, pos.x, pos.y, pos.z + 2)
    SetCamActiveWithInterp(cam, cam2, 3700, true, true)
    Citizen.Wait(3700)
    PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    FreezeEntityPosition(ped, false)
    Citizen.Wait(500)
    SetCamActive(cam, false)
    DestroyCam(cam, true)

    -- DisplayHud(true)
    -- DisplayRadar(true)
end

local function EndFade()
	ShutdownLoadingScreen()
	DoScreenFadeIn(500)
	while IsScreenFadingIn() do
		Citizen.Wait(1)
	end
end

local roupa
local barba
RegisterNetEvent("creation:spawn")
AddEventHandler("creation:spawn",function(clothes,barber,spawnar)
    roupa = clothes
    barba = barber
	TriggerEvent("spawn:Finish",spawnar)
	local ped = PlayerPedId()
	setBarbershop(ped,barba)
	setClothing(ped,roupa)
end)

RegisterNUICallback("resetCam", function(data)
	if not DoesCamExist(cam) then
		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA",false)
	end

  	cam  = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1380.78, -469.91, 72.5, f(0), f(0), f(180), f(45),true,2)
  	SetCamActive(cam,true)
  	RenderScriptCams(true,true,20000000000000000000000000,0,0,0)

 	SetEntityCoordsNoOffset(PlayerPedId(),-1380.72,-471.07,72.05,true,true,true) 
 	SetEntityHeading(PlayerPedId(),f(360))
end)

RegisterNUICallback("spawnCharacter",function(data,cb)
    -- server.spawnCharacter(data.choice)
	local spawn = data.choice+1
    ResetCamera()
    cb("ok")

    if DoesEntityExist(scene.ped) then
        DeleteEntity(scene.ped)
        scene.ped = nil
    end

    if spawn then
        DoScreenFadeOut(0)
        local ped = PlayerPedId()
        FreezeEntityPosition(ped,false,false)

        --- Camera propreties
        -- RenderScriptCams(false,false,0,true,true)
        -- SetCamActive(characterCamera,false)
        -- DestroyCam(characterCamera,true)
        -- characterCamera = nil
    
        SetEntityVisible(ped,true,false)
        TriggerEvent("hudActived",true)
        SetEntityCoordsNoOffset(PlayerPedId(),spawnLocations[spawn][2],spawnLocations[spawn][3],spawnLocations[spawn][4],true,true,true)
        SetNuiFocus(false,false)
        vRP.stopAnim()
        EndFade()
        Citizen.Wait(1000)
        setBarbershop(ped,barba)
        setClothing(ped,roupa)
        DoScreenFadeIn(1000)
    else
        DoScreenFadeOut(0)
        local ped = PlayerPedId()
        FreezeEntityPosition(ped,false,false)
        RenderScriptCams(false,false,0,true,true)
        -- SetCamActive(characterCamera,false)
        -- DestroyCam(characterCamera,true)
        -- characterCamera = nil
    
        SetEntityVisible(ped,true,false)
        TriggerEvent("hudActived",true)
        SetNuiFocus(false,false)
        vRP.stopAnim()
        EndFade()
        Citizen.Wait(1000)
        setBarbershop(ped,barba)
        setClothing(ped,roupa)
        DoScreenFadeIn(1000)
    end

end)

RegisterNUICallback("cDone0",function(data,cb)

	currentCharacterMode2.name = data.name
	currentCharacterMode2.lastname = data.lastname
	currentCharacterMode2.gender = data.gender
	currentCharacterMode2.age = data.age
	currentCharacterMode2.where = data.where
	SendNUIMessage({ spawn = false, CharacterMode0 = false, CharacterMode = true, CharacterMode2 = false, CharacterMode3 = false })

end)

RegisterNUICallback("BackPart0", function(data,cb)
	-- SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ spawn = false, CharacterMode0 = true, CharacterMode = false, CharacterMode2 = false, CharacterMode3 = false })

	-- SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback("cDone",function(data,cb)
	-- SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ spawn = false, CharacterMode0 = false, CharacterMode = false, CharacterMode2 = true, CharacterMode3 = false })

	-- SendNUIMessage({ CharacterMode = not isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback("BackPart1", function(data,cb)
	-- SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ spawn = false, CharacterMode0 = false, CharacterMode = true, CharacterMode2 = false, CharacterMode3 = false })

	-- SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback("cDonePart2", function(data,cb)
	-- SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ spawn = false, CharacterMode0 = false, CharacterMode = false, CharacterMode2 = false, CharacterMode3 = true })

	-- SendNUIMessage({ CharacterMode = not isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = isInCharacterMode })
end)

RegisterNUICallback("BackPart2", function(data,cb)
	-- SetNuiFocus(isInCharacterMode, isInCharacterMode)
	SendNUIMessage({ spawn = false, CharacterMode0 = false, CharacterMode = false, CharacterMode2 = true, CharacterMode3 = false })

	-- SendNUIMessage({ CharacterMode = isInCharacterMode, CharacterMode2 = not isInCharacterMode, CharacterMode3 = not isInCharacterMode })
end)

RegisterNUICallback("cDoneSave",function(data,cb)
	isInCharacterMode = false
	SetNuiFocus(isInCharacterMode,isInCharacterMode)
	SendNUIMessage({ spawn = false, CharacterMode0 = isInCharacterMode, CharacterMode = isInCharacterMode, CharacterMode2 = isInCharacterMode, CharacterMode3 = isInCharacterMode })
	SetEntityHealth(PlayerPedId(),400)

	FreezeEntityPosition(PlayerPedId(),false)
	SetCamActive(cam,false)
	RenderScriptCams(false,true,20000000000000000000000000,0,0,0)
	DestroyCam(cam, true)
	-- playerClothes(true,false,currentCharacterMode2.gender)
	TriggerServerEvent("createModule:createAccount",currentCharacterMode,currentCharacterMode2)
	TriggerEvent("hudActived",true)
end)

RegisterNUICallback("cChangeHeading",function(data,cb)
	SetEntityHeading(PlayerPedId(),f(data.camRotation*2))
	cb("ok")
end)

RegisterNUICallback("UpdateSkinOptions",function(data,cb)
	currentCharacterMode.fathersID = data.fathersID
	currentCharacterMode.mothersID = data.mothersID
	currentCharacterMode.skinColor = data.skinColor
	currentCharacterMode.shapeMix = data.shapeMix
	TaskUpdateSkinOptions()
	cb("ok")
end)

function TaskUpdateSkinOptions()
	local data = currentCharacterMode
	SetPedHeadBlendData(PlayerPedId(),data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
end

RegisterNUICallback("UpdateFaceOptions",function(data,cb)
	currentCharacterMode.eyesColor = data.eyesColor
	currentCharacterMode.eyebrowsHeight = data.eyebrowsHeight
	currentCharacterMode.eyebrowsWidth = data.eyebrowsWidth
	currentCharacterMode.noseWidth = data.noseWidth
	currentCharacterMode.noseHeight = data.noseHeight
	currentCharacterMode.noseLength = data.noseLength
	currentCharacterMode.noseBridge = data.noseBridge
	currentCharacterMode.noseTip = data.noseTip
	currentCharacterMode.noseShift = data.noseShift
	currentCharacterMode.cheekboneHeight = data.cheekboneHeight
	currentCharacterMode.cheekboneWidth = data.cheekboneWidth
	currentCharacterMode.cheeksWidth = data.cheeksWidth
	currentCharacterMode.lips = data.lips
	currentCharacterMode.jawWidth = data.jawWidth
	currentCharacterMode.jawHeight = data.jawHeight
	currentCharacterMode.chinLength = data.chinLength
	currentCharacterMode.chinPosition = data.chinPosition
	currentCharacterMode.chinWidth = data.chinWidth
	currentCharacterMode.chinShape = data.chinShape
	currentCharacterMode.neckWidth = data.neckWidth
	TaskUpdateFaceOptions()
	cb("ok")
end)

function TaskUpdateFaceOptions()
	local ped = PlayerPedId()
	local data = currentCharacterMode

	SetPedEyeColor(ped,data.eyesColor)

	SetPedFaceFeature(ped,6,data.eyebrowsHeight)
	SetPedFaceFeature(ped,7,data.eyebrowsWidth)

	SetPedFaceFeature(ped,0,data.noseWidth)
	SetPedFaceFeature(ped,1,data.noseHeight)
	SetPedFaceFeature(ped,2,data.noseLength)
	SetPedFaceFeature(ped,3,data.noseBridge)
	SetPedFaceFeature(ped,4,data.noseTip)
	SetPedFaceFeature(ped,5,data.noseShift)

	SetPedFaceFeature(ped,8,data.cheekboneHeight)
	SetPedFaceFeature(ped,9,data.cheekboneWidth)
	SetPedFaceFeature(ped,10,data.cheeksWidth)

	SetPedFaceFeature(ped,12,data.lips)
	SetPedFaceFeature(ped,13,data.jawWidth)
	SetPedFaceFeature(ped,14,data.jawHeight)

	SetPedFaceFeature(ped,15,data.chinLength)
	SetPedFaceFeature(ped,16,data.chinPosition)
	SetPedFaceFeature(ped,17,data.chinWidth)
	SetPedFaceFeature(ped,18,data.chinShape)

	SetPedFaceFeature(ped,19,data.neckWidth)
end

RegisterNUICallback("UpdateHeadOptions",function(data,cb)
	currentCharacterMode.hairModel = data.hairModel
	currentCharacterMode.firstHairColor = data.firstHairColor
	currentCharacterMode.secondHairColor = data.secondHairColor
	currentCharacterMode.eyebrowsModel = data.eyebrowsModel
	currentCharacterMode.eyebrowsColor = data.eyebrowsColor
	currentCharacterMode.beardModel = data.beardModel
	currentCharacterMode.beardColor = data.beardColor
	currentCharacterMode.chestModel = data.chestModel
	currentCharacterMode.chestColor = data.chestColor
	currentCharacterMode.blushModel = data.blushModel
	currentCharacterMode.blushColor = data.blushColor
	currentCharacterMode.lipstickModel = data.lipstickModel
	currentCharacterMode.lipstickColor = data.lipstickColor
	currentCharacterMode.blemishesModel = data.blemishesModel
	currentCharacterMode.ageingModel = data.ageingModel
	currentCharacterMode.complexionModel = data.complexionModel
	currentCharacterMode.sundamageModel = data.sundamageModel
	currentCharacterMode.frecklesModel = data.frecklesModel
	currentCharacterMode.makeupModel = data.makeupModel
	TaskUpdateHeadOptions()
	cb("ok")
end)

function TaskUpdateHeadOptions()
	local ped = PlayerPedId()
	local data = currentCharacterMode

	SetPedComponentVariation(ped,2,data.hairModel,0,0)
	SetPedHairColor(ped,data.firstHairColor,data.secondHairColor)

	SetPedHeadOverlay(ped,2,data.eyebrowsModel,0.99)
	SetPedHeadOverlayColor(ped,2,1,data.eyebrowsColor,data.eyebrowsColor)

	SetPedHeadOverlay(ped,1,data.beardModel,0.99)
	SetPedHeadOverlayColor(ped,1,1,data.beardColor,data.beardColor)

	SetPedHeadOverlay(ped,10,data.chestModel,0.99)
	SetPedHeadOverlayColor(ped,10,1,data.chestColor,data.chestColor)

	SetPedHeadOverlay(ped,5,data.blushModel,0.99)
	SetPedHeadOverlayColor(ped,5,2,data.blushColor,data.blushColor)

	SetPedHeadOverlay(ped,8,data.lipstickModel,0.99)
	SetPedHeadOverlayColor(ped,8,2,data.lipstickColor,data.lipstickColor)

	SetPedHeadOverlay(ped,0,data.blemishesModel,0.99)
	SetPedHeadOverlayColor(ped,0,0,0,0)

	SetPedHeadOverlay(ped,3,data.ageingModel,0.99)
	SetPedHeadOverlayColor(ped,3,0,0,0)

	SetPedHeadOverlay(ped,6,data.complexionModel,0.99)
	SetPedHeadOverlayColor(ped,6,0,0,0)

	SetPedHeadOverlay(ped,7,data.sundamageModel,0.99)
	SetPedHeadOverlayColor(ped,7,0,0,0)

	SetPedHeadOverlay(ped,9,data.frecklesModel,0.99)
	SetPedHeadOverlayColor(ped,9,0,0,0)

	SetPedHeadOverlay(ped,4,data.makeupModel,0.99)
	SetPedHeadOverlayColor(ped,4,0,0,0)
end

RegisterNUICallback("createSimplePed",function(data,cb)
	changeGender(data.sex)
	playerClothes(false,true,data.sex)


	Citizen.Wait(500)
	if currentCharacterMode ~= nil then
		br.setCharacter(currentCharacterMode)
	end

    cb("ok")
end)


function playerClothes(isProp, isCreating, gender)
	if gender == "mp_m_freemode_01" then 
-------------- MASCULINO
		if isCreating then 
-- DURANTE A CRIAÇÃO DE PERSONAGEM
			if isProp then 
				return {
					{ component = 0, drawable = -1, texture = 0 }, -- Chapeu
					{ component = 1, drawable = -1, texture = 0 }, -- Oculos
					{ component = 2, drawable = -1, texture = 0 }, -- Orelha
					{ component = 6, drawable = -1, texture = 0 }, -- Braço direito
					{ component = 7, drawable = -1, texture = 0 }, -- Braço esquerdo
				}
			else 
				return {
					{ component = 1, drawable = 0, texture = 0, pallete = 2 }, -- Mascara
					{ component = 3, drawable = 1, texture = 0, pallete = 20 }, -- Maos
					{ component = 4, drawable = 21, texture = 0, pallete = 0 }, -- Pernas
					{ component = 5, drawable = 0, texture = 0, pallete = 0 }, -- Mochila
					{ component = 6, drawable = 4, texture = 0, pallete = 2 }, -- Sapatos
					{ component = 7, drawable = 0, texture = 0, pallete = 2 }, -- Acessórios
					{ component = 8, drawable = 15, texture = 0, pallete = 2 }, -- Blusa
					{ component = 9, drawable = 0, texture = 0, pallete = 0 }, -- Colete
					{ component = 10, drawable = 0, texture = 0, pallete = 0 }, -- Adesivos
					{ component = 11, drawable = 15, texture = 0, pallete = 2 }, -- Jaqueta
				}
			end
		else 
		--------- APÓS A CRIAÇÃO DE PERSONAGEM MASCULINA
			if isProp then 
				return {
					{ component = 0, drawable = -1, texture = 0 }, -- Chapeu
					{ component = 1, drawable = -1, texture = 0 }, -- Oculos
					{ component = 2, drawable = -1, texture = 0 }, -- Orelha
					{ component = 6, drawable = -1, texture = 0 }, -- Braço direito
					{ component = 7, drawable = -1, texture = 0 }, -- Braço esquerdo
				}
			else 
				return {
					{ component = 1, drawable = 0, texture = 0, pallete = 2 }, -- Mascara
					{ component = 3, drawable = 4, texture = 0, pallete = 20 }, -- Maos
					{ component = 4, drawable = 1, texture = 0, pallete = 0 }, -- Pernas
					{ component = 5, drawable = 0, texture = 0, pallete = 0 }, -- Mochila
					{ component = 6, drawable = 4, texture = 0, pallete = 2 }, -- Sapatos
					{ component = 7, drawable = 0, texture = 0, pallete = 2 }, -- Acessórios
					{ component = 8, drawable = 15, texture = 0, pallete = 2 }, -- Blusa
					{ component = 9, drawable = 0, texture = 0, pallete = 0 }, -- Colete
					{ component = 10, drawable = 0, texture = 0, pallete = 0 }, -- Adesivos
					{ component = 11, drawable = 57, texture = 0, pallete = 2 }, -- Jaqueta
				}
			end

		end
		
	else 
----------- FEMININO
		if isCreating then 
-- DURANTE A CRIAÇÃO DE PERSONAGEM FEMININA

			if isProp then 
				return {
					{ component = 0, drawable = -1, texture = 0 }, -- Chapeu
					{ component = 1, drawable = -1, texture = 0 }, -- Oculos
					{ component = 2, drawable = -1, texture = 0 }, -- Orelha
					{ component = 6, drawable = -1, texture = 0 }, -- Braço direito
					{ component = 7, drawable = -1, texture = 0 }, -- Braço esquerdo
				}
			else 
				return {
					{ component = 1, drawable = 0, texture = 0, pallete = 0 }, -- Mascara
					{ component = 3, drawable = 15, texture = 0, pallete = 2 }, -- Maos
					{ component = 4, drawable = 43, texture = 0, pallete = 0 }, -- Pernas
					{ component = 5, drawable = 0, texture = 0, pallete = 0 }, -- Mochila
					{ component = 6, drawable = 20, texture = 0, pallete = 2 }, -- Sapatos
					{ component = 7, drawable = 0, texture = 0, pallete = 2 }, -- Acessórios
					{ component = 8, drawable = 15, texture = 0, pallete = 2 }, -- Blusa
					{ component = 9, drawable = 0, texture = 0, pallete = 0 }, --  Colete
					{ component = 10, drawable = 0, texture = 0, pallete = 0 }, -- Adesivos
					{ component = 11, drawable = 74, texture = 0, pallete = 2 }, --  Jaqueta
				}
			end 
		else 
		--------- APÓS A CRIAÇÃO DE PERSONAGEM FEMININA
			if isProp then 
				return {
					{ component = 0, drawable = -1, texture = 0 }, -- Chapeu
					{ component = 1, drawable = -1, texture = 0 }, -- Oculos
					{ component = 2, drawable = -1, texture = 0 }, -- Orelha
					{ component = 6, drawable = -1, texture = 0 }, -- Braço direito
					{ component = 7, drawable = -1, texture = 0 }, -- Braço esquerdo
				}
			else 
				return {
					{ component = 1, drawable = 0, texture = 0, pallete = 0 }, -- Mascara
					{ component = 3, drawable = 15, texture = 0, pallete = 2 }, -- Maos
					{ component = 4, drawable = 43, texture = 0, pallete = 0 }, -- Pernas
					{ component = 5, drawable = 0, texture = 0, pallete = 0 }, -- Mochila
					{ component = 6, drawable = 20, texture = 0, pallete = 2 }, -- Sapatos
					{ component = 7, drawable = 0, texture = 0, pallete = 2 }, -- Acessórios
					{ component = 8, drawable = 15, texture = 0, pallete = 2 }, -- Blusa
					{ component = 9, drawable = 0, texture = 0, pallete = 0 }, --  Colete
					{ component = 10, drawable = 0, texture = 0, pallete = 0 }, -- Adesivos
					{ component = 11, drawable = 74, texture = 0, pallete = 2 }, --  Jaqueta
				}
			end

		end
	   
	end
	
end

function f(n)
	n = n + 0.00000
	return n
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
vSERVER = Tunnel.getInterface("spawn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local Camera = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOCATE
-----------------------------------------------------------------------------------------------------------------------------------------
local Locate = {
	{ name = "Ultima localização", Coords = vec4(55.04,-878.8,30.37,176.39) },
	{ name = "Garagem Praça", Coords = vec4(55.04,-878.8,30.37,176.39) },
    { name = "Garagem Sandy Shores", Coords = vec4(318.1,2623.98,44.47,268.35) },
    { name = "Garagem Paleto", Coords = vec4(-772.95,5595.9,33.49,168.85) },
    { name = "Pier", Coords = vec4(-1846.06, -1227.31, 13.02,322.80) }, 
    { name = "Ilha", Coords = vec4(4480.34, -4493.35, 4.2,108.80) },
    --{ name = "HOSPITAL", Coords = {1164.08, -1520.58, 34.85, 0.72} },
    { name = "HOSPITAL", Coords = vec4(-805.6, -1202.38, 6.94,135.73) },
    { name = "PRAÇA", Coords = vec4(158.85, -1001.63, 29.36,154.43) },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANIMS
-----------------------------------------------------------------------------------------------------------------------------------------
local Anims = {
	{ ["Dict"] = "anim@amb@nightclub@dancers@crowddance_groups@hi_intensity", ["Name"] = "hi_dance_crowd_17_v2_male^2" },
	{ ["Dict"] = "anim@amb@nightclub@mini@dance@dance_solo@male@var_b@", ["Name"] = "high_center_down" },
	{ ["Dict"] = "anim@amb@nightclub@mini@dance@dance_solo@female@var_a@", ["Name"] = "med_center_up" }
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:OPENED
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	Citizen.Wait(1500)
	DoScreenFadeOut(0)
	ShutdownLoadingScreen()
	Citizen.Wait(1500)
	TriggerEvent("hudActived",false)
	local Ped = PlayerPedId()
	SetEntityCoords(Ped,233.85,-1387.59,29.55,false,false,false,false)
	SetEntityVisible(Ped,false,false)
	FreezeEntityPosition(Ped,true)
	SetEntityInvincible(Ped,true)
	SetEntityHeading(Ped,136.07)
	-- SetEntityHealth(Ped,101)
	-- SetPedArmour(Ped,0)

	Camera = CreateCam("DEFAULT_SCRIPTED_CAMERA",true)
	SetCamCoord(Camera,232.0,-1388.64,30.45)
	RenderScriptCams(true,true,0,true,true)
	SetCamRot(Camera,0.0,0.0,320.0,2)
	SetCamActive(Camera,true)
	if IsScreenFadedOut() then
		DoScreenFadeIn(1000)
	end
	vSERVER.joinIn()
end)

RegisterNetEvent("spawn:setCharacters")
AddEventHandler("spawn:setCharacters",function(Characters)
	if parseInt(#Characters) > 0 then
		Customization(Characters[1])
	end

	Wait(5000)

	SendNUIMessage({ Action = "Spawn", Table = Characters })
	SetNuiFocus(true,true)
	if IsScreenFadedOut() then
		DoScreenFadeIn(1000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHARACTERCHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("CharacterChosen",function(Data,Callback)
	if vSERVER.CharacterChosen(Data["Passport"]) then
		SendNUIMessage({ Action = "Close" })
	end
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NEWCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("NewCharacter",function(Data,Callback)
	vSERVER.NewCharacter(Data["name"],Data["lastname"],Data["sex"])

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SWITCHCHARACTER
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("SwitchCharacter",function(Data,Callback)
	for _,v in pairs(Characters) do
		if v["Passport"] == Data["Passport"] then
			Customization(v,true)
			break
		end
	end

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:FINISH
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Finish")
AddEventHandler("spawn:Finish",function(Open)
	local ped = PlayerPedId()
	if Open then
		local coords = GetEntityCoords(ped)
		Locate[1].Coords = vec4(coords.x,coords.y,coords.z,GetEntityHeading(ped))
		SetCamCoord(Camera,Locate[1]["Coords"]["x"],Locate[1]["Coords"]["y"],Locate[1]["Coords"]["z"] + 1)
		SendNUIMessage({ Action = "Location", Table = Locate })
		SetEntityVisible(ped,false,false)
		SetCamRot(Camera,0.0,0.0,0.0,2)
	else
		SetEntityVisible(ped,true,false)
		SendNUIMessage({ Action = "Close" })
		TriggerEvent("hudActived",true)
		SetNuiFocus(false,false)

		if DoesCamExist(Camera) then
			RenderScriptCams(false,false,0,false,false)
			SetCamActive(Camera,false)
			DestroyCam(Camera,false)
			Camera = nil
		end
		FreezeEntityPosition(ped,false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Spawn",function(Data,Callback)
	if DoesCamExist(Camera) then
		RenderScriptCams(false,false,0,false,false)
		SetCamActive(Camera,false)
		DestroyCam(Camera,false)
		Camera = nil
	end
	local ped = PlayerPedId()
	if #(GetEntityCoords(ped) - vec3(233.85,-1387.59,29.55)) <= 5 then
		SetEntityCoords(ped,55.04,-878.8,30.37)
	end
	SetEntityVisible(PlayerPedId(),true,false)
	SendNUIMessage({ Action = "Close" })
	TriggerEvent("hudActived",true)
	SetNuiFocus(false,false)
	FreezeEntityPosition(PlayerPedId(),false)
	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHOSEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Chosen",function(Data,Callback)
	local Ped = PlayerPedId()
	local Index = Data["index"]

	SetEntityCoords(Ped,Locate[Index]["Coords"]["x"],Locate[Index]["Coords"]["y"],Locate[Index]["Coords"]["z"] - 1)
	SetCamCoord(Camera,Locate[Index]["Coords"]["x"],Locate[Index]["Coords"]["y"],Locate[Index]["Coords"]["z"] + 1)
	SetCamRot(Camera,0.0,0.0,0.0,2)

	Callback("Ok")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CUSTOMIZATION
-----------------------------------------------------------------------------------------------------------------------------------------
function Customization(Table,Check)
	if loadModel(Table["Skin"]) then
		if Check then
			if GetEntityModel(PlayerPedId()) ~= GetHashKey(Table["Skin"]) then
				SetPlayerModel(PlayerId(),Table["Skin"])
				SetPedComponentVariation(PlayerPedId(),5,0,0,1)
			end
		else
			SetPlayerModel(PlayerId(),Table["Skin"])
			SetPedComponentVariation(PlayerPedId(),5,0,0,1)
		end

		local Ped = PlayerPedId()
		local Random = math.random(#Anims)
		if LoadAnim(Anims[Random]["Dict"]) then
			TaskPlayAnim(Ped,Anims[Random]["Dict"],Anims[Random]["Name"],8.0,8.0,-1,1,0,0,0,0)
		end

		Clothes(Ped,Table["Clothes"])
 		Barber(Ped,Table["Barber"])

		for Index,Overlay in pairs(Table["Tattoos"]) do
			SetPedDecoration(Ped,GetHashKey(Overlay[1]),GetHashKey(Index))
		end

		SetEntityVisible(Ped,true,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWN:INCREMENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("spawn:Increment")
AddEventHandler("spawn:Increment",function(Tables)
	for _,v in pairs(Tables) do
		Locate[#Locate + 1] = { ["Coords"] = v["Coords"], ["name"] = "" }
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLOTHES
-----------------------------------------------------------------------------------------------------------------------------------------
function Clothes(ped,data)
	if data then
		if data["backpack"] == nil then
			data["backpack"] = {}
			data["backpack"]["item"] = 0
			data["backpack"]["texture"] = 0
		end

		SetPedComponentVariation(ped,4,data["pants"]["item"] or 0,data["pants"]["texture"] or 0,1)
		SetPedComponentVariation(ped,3,data["arms"]["item"] or 0,data["arms"]["texture"] or 0,1)
		SetPedComponentVariation(ped,5,data["backpack"]["item"] or 0,data["backpack"]["texture"] or 0,1)
		SetPedComponentVariation(ped,8,data["tshirt"]["item"] or 0,data["tshirt"]["texture"] or 0,1)
		SetPedComponentVariation(ped,9,data["vest"]["item"] or 0,data["vest"]["texture"] or 0,1)
		SetPedComponentVariation(ped,11,data["torso"]["item"] or 0,data["torso"]["texture"] or 0,1)
		SetPedComponentVariation(ped,6,data["shoes"]["item"] or 0,data["shoes"]["texture"] or 0,1)
		SetPedComponentVariation(ped,1,data["mask"]["item"] or 0,data["mask"]["texture"] or 0,1)
		SetPedComponentVariation(ped,10,data["decals"]["item"] or 0,data["decals"]["texture"] or 0,1)
		SetPedComponentVariation(ped,7,data["accessory"]["item"] or 0,data["accessory"]["texture"] or 0,1)

		if data["hat"]["item"] ~= -1 and data["hat"]["item"] ~= 0 then
			SetPedPropIndex(ped,0,data["hat"]["item"],data["hat"]["texture"],1)
		else
			ClearPedProp(ped,0)
		end

		if data["glass"]["item"] ~= -1 and data["glass"]["item"] ~= 0 then
			SetPedPropIndex(ped,1,data["glass"]["item"],data["glass"]["texture"],1)
		else
			ClearPedProp(ped,1)
		end

		if data["ear"]["item"] ~= -1 and data["ear"]["item"] ~= 0 then
			SetPedPropIndex(ped,2,data["ear"]["item"],data["ear"]["texture"],1)
		else
			ClearPedProp(ped,2)
		end

		if data["watch"]["item"] ~= -1 and data["watch"]["item"] ~= 0 then
			SetPedPropIndex(ped,6,data["watch"]["item"],data["watch"]["texture"],1)
		else
			ClearPedProp(ped,6)
		end

		if data["bracelet"]["item"] ~= -1 and data["bracelet"]["item"] ~= 0 then
			SetPedPropIndex(ped,7,data["bracelet"]["item"],data["bracelet"]["texture"],1)
		else
			ClearPedProp(ped,7)
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- BARBER
-----------------------------------------------------------------------------------------------------------------------------------------
function Barber(ped,status)
	local data = status
	if data then
		SetPedHeadBlendData(ped,data.fathersID,data.mothersID,0,data.skinColor,0,0,f(data.shapeMix),0,0,false)
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

function f(n) 
	n = parseInt(n) + 0.00000
    return n 
end

function loadModel(model)
	while not HasModelLoaded(model) do
        RequestModel(model)
        Citizen.Wait(10)
    end
	return true
end
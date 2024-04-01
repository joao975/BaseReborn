-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
admVRP = {}
Tunnel.bindInterface("Admin",admVRP)
admSERVER = Tunnel.getInterface("Admin")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function admVRP.vehicleHash(vehicle)
    return GetEntityModel(vehicle)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ILHA
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        if IsPauseMenuActive() then
            timeDistance = 1
            SetRadarAsExteriorThisFrame()
            SetRadarAsInteriorThisFrame("h4_fake_islandx",vec(4700.0,-5145.0),0,0)
        end
        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTWAY
-----------------------------------------------------------------------------------------------------------------------------------------
function admVRP.teleportWay()
	local ped = PlayerPedId()
	local veh = GetVehiclePedIsUsing(ped)
	if IsPedInAnyVehicle(ped) then
		ped = veh
    end

	local waypointBlip = GetFirstBlipInfoId(8)
	local x,y,z = table.unpack(Citizen.InvokeNative(0xFA7C7F0AADF25D09,waypointBlip,Citizen.ResultAsVector()))

	local ground
	local groundFound = false
	local groundCheckHeights = { 0.0,50.0,100.0,150.0,200.0,250.0,300.0,350.0,400.0,450.0,500.0,550.0,600.0,650.0,700.0,750.0,800.0,850.0,900.0,950.0,1000.0,1050.0,1100.0 }

	for i,height in ipairs(groundCheckHeights) do
		SetEntityCoordsNoOffset(ped,x,y,height,0,0,1)

		RequestCollisionAtCoord(x,y,z)
		while not HasCollisionLoadedAroundEntity(ped) do
			Citizen.Wait(10)
		end
		Citizen.Wait(20)

		ground,z = GetGroundZFor_3dCoord(x,y,height)
		if ground then
			z = z + 1.0
			groundFound = true
			break;
		end
	end

	if not groundFound then
		z = 1200
		GiveDelayedWeaponToPed(ped,0xFBAB5776,1,0)
	end

	RequestCollisionAtCoord(x,y,z)
	while not HasCollisionLoadedAroundEntity(ped) do
		Citizen.Wait(10)
	end

	SetEntityCoordsNoOffset(ped,x,y,z,0,0,1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
function admVRP.teleportLimbo()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))
	local _,vector = GetNthClosestVehicleNode(x,y,z,math.random(5,10),0,0,0)
	local x2,y2,z2 = table.unpack(vector)

	SetEntityCoordsNoOffset(ped,x2,y2,z2+5,0,0,1)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHELETRIC
-----------------------------------------------------------------------------------------------------------------------------------------
local vehEletric = {
	["teslaprior"] = true,
	["voltic"] = true,
	["raiden"] = true,
	["neon"] = true,
	["tezeract"] = true,
	["cyclone"] = true,
	["surge"] = true,
	["dilettante"] = true,
	["dilettante2"] = true,
	["bmx"] = true,
	["cruiser"] = true,
	["fixter"] = true,
	["scorcher"] = true,
	["tribike"] = true,
	["tribike2"] = true,
	["tribike3"] = true
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("skinmenu")
AddEventHandler("skinmenu",function(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    if HasModelLoaded(mhash) then
        SetPlayerModel(PlayerId(),mhash)
        SetModelAsNoLongerNeeded(mhash)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADMINVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("adminVehicle")
AddEventHandler("adminVehicle",function(name,plate)
	local mHash = GetHashKey(name)

	RequestModel(mHash)
	while not HasModelLoaded(mHash) do
		RequestModel(mHash)
		Citizen.Wait(10)
	end

	if HasModelLoaded(mHash) then
		local ped = PlayerPedId()
		local nveh = CreateVehicle(mHash,GetEntityCoords(ped),GetEntityHeading(ped),true,false)

		SetVehicleDirtLevel(nveh,0.0)
		SetVehRadioStation(nveh,"OFF")
		SetVehicleNumberPlateText(nveh,plate)
		SetEntityAsMissionEntity(nveh,true,true)

		SetPedIntoVehicle(ped,nveh,-1)

		if vehEletric[vehname] then
			SetVehicleFuelLevel(nveh,0.0)
		else
			SetVehicleFuelLevel(nveh,100.0)
		end

		SetModelAsNoLongerNeeded(mHash)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELETENPCS
-----------------------------------------------------------------------------------------------------------------------------------------
function admVRP.deleteNpcs()
	local handle,ped = FindFirstPed()
	local finished = false
	repeat
		local coords = GetEntityCoords(ped)
		local coordsPed = GetEntityCoords(PlayerPedId())
		local distance = #(coords - coordsPed)
		if IsPedDeadOrDying(ped) and not IsPedAPlayer(ped) and distance < 3 then
			TriggerServerEvent("tryDeleteEntity",PedToNet(ped))
			finished = true
		end
		finished,ped = FindNextPed(handle)
	until not finished
	EndFindPed(handle)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- /SPEC Rusher#1337 CLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("SpecMode")
AddEventHandler("SpecMode", function(nsource)
    if not NetworkIsInSpectatorMode() and nsource then
        TriggerEvent("rsh:ExcecaoSpec", true)
        local nped = GetPlayerPed(GetPlayerFromServerId(nsource))
        --NetworkSetInSpectatorMode(true, nped)
        NetworkSetInSpectatorModeExtended(true,nped,true)
        TriggerEvent("Notify", "sucesso", "Você entrou no modo espectador.",4000)
    else
        TriggerEvent("rsh:ExcecaoSpec", false)
        --NetworkSetInSpectatorMode(false)
        NetworkSetInSpectatorModeExtended(false)
        TriggerEvent("Notify", "negado", "Você saiu do modo espectador.",4000) 
    end
end)


-----------------------------------------------------------------------------------------------------------------------------------------
-- NOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("nc",function(source,args,rawCommand)
	admSERVER.enablaNoclip()
end)

RegisterKeyMapping("nc","Admin: Noclip","keyboard","o")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("vehtuning")
AddEventHandler("vehtuning",function()
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped)
	if IsEntityAVehicle(vehicle) then
		SetVehicleModKit(vehicle,0)
		--SetVehicleWheelType(vehicle,7)
		SetVehicleMod(vehicle,0,GetNumVehicleMods(vehicle,0)-1,false)
		SetVehicleMod(vehicle,1,GetNumVehicleMods(vehicle,1)-1,false)
		SetVehicleMod(vehicle,2,GetNumVehicleMods(vehicle,2)-1,false)
		SetVehicleMod(vehicle,3,GetNumVehicleMods(vehicle,3)-1,false)
		SetVehicleMod(vehicle,4,GetNumVehicleMods(vehicle,4)-1,false)
		SetVehicleMod(vehicle,5,GetNumVehicleMods(vehicle,5)-1,false)
		SetVehicleMod(vehicle,6,GetNumVehicleMods(vehicle,6)-1,false)
		SetVehicleMod(vehicle,7,GetNumVehicleMods(vehicle,7)-1,false)
		SetVehicleMod(vehicle,8,GetNumVehicleMods(vehicle,8)-1,false)
		SetVehicleMod(vehicle,9,GetNumVehicleMods(vehicle,9)-1,false)
		SetVehicleMod(vehicle,10,GetNumVehicleMods(vehicle,10)-1,false)
		SetVehicleMod(vehicle,11,GetNumVehicleMods(vehicle,11)-1,false)
		SetVehicleMod(vehicle,12,GetNumVehicleMods(vehicle,12)-1,false)
		SetVehicleMod(vehicle,13,GetNumVehicleMods(vehicle,13)-1,false)
		SetVehicleMod(vehicle,14,16,false)
		SetVehicleMod(vehicle,15,GetNumVehicleMods(vehicle,15)-2,false)
		SetVehicleMod(vehicle,16,GetNumVehicleMods(vehicle,16)-1,false)
		ToggleVehicleMod(vehicle,17,true)
		ToggleVehicleMod(vehicle,18,true)
		ToggleVehicleMod(vehicle,19,true)
		ToggleVehicleMod(vehicle,20,true)
		ToggleVehicleMod(vehicle,21,true)
		ToggleVehicleMod(vehicle,22,true)
		--SetVehicleMod(vehicle,23,1,false)
		SetVehicleMod(vehicle,24,1,false)
		SetVehicleMod(vehicle,25,GetNumVehicleMods(vehicle,25)-1,false)
		SetVehicleMod(vehicle,27,GetNumVehicleMods(vehicle,27)-1,false)
		SetVehicleMod(vehicle,28,GetNumVehicleMods(vehicle,28)-1,false)
		SetVehicleMod(vehicle,30,GetNumVehicleMods(vehicle,30)-1,false)
		--SetVehicleMod(vehicle,33,GetNumVehicleMods(vehicle,33)-1,false)
		SetVehicleMod(vehicle,34,GetNumVehicleMods(vehicle,34)-1,false)
		SetVehicleMod(vehicle,35,GetNumVehicleMods(vehicle,35)-1,false)
		SetVehicleMod(vehicle,38,GetNumVehicleMods(vehicle,38)-1,true)
        SetVehicleWindowTint(vehicle,1)
        --SetVehicleTyresCanBurst(vehicle,false)
        --SetVehicleNumberPlateText(vehicle,"LAST")
        --SetVehicleNumberPlateTextIndex(vehicle,5)
    end
end)



--[ DEBUG ]-------------------------------------------------------------------------------------------------------------------

local dickheaddebug = false

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

RegisterNetEvent("ToggleDebug")
AddEventHandler("ToggleDebug",function()
	dickheaddebug = not dickheaddebug
    if dickheaddebug then
        TriggerEvent('chatMessage',"DEBUG",{255,70,50},"ON")
        debugon()
    else
        TriggerEvent('chatMessage',"DEBUG",{255,70,50},"OFF")
    end
end)

local inFreeze = false

function GetVehicle()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstVehicle()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Veh: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
    return rped
end

function GetObject()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 10.0 then
            distanceFrom = distance
            rped = ped
            --FreezeEntityPosition(ped, inFreeze)
	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"]+1, "Obj: " .. ped .. " Model: " .. GetEntityModel(ped) .. "" )
	    	end
        end
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end

function getNPC()
    local playerped = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstPed()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if canPedBeUsed(ped) and distance < 30.0 and (distanceFrom == nil or distance < distanceFrom) then
            distanceFrom = distance
            rped = ped

	    	if IsEntityTouchingEntity(GetPlayerPed(-1), ped) then
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) .. " IN CONTACT" )
	    	else
	    		DrawText3Ds(pos["x"],pos["y"],pos["z"], "Ped: " .. ped .. " Model: " .. GetEntityModel(ped) .. " Relationship HASH: " .. GetPedRelationshipGroupHash(ped) )
	    	end

            FreezeEntityPosition(ped, inFreeze)
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return rped
end

function canPedBeUsed(ped)
    if ped == nil then
        return false
    end
    if ped == GetPlayerPed(-1) then
        return false
    end
    if not DoesEntityExist(ped) then
        return false
    end
    return true
end

function debugon()
Citizen.CreateThread( function()

    while true do
        Citizen.Wait(4)
        
        if dickheaddebug then
            local pos = GetEntityCoords(GetPlayerPed(-1))

            local forPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 1.0, 0.0)
            local backPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -1.0, 0.0)
            local LPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 1.0, 0.0, 0.0)
            local RPos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -1.0, 0.0, 0.0) 

            local forPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, 2.0, 0.0)
            local backPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0, -2.0, 0.0)
            local LPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 2.0, 0.0, 0.0)
            local RPos2 = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), -2.0, 0.0, 0.0)    

            local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
            local currentStreetHash, intersectStreetHash = GetStreetNameAtCoord(x, y, z, currentStreetHash, intersectStreetHash)
            currentStreetName = GetStreetNameFromHashKey(currentStreetHash)

            drawTxtS(0.8, 0.50, 0.4,0.4,0.30, "Heading: " .. GetEntityHeading(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.52, 0.4,0.4,0.30, "Coords: " .. pos, 55, 155, 55, 255)
            drawTxtS(0.8, 0.54, 0.4,0.4,0.30, "Attached Ent: " .. GetEntityAttachedTo(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.56, 0.4,0.4,0.30, "Health: " .. GetEntityHealth(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.58, 0.4,0.4,0.30, "H a G: " .. GetEntityHeightAboveGround(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.60, 0.4,0.4,0.30, "Model: " .. GetEntityModel(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.62, 0.4,0.4,0.30, "Speed: " .. GetEntitySpeed(GetPlayerPed(-1)), 55, 155, 55, 255)
            drawTxtS(0.8, 0.64, 0.4,0.4,0.30, "Frame Time: " .. GetFrameTime(), 55, 155, 55, 255)
            drawTxtS(0.8, 0.66, 0.4,0.4,0.30, "Street: " .. currentStreetName, 55, 155, 55, 255)
            
            
            DrawLine(pos,forPos, 255,0,0,115)
            DrawLine(pos,backPos, 255,0,0,115)

            DrawLine(pos,LPos, 255,255,0,115)
            DrawLine(pos,RPos, 255,255,0,115)

            DrawLine(forPos,forPos2, 255,0,255,115)
            DrawLine(backPos,backPos2, 255,0,255,115)

            DrawLine(LPos,LPos2, 255,255,255,115)
            DrawLine(RPos,RPos2, 255,255,255,115)

            local nearped = getNPC()

            local veh = GetVehicle()

            local nearobj = GetObject()

            if IsControlJustReleased(0, 38) then
                if inFreeze then
                    inFreeze = false
                    TriggerEvent("Notify","aviso","Freeze ON.",5000)
                else
                    inFreeze = true
                    TriggerEvent("Notify","aviso","Freeze OFF.",5000)
                end
            end
        else
            break
        end
    end
end)
end

function drawTxtS(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(0.25, 0.25)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

RegisterNetEvent('Congelar')
AddEventHandler('Congelar',function(source)
    local ped = PlayerPedId(-1)
    if not congelar then
        congelar = true
        while congelar do
            FreezeEntityPosition(ped, true);
            ShakeGameplayCam("LARGE_EXPLOSION_SHAKE",0.80)
            SetPedToRagdoll(ped,5000,5000,0,0,0,0)
            SetFlash(0,0,500,1000,500)
            TriggerEvent("vrp_hud:toggleHood",ped)
            Citizen.Wait(1000)
        end
    else
        congelar = false
        FreezeEntityPosition(ped, false);
        SetPedComponentVariation(ped,1,0,0,2)
    end
end)

RegisterNetEvent("derrubar2")
AddEventHandler("derrubar2",function()
    SetPedToRagdoll(PlayerPedId(),60000,60000,0,0,0,0)
    SetPedToRagdollWithFall(PlayerPedId(),3000,3000,0,ForwardVectorX,ForwardVectorY,ForwardVectorZ,10.0,0.0,0.0,0.0,0.0,0.0,0.0)
end)

RegisterNetEvent("derrubar")
AddEventHandler("derrubar",function()
    SetPedToRagdoll(PlayerPedId(),5000,5000,0,0,0,0)
    SetPedToRagdollWithFall(PlayerPedId(),3000,3000,0,ForwardVectorX,ForwardVectorY,ForwardVectorZ,10.0,0.0,0.0,0.0,0.0,0.0,0.0)
end)

-- -1919.02,-3037.17,23.59
local object = nil
RegisterNetEvent("createProp")
AddEventHandler("createProp",function(prop)
    local prop = prop
    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    mHash = GetHashKey(prop)
    object = CreateObject(mHash,x + 1.0,y + 1.0,z-1.0,true,true,true)
    SetEntityHeading(object, 317.70)
    FreezeEntityPosition(object,true)
end)

RegisterNetEvent("deleteProp")
AddEventHandler("deleteProp",function()
    TriggerServerEvent("tryDeleteEntity",ObjToNet(object))
end)

----------[ DRIFT ]------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(PlayerPedId())
        local timeDistance = 1000
        if IsPedInAnyVehicle(ped) then
            local speed = GetEntitySpeed(vehicle)*2.236936
            if GetPedInVehicleSeat(vehicle,-1) == ped 
                and (GetEntityModel(vehicle) ~= GetHashKey("coach") 
                    and GetEntityModel(vehicle) ~= GetHashKey("bus") 
                    and GetEntityModel(vehicle) ~= GetHashKey("youga2") 
                    and GetEntityModel(vehicle) ~= GetHashKey("ratloader") 
                    and GetEntityModel(vehicle) ~= GetHashKey("taxi") 
                    and GetEntityModel(vehicle) ~= GetHashKey("boxville4") 
                    and GetEntityModel(vehicle) ~= GetHashKey("trash2") 
                    and GetEntityModel(vehicle) ~= GetHashKey("tiptruck") 
                    and GetEntityModel(vehicle) ~= GetHashKey("rebel") 
                    and GetEntityModel(vehicle) ~= GetHashKey("speedo") 
                    and GetEntityModel(vehicle) ~= GetHashKey("phantom") 
                    and GetEntityModel(vehicle) ~= GetHashKey("packer") 
                    and GetEntityModel(vehicle) ~= GetHashKey("paramedicoambu")) then
                    if speed <= 100.0 then
                        timeDistance = 50
                    if IsControlPressed(1,21) then
                        SetVehicleReduceGrip(vehicle,true)
                    else
                        SetVehicleReduceGrip(vehicle,false)
                    end
                end
            end
        end
        Citizen.Wait(timeDistance)
    end
end)
local CurrentElevator
local CurrentFloor

local GameTimer = GetGameTimer()

local Functions = {

    ['close'] = function()
        SendNUIMessage({ action = 'close' })
        SetNuiFocus(false, false)
    end,
    
    ['open'] = function()
        local Ped = PlayerPedId()
        local PlayerCoord = GetEntityCoords(Ped)

        for i = 1, #Elevators do
            for j = 1, #Elevators[i] do
                local Floor = Elevators[i][j]
                if #(PlayerCoord - vector3(Floor['Coord']['x'], Floor['Coord']['y'], Floor['Coord']['z'])) <= 1.3 then
					
					if IsPedInAnyVehicle(Ped) and not Floor['CanUseVehicle'] then
						Notify('~r~Veículos são proibidos no andar selecionado')
						return
					end
		
                    local Data = {}
                    for k, v in pairs(Elevators[i]) do
                        local name = v['Name'] or tostring(k)
                        table.insert(Data, { id = k, name = name })
                    end
                    
                    CurrentFloor = j
                    CurrentElevator = i
                    SetNuiFocus(true, true)
                    SendNUIMessage({ action = 'openElevator', andares = Data })
                    break
                end
            end
        end
    end,
    
    ['teleport'] = function(id)
        local Floor = Elevators[CurrentElevator][id]
		local Ped = PlayerPedId()
		
		if IsPedInAnyVehicle(Ped) and not Floor['CanUseVehicle'] then
			Notify('~r~Veículos são proibidos no andar selecionado')
			return
		end
		
		if (CurrentFloor == id) then
			Notify('~y~Você já está no andar selecionado')
			return
		end

        if Floor then
            local Entity = GetVehiclePedIsIn(Ped) ~= 0 and GetVehiclePedIsIn(Ped) or Ped
			
			SetNuiFocus(false, false)
			SendNUIMessage({ action = 'bell' })
            SendNUIMessage({ action = 'close' })
			
			GameTimer = (GetGameTimer() + 3 * 1000)
			
            NetworkFadeOutEntity(Entity, false, true)
			Wait(500)
			
            DoScreenFadeOut(500)
            Wait(500)
            
            SetEntityCoordsNoOffset(Entity, Floor['Coord']['x'], Floor['Coord']['y'], Floor['Coord']['z'], false, false, false)
            
            while not HasCollisionLoadedAroundEntity(Entity) do
			
                FreezeEntityPosition(Entity, true)
                SetEntityCoords(Entity, Floor['Coord']['x'], Floor['Coord']['y'], Floor['Coord']['z'], 1, 0, 0, 1)
                RequestCollisionAtCoord(Floor['Coord']['x'], Floor['Coord']['y'], Floor['Coord']['z'])
                
                Wait(500)
            end

            SetEntityCoordsNoOffset(Entity, Floor['Coord']['x'], Floor['Coord']['y'], Floor['Coord']['z'], false, false, false)
            SetVehicleOnGroundProperly(Entity)
            
            local EntityCoord = GetEntityCoords(Entity)
            local deltaX = Floor['Coord']['x'] - EntityCoord['x']
            local deltaY = Floor['Coord']['y'] - EntityCoord['y']
            local angle = math.atan2(deltaY, deltaX) * (180 / math.pi)

            angle += 180 < 0 and angle + 180 + 360 or angle + 180

            SetGameplayCamRelativeHeading(angle)
            SetGameplayCamRelativePitch(-20.0, 1.0)
            
            SetEntityHeading(Entity, Floor['Coord']['w'])
            Wait(500)
            
			DoScreenFadeIn(500)			
            FreezeEntityPosition(Entity, false)
            NetworkFadeInEntity(Entity, true)
			
        end
    end
}

function Notify(Text, Seconds)
	local Text, Seconds = Text or "", Seconds or 5

	BeginTextCommandThefeedPost("STRING")
	AddTextComponentSubstringPlayerName(Text)
	EndTextCommandThefeedPostTicker(false,true)

	SetTimeout(Seconds * 1000,function()
		ThefeedRemoveItem()
	end)
end

RegisterNUICallback('UIRequest', function(data, cb)
    local Action = data['action']
    local FloorId = data['andarId']
    Functions[Action](FloorId)
end)

RegisterCommand('+OpenElevator', function()
	if (GetGameTimer() >= GameTimer) then
		Functions:open()
	end
end)

RegisterKeyMapping("+OpenElevator", "Open Elevator", "keyboard", "E")

CreateThread(function()

    local DrawCoords = {}
	
    for _, k in pairs(Elevators) do
        for _, v in pairs(k) do
            table.insert(DrawCoords, vector3(v['Coord']['x'], v['Coord']['y'], v['Coord']['z']))
        end
    end

    while true do
	
        local idleTime = 1000
        local playerPos = GetEntityCoords(PlayerPedId())
		
        for i = 1, #DrawCoords do
            local dist = #(playerPos - DrawCoords[i])
			
            if dist < 20 then
                idleTime = 5
				
				if dist < 10 and (GetGameTimer() >= GameTimer) then
				
					DrawMarker(27, DrawCoords[i]['x'], DrawCoords[i]['y'], DrawCoords[i]['z'] - 0.95, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.75, 1.75, 0.0, 0, 0, 0, 70, false, false, 0, true )
				--	DrawMarker(30,DrawCoords[i]['x'], DrawCoords[i]['y'], DrawCoords[i]['z']-0.45,0,0,0,0.0,0,0,0.3,0.3,0.3,255,255,255,180,0,0,0,1)

				end
				 
            end		
        end
        Wait(idleTime)
    end
end)
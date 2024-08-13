-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
doorsVRP = {}
Tunnel.bindInterface("doors",doorsVRP)
vSERVERDoor = Tunnel.getInterface("doors")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local doors = nil
local tempData = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DOORSUPDATE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("doors:doorsUpdate")
AddEventHandler("doors:doorsUpdate",function(status)
	doors = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADBUTTON
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		if doors ~= nil then
			for k,v in pairs(doors) do
				local distance = #(coords - vector3(v.x,v.y,v.z))
				if distance <= v.distance then
					local door = GetClosestObjectOfType(v.x,v.y,v.z,1.0,v.hash,false,false,false)
					if doors ~= 0 then
						if v.lock then
							local _,h = GetStateOfClosestDoorOfType(v.hash,v.x,v.y,v.z,_,h)
							if h > -0.02 and h < 0.02 then
								FreezeEntityPosition(door,true)
							end
						else
							FreezeEntityPosition(door,false)
						end

						if distance <= v.press then
							timeDistance = 4
							if v.text then
								if v.lock then
									DrawText3D(v.x,v.y,v.z,"🔒")
								else
									DrawText3D(v.x,v.y,v.z,"🔓")
								end
							end

							if IsControlJustPressed(1,38) and vSERVERDoor.doorsPermission(k) then
								v.lock = not v.lock
								vSERVERDoor.doorsStatistics(k,v.lock)
								vRP._playAnim(true,{"anim@heists@keycard@","exit"},false)
								Citizen.Wait(350)
								vRP.stopAnim()
							end
						end
					end
				end
			end
		end
		Citizen.Wait(timeDistance)
	end
end)

function doorsVRP.getDoorInfos()
	local rayCastCam = function(flags, ignore, distance)
        local coords, normal = GetWorldCoordFromScreenCoord(0.5, 0.5)
        local destination = coords + normal * (distance or 10)
        local handle = StartShapeTestLosProbe(coords.x, coords.y, coords.z, destination.x, destination.y, destination.z, flags or 511, PlayerPedId(), ignore or 4)
    
        while true do
            Wait(0)
    
            local retval, hit, endCoords, surfaceNormal, materialHash, entityHit = GetShapeTestResultIncludingMaterial(handle)
    
            if retval ~= 1 then
                return hit, entityHit, endCoords, surfaceNormal, materialHash
            end
        end
    end
    isAddingDoorlock = true
    repeat
        DisablePlayerFiring(PlayerId(), true)
        DisableControlAction(0, 25, true)

        local hit, entity, coords = rayCastCam(1|16)
        local changedEntity = lastEntity ~= entity
        local doorA = tempData[1] and tempData[1].entity

        if changedEntity and lastEntity ~= doorA then
            SetEntityDrawOutline(lastEntity, false)
        end

        lastEntity = entity

        if hit then
            DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.2, 0.2, 0.2, 255, 42, 24, 100, false, false, 0, true, false, false, false)
        end

        if hit and entity > 0 and GetEntityType(entity) == 3 and (doorA ~= entity) then
            if changedEntity then
                SetEntityDrawOutline(entity, true)
            end

            if IsDisabledControlJustPressed(0, 24) then
                isAddingDoorlock = false
                local data = {
					x = coords.x,
					y = coords.y,
					z = coords.z,
                    hash = GetEntityModel(entity)
                }
                SetEntityDrawOutline(entity, false)
                return data
            end
        end

        if IsDisabledControlJustPressed(0, 25) then
            SetEntityDrawOutline(entity, false)

            if not doorA then
                isAddingDoorlock = false
                return
            end

            SetEntityDrawOutline(doorA, false)
            table.wipe(tempData)
        end
    until not isAddingDoorlock
end

function TryGetDoor()
    local playerped = PlayerPedId()
    local playerCoords = GetEntityCoords(playerped)
    local handle, ped = FindFirstObject()
    local success
    local rped = nil
    local distanceFrom
    repeat
        local pos = GetEntityCoords(ped)
        local distance = GetDistanceBetweenCoords(playerCoords, pos, true)
        if distance < 1.5 then
            distanceFrom = distance
            --FreezeEntityPosition(ped, true)
			rped = ped
	    	if IsEntityTouchingEntity(playerped, ped) then
				rped = ped
				break
	    	end
        end
        success, ped = FindNextObject(handle)
    until not success
    EndFindObject(handle)
    return rped
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = GetScreenCoordFromWorldCoord(x,y,z)

	if onScreen then
		BeginTextCommandDisplayText("STRING")
		AddTextComponentSubstringKeyboardDisplay(text)
		SetTextColour(255,255,255,150)
		SetTextScale(0.35,0.35)
		SetTextFont(4)
		SetTextCentre(1)
		EndTextCommandDisplayText(_x,_y)
	end
end
local lastSpectateLocation = {}
isSpectateEnabled = false
storedTargetPed = nil
local storedTargetPlayerId = -1
local storedGameTag = ""

RegisterCommand('endSpectate', function()
    if isSpectateEnabled then
        toggleSpectate(storedTargetPed)
        preparePlayerForSpec(false)
        TriggerServerEvent('will_admin/server/stop-spectate')
    end
end)

function sendMessage(pMsg)
    TriggerEvent('Notify', 'importante', pMsg, 5000)
end

-- [ Threads ] --

Citizen.CreateThread(function()
    while true do
        if isSpectateEnabled then
            createGamerTagInfo()
        else
            clearGamerTagInfo()
        end
        Citizen.Wait(100)
    end
end)

-- [ Functions ] --

function calculateSpectatorCoords(coords)
    return vec3(coords[1], coords[2], coords[3] - 15.0)
end

function createGamerTagInfo()
    if storedGameTag and IsMpGamerTagActive(storedGameTag) then return end
    local nameTag = ('[%d] %s'):format(GetPlayerServerId(storedTargetPlayerId), GetPlayerName(storedTargetPlayerId))
    storedGameTag = CreateFakeMpGamerTag(storedTargetPed, nameTag, false, false, '', 0, 0, 0, 0)
    SetMpGamerTagVisibility(storedGameTag, 2, 1)  --set the visibility of component 2(healthArmour) to true
    SetMpGamerTagAlpha(storedGameTag, 2, 255) --set the alpha of component 2(healthArmour) to 255
    SetMpGamerTagHealthBarColor(storedGameTag, 129) --set component 2(healthArmour) color to 129(HUD_COLOUR_YOGA)
    SetMpGamerTagVisibility(storedGameTag, 4, NetworkIsPlayerTalking(i))
end

function clearGamerTagInfo()
    if not storedGameTag then return end
    RemoveMpGamerTag(storedGameTag)
    storedGameTag = nil
end

function preparePlayerForSpec(bool)
    local playerPed = PlayerPedId()
    FreezeEntityPosition(playerPed, bool)
    SetEntityVisible(playerPed, not bool, 0)
end

function createSpectatorTeleportThread()
    CreateThread(function()
        while isSpectateEnabled do
            Citizen.Wait(500)
            if not DoesEntityExist(storedTargetPed) then
                local _ped = GetPlayerPed(storedTargetPlayerId)
                if _ped > 0 then
                    if _ped ~= storedTargetPed then
                        storedTargetPed = _ped
                    end
                    storedTargetPed = _ped
                else
                    toggleSpectate(storedTargetPed, storedTargetPlayerId)
                    break
                end
            end
            local newSpectateCoords = calculateSpectatorCoords(GetEntityCoords(storedTargetPed))
            SetEntityCoords(PlayerPedId(), newSpectateCoords.x, newSpectateCoords.y, newSpectateCoords.z, 0, 0, 0, false)
        end
    end)
end

function toggleSpectate(targetPed, targetPlayerId)
    local playerPed = PlayerPedId()
    if isSpectateEnabled then
        isSpectateEnabled = false
        if not lastSpectateLocation then
            print('Last location previous to spectate was not stored properly')
        end
        if not storedTargetPed then
            print('Target ped was not stored to unspectate')
        end
        DoScreenFadeOut(500)
        while not IsScreenFadedOut() do Citizen.Wait(0) end
        RequestCollisionAtCoord(lastSpectateLocation.x, lastSpectateLocation.y, lastSpectateLocation.z)
        SetEntityCoords(playerPed, lastSpectateLocation.x, lastSpectateLocation.y, lastSpectateLocation.z - 1.0)
        while not HasCollisionLoadedAroundEntity(playerPed) do
            Citizen.Wait(5)
        end
        preparePlayerForSpec(false)
        NetworkSetInSpectatorMode(false, storedTargetPed)
        clearGamerTagInfo()
        DoScreenFadeIn(500)
        sendMessage('Stopped spectating '..GetPlayerName(storedTargetPlayerId)..' ('..GetPlayerServerId(storedTargetPlayerId)..')')
        storedTargetPed = nil
    else
        storedTargetPed = targetPed
        storedTargetPlayerId = targetPlayerId
        local targetCoords = GetEntityCoords(targetPed)
        RequestCollisionAtCoord(targetCoords.x, targetCoords.y, targetCoords.z)
        while not HasCollisionLoadedAroundEntity(targetPed) do
            Citizen.Wait(5)
        end
        NetworkSetInSpectatorMode(true, targetPed)
        DoScreenFadeIn(500)
        sendMessage('Started spectating '..GetPlayerName(storedTargetPlayerId)..' ('..GetPlayerServerId(storedTargetPlayerId)..')')
        isSpectateEnabled = true
        createSpectatorTeleportThread()
    end
end

function cleanupFailedResolve()
    local playerPed = PlayerPedId()
    RequestCollisionAtCoord(lastSpectateLocation.x, lastSpectateLocation.y, lastSpectateLocation.z)
    SetEntityCoords(playerPed, lastSpectateLocation.x, lastSpectateLocation.y, lastSpectateLocation.z)
    while not HasCollisionLoadedAroundEntity(playerPed) do
        Citizen.Wait(5)
    end
    preparePlayerForSpec(false)
    DoScreenFadeIn(500)
    sendMessage('Stopped spectating, could not find player..', 'error')
end

-- [ Events ] --

RegisterNetEvent('Mercy/client/specPlayer')
AddEventHandler('Mercy/client/specPlayer', function(targetServerId, coords)
    local spectatorPed = PlayerPedId()
    lastSpectateLocation = GetEntityCoords(spectatorPed)
    local targetPlayerId = GetPlayerFromServerId(targetServerId)
    if targetPlayerId == PlayerId() then
        return sendMessage('Não pode spectar você mesmo...', 'error')
    end
    DoScreenFadeOut(500)
    while not IsScreenFadedOut() do Citizen.Wait(0) end
    local tpCoords = calculateSpectatorCoords(coords)
    SetEntityCoords(spectatorPed, tpCoords.x, tpCoords.y, tpCoords.z, 0, 0, 0, false)
    preparePlayerForSpec(true)
    local resolvePlayerAttempts = 0
    local resolvePlayerFailed
    repeat
        if resolvePlayerAttempts > 100 then
            resolvePlayerFailed = true
            break;
        end
        Citizen.Wait(50)
        print('[SPECTATE] Waiting for player...')
        targetPlayerId = GetPlayerFromServerId(targetServerId)
        resolvePlayerAttempts = resolvePlayerAttempts + 1
    until (GetPlayerPed(targetPlayerId) > 0) and targetPlayerId ~= -1
    if resolvePlayerFailed then
        return cleanupFailedResolve()
    end
    print('[SPECTATE] Succesfully found player!')
    toggleSpectate(GetPlayerPed(targetPlayerId), targetPlayerId)
end)

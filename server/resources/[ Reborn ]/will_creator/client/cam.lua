-- #########################
--      VARIABLES
-- #########################

spawnCam = nil
creatorCam = nil
multicharCam = nil
camOffset = 2
animActived = false
headingToCam = GetEntityHeading(PlayerPedId())

-- #########################
--      SPAWN
-- #########################

function createSpawnCamera()
    local playerCoords = GetEntityCoords(PlayerPedId())
    spawnCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(spawnCam, playerCoords.x, playerCoords.y, playerCoords.z)
    SetCamRot(spawnCam, -90.0, 0, 0)
    SetCamParams(spawnCam, Config.DefaultCoords.x, Config.DefaultCoords.y, Config.DefaultCoords.z, -90.0, 0, 0, 70.0, 2500, 1, 0, 2);
    SetCamActive(spawnCam, true)
    RenderScriptCams(true, false, 1, true, true)
end

-- #########################
--      CREATOR
-- #########################

local cameras = {
    body = { coords = vec3(0.0, 1.1, 0.7), point = vec3(0.0,0.0,0.7), f = function() freezeAnim("mp_sleep", "bind_pose_180", 49, true) end }, 
    eye = { coords = vec3(0.0, 0.32, 0.7), point = vec3(0.0,0.0,0.7), f = function() freezeAnim("mp_sleep", "bind_pose_180", 49, true) end },
    nose = { coords = vec3(0.0, 0.32, 0.66), point = vec3(0.0,0.0,0.66), f = function() freezeAnim("mp_sleep", "bind_pose_180", 49, true) end },
    mouth = { coords = vec3(0.0, 0.32, 0.63), point = vec3(0.0,0.0,0.63), f = function() freezeAnim("mp_sleep", "bind_pose_180", 49, true) end },
    head = { coords = vec3(0.0, 0.5, 0.72), point = vec3(0.0,0.0,0.67), f = function() freezeAnim("mp_sleep", "bind_pose_180", 49, true) end },
}

activeCam = nil

function interpCamera(cameraName)
    if cameras[cameraName] then
        local cam = cameras[cameraName]
        if cam.f then cam.f() end
        if cameraName == activeCam then return end
        activeCam = cameraName
        local ped = PlayerPedId()
        local coord = GetOffsetFromEntityInWorldCoords(ped,cam.coords)
        local tempCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coord, 0,0,0, 50.0)
        local pointCoords = GetOffsetFromEntityInWorldCoords(ped,cam.point)
        SetCamActive(tempCam, true)
        SetCamActiveWithInterp(tempCam, creatorCam, 600, true, true)
        PointCamAtCoord(tempCam, pointCoords)
        CreateThread(function()
            Wait(600)
            DestroyCam(creatorCam)
            creatorCam = tempCam
        end)
    end
end

function createCamera()
    local ped = PlayerPedId()
    local groundCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    AttachCamToEntity(groundCam, ped, 0.0, -2.0, 0.0)
    SetCamActive(groundCam, true)
    RenderScriptCams(true, false, 1, true, true)
    activeCam = "body"
    local cam = cameras[activeCam]
    local coord = GetOffsetFromEntityInWorldCoords(ped,cam.coords)
    creatorCam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", coord, 0,0,0, 50.0)
    local pointCoords = GetOffsetFromEntityInWorldCoords(ped,cam.point)
    PointCamAtCoord(creatorCam, pointCoords)
    SetCamActive(creatorCam, true)
    SetCamActiveWithInterp(creatorCam, groundCam, 1000, true, true)
    if cam.f then cam.f() end
    CreateThread(function()
        Wait(1000)
        DestroyCam(groundCam)
    end)
end

function enableCam()
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 2.0, 0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(cam, false)
    if (not DoesCamExist(cam)) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 0, true, true)
        SetCamCoord(cam, coords.x, coords.y, coords.z + 0.2)
        SetCamRot(cam, 0.0, 0.0, GetEntityHeading(PlayerPedId()) + 180)
    end

    if customCamLocation ~= nil then
        SetCamCoord(cam, customCamLocation.x, customCamLocation.y, customCamLocation.z)
        SetCamRot(cam, 0.0, 0.0, customCamLocation.w)
    end

    headingToCam = GetEntityHeading(PlayerPedId()) + 90
    camOffset = 2.0
end

function GetPositionByRelativeHeading(ped, head, dist)
    local pedPos = GetEntityCoords(ped)
    local finPosx = pedPos.x + math.cos(head * (math.pi / 180)) * dist
    local finPosy = pedPos.y + math.sin(head * (math.pi / 180)) * dist
    return finPosx, finPosy
end

RegisterNUICallback('setupCam', function(data, cb)
    local value = data.value
    if not value then return end
    if cameras[value] then
        interpCamera(value)
    else
        local pedPos = GetEntityCoords(PlayerPedId())
        camOffset = 2.0
        local cx, cy = GetPositionByRelativeHeading(PlayerPedId(), headingToCam, camOffset)
        SetCamCoord(cam, cx, cy, pedPos.z + 0.2)
        PointCamAtCoord(cam, pedPos.x, pedPos.y, pedPos.z + 0.2)
    end
    cb('ok')
end)

-- #########################
--      MULTI CHAR
-- #########################

function IntroCam()
    local ped = PlayerPedId()
    local initCoord = Config.MulticharCoords
    teleport(ped,initCoord.x,initCoord.y,initCoord.z)
    SetEntityHeading(ped, initCoord.w)
    Wait(500)
    PointCamAtPedBone(multicharCam, ped, 31086, 0.0, 0.0, 0.0, true)
    local coords = GetOffsetFromEntityInWorldCoords(ped, 0, 1.1, 0)
    SetCamCoord(multicharCam, coords.x, coords.y, coords.z + 0.6)
    SetCamRot(multicharCam, 0.0, 0.0, GetEntityHeading(ped) + 180)

    SetCamUseShallowDofMode(multicharCam, true)
    SetCamNearDof(multicharCam, 0.7)
    SetCamFarDof(multicharCam, 5.3)
    SetCamDofStrength(multicharCam, 1.0)
    SetUseHiDof()
end

function enableMulticharCam()
    local coords = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0, 2.0, 0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(multicharCam, false)

    if (not DoesCamExist(multicharCam)) then
        multicharCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(multicharCam, true)
        RenderScriptCams(true, false, 0, true, true)
        SetCamCoord(multicharCam, coords.x, coords.y, coords.z + 0.2)
        SetCamRot(multicharCam, 0.0, 0.0, GetEntityHeading(PlayerPedId()) + 180)
    end

    if customCamLocation ~= nil then
        SetCamCoord(multicharCam, customCamLocation.x, customCamLocation.y, customCamLocation.z)
        SetCamRot(multicharCam, 0.0, 0.0, customCamLocation.w)
    end

    headingToCam = GetEntityHeading(PlayerPedId()) + 90
    camOffset = 2.0
end
--[[ 
function freezeAnim(dict, anim, flag, keep)
    local ped = PlayerPedId()
    if not keep then
        ClearPedTasks(ped)
    end
    loadAnim(dict)
    SetFacialIdleAnimOverride(ped, "pose_normal_1", 0)
    TaskPlayAnim(ped, dict, anim, 2.0, 2.0, -1, 49, 0, false, false, false)
    -- vRP.playAnim(true,{dict, anim},true)
    animActived = true
    CreateThread(function()
        while animActived do
            if not IsEntityPlayingAnim(PlayerPedId(),dict,anim,3) then
                TaskPlayAnim(PlayerPedId(),dict,anim,3.0,3.0,-1,49,0,0,0,0)
            end
            Wait(4)
        end
    end)
end
 ]]

function freezeAnim(dict, anim, flag, keep)
    if not keep then
        ClearPedTasks(PlayerPedId())
    end
    loadAnim(dict)
    TaskPlayAnim(PlayerPedId(), dict, anim, 2.0, 2.0, -1, flag or 1, 0, false, false, false)
    RemoveAnimDict(dict)
end

function disableCam(cam)
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(cam, false)
    FreezeEntityPosition(PlayerPedId(), false)
end


local playing = false

Citizen.CreateThread(function()
    while true do
		local idle = 500
        local ped = PlayerPedId()
        local playerpos = GetEntityCoords(ped)
        local object = GetClosestObjectOfType(playerpos,1.2,-1005355458,0,0,0)
		local coordsobj = GetEntityCoords(object)
		local objHeading = GetEntityHeading(object)
        if DoesEntityExist(object) and not playing then
			idle = 4
            DrawMarker(20,coordsobj.x, coordsobj.y, coordsobj.z + 1.0,0.0,0.0,0.0,180.0,0.0,0.0,0.3,0.3,0.3,255,255,255,255,true,true,2,true,nil,nil,false)
			if IsControlJustPressed(0,38) then
				SITTING_SCENE = NetworkCreateSynchronisedScene(coordsobj, objHeading - 90.0, 2, 1, 0, 1065353216, 0, 1065353216)
				RequestAnimDict('anim_casino_b@amb@casino@games@shared@player@')
				while not HasAnimDictLoaded('anim_casino_b@amb@casino@games@shared@player@') do
					Citizen.Wait(1)
				end
				local randomSit = ({'sit_enter_left', 'sit_enter_right'})[math.random(1, 2)]
				NetworkAddPedToSynchronisedScene(PlayerPedId(),SITTING_SCENE,'anim_casino_b@amb@casino@games@shared@player@',randomSit,2.0,-2.0,13,16,2.0,0)
				NetworkStartSynchronisedScene(SITTING_SCENE)
				
				local sex = 0
				local objrot = GetEntityRotation(object)
				local rot = objrot + vector3(0.0, 0.0, 180.0)
				if GetEntityModel(PlayerPedId()) == GetHashKey('mp_f_freemode_01') then sex = 1 end
				local L = 'anim_casino_a@amb@casino@games@slots@male'
				if sex == 1 then
					L = 'anim_casino_a@amb@casino@games@slots@female'
				end
				RequestAnimDict(L)
				while not HasAnimDictLoaded(L) do
					Citizen.Wait(1)
				end
				SITTING_SCENE = NetworkCreateSynchronisedScene(coordsobj + vector3(-0.2, 0.8, -0.12), rot, 2, 1, 0, 1065353216, 0, 1065353216)
				local rndspin = ({'base_idle_a', 'base_idle_b', 'base_idle_c', 'base_idle_d', 'base_idle_e', 'base_idle_f'})[math.random(1, 6)]
				NetworkAddPedToSynchronisedScene(PlayerPedId(),SITTING_SCENE,L,rndspin,2.0,2.0,13,16,2.0,0)
				NetworkStartSynchronisedScene(SITTING_SCENE)
				Citizen.Wait(1200)
				local Offset = GetObjectOffsetFromCoords(GetEntityCoords(object), GetEntityHeading(object), 0.0, -0.5, 0.6)
				local CamOffset = GetObjectOffsetFromCoords(GetEntityCoords(object), GetEntityHeading(object), 0.0, -0.5, 0.6)

				local Camposition = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', CamOffset.x, CamOffset.y, CamOffset.z+0.8, rot.x-25.0, rot.y, rot.z, 85.0, true, 2)
				SetCamActive(Camposition, true)
				ShakeCam(Camposition, 'HAND_SHAKE', 0.3)
				RenderScriptCams(true, 900, 900, true, false)
                Citizen.Wait(1200)
                OpenInsideTrack()
                playing = true
				Citizen.Wait(3000)

				-- Voltar a camera
                RenderScriptCams(false, 900, 900, true, false)
				if DoesCamExist(Camposition) then
					DestroyCam(Camposition, false)
				end
			end
        end
        Citizen.Wait(idle)
    end
end)
SetPlayerControl(PlayerId(), true, 0)

RegisterNetEvent("InsideTrack:LeaveInsideTrack")
AddEventHandler("InsideTrack:LeaveInsideTrack",function()
    local ped = PlayerPedId()
    local playerpos = GetEntityCoords(ped)
    FreezeEntityPosition(ped, false)
    SetEntityCoords(ped, playerpos.x, playerpos.y - 0.43, playerpos.z + 0.15, 1, 0, 0 , true)
    Citizen.Wait(200)
    RenderScriptCams(false, 900, 900, true, false)
    --DoScreenFadeOut(500)
    playing = false
    Citizen.Wait(600)
    LeaveInsideTrack()
    ClearPedTasks(GetPlayerPed(-1))
    ClearPedSecondaryTask(ped)
end)
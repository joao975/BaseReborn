local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
emP = Tunnel.getInterface("Lavagem")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS --
-----------------------------------------------------------------------------------------------------------------------------------------
local papel = false
local colocarpapel = false
local pegarnota = false
local colocarnota = false
local embalando = false
-------------------------------------------------------------------------------------------------
--[ AÇÃO ]---------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function() -- PEGAR PAPEL
	while true do
		local sleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Farms.lavagem['locais'][1], true ) <= 2 and not papel then
			local x,y,z = table.unpack(Farms.lavagem['locais'][1])
			DrawText3D(x,y,z, "[~r~E~w~] Para coletar o ~r~PAPEL~w~.")
			sleep = 4
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Farms.lavagem['locais'][1], true ) <= 2 and not papel then
				if IsControlJustPressed(0,38) and emP.checkItens() then
					local ped = PlayerPedId()
					papel = true
					vRP._playAnim(true,{"anim@heists@box_carry@","idle"},true)
					vRP.createObjects("anim@heists@box_carry@","idle","bkr_prop_prtmachine_paperream",50,28422,0.0,-0.35,-0.05,0.0,180.0,0.0)
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function() -- COLOCAR PAPEL
	while true do
		local sleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Farms.lavagem['locais'][2], true ) <= 2 and papel and not colocarpapel then
			local x,y,z = table.unpack(Farms.lavagem['locais'][2])
			DrawText3D(x,y,z, "[~r~E~w~] Para colocar o ~r~PAPEL~w~.")
			sleep = 4
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Farms.lavagem['locais'][2], true ) <= 2 and papel and not colocarpapel then
				if IsControlJustPressed(0,38) then
					local ped = PlayerPedId()
					colocarpapel = true
					vRP.removeObjects("one")
					vRP._stopAnim(source,false)
					notasfalsa = CreateObject(GetHashKey("bkr_prop_prtmachine_moneyream"),25.95,-1402.15,30.06-1.1,true,true,true) 
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function() -- PEGAR NOTAS FALSAS
	while true do
		local sleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Farms.lavagem['locais'][3], true ) <= 2 and colocarpapel and not pegarnota then
			local x,y,z = table.unpack(Farms.lavagem['locais'][3])
			DrawText3D(x,y,z, "[~r~E~w~] Para pegar as ~r~NOTAS FALSAS~w~.")
			sleep = 4
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Farms.lavagem['locais'][3], true ) <= 2 and colocarpapel and not pegarnota then
				if IsControlJustPressed(0,38) then
					local ped = PlayerPedId()
					pegarnota = true
					vRP._playAnim(true,{"anim@heists@box_carry@","idle"},true)
					vRP.createObjects("anim@heists@box_carry@","idle","bkr_prop_prtmachine_moneyream",50,28422,0.0,-0.35,-0.05,0.0,180.0,0.0)
					DeleteObject(notasfalsa)
				end
			end
		end	
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function() -- Cortar NOTAS FALSAS
	while true do
		local sleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Farms.lavagem['locais'][4], true ) <= 2 and pegarnota and not colocarnota then
			local x,y,z = table.unpack(Farms.lavagem['locais'][4])
			DrawText3D(x,y,z, "[~r~E~w~] Para cortas as ~r~NOTAS FALSAS~w~.")
			sleep = 4
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()),Farms.lavagem['locais'][4], true ) <= 2 and pegarnota and not colocarnota then
				if IsControlJustPressed(0,38) then
					local ped = PlayerPedId()
					colocarnota = true
					vRP.removeObjects("one")
					vRP._stopAnim(source,false)
					--notasfalsa1 = CreateObject(GetHashKey("bkr_prop_prtmachine_moneyream"),23.09,-1402.34,29.55-1.1,true,true,true)
					local  targetRotation = vec3(180.0, 180.0, 0.0)
					local x,y,z = table.unpack(vec3(1119.96,-3198.50,-40.95))  
		
					local animDict = "anim@amb@business@cfm@cfm_cut_sheets@"
			
					RequestAnimDict(animDict)
					RequestModel("bkr_prop_cutter_moneypage")
					RequestModel("bkr_prop_cutter_moneystrip")
					RequestModel("bkr_prop_cutter_moneystack_01a")
					RequestModel("bkr_prop_cutter_singlestack_01a")
					
		
					while not HasAnimDictLoaded(animDict) and
						not HasModelLoaded("bkr_prop_cutter_moneypage") and
						not HasModelLoaded("bkr_prop_cutter_moneystrip") and
						not HasModelLoaded("bkr_prop_cutter_singlestack_01a") and
						not HasModelLoaded("bkr_prop_cutter_moneystack_01a") do
						Citizen.Wait(100)
					end
		
					local cutter = GetClosestObjectOfType(
						GetEntityCoords(PlayerPedId()),
						3.0, 
						1731949568, 
						false, 
						false, 
						false
					)
		
					money_page = CreateObject(GetHashKey('bkr_prop_cutter_moneypage'), x, y, z-10, 1, 0, 1)
					money_stack = CreateObject(GetHashKey('bkr_prop_cutter_moneystack_01a'), x, y, z-10, 1, 0, 1)
					money_singleStack = CreateObject(GetHashKey('bkr_prop_cutter_singlestack_01a'), x, y, z-10, 1, 0, 1)
					money_strip = CreateObject(GetHashKey('bkr_prop_cutter_moneystrip'), x, y, z-10, 1, 0, 1)
				
		
					local netScene = NetworkCreateSynchronisedScene(x,y, z, targetRotation, 2, false, false, 1148846080, 0, 1.3)
					NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "extended_load_tune_cut_billcutter", 1.5, -4.0, 1, 16, 1148846080, 0)
					NetworkAddEntityToSynchronisedScene(money_page, netScene, animDict, "extended_load_tune_cut_singlemoneypage", 4.0, -8.0, 1)
					NetworkAddEntityToSynchronisedScene(money_stack, netScene, animDict, "extended_load_tune_cut_moneystack", 4.0, -8.0, 1)
					NetworkAddEntityToSynchronisedScene(money_singleStack, netScene, animDict, "extended_load_tune_cut_singlestack", 4.0, -8.0, 1)
					NetworkAddEntityToSynchronisedScene(cutter, netScene, animDict, "extended_load_tune_cut_papercutter", 4.0, -8.0, 1)
					NetworkAddEntityToSynchronisedScene(money_strip, netScene, animDict, "extended_load_tune_cut_singlemoneystrip", 4.0, -8.0, 1)


					NetworkStartSynchronisedScene(netScene)
					Citizen.Wait(150)

					
					Citizen.Wait(GetAnimDuration(animDict, "extended_load_tune_cut_billcutter") * 770)
					--TriggerEvent('Notify', 'sucesso', 'Você separou a bucha.')
					DeleteObject(money_page)
					DeleteObject(money_stack)
					DeleteObject(money_singleStack)
					DeleteObject(money_strip)
					--DeleteObject(table)
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function() -- EMBALAR NOTAS FALSAS
	while true do
		local sleep = 500
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Farms.lavagem['locais'][5], true ) <= 2 and colocarnota and not embalando then
			local x,y,z = table.unpack(Farms.lavagem['locais'][5])
			DrawText3D(x,y,z, "[~r~E~w~] Para embalas as ~r~NOTAS FALSAS~w~.")
			sleep = 4
			if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Farms.lavagem['locais'][5], true ) <= 2 and colocarnota and not embalando then
				if IsControlJustPressed(0,38) then
					local ped = PlayerPedId()
					local  targetRotation = vec3(180.0, 180.0, -90.0)
					local x,y,z = table.unpack(vec3(1115.76,-3196.52,-41.05)) 

					local animDict = "anim@amb@business@cfm@cfm_counting_notes@"
			
					RequestAnimDict(animDict)
					RequestModel("bkr_prop_coke_tin_01")
					RequestModel("bkr_prop_tin_cash_01a")
					RequestModel("bkr_prop_money_unsorted_01")
					RequestModel("bkr_prop_money_wrapped_01")
					RequestModel("bkr_prop_moneypack_01a")

					
					while not HasAnimDictLoaded(animDict) and
						not HasModelLoaded("bkr_prop_coke_tin_01") and
						not HasModelLoaded("bkr_prop_tin_cash_01a") and
						not HasModelLoaded("bkr_prop_money_wrapped_01") and
						not HasModelLoaded("bkr_prop_money_unsorted_01") do
						Citizen.Wait(100)
					end

					money_unsorted = CreateObject(GetHashKey('bkr_prop_money_unsorted_01'), x, y, z-10, 1, 0, 1)
					money_wrapped = CreateObject(GetHashKey('bkr_prop_money_wrapped_01'), x, y, z-10, 1, 0, 1)
					money_bucket = CreateObject(GetHashKey('bkr_prop_coke_tin_01'), x, y, z-10, 1, 0, 1)
					money_bucketCash = CreateObject(GetHashKey('bkr_prop_tin_cash_01a'), x, y, z-10, 1, 0, 1)

					local netScene = NetworkCreateSynchronisedScene(x,y, z, targetRotation, 2, false, false, 1148846080, 0, 1.3)
					NetworkAddPedToSynchronisedScene(ped, netScene, animDict, "note_counting_counter", 1.5, -4.0, 1, 16, 1148846080, 0)
					NetworkAddEntityToSynchronisedScene(money_unsorted, netScene, animDict, "note_counting_moneyunsorted", 4.0, -8.0, 1)
					NetworkAddEntityToSynchronisedScene(money_wrapped, netScene, animDict, "note_counting_moneywrap", 4.0, -8.0, 1)
					NetworkAddEntityToSynchronisedScene(money_bucket, netScene, animDict, "note_counting_moneybin", 4.0, -8.0, 1)
					NetworkAddEntityToSynchronisedScene(money_bucketCash, netScene, animDict, "note_counting_moneybin", 4.0, -8.0, 1)
		
					NetworkStartSynchronisedScene(netScene)
					Citizen.Wait(150)
					
					Citizen.Wait(GetAnimDuration(animDict, "note_counting_counter") * 770)
					--TriggerEvent('Notify', 'sucesso', 'Você separou a bucha.')
					DeleteObject(money_unsorted)
					DeleteObject(money_wrapped)
					DeleteObject(money_bucket)
					DeleteObject(money_bucketCash)
					embalando = false
					colocarnota = false
					pegarnota = false
					colocarpapel = false
					papel = false
					emP.checkPayment()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)


-------------------------------------------------------------------------------------------------
--[ ANTI-BUG ]-----------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
    	local sleep = 500
		if papel then
			sleep = 2
			DisableControlAction(0,167,true)
			DisableControlAction(0,21,true)
			DisableControlAction(0,22,true)
		end
		Citizen.Wait(sleep)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNÇÕES --
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D(x, y, z, text)
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
end
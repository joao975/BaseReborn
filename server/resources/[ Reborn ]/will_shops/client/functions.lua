isPrice = 0
lastFuel = 0
vehFuels = {}
isFuel = false
showNui = false
local gameTimer = GetGameTimer()
local vehClass = {
	[13] = 0.0,
	[14] = 0.0,
	[15] = 2.5,
	[21] = 0.0
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAIN THREADS
-----------------------------------------------------------------------------------------------------------------------------------------
function will.initThreads()
    Citizen.CreateThread(function()
        SetNuiFocus(false, false)
        while true do
            local timeDistance = 500
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            for k,v in pairs(GlobalState['Will_Shops']) do
                local managmentDis = #(coords - v['managment_coords'])
                local shopDis = #(coords - v['buy_products_coords'])
                local jobDis = #(coords - v['job_coords'])
                if managmentDis <= 2.0 then
                    timeDistance = 4
                    DrawText3D(v['managment_coords'].x,v['managment_coords'].y,v['managment_coords'].z,"~g~[E]~w~ Gerenciamento")
                    if IsControlJustPressed(0,38) then
                        openManagment(k)
                    end
                elseif shopDis <= 2.0 then
                    timeDistance = 4
                    DrawText3D(v['buy_products_coords'].x,v['buy_products_coords'].y,v['buy_products_coords'].z,"~g~[E]~w~ Abrir loja")
                    if IsControlJustPressed(0,38) then
                        openShop(k)
                    end
                elseif jobDis <= 2.0 then
                    timeDistance = 4
                    DrawText3D(v['job_coords'].x,v['job_coords'].y,v['job_coords'].z,"~g~[E]~w~ Emprego")
                    if IsControlJustPressed(0,38) then
                        checkShopJobs(k)
                    end
                end
            end
            Citizen.Wait(timeDistance)
        end
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE BOX
-----------------------------------------------------------------------------------------------------------------------------------------
function createBox()
    if Config.base == "creative" or Config.base == "summerz" then		
        vRP.createObjects("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
    else
        vRP._CarregarObjeto("anim@heists@box_carry@","idle","hei_prop_heist_box",50,28422)
    end
end

function removeObjects()
    if Config.base == "creative" or Config.base == "summerz" then	
		vRP.removeObjects()
	else
		vRP._DeletarObjeto()
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- WORKS THREADS - PRODUCTS
-----------------------------------------------------------------------------------------------------------------------------------------
function startThreadInWork(destiny, id, quantity, shop)
    local collected = 0
    local withBox = false
    local totalQuantity = quantity
    local newQuantity = parseInt(quantity / 5)
	addBlipCoords("Mercadoria", destiny)

    Citizen.CreateThread(function()
        while inWork and quantity > 0 do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local timeDistance = 500
            if not withBox then
                local distance = #(coords - vector3(destiny.x, destiny.y, destiny.z))
                if distance <= 10 then
                    timeDistance = 4
                    DrawMarker(23,destiny.x, destiny.y, destiny.z-0.95,0,0,0,0,0,0,2.0,2.0,1.0,240,203,88,250,0,0,0,0)
                    if distance <= 2 and not IsPedInAnyVehicle(ped) then
                        DrawText3D(destiny.x, destiny.y, destiny.z,"~g~[E]~w~ Coletar mercadoria")
                        if IsControlJustPressed(0,38) then
                            withBox = true
                            SetVehicleDoorOpen(workVeh, 6, true, false)
							async(function()
								createBox()
							end)
                        end
                    end
                end
            else
                local coordsVeh = GetEntityCoords(workVeh)
                local distance = #(coords - coordsVeh)
                
                if distance <= 5 then
                    timeDistance = 4
                    DrawText3D(coordsVeh.x, coordsVeh.y, coordsVeh.z,"~g~[E]~w~ Guardar mercadoria")
                    if IsControlJustPressed(0,38) then
                        withBox = false
						async(function()
							removeObjects()
						end)
                        collected = collected + newQuantity
                        if collected == totalQuantity then
                            quantity = 0
                        elseif collected + newQuantity >= totalQuantity then
                            newQuantity = collected - totalQuantity
                            quantity = 0
                        end
                    end
                end
            end
            Citizen.Wait(timeDistance)
        end
        if DoesBlipExist(workBlip) then
            RemoveBlip(workBlip)
        end
        endOfWork(shop, id)
    end)
end

function startWorkFuel(destiny, id, shop, data)
	local nearVeh = GetClosestVehicle(destiny.x, destiny.y, destiny.z,1.701,0,71)
    if nearVeh == 0 then
		addBlipCoords(data['name'], data['destiny'])
		local vHash = GetHashKey("tanker")
		loadModel(vHash)
		local tanker = CreateVehicle(vHash, destiny.x, destiny.y, destiny.z, destiny.w, true, false)
		local tankAttached = false
		Citizen.CreateThread(function()
			while inWork and not tankAttached do
				local ped = PlayerPedId()
				local coords = GetEntityCoords(ped)
				local timeDistance = 500
				local distance = #(coords - vector3(destiny.x, destiny.y, destiny.z))
				if distance <= 20 then
					timeDistance = 4
					DrawMarker(23,destiny.x, destiny.y, destiny.z-0.95,0,0,0,0,0,0,5.0,5.0,1.0,20,203,88,250,0,0,0,0)
					if IsEntityAttachedToEntity(tanker, workVeh) then
						tankAttached = true
					end
				end
				Citizen.Wait(timeDistance)
			end
			if DoesBlipExist(workBlip) then
				RemoveBlip(workBlip)
			end
			endOfWork(shop, id)
		end)
	else
        TriggerEvent(Config.Notify['NotifyEvent'], Config.Notify['NotifyTypes']['Denied'],"Já possui um veiculo na vaga!",5000)
		Citizen.Wait(5000)
		local deliveryCoords = Config.deliveryCoords["fuel"]
		local rand = math.random(1, #deliveryCoords)
		local destiny = deliveryCoords[rand]
		local newDestiny = vector4(destiny[1],destiny[2],destiny[3],destiny[4] or 0.0)
		startWorkFuel(newDestiny, id, shop, data)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GAMEEVENTTRIGGERED
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("gameEventTriggered",function(eventName,args)
	if eventName == "CEventNetworkPlayerEnteredVehicle" then
		if args[1] == PlayerId() then
			local vehPlate = GetVehicleNumberPlateText(args[2])
			vehFuels[vehPlate] = vSERVER.vehicleFuel(vehPlate)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLOOR
-----------------------------------------------------------------------------------------------------------------------------------------
function floor(num)
	local mult = 10 ^ 1
	return math.floor(num * mult + 0.5) / mult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONSUMEFUEL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	SetNuiFocus(false,false)
	while true do
		local timeDistance = 1999
		local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsUsing(ped)
			local speed = GetEntitySpeed(vehicle) * 2.236936
			if GetVehicleFuelLevel(vehicle) >= 1 then
				if speed >= 1 then
					local vehPlate = GetVehicleNumberPlateText(vehicle)
					if vehFuels[vehPlate] ~= nil then
						local vehClasses = GetVehicleClass(vehicle)
						vehFuels[vehPlate] = (vehFuels[vehPlate] - (floor(GetVehicleCurrentRpm(vehicle)) or 1.0) * (vehClass[vehClasses] or 1.0) / 10)
						SetVehicleFuelLevel(vehicle,vehFuels[vehPlate])
					end
					if GetPedInVehicleSeat(vehicle,-1) == ped then
						TriggerServerEvent("engine:tryFuel",vehPlate,vehFuels[vehPlate])
					end
				end
			else
				SetVehicleEngineOn(vehicle,false,true,true)
				timeDistance = 1
			end
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THRED FUEL
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 999
		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			if GetSelectedPedWeapon(ped) == 883325847 then
				local vehicle = GetPlayersLastVehicle()
				if DoesEntityExist(vehicle) then
					local coords = GetEntityCoords(ped)
					local coordsVeh = GetEntityCoords(vehicle)
					local vehFuel = GetVehicleFuelLevel(vehicle)
					local vehPlate = GetVehicleNumberPlateText(vehicle)
					local distance = #(coords - vector3(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"]))
					if distance <= 3.5 then

						if not isFuel then
							timeDistance = 4
							if GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 <= 1 then
								DrawText3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~b~GALÃO VAZIO")
							elseif vehFuel < 100.0 then
								DrawText3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~g~E~w~   ABASTECER")
							end
						else
							if GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 > 1 then
								timeDistance = 4
								SetPedAmmo(ped,883325847,math.floor(GetAmmoInPedWeapon(ped,883325847) - 0.01 * 100))

								SetVehicleFuelLevel(vehicle,vehFuel + 0.005)
								DrawText3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~g~E~w~   CANCELAR")
								DrawText3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 0.85,"TANQUE: ~y~"..parseInt(floor(vehFuel)).."%   ~w~GALÃO: ~y~"..parseInt(GetAmmoInPedWeapon(ped,883325847) / 4500 * 100).."%")

								if not IsEntityPlayingAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
									TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
								end

								if vehFuel >= 100.0 or GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 <= 1 or GetEntityHealth(ped) <= 101 then
									TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
									StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
									RemoveAnimDict("timetable@gardener@filling_can")
									isFuel = false
								end
							end
						end

						if IsControlJustPressed(1,38) and GetGameTimer() >= gameTimer and MumbleIsConnected() then
							gameTimer = GetGameTimer() + 3000

							if isFuel then
								TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
								StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
								RemoveAnimDict("timetable@gardener@filling_can")
								isFuel = false
							else
								if GetAmmoInPedWeapon(ped,883325847) - 0.02 * 100 >= 0 and vehFuel <= 100.0 then
									TaskTurnPedToFaceEntity(ped,vehicle,5000)
									loadAnim("timetable@gardener@filling_can")
									TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
									isFuel = true
								end
							end
						end
					end

					if isFuel and distance > 3.5 then
						TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
						StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
						RemoveAnimDict("timetable@gardener@filling_can")
						isFuel = false
					end
				end
			end

			if isFuel then
				DisableControlAction(1,18,true)
				DisableControlAction(1,22,true)
				DisableControlAction(1,23,true)
				DisableControlAction(1,24,true)
				DisableControlAction(1,29,true)
				DisableControlAction(1,30,true)
				DisableControlAction(1,31,true)
				DisableControlAction(1,140,true)
				DisableControlAction(1,142,true)
				DisableControlAction(1,143,true)
				DisableControlAction(1,257,true)
				DisableControlAction(1,263,true)
			end
		end

		Citizen.Wait(timeDistance)
	end
end)

function fuelLocsThread(fuelLocs, shop)
	Citizen.CreateThread(function()
		local litros = 0
		while true do
			local timeDistance = 500
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			for k,v in pairs(fuelLocs) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 8.0 then
					timeDistance = 4
					local vehicle = GetPlayersLastVehicle()
					if DoesEntityExist(vehicle) and not IsPedInAnyVehicle(ped) and GetSelectedPedWeapon(ped) ~= 883325847 then
						local coordsVeh = GetEntityCoords(vehicle)
						local vehFuel = GetVehicleFuelLevel(vehicle)
						local vehPlate = GetVehicleNumberPlateText(vehicle)
						local distance = #(coords - vector3(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"]))
						if distance <= 3.5 then
							if not isFuel then
								if vehFuel < 100.0 then
									DrawText3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~g~E~w~   ABASTECER")
								end
							else
								if not showNui then
									SendNUIMessage({ fuel = true })
									showNui = true
								end
								local fuelPrice = GlobalState['Will_Shops'][shop]['products']['fuel']
								isPrice = isPrice + fuelPrice
								SetVehicleFuelLevel(vehicle,vehFuel + 0.025)
								litros = litros + 0.02
								SendNUIMessage({ tank = parseInt(floor(vehFuel)), price = parseInt(isPrice), lts = litros })
								DrawText3D(coordsVeh["x"],coordsVeh["y"],coordsVeh["z"] + 1,"~g~E~w~   FINALIZAR")

								if not IsEntityPlayingAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3) then
									TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
								end

								if vehFuel >= 100.0 or GetEntityHealth(ped) <= 101 then
									if vSERVER.paymentFuel(isPrice,vehPlate,100.0,shop,litros) then
										TriggerServerEvent("engine:tryFuel",vehPlate,100.0)
										vehFuels[vehPlate] = 100.0
									else
										TriggerServerEvent("engine:tryFuel",vehPlate,lastFuel)
										vehFuels[vehPlate] = lastFuel
									end
									SetVehicleFuelLevel(vehicle,vehFuels[vehPlate])
									StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
									RemoveAnimDict("timetable@gardener@filling_can")
									SendNUIMessage({ fuel = false })
									showNui = false
									isFuel = false
									isPrice = 0
									litros = 0
								end
							end

							if IsControlJustPressed(1,38) and GetGameTimer() >= gameTimer then
								gameTimer = GetGameTimer() + 3000

								if isFuel then
									if vSERVER.paymentFuel(isPrice,vehPlate,vehFuel,shop,isPrice * 4) then
										TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
										vehFuels[vehPlate] = vehFuel
									else
										TriggerServerEvent("engine:tryFuel",vehPlate,lastFuel)
										vehFuels[vehPlate] = lastFuel
									end
									SetVehicleFuelLevel(vehicle,vehFuels[vehPlate])
									StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
									RemoveAnimDict("timetable@gardener@filling_can")
									SendNUIMessage({ fuel = false })
									showNui = false
									isFuel = false
									isPrice = 0
									litros = 0
								else
									if vehFuel < 100.0 then
										lastFuel = vehFuel
										TaskTurnPedToFaceEntity(ped,vehicle,5000)
										loadAnim("timetable@gardener@filling_can")
										TaskPlayAnim(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",3.0,3.0,-1,50,0,0,0,0)
										isFuel = true
									end
								end
							end
						end

						if isFuel and distance > 3.5 then
							if vSERVER.paymentFuel(isPrice,vehPlate,vehFuel,shop,isPrice * 4) then
								TriggerServerEvent("engine:tryFuel",vehPlate,vehFuel)
								vehFuels[vehPlate] = vehFuel
							else
								TriggerServerEvent("engine:tryFuel",vehPlate,lastFuel)
								vehFuels[vehPlate] = lastFuel
							end
							SetVehicleFuelLevel(vehicle,vehFuels[vehPlate])
							StopAnimTask(ped,"timetable@gardener@filling_can","gar_ig_5_filling_can",2.0)
							RemoveAnimDict("timetable@gardener@filling_can")
							SendNUIMessage({ fuel = false })
							showNui = false
							isFuel = false
							isPrice = 0
							litros = 0
						end
					end
				end
			end
			Citizen.Wait(timeDistance)
		end
	end)
end

RegisterNetEvent("engine:syncFuel")
AddEventHandler("engine:syncFuel",function(vehPlate,vehResult)
	vehFuels[vehPlate] = vehResult
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THRED SKINSHOPS
-----------------------------------------------------------------------------------------------------------------------------------------
function skinshopThread(locs,shop)
	CreateThread(function()
		while true do
			local timeDistance = 500
			local ped = PlayerPedId()
			local coords = GetEntityCoords(ped)
			for k,v in pairs(locs) do
				local distance = #(coords - vector3(v[1],v[2],v[3]))
				if distance <= 5 then
					timeDistance = 4
					-- DrawMarker(27,v[1],v[2],v[3]-0.95,0,0,0,0,180.0,130.0,1.0,1.0,1.0,255,0,0,75,0,0,0,1)
                    DrawText3D2(v[1],v[2],v[3], "~p~[Loja de Roupa]\n~w~~b~[E]~w~ PARA ACESSAR")
					if IsControlJustPressed(1,38) then
						timeDistance = 1000
						TriggerEvent("will_skinshop:openShop",shop)
					end
				end
			end
			Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTEXT3D
-----------------------------------------------------------------------------------------------------------------------------------------
function DrawText3D2(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    SetTextScale(0.45, 0.45)
    SetTextFont(6)
    SetTextProportional(true)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function DrawText3D(x,y,z,text)
	local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,200)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text))/350
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end

function drawTxt()
	SetTextFont(4)
	SetTextScale(0.40,0.40)
	SetTextColour(255,255,255,180)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString("~w~PRESSIONE~r~  F7  ~w~PARA FINALIZAR O TRABALHO")
	DrawText(0.25,0.97)
end

function loadAnim(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end

function loadModel(model)
	RequestModel(model)
	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function addBlipCoords(name, coords)
    workBlip = AddBlipForCoord(coords.x, coords.y, coords.z)
    SetBlipSprite(workBlip,1)
	SetBlipColour(workBlip,84)
	SetBlipScale(workBlip,0.4)
	SetBlipAsShortRange(workBlip,false)
	SetBlipRoute(workBlip,true)
	BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(workBlip)
end

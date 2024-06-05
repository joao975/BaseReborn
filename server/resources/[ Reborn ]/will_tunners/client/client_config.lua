-----#######################################--
--##            Threads 
-----#######################################--

--[[ Citizen.CreateThread(function()
    Wait(2000)
    for k, v in pairs (Config.Customs) do
        local blip = AddBlipForCoord(v.shopcoord.x, v.shopcoord.y, v.shopcoord.z)
        SetBlipSprite (blip, v.Blips.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale  (blip, v.Blips.scale)
        SetBlipColour (blip, v.Blips.color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(k)
        EndTextCommandSetBlipName(blip)
    end
end) ]]

CreateThread(function()
    Wait(500)
    while true do
        local ped = PlayerPedId()
        for k,v in pairs(Config.Customs) do
            local distance = #(GetEntityCoords(ped) - vector3(v.shopcoord.x,v.shopcoord.y,v.shopcoord.z))
            if distance < v.radius then
                currentprivate = k
                local garage = v
                while distance < v.radius do
                    distance = #(GetEntityCoords(ped) - vector3(v.shopcoord.x,v.shopcoord.y,v.shopcoord.z))
                    local timeDistance = 500
                    if v.mod then
                        for _,w in pairs(v.mod) do
                            local distance = #(GetEntityCoords(ped) - vector3(w.coord.x,w.coord.y,w.coord.z))
                            local invehicle = IsPedInAnyVehicle(ped)
                            if distance < 30 and invehicle then
                                timeDistance = 4
                                DrawMarker(23,w.coord.x,w.coord.y,w.coord.z -0.3,0,0,0,0,0,3.0,3.0,3.0,3.0,55,55,150,200,0,0,0,1)
                                if distance < 3 and IsControlJustPressed(0,38) and vSERVER.ShopPermmision(currentprivate) then
                                    openMenu()
                                end
                            end
                        end
                    end
                    Wait(timeDistance)
                end
            end
        end
        Wait(1000)
    end
end)

RegisterNetEvent('will_customs:openmenu')
AddEventHandler('will_customs:openmenu', function(menu)
    openMenu()
end)

RegisterNetEvent('will_customs:restoremod')
AddEventHandler('will_customs:restoremod', function(net,prop)
    local ent = NetworkGetEntityFromNetworkId(net)
    SetModable(ent)
    SetVehicleProp(ent, prop)
end)

MathRound = function(value, numDecimalPlaces)
	if numDecimalPlaces then
		local power = 10^numDecimalPlaces
		return math.floor((value * power) + 0.5) / (power)
	else
		return math.floor(value + 0.5)
	end
end

function numWithCommas(n)
    return tostring(math.floor(n)):reverse():gsub("(%d%d%d)","%1,"):gsub(",(%-?)$","%1"):reverse()
end

RegisterNetEvent("dynamic:animalSpawn")
AddEventHandler("dynamic:animalSpawn",function(model)
    if animalHash == nil then
        if not spawnAnimal then
            spawnAnimal = true
            local ped = PlayerPedId()
            local heading = GetEntityHeading(ped)
            local coords = GetOffsetFromEntityInWorldCoords(ped,0.0,1.0,0.0)
            local myObject,objNet = vSERVER.CreatePed(model,coords["x"],coords["y"],coords["z"],heading,28)
            if myObject then
                local spawnAnimal = 0
                animalHash = NetworkGetEntityFromNetworkId(objNet)
                while not DoesEntityExist(animalHash) and spawnAnimal <= 1000 do
                    animalHash = NetworkGetEntityFromNetworkId(objNet)
                    spawnAnimal = spawnAnimal + 1
                    Citizen.Wait(1)
                end
                typeAnimal = model
                spawnAnimal = 0
                local pedControl = NetworkRequestControlOfEntity(animalHash)
                while not pedControl and spawnAnimal <= 1000 do
                    pedControl = NetworkRequestControlOfEntity(animalHash)
                    spawnAnimal = spawnAnimal + 1
                    Citizen.Wait(1)
                end

                SetPedCanRagdoll(animalHash,false)
                SetEntityInvincible(animalHash,true)
                SetPedFleeAttributes(animalHash,0,0)
                SetEntityAsMissionEntity(animalHash,true,false)
                SetBlockingOfNonTemporaryEvents(animalHash,true)
                SetPedRelationshipGroupHash(animalHash,GetHashKey("k9"))
                GiveWeaponToPed(animalHash,GetHashKey("WEAPON_ANIMAL"),200,true,true)

                SetEntityAsNoLongerNeeded(animalHash)

                TriggerEvent("dynamic:animalFunctions","seguir")

                vSERVER.animalRegister(objNet)
            end

            spawnAnimal = false
        end
    else
        vSERVER.animalCleaner()
        animalFollow = false
        animalHash = nil
        typeAnimal = nil
    end
end)

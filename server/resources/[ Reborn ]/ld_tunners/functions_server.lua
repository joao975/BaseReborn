Citizen.CreateThread(function()

    MySQL.Async.execute([[
        CREATE TABLE IF NOT EXISTS `ld_tunners` (
        `car` text DEFAULT NULL,
        `plate` text DEFAULT NULL,
        `data` longtext DEFAULT '[]'
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
    ]])

    GetMoney = function(source)
        local user_id = vRP.getUserId(source)
        return vRP.getBankMoney(user_id)
    end

    RemoveMoney = function(source, amount, type)
        local user_id = vRP.getUserId(source)
        if type == "card" then
            vRP.tryPayment(user_id, amount)
        else
            vRP.tryGetInventoryItem(user_id, "dollars", amount)
        end
    end

    HasPermission = function(source, permission)
        local user_id = vRP.getUserId(source)
        return vRP.hasPermission(user_id, permission)
    end

    Notification = function(source, message)
        TriggerClientEvent("Notify",source,"importante",message)
    end

    local Tunners = {}

    RegisterServerEvent("ld_tunners:saveVehicle")
    AddEventHandler("ld_tunners:saveVehicle",function(mods,plate,car)
        local user_id = vRP.getVehiclePlate(plate)
        if user_id then
            Tunners[plate] = mods
            MySQL.Async.execute("REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@dkey,@dvalue)",{
                ["@dkey"] = "mods:"..plate,
                ["@dvalue"] = json.encode(mods),
            })
        end
    end)

    RegisterServerEvent("ld_tunners:applyMods")
    AddEventHandler("ld_tunners:applyMods",function(plate,car_name,car_ent)
        if Tunners[plate] then
            TriggerClientEvent("ld_tunners:client:applyMods",-1,car_ent,Tunners[plate])
            return
        end
        local user_id = vRP.getVehiclePlate(plate)
        if user_id then
            local source = vRP.getUserSource(user_id)
            if source then
                MySQL.Async.fetchAll("SELECT * FROM vrp_srv_data WHERE dkey = @key",{
                    ["@key"] = "mods:"..plate
                }, function(result)
                    if #result > 0 then
                        if not Tunners[plate] then
                            Tunners[plate] = json.decode(result[1].dvalue)
                        end
                        TriggerClientEvent("ld_tunners:client:applyMods",source,car_ent,Tunners[plate])
                    end
                end)
            end
        end
    end)
end)

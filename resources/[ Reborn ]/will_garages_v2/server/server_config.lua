-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    
	prepare("will/add_vehicle","INSERT IGNORE INTO "..Config.vehicleDB.."(user_id,vehicle,plate,engine,body,fuel,work) VALUES(@user_id,@vehicle,@plate,@engine,@body,@fuel,@work)")
	prepare("will/add_work_veh","INSERT IGNORE INTO "..Config.vehicleDB.."(user_id,vehicle,plate,engine,body,fuel,work) VALUES(@user_id,@vehicle,@plate,@engine,@body,@fuel,'true')")
	prepare("will/rem_vehicle","DELETE FROM "..Config.vehicleDB.." WHERE user_id = @user_id AND vehicle = @vehicle")
	prepare("will/get_vehicle","SELECT * FROM "..Config.vehicleDB.." WHERE user_id = @user_id AND vehicle = @vehicle")
	prepare("will/get_vehicles","SELECT * FROM "..Config.vehicleDB.." WHERE user_id = @user_id")
	prepare("will/get_user_plate","SELECT * FROM "..Config.vehicleDB.." WHERE plate = @plate")
	prepare("will/update_vehicles_plates","UPDATE "..Config.vehicleDB.." SET plate = @plate WHERE user_id = @user_id AND vehicle = @vehicle")
	prepare("will/update_vehicles","UPDATE "..Config.vehicleDB.." SET engine = @engine, body = @body, fuel = @fuel, doors = @doors, windows = @windows, tyres = @tyres WHERE plate = @plate")
	prepare("will/move_vehicle","UPDATE "..Config.vehicleDB.." SET user_id = @nuser_id WHERE plate = @plate")
	prepare("will/set_garage","UPDATE "..Config.vehicleDB.." SET garage = @garage WHERE plate = @plate")
	prepare("will/get_stoled_vehs","SELECT * FROM "..Config.vehicleDB.." WHERE theft LIKE '%thief%'")
	prepare("will/get_shared_vehs","SELECT * FROM "..Config.vehicleDB.." WHERE garage LIKE CONCAT('shared:', @garage)")
	prepare("will/set_veh_stoled","UPDATE "..Config.vehicleDB.." SET theft = @theft WHERE plate = @plate")

    AddEventHandler("vRP:playerSpawn",function(user_id,source)
        playerSpawn(user_id,source)
    end)

	if Config.base == "creative" then
		prepare("will/set_arrest","UPDATE "..Config.vehicleDB.." SET arrest = @arrest, time = @time WHERE plate = @plate")
		prepare("will/get_arrested_vehs","SELECT * FROM "..Config.vehicleDB.." WHERE arrest > 0")
        -- prepare("will/get_homeuser","SELECT * FROM vrp_homes WHERE user_id = @user_id AND home = @home")
        prepare("will/get_homeuser","SELECT * FROM will_homes WHERE owner = @user_id AND name = @home")
        prepare("will/rem_srv_data","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
        prepare("will/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
    elseif Config.base == "summerz" then
        prepare("will/set_arrest","UPDATE "..Config.vehicleDB.." SET arrest = @arrest, tax = @time WHERE plate = @plate")
		prepare("will/get_arrested_vehs","SELECT * FROM "..Config.vehicleDB.." WHERE arrest > 0")
        prepare("will/get_homeuser","SELECT * FROM summerz_propertys WHERE id = @user_id AND name = @home")
        prepare("will/rem_srv_data","DELETE FROM summerz_entitydata WHERE dkey = @dkey")
        prepare("will/set_srvdata","REPLACE INTO summerz_entitydata(dkey,dvalue) VALUES(@key,@value)")
    else
		prepare("will/set_arrest","UPDATE "..Config.vehicleDB.." SET detido = @arrest, time = @time WHERE plate = @plate")
		prepare("will/get_arrested_vehs","SELECT * FROM "..Config.vehicleDB.." WHERE detido > 0")
        prepare("will/get_homeuser","SELECT * FROM will_homes WHERE owner = @user_id AND name = @home")
        prepare("will/set_srvdata","REPLACE INTO vrp_srv_data(dkey,dvalue) VALUES(@key,@value)")
        prepare("will/rem_srv_data","DELETE FROM vrp_srv_data WHERE dkey = @dkey")
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
-----------------------------------------------------------------------------------------------------------------------------------------

local adminPermission = "admin.permissao"

--######################--
--### SPAWNAR CARRO ###---
--######################--

RegisterCommand("car",function(source,args,rawCommand)
	local user_id = getUserId(source)
    local identity = getUserIdentity(user_id)
 	if user_id then
		if hasPermission(user_id,adminPermission) and args[1] then
			TriggerClientEvent("will_garages_v2:adminVehicle",source,args[1],identity.registration)
            local ped = GetPlayerPed(source)
			local x,y,z = table.unpack(GetEntityCoords(ped))
            local h = GetEntityHeading(ped)
            --will.spawnVehicle(args[1],x,y,z,h,{},false,0)
			--SendDiscord(Config.Weebhok,12422,"Reborn Shop","Garagem","ID: "..user_id,"Spawnou o **"..args[1].."**\n Coordenadas: "..tD(x)..", "..tD(y)..", "..tD(z))
		end
	end
end)

--######################--
--### DELETAR CARRO ###---
--######################--

RegisterCommand("dv",function(source,args,rawCommand)
	local user_id = getUserId(source)
	if hasPermission(user_id,adminPermission) then
        if args[1] then
            local vehicles = vCLIENT.getNearVehicles(parseInt(args[1])) or {}
            if #vehicles > 0 then
                for veh,dist in pairs(vehicles) do
                    vCLIENT.deleteVehicle(source,veh,true)
                end
            end
        else
            local vehicle = vCLIENT.getNearVehicle(source,12)
            if vehicle then
                vCLIENT.deleteVehicle(source,vehicle,true)
                local veh,vehNet,vehPlate,vehName = vCLIENT.vehList(source,11)
                if vehName then
                    local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
                    SendDiscord(Config.Weebhok,12422,"Reborn Shop","Garagem","ID: "..user_id,"Deletou o **"..vehName.."**\n Coordenadas: "..tD(x)..", "..tD(y)..", "..tD(z))
                end
            end
        end
	end
end)

function tD(n)
	local n = n or 0
    n = math.ceil(n * 100) / 100
    return n
end

--######################--
--###  FIXAR CARRO  ###---
--######################--

RegisterCommand("fix",function(source,args,rawCommand)
	local user_id = getUserId(source)
	if user_id then
		if hasPermission(user_id,adminPermission) then
			local vehicle,vehNet,vehPlate,vehName = vCLIENT.vehList(source,7)
			if vehicle then
				TriggerClientEvent("will_garages_v2:repairVehicle",-1,vehNet,true)
				local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(source)))
				SendDiscord(Config.Weebhok,12422,"Reborn Shop","Garagem","ID: "..user_id,"Deu fix no carro **"..vehName.."**\n Coordenadas: "..tD(x)..", "..tD(y)..", "..tD(z))
			end
		end
	end
end)

--############################--
--###  REGISTRAR VEICULO  ###---
--############################--

RegisterCommand("setcar",function(source,args,rawCommand)
    local source = source
	local user_id = getUserId(source)
	if user_id then
		if hasPermission(user_id,adminPermission) then
			local vehicle = vCLIENT.getNearVehicle(source,12)
			if vehicle then
				local carname = prompt(source,"Nome de spawn do veiculo:","")
				local nicename = prompt(source,"Nome bonito do veiculo:","")
				local carprice = prompt(source,"Preço do veiculo:","50000")
				local carchest = prompt(source,"Bau do veiculo:","40")
				local cartype = prompt(source,"Tipo do veiculo:","carros")
                if carname and nicename then
                    if Config.updateFile then
                        if updateVehicles(carname, nicename, carprice, carchest, cartype) then
                            TriggerClientEvent("Notify",source,"sucesso","Veiculo cadastrado com sucesso!",5000)
                        else
                            TriggerClientEvent("Notify",source,"negado","Erro ao cadastrar veiculo",5000)
                        end
                    else
                        prompt(source,"Resultado:","['"..carname.."'] = { ['name'] = '"..nicename.."', ['price'] = "..carprice..", ['type'] = '"..cartype.."', ['chest'] = '"..carchest.."' },")
                    end
                end
			end
		end
	end
end)

--#############################--
--###  COMPARTILHAR CHAVE  ###---
--#############################--

local sharedKeys = {}

RegisterCommand("chave",function(source, args)
    local source = source
    local user_id = getUserId(source)
    local keyCommands = {
        ["add"] = function(vehicle, id)
            if not getUserSource(id) then
                TriggerClientEvent("Notify", source, "aviso", "ID "..id.." não está online", 5000)
                return
            end
            local index = "key-"..vehicle.."-"..user_id
            if not sharedKeys[index] then
                sharedKeys[index] = { id }
                TriggerClientEvent("Notify", source, "sucesso", "Chave do veículo <b>"..vehicle.."<.b> emprestada para o ID <b>"..id.."<.b>", 5000)
            else
                for k,v in pairs(sharedKeys[index]) do
                    if id == v then
                        TriggerClientEvent("Notify", source, "aviso", "ID "..id.." já possui a chave desse veículo", 5000)
                        return
                    end
                end
                table.insert(sharedKeys[index], id)
                TriggerClientEvent("Notify", source, "sucesso", "Chave do veículo <b>"..vehicle.."<.b> emprestada para o ID <b>"..id.."<.b>", 5000)  
            end
        end,
        ["remove"] = function(vehicle, id)
            local index = "key-"..vehicle.."-"..user_id
            if sharedKeys[index] then
                for k,v in ipairs(sharedKeys[index]) do
                    if id == v then
                        table.remove(sharedKeys[index], k)
                        TriggerClientEvent("Notify", source, "importante", "Chave do veículo <b>"..vehicle.."<.b> removida do ID <b>"..id.."<.b>", 5000)  
                        return
                    end
                end
                TriggerClientEvent("Notify", source, "aviso", "ID "..id.." não possui a chave desse veículo", 5000)
            else
                TriggerClientEvent("Notify", source, "aviso", "ID "..id.." não possui a chave desse veículo", 5000)
            end
        end,
        ["list"] = function()
            local myvehicles = query("will/get_vehicles", {user_id = user_id})
            local list = "Chaves emprestadas:"
            if #myvehicles > 0 then
                for i, veh in ipairs(myvehicles) do
                    local vehicle = veh.vehicle
                    local index = "key-"..vehicle.."-"..user_id
                    if sharedKeys[index] and #sharedKeys[index] > 0 then
                        list = list.."<br><b>"..vehicle.."<.b>: "
                        for k,v in ipairs(sharedKeys[index]) do
                            if k == #sharedKeys[index] then
                                list = list..v
                            else
                                list = list..v..",<br>"
                            end
                        end
                    end
                end
                if string.len(list) > 24 then
                    TriggerClientEvent("Notify",source,"importante", list)
                end
            end
        end
    }
    if args[1] and args[1] == "list" then
        keyCommands[args[1]]()
        return
    end
    if #args < 3 or not keyCommands[args[1]] then
        TriggerClientEvent("Notify", source, "aviso", "Utilize .chave <b>(add.remove) (veículo) (id)<.b>", 5000)
        return
    end
    local id = parseInt(args[3])
    local vehicle = args[2]
    local hasVehicle = #(query("will/get_vehicle", { user_id = user_id, vehicle = vehicle })) > 0
    if not hasVehicle then
        TriggerClientEvent("Notify", source, "aviso", "Você não possui o veículo <b>"..vehicle.."<.b>", 5000)
        return
    elseif not id or id < 1 or id == user_id then
        TriggerClientEvent("Notify", source, "aviso", "ID inválido", 5000)
        return
    end
    keyCommands[args[1]](vehicle, id)
end)

function canLockVehicle(user_id, vname, owner)
    if user_id and vname and owner then
        local index = "key-"..vname.."-"..owner
        if sharedKeys[index] then
            for _,id in pairs(sharedKeys[index]) do
                if id == user_id then
                    return true
                end
            end
        end
    end
    return false
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------

-- Função chamada ao spawnar um veiculo (Server-side)
function modifiesOnSpawnVehicle(user_id, vehName, data)
    -- Parametro 'data' são as informações do banco de dados
    return
end

-- Função chamada ao deletar um veiculo (Server-side)
function modifiesOnDeleteVehicle(user_id, vehName, byDv)
    -- Parametro 'byDv' é 'true' caso o veiculo seja deletado por /dv
    return
end

--########## Spawnar veiculo ##########
local spawnedWrongVehs = {}

function will.spawnVehicle(vname,x,y,z,h,data,interior,bucket)
    local source = source
    local debugVehicle = 0
    local mHash = GetHashKey(vname)
    local height = bucket == 0 and z or 1.000
	local nveh = CreateVehicle(mHash, x, y, height, h ,true, true)
    while not DoesEntityExist(nveh) and debugVehicle <= 80 do
        debugVehicle = debugVehicle + 1
        Citizen.Wait(100)
    end
    if DoesEntityExist(nveh) then
        local netid = NetworkGetNetworkIdFromEntity(nveh)
        if not netid then
            spawnedWrongVehs[nveh] = true
            return
        end
        local vehPlate = data.plate or will.generatePlateNumber()
        SetVehicleNumberPlateText(nveh,vehPlate)
        TriggerEvent("setPlateEveryone",vehPlate)
        while GetEntityRoutingBucket(nveh) ~= parseInt(bucket) do
            SetEntityRoutingBucket(nveh,parseInt(bucket))
            Citizen.Wait(100)
        end
        debugVehicle = 0
        while GetVehicleNumberPlateText(nveh) ~= vehPlate and debugVehicle <= 50 do
            SetVehicleNumberPlateText(nveh,vehPlate)
            debugVehicle = debugVehicle + 1
            Citizen.Wait(100)
        end
        Citizen.Wait(100)
        SetEntityCoords(nveh, x, y, z, false, false, false, true)
        SetEntityHeading(nveh, h)
        if data.body then
            SetVehicleBodyHealth(nveh,data.body+0.0)
        else
            SetVehicleBodyHealth(nveh,1000.0)
        end
        if data.vehDoors ~= nil and type(data.vehDoors) == "table" then
            for k,v in pairs(data.vehDoors) do
                if v then
                    SetVehicleDoorBroken(nveh,parseInt(k),parseInt(v))
                end
            end
        end
        if interior then
            SetVehicleDoorsLocked(nveh,1)   -- Destrancado
            if not spawnedVehsInside[source] then spawnedVehsInside[source] = {} end
            spawnedVehsInside[source][vehPlate] = nveh
        else
            SetVehicleDoorsLocked(nveh,2)   -- Trancado
        end
	    return netid
    elseif nveh then
        spawnedWrongVehs[nveh] = true
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        for k,v in pairs(spawnedWrongVehs) do
            if DoesEntityExist(k) then
                vCLIENT.deleteVehicle(-1,k,true)
                DeleteEntity(k)
            else
                spawnedWrongVehs[k] = nil
            end
        end
    end
end)

--########## Pegar tunagem ##########

function getTunning(user_id,veiculo,vehPlate)
	local tunagem = ''
	if Config.base == "creative" then
    	tunagem = getSData("custom:"..user_id..":"..veiculo)
	elseif Config.base == "vrpex" then
    	tunagem = getSData("custom:u"..user_id.."veh_"..veiculo)
	elseif Config.base == "summerz" then
		local custom = query("entitydata/getData",{ dkey = "custom:"..user_id..":"..veiculo })
		if custom[1] then
			tunagem = custom[1]["dvalue"]
		end
	end
    if GetResourceState("will_tunners") == "started" then
        tunagem = getSData("custom:"..vehPlate)
    end
    if type(tunagem) == 'string' then tunagem = json.decode(tunagem) end
	return (tunagem or {})
end

--########## Permissão das casas ##########

function getMyHome(user_id,nome)
    local myHome = query("will/get_homeuser",{ user_id = parseInt(user_id), home = tostring(nome) })
    if myHome[1] then
        return true
    end
    local nplayer = getUserSource(user_id)
    TriggerClientEvent("Notify",nplayer,"negado","Você não possui permissão na casa "..nome..".", 5000)
    return false
end

function getNewHomes()
	local result = {}

    -- ### Função para setar garagem com outro script de casas ###

    --prepare("homes/fullGarages","SELECT * FROM mrlt_residences WHERE residence_garage_active = 1")
    --local homes = query("homes/fullGarages") or {}
    --[[ for i,v in pairs(homes) do 
        if v then
			local home = {}
            home.entrada = {}
            local a = json.decode(v.residence_garage_blip)
            local b = json.decode(v.residence_garage_spawn)
            local x,y,z = a[1],a[2],a[3]
            local x2,y2,z2,h = b[1],b[2],b[3],b[4]
            if x and x2 then
              home.name = v.residence_name
              home.payment = false
              home.perm = false
              home.entrada['blip'] = { x,y,z,h }
              home.entrada['veiculo'] = { x2,y2,z2,h }
              home.interior = v.garage_interior or "Garagem_menor"
              table.insert(result, { home })
            end
        end
    end ]]
	return result
end

--########## Pagamento da garagem ##########

function will.payGarage(payment)
    local source = source
    local user_id = getUserId(source)
    if payment and type(payment) == 'number' then
        if request(source,"Deseja alugar o veiculo por R$"..payment.."?",30) then
            return paymentMethod(user_id, payment)
        end
    end
end

--########## Função para vender o veiculo ##########

function sellVehicle(source, vehicle, price, plate)
    local user_id = getUserId(source)
    if vRP.vehicleType(vehicle) ~= "vip" then
        if request(source, "Deseja vender o veiculo "..vehicle.." por R$"..price.."?", 30) then
            local vehData = query("will/get_user_plate", { plate = plate })
            if vehData[1] and parseInt(vehData[1]['user_id']) == user_id then
                execute("will/rem_vehicle", { user_id = user_id, vehicle = vehicle })
                addBank(user_id, price)
                TriggerClientEvent("Notify",source,"sucesso","Venda concluída com sucesso.",5000)
            end
        end
    else
        TriggerClientEvent("Notify",source,"negado","Não pode vender veiculo vip.",5000)
    end
end

--########## Função para transferir o veiculo ##########

function transferVehicle(source, nplayer, vehicle, plate)
    local user_id = getUserId(source)
    local nuser_id = getUserId(nplayer)
    local identity = getUserIdentity(nuser_id)
    if nplayer and identity then
        if request(source, "Deseja transferir o veiculo "..vehicle.." para "..identity.name.." ?", 30) then
        	local vehData = query("will/get_user_plate", { plate = plate })
            if vehData[1] and parseInt(vehData[1]['user_id']) == user_id then
                local custom = getTunning(user_id,vehicle)
                if custom then
                    execute("will/rem_srv_data",{ dkey = "custom:u"..parseInt(user_id).."veh_"..tostring(vehicle) })
                    execute("will/set_srvdata",{ key = "custom:u"..parseInt(nuser_id).."veh_"..tostring(vehicle), value = json.encode(custom) })
                end
                
                execute("will/move_vehicle", { nuser_id = nuser_id, plate = plate })
    
                TriggerClientEvent("Notify",source,"sucesso","Transferência concluída com sucesso.",5000)
                TriggerClientEvent("Notify",nplayer,"sucesso","Você recebeu "..vehicle.." em sua garagem.",5000)
            end
        end
    else
        Config.Notification('player_transfer','negado',true,source)
    end
end

--########## Permissão para entrar no interior ##########

function requestEnterGarage(source, nplayer)
    local user_id = getUserId(source)
    local identity = getUserIdentity(user_id)
    if request(nplayer, "Permitir "..identity.name.." entrar na sua garagem?", 8) then
        return true
    end
end

--########## Verifica se o veiculo está detido ou com multa ##########

function checkArrestedVehicle(source,user_id,data,vname)
    local arrested = false
    if Config.base == "vrpex" and (parseInt(data.detido) >= 1 or parseInt(os.time()) <= (parseInt(data.time)+24*60*60)) then
        arrested = true
    elseif Config.base == "creative" and (parseInt(data.arrest) >= 1 or parseInt(os.time()) <= (parseInt(data.time)+24*60*60)) then
        arrested = true
    elseif Config.base == "summerz" and (parseInt(data.arrest) >= 1 or parseInt(os.time()) <= (parseInt(data.tax)+24*60*60)) then
        arrested = true
    end
    if arrested then
        local valordetido = 2/100
        local vehType = will.getVehicleType(vname)
        if vehType == "carros" or vehType == "motos" or vehType == nil then
            valordetido = 3/100
        elseif vehType == "donate" then
            valordetido = 5/100
        end
        local vehPrice = will.getVehiclePrice(vname)*valordetido
        local status = request(source,"O veículo "..vname.." está detido, deseja acionar o seguro pagando <b>R$"..tostring(vehPrice).."</b>?",60)
        if status then
            if paymentMethod(user_id, vehPrice) then
                execute("will/set_arrest",{ plate = data.plate, arrest = 0, time = 0 })
                return true
            else
                TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",5000)
            end
        end
    else
        return true
    end
end

RegisterServerEvent("will_garages:setVehStatus")
AddEventHandler("will_garages:setVehStatus",function(nuser_id, vehname, status, src)
	if src == nil then src = source end
    if type(nuser_id) == "string" then nuser_id = getUserByPlate(nuser_id) end
	local vehicle = vCLIENT.getNearVehicle(src,7)
	if status == "Detido" then
		if vehicle then
			execute("will/set_vehicle_state",{ user_id = nuser_id, vehicle = vehname, arrest = 1 })
			local veh,vehNet,vehPlate,vehName = vCLIENT.vehList(src,7)
			if vehName == vehname then
				vCLIENT.deleteVehicle(src,vehicle)
			end
		end
	elseif status == "Normal" then
		execute("will/set_vehicle_state",{ user_id = nuser_id, vehicle = vehname, arrest = 0 })
	end
end)

--########## GENERATE PLATE NUMBER ##########

function generateStringNumber(format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""
	for i = 1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then
    		number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then
			number = number..string.char(abyte+math.random(0,25))
		else
			number = number..char
		end
	end
	return number
end

function will.generatePlateNumber()
	local user_id = nil
	local plate = ""
	repeat
		Citizen.Wait(10)
		plate = generateStringNumber("DDLLLDDD")
		user_id = getUserByPlate(plate)
	until not user_id
	return plate
end

--########## Funções ##########

function will.getVehicleGlobal()
    return vehicleGlobal
end

function will.getVehicleName(name)
	local vname = name
    if vehicleGlobal[name] then
        vname = vehicleGlobal[name].name
    end
    return vname
end

function will.getVehiclePrice(name)
	local vprice = 50000    
    if vehicleGlobal[name] then
        vprice = vehicleGlobal[name].price
    end
    return vprice
end

function will.getVehicleChest(name)
    local vchest = 40
    if vehicleGlobal[name] then
        if vehicleGlobal[name].chest then
            vchest = vehicleGlobal[name].chest
        elseif vehicleGlobal[name].mala then
            vchest = vehicleGlobal[name].mala
        end
    end
    return parseInt(vchest)
end

function will.getVehicleType(name)
    local vtype = "carros"
    if vehicleGlobal[name] then
        vtype = vehicleGlobal[name].type
        if vehicleGlobal[name].tipo then
            vtype = vehicleGlobal[name].tipo
        end
    end
    return vtype
end

function SendDiscord(webhook, color, title, subtitle, text, target)
	local ts = os.time()
	local time = os.date('%Y-%m-%d %H:%M:%S', ts)
	local connect = {
	    {
	        ["color"] = color,
	        ["title"] = title,
	        ["description"] = text,
	        ["footer"] = {
				["text"] = subtitle,
				["icon_url"] = Config.IconURL,
	        },
	    }
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.Botname, embeds = connect, avatar_url = Config.Logo}), { ['Content-Type'] = 'application/json' })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- EVENTS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("will_garages_v2:vehicleLock")
AddEventHandler("will_garages_v2:vehicleLock",function()
	local source = source
	local user_id = getUserId(source)
	if user_id then
		local vehicle,vehNet,vehPlate,vehName,vehLock = vCLIENT.vehList(source,4)
		if vehicle and vehPlate then
			local plateUserId = getUserByPlate(vehPlate)
			if user_id == plateUserId or canLockVehicle(user_id, vehName, plateUserId) then
                if not vCLIENT.inVehicle(source) then
                    playAnim(source)
                end
                local networkVeh = NetworkGetEntityFromNetworkId(vehNet)
                if vehLock >= 2 then
                    TriggerClientEvent("Notify",source,"importante","Veículo <b>destrancado</b> com sucesso.",5000)
                    TriggerClientEvent("vrp_sound:source",source,"unlock",0.3)
                    SetVehicleDoorsLocked(networkVeh,1)   -- Destrancado
                else
                    TriggerClientEvent("Notify",source,"importante","Veículo <b>trancado</b> com sucesso.",5000)
                    TriggerClientEvent("vrp_sound:source",source,"lock",0.3)
                    SetVehicleDoorsLocked(networkVeh,2)   -- Trancado
                end
			end
		end
	end
end)

RegisterServerEvent("setPlateEveryone")
AddEventHandler("setPlateEveryone",function(plate)
	trydoors[plate] = true
	TriggerClientEvent("will_garages_v2:syncTrydoors",-1,trydoors)
    if Config.base == "summerz" then
        GlobalState["vehPlates"] = trydoors
    end
end)

AddEventHandler("playerDropped",function()
    local source = source
    playerDropped(source)
end)

AddEventHandler("vRP:playerSpawn",function(user_id,source)
    local homes = getNewHomes()
    TriggerClientEvent("will_garages:setHomes",source,homes)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- EXPORTS
-----------------------------------------------------------------------------------------------------------------------------------------
exports('getVehicleGlobal', will.getVehicleGlobal)
exports('getVehicleName', will.getVehicleName)
exports('getVehiclePrice', will.getVehiclePrice)
exports('getVehicleChest', will.getVehicleChest)
exports('getVehicleType', will.getVehicleType)
exports('generatePlateNumber', will.generatePlateNumber)

--########## Export para adicionar veiculo na garagem ##########

-- Máximo de veiculos por permissão

local enableMaxVehs = false

local maxVehs = {
    ['Supremo'] = 15,
    ['Ruby'] = 12,
    ['Diamante'] = 10,
    ['Ouro'] = 7,
    ['Prata'] = 6
}

exports('addVehicle', function(user_id, vehicle)
    local myvehicles = enableMaxVehs and #query("will/get_vehicles", {user_id = user_id}) or {}
    local maxVeh = 5
    if enableMaxVehs then
        for perm, veh in pairs(maxVehs) do
            if hasPermission(user_id, perm) then
                maxVeh = veh
            end
        end
    end
    if #myvehicles < maxVeh or not enableMaxVehs then
        local plate = will.generatePlateNumber()
        local infos = { user_id = user_id, vehicle = vehicle, plate = plate, engine = 1000, body = 1000, fuel = 100, work = 'false' }
        execute("will/add_vehicle", infos)
    else
        local nplayer = getUserSource(user_id)
        TriggerClientEvent("Notify",nplayer,"negado","Máximo de veículos atingido.",5000)
    end
end)

-- ## exports['will_garages_v2']:addVehicle(user_id, vehicle)

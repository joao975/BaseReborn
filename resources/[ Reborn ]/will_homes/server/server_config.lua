Citizen.CreateThread(function()
    prepare('will/get_all_homes',"SELECT * FROM will_homes WHERE owner != @owner")
    prepare('will/get_vault',"SELECT vault FROM will_homes WHERE id = @id")
    prepare('will/get_homeuserid',"SELECT * FROM will_homes WHERE owner = @owner")
	prepare("homes/get_homepermissions","SELECT * FROM will_homes WHERE owner = @user_id AND name = @home")
    prepare("will/get_homeuseridowner", "SELECT * FROM will_homes WHERE name = @home")
    prepare('will/update_name',"UPDATE `will_homes` SET name = @name WHERE id = @id")
    prepare('will/update_theme',"UPDATE `will_homes` SET theme = @theme WHERE id = @id")
    prepare('will/update_extends',"UPDATE `will_homes` SET extends = @extends WHERE id = @id")
    prepare('will/update_friends',"UPDATE `will_homes` SET friends = @friends WHERE id = @id")
    prepare('will/update_home','UPDATE `will_homes` SET owner = @owner, tax = @tax WHERE id = @id')
    prepare("will/upd_taxhomes","UPDATE `will_homes` SET tax = @tax WHERE owner = @owner AND name = @home")
    prepare("will/insert_home","INSERT IGNORE INTO will_homes(id,owner,name,friends,extends,tax) VALUES(@id,@owner,@name,@friends,@extends,@tax)")
    prepare('will/delete_home','UPDATE `will_homes` SET owner = @owner, friends = @friends, extends = @extends, tax = @tax WHERE id = @id')
end)

-----------------------------------------------------------------------------------------------------------------------------------------
-- TRANSFERENCIA / COMPRA
-----------------------------------------------------------------------------------------------------------------------------------------

function tryTransferHome(user_id, nuser_id, house)
    local source = getUserSource(user_id)
    local nplayer = getUserSource(nuser_id)
    local identity = getUserIdentity(user_id)
    local nidentity = getUserIdentity(nuser_id)
    if nplayer then
        if request(source,"Deseja transferir sua casa para "..nidentity.name.." ?",30) then
            if request(nplayer,"Aceitar casa de "..identity.name.." ?",30) then
                TriggerClientEvent("Notify",source,"sucesso","Casa transferida com sucesso.",5000)
                TriggerClientEvent("Notify",nplayer,"sucesso","Casa transferida com sucesso.",5000)
                return true
            end
        end
    else
        TriggerClientEvent("Notify",source,"negado","Cidadão não se encontra.",5000)
    end
end

function tryBuyHouse(user_id, house)
    local homes = query("will/get_homeuserid", { owner = user_id })
    if #homes >= 20 then
        local source = getUserSource(user_id)
        TriggerClientEvent("Notify",source,"negado","Limite de casas atingido.",5000)
        return false
    end
    return true
end

Citizen.CreateThread(function()
	Citizen.Wait(1000)
	local houses = query('will/get_all_homes', { owner = "" }) or {}
	for k,v in pairs(houses) do
		if (parseInt(v.tax)+60*60*24*Config.delHomeTime) < os.time() then
			execute('will/delete_home', { id = v.id, owner = "", tax = os.time(), extends = json.encode(Config.Houses_Template.extends), friends = json.encode(Config.Houses_Template.friends) })
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUBOS
-----------------------------------------------------------------------------------------------------------------------------------------

local mobileTheft = {
	["MOBILE"] = {
		{ item = "notepad", min = 1, max = 5 },
		{ item = "keyboard", min = 1, max = 1 },
		{ item = "plastic", min = 1, max = 1 },
		{ item = "dollars", min = 500, max = 1500 },
		{ item = "mouse", min = 1, max = 1 },
		{ item = "watch", min = 2, max = 4 },
		{ item = "playstation", min = 1, max = 1 },
		{ item = "xbox", min = 1, max = 1 },
		{ item = "legos", min = 1, max = 1 },
		{ item = "ominitrix", min = 1, max = 1 },
		{ item = "ring", min = 1, max = 1 },
		{ item = "dildo", min = 1, max = 1 },
	},
	["LOCKER"] = {
		{ item = "dollars", min = 2500, max = 5000 },
		{ item = "watch", min = 25, max = 35 },
		{ item = "lockpick", min = 2, max = 3 },
		{ item = "bluecard", min = 2, max = 3 },
		{ item = "blackcard", min = 1, max = 1 },
		{ item = "pager", min = 5, max = 10 }
	}
}

function will.paymentTheft(mobile)
	local source = source
	local user_id = getUserId(source)
	if user_id then
		local policeResult = getPolicesByPermission()
		local randItem = math.random(#mobileTheft[mobile])
		local value = math.random(mobileTheft[mobile][randItem]["min"],mobileTheft[mobile][randItem]["max"])

		if (getInventoryWeigth(user_id) + (vRP.itemWeightList(mobileTheft[mobile][randItem]["item"]) * parseInt(value))) <= getInventoryMaxWeight(user_id) then
			if parseInt(#policeResult) <= 4 then
				if math.random(100) <= 40 then
					vRP.giveInventoryItem(user_id,mobileTheft[mobile][randItem]["item"],parseInt(value),true)
				else
					TriggerClientEvent("Notify",source,"aviso","Compartimento vazio.",5000)
				end
			else
				if math.random(100) <= 80 then
					vRP.giveInventoryItem(user_id,mobileTheft[mobile][randItem]["item"],parseInt(value),true)
				else
					TriggerClientEvent("Notify",source,"aviso","Compartimento vazio.",5000)
				end
			end
		else
			TriggerClientEvent("Notify",source,"negado","Mochila cheia.",5000)
		end
	end
end

function will.callPolice(x,y,z)
    local source = source
	local user_id = getUserId(source)
	if user_id then
		local ped = GetPlayerPed(source)
		local coords = GetEntityCoords(ped)

		local policeResult = getPolicesByPermission()
		for k,v in pairs(policeResult) do
			async(function()
				TriggerClientEvent("NotifyPush",v,{ code = 90, title = "Roubo de Propriedade", x = x, y = y, z = z, criminal = "Alarme de segurança", time = "Recebido às "..os.date("%H:%M"), blipColor = 43 })
			end)
		end
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- COMANDOS
-----------------------------------------------------------------------------------------------------------------------------------------

RegisterCommand("house_reload", function(source, args, rawCommand)
    local source = source
	local user_id = getUserId(source)
    if hasPermission(user_id, "admin.permissao") then
        CacheHouses = {}
        local houses = query('will/get_all_homes', { owner = "" })
        will.loadHouses(houses)
        TriggerClientEvent("Notify",source,"sucesso","Casas carregadas com sucesso.",5000)
    end
end)

RegisterCommand("casas",function(source,args,rawCommand)
	local source = source
	local user_id = getUserId(source)
	if user_id then
        TriggerClientEvent("will_homes:client:updateBlips",source)
        TriggerClientEvent("Notify",source,"aviso","Marcação das casas.",5000)
	end
end)

RegisterCommand("invadir",function(source,args,rawCommand)
	local source = source
	local user_id = getUserId(source)
	if hasPermission(user_id, "policia.permissao") then
        tryEnterHome(source)
	end
end)

-- Função para entrar na casa mais proxima
-- Pode ser usado para implementar em seu script de roubo

exports("tryEnterHome", tryEnterHome)   -- tryEnterHome(source)

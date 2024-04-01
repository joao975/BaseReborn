-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy = module("vrp","lib/Proxy")
Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
cSURVIVAL = Tunnel.getInterface("Survival")

-----------------------------------
--########## Funções VRP ##########
-----------------------------------

function getUserId(source)
    return vRP.getUserId(source)
end

function getUserSource(user_id)
	if Config.base == "summerz" then
		return vRP.userSource(user_id)
	end
	return vRP.getUserSource(user_id)
end

function getUserIdentity(user_id)
    if Config.base == "summerz" then
		return vRP.userIdentity(user_id)
	end
	return vRP.getUserIdentity(user_id)
end

function hasPermission(user_id, perm)
    return vRP.hasPermission(user_id, perm)
end

function addGroup(user_id, perm)
    vRP.addUserGroup(user_id, perm)
end

function addBank(user_id, amount)
    return vRP.addBank(user_id, amount)
end

function giveItem(user_id, item, amount)
    vRP.giveInventoryItem(user_id, item, amount, true)
end

function prepare(name, query)
    vRP.prepare(name, query)
end

function query(name, data)
    return vRP.query(name, data)
end

function execute(name, data)
    vRP.execute(name, data)
end

function GetIdentiy(source, typ)
    local result = 0
	local identifiers = GetPlayerIdentifiers(source)
	for _,v in pairs(identifiers) do
		if string.find(v, typ) then
			local splitName = splitString(v,":")
			result = splitName[2]
			break
		end
	end
	return result
end

function updateFoodDrink(user_id)
    vRP.upgradeHunger(user_id, 100)
    vRP.upgradeThirst(user_id, 100)
end

function checkInventory(src, target)
    local user_id = getUserId(src)
    local nplayer = getUserSource(target)
    if nplayer then
        TriggerEvent('ld-inv:Server:OpenPlayerInventory',target,user_id)
    end
end

function revivePlayer(user_id)
    local nplayer = getUserSource(user_id)
    vRP.upgradeThirst(user_id,100)
    vRP.upgradeHunger(user_id,100)
    vRP.downgradeStress(user_id,100)
    vRPclient.setArmour(nplayer,100)
    cSURVIVAL.revivePlayer(nplayer,400)
    TriggerClientEvent("resetBleeding",nplayer)
    TriggerClientEvent("resetDiagnostic",nplayer)
end

function getAllUsers()
    local users = vRP.getUsers()
    return users 
end

function getPlayerName(source)
    local user_id = getUserId(source)
    if user_id then
        local identity = getUserIdentity(user_id)
        if identity then
            local fullName = identity.name.." "..identity.firstname
            return fullName
        end
    end
    return "Não identificado"
end

function sendMessage(src, msg)
    TriggerClientEvent("Notify", src, "importante", msg, 5000)
end

Citizen.CreateThread(function()
    prepare("will/add_ban", "INSERT INTO user_bans(name, license, discord, ip, reason, expire, bannedby) VALUES (@name, @license, @discord, @ip, @reason, @expire, @bannedby)")
    prepare("will/get_ban", "SELECT * FROM user_bans WHERE license = @license OR discord = @discord OR ip = @ip")
    prepare("will/delete_ban", "DELETE FROM user_bans WHERE license = @license OR discord = @discord OR ip = @ip")
end)

function GetBanTime(Expires)
    local Time = os.time()
    local Expiring = nil
    local ExpireDate = nil
    if Expires == '1 Hora' then
        Expiring = os.date("*t", Time + 3600)
        ExpireDate = tonumber(Time + 3600)
    elseif Expires == '6 Horas' then
        Expiring = os.date("*t", Time + 21600)
        ExpireDate = tonumber(Time + 21600)
    elseif Expires == '12 Horas' then
        Expiring = os.date("*t", Time + 43200)
        ExpireDate = tonumber(Time + 43200)
    elseif Expires == '1 Dia' then
        Expiring = os.date("*t", Time + 86400)
        ExpireDate = tonumber(Time + 86400)
    elseif Expires == '3 Dias' then
        Expiring = os.date("*t", Time + 259200)
        ExpireDate = tonumber(Time + 259200)
    elseif Expires == '1 Semana' then
        Expiring = os.date("*t", Time + 604800)
        ExpireDate = tonumber(Time + 604800)
    elseif Expires == 'Permanente' then
        Expiring = os.date("*t", Time + 315360000) -- 10 Years
        ExpireDate = tonumber(Time + 315360000)
    end
    return Expiring, ExpireDate
end
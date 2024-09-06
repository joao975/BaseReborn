-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Webhooks = module("Reborn/webhooks")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
admVRP = {}
Tunnel.bindInterface("Admin",admVRP)
admCLIENT = Tunnel.getInterface("Admin")
-- -----------------------------------------------------------------------------------------------------------------------------------------
-- -- KICKALL
-- -----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kickall",function(source,args,rawCommand)
 	if source == 0 then
 		local users = vRP.getUsers()
		for k,v in pairs(users) do
			local user_idk = vRP.getUserId(v)
			vRP.kick(parseInt(user_idk),"Terremoto!")
		end
 	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("say",function(source,args,rawCommand)
	if source == 0 then
		TriggerClientEvent("Notify",-1,"negado",rawCommand:sub(4).."<br><b>Mensagem enviada por:</b> Governador",15000)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SKIN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('skin',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"Owner") then
		local nplayer = vRP.getUserSource(tonumber(args[1]))
		if nplayer then
			TriggerClientEvent("skinmenu",nplayer,args[2])
			TriggerClientEvent("Notify",source,"negado","Voce setou a skin <b>"..args[2].."</b> no passaporte <b>"..parseInt(args[1]).."</b>.",5000)
		end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEM
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("item",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin")  then
			if args[1] and args[2] then
				if vRP.itemBodyList(args[1]) then
					vRP.giveInventoryItem(user_id,args[1],parseInt(args[2]), nil, true)
					vRP.createWeebHook(Webhooks.webhookgive,"```prolog\n[ID]: "..user_id.."\n[PEGOU]: "..args[1].." \n[QUANTIDADE]: "..parseInt(args[2]).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				else
					TriggerClientEvent("Notify",source,"negado","Item inexistente",5000)
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("debug",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			TriggerClientEvent("ToggleDebug",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ADDCAR
-----------------------------------------------------------------------------------------------------------------------------------------
--[[ RegisterCommand("addcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") and args[1] and args[2] then
			vRP.execute("vRP/add_vehicle",{ user_id = parseInt(args[1]), vehicle = args[2], plate = vRP.generatePlateNumber(), phone = vRP.getPhone(args[1]), work = tostring(false) })
			TriggerClientEvent("Notify",args[1],"importante","Voce recebeu <b>"..args[2].."</b> em sua garagem.",5000)
			TriggerClientEvent("Notify",source,"importante","Adicionou o veiculo: <b>"..args[2].."</b> no ID:<b>"..args[1].."</b.",5000)
			vRP.createWeebHook(Webhooks.webhookaddcar,"```prolog\n[ID]: "..user_id.."\n[ADICIONOU NO ID:]: "..args[1].." \n[CARRO]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end) ]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- CAPUZ
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("capuz",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			TriggerClientEvent("vrp_hud:toggleHood",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- NC
-----------------------------------------------------------------------------------------------------------------------------------------
function admVRP.enablaNoclip()
	local source = source
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			vRPclient.noClip(source)
		end
	end
end

RegisterCommand("gobucket",function(source,args)
	local source = source
	local user_id = vRP.getUserId(source)
	SetPlayerRoutingBucket(source,parseInt(args[1]))
end)

RegisterCommand("getbucket",function(source,args)
	local source = source
	local bucket = GetPlayerRoutingBucket(source)
	TriggerClientEvent("Notify",source,"aviso","Você esta no bucket "..bucket,5000)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- KICK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("kick",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) and parseInt(args[1]) > 0 then
			if vRP.getUserSource(parseInt(args[1])) then
				vRP.kick(parseInt(args[1]),"Você foi expulso da cidade.")
				vRP.createWeebHook(Webhooks.webhookkick,"```prolog\n[ID]: "..user_id.."\n[KICKOU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			else
				TriggerClientEvent("Notify",source,"negado","Cidadão não esta na cidade",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.execute("vRP/set_banned",{ steam = tostring(identity.steam), banned = 1 })
				TriggerClientEvent("Notify",source,"importante","Você baniu "..args[1]..".",5000)
				vRP.createWeebHook(Webhooks.webhookban,"```prolog\n[ID]: "..user_id.." \n[BANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- WL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("wl",function(source,args,rawCommand)
	if source == 0 then
		vRP.setWhitelist(args[1], 1)
		print('Id '..args[1]..' com whitelist liberado.')
		return
	end
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			vRP.setWhitelist(args[1], 1)
			TriggerClientEvent("Notify",source,"importante","Você Aprovou "..args[1]..".",5000)
			vRP.createWeebHook(Webhooks.webhookadminwl,"```prolog\n[ID]: "..user_id.."\n[APROVOU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNWL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unwl",function(source,args,rawCommand)
	if source == 0 then
		vRP.setWhitelist(args[1], 0)
		print('Id '..args[1]..' com whitelist bloqueada.')
		return
	end
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) and parseInt(args[1]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.setWhitelist(args[1], 0)
				TriggerClientEvent("Notify",source,"importante","Você retirou a "..args[1]..".",5000)
				vRP.createWeebHook(Webhooks.webhookunwl,"```prolog\n[ID]: "..user_id.."\n[RETIROU WL]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GEMS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("Coins",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") and parseInt(args[1]) > 0 and parseInt(args[2]) > 0 then
			local identity = vRP.getUserIdentity(parseInt(args[1]))
			if identity then
				vRP.addGmsId(args[1],args[2])
				TriggerClientEvent("Notify",source,"importante","Coins entregues para "..identity.name.." #"..args[1]..".",5000)
				vRP.createWeebHook(Webhooks.webhookgems,"```prolog\n[ID]: "..user_id.."\n[PLAYER]: "..args[1].."\n[Coins]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MONEY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("money",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") and parseInt(args[1]) > 0 then
			vRP.giveInventoryItem(user_id,"dollars",parseInt(args[1]),nil,true)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNBAN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("unban",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) and parseInt(args[1]) > 0 then
			local identity = vRP.getInformation(parseInt(args[1]))
			if identity and identity[1] then
				vRP.execute("vRP/set_banned",{ steam = tostring(identity[1].steam), banned = 0 })
				TriggerClientEvent("Notify",source,"importante","Você desbaniu "..args[1]..".",5000)
				vRP.createWeebHook(Webhooks.webhookunban,"```prolog\n[ID]: "..user_id.." \n[DESBANIU]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPCDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpcds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") or vRP.hasPermission(user_id,"Admin") then
			local fcoords = vRP.prompt(source,"Coordenadas:","")
			if fcoords == "" then
				return
			end

			local coords = {}
			for coord in string.gmatch(fcoords or "0,0,0","[^,]+") do
				table.insert(coords,parseInt(coord))
			end
			vRPclient.teleport(source,coords[1] or 0,coords[2] or 0,coords[3] or 0)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			local x,y,z = vRPclient.getPositions(source)
			vRP.prompt(source,"Coordinates:",x..","..y..","..z)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cds2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			local x,y,z,h = vRPclient.getPositions(source)
			vRP.prompt(source,"Coordinates:",x..","..y..","..z..","..h)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("group",function(source,args,rawCommand)
	if source == 0 then
		vRP.addUserGroup(parseInt(args[1]),tostring(args[2]))
		print("O cidadão foi setado como " ..args[2])
		return
	end
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasAnyPermission(user_id,{ "Owner", "Admin", "Mod", "Sup" }) then
			if args[2] == "Owner" then
				return
			else
				local kgroup = vRP.getGroup(tostring(args[2]))
				if kgroup == nil then
					TriggerClientEvent("Notify",source,"sucesso","O grupo não existe",5000)
					return 
				end
				if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == "job" then
					local group = vRP.getUserGroupByType(parseInt(args[1]),"job")
					if group then
						vRP.removePermission(parseInt(args[1]),group)
						vRP.execute("vRP/del_group",{ user_id = parseInt(args[1]), permiss = group })
					end
				end
				if not vRP.hasPermission(parseInt(args[1]),tostring(args[2])) then
					vRP.addUserGroup(parseInt(args[1]),tostring(args[2]))
					TriggerClientEvent("Notify",source,"sucesso","O cidadão foi setado como " ..(args[2]).." ",5000)
					vRP.createWeebHook(Webhooks.webhookset,"```prolog\n[ID]: "..user_id.." \n[SETOU]: "..args[1].." \n [GROUP]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rg2",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			local permiss = vRP.query("vRP/get_perm",{ user_id = parseInt(args[1]) })
			for k,v in ipairs(permiss) do
				TriggerClientEvent("Notify",source,"importante","<b>SETS:</b> "..v.permiss.." ",7000)
				Citizen.Wait(1)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UNGROUP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("ungroup",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			if vRP.hasPermission(parseInt(args[1]),tostring(args[2])) then
				vRP.removePermission(parseInt(args[1]),tostring(args[2]))
				vRP.execute("vRP/del_group",{ user_id = parseInt(args[1]), permiss = tostring(args[2]) })
				TriggerClientEvent("Notify",source,"sucesso","O cidadão foi retirado de " ..(args[2])..".",5000)
				vRP.createWeebHook(Webhooks.webhookunset,"```prolog\n[ID]: "..user_id.." \n[TIROU SET DE]: "..args[1].." \n [GROUP]: "..args[2].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTOME
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tptome",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) and parseInt(args[1]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.teleport(nplayer,vRPclient.getPositions(source))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Limpar INV
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparinv",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = tonumber(args[1])
	if vRP.hasPermission(user_id,"Admin") then
		if nplayer ~= nil then
			vRP.clearInventory(nplayer)
			TriggerClientEvent("Notify",source,"sucesso","Você limpou inventario de " ..nplayer..".",5000)
			vRP.createWeebHook(Webhooks.webhooklimparinv,"```prolog\n[ID]: "..user_id.." \n[LIMPOU INV DE]: "..nplayer..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		else
			vRP.clearInventory(user_id)
			TriggerClientEvent("Notify",source,"sucesso","Você limpou seu inventario",5000)
			vRP.createWeebHook(Webhooks.webhooklimparinv,"```prolog\n[ID]: "..user_id.." /n[LIMPOU PROPRIO INV]" ..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpto",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) and parseInt(args[1]) > 0 then
			local nplayer = vRP.getUserSource(parseInt(args[1]))
			if nplayer then
				vRPclient.teleport(source,vRPclient.getPositions(nplayer))
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TPWAY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tpway",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			admCLIENT.teleportWay(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMBO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limbo",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRPclient.getHealth(source) <= 101 then
			admCLIENT.teleportLimbo(source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HASH / GETCAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("hash",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			local vehicle = vRPclient.getNearVehicle(source,7)
			if vehicle then
				vRP.prompt(source,"Hash do veiculo:",GetHashKey(vehicle))			
			end
		end
	end
end)

RegisterCommand("getcar",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			local vehicle = vRPclient.getNearVehicle(source,7)
			if vehicle then
				local hash = admCLIENT.vehicleHash(source,vehicle)
				local carname = vRP.prompt(source,"Nome de spawn do carro:","")
				local nicename = vRP.prompt(source,"Nome bonito do carro:","")
				local carprice = vRP.prompt(source,"Preço do carro:","")
				local carchest = vRP.prompt(source,"Bau do carro (Padrao 40):","40")
				local cartype = vRP.prompt(source,"Tipo do carro:","carros")
				vRP.prompt(source,"Resultado:","{ hash = "..hash..", name = '"..carname.."', price = "..carprice..", banido = false, modelo = '"..nicename.."', capacidade = "..carchest..", tipo = '"..cartype.."' },")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DELNPCS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("delnpcs",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			admCLIENT.deleteNpcs(source,tonumber(args[1]))
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TUNING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tuning",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			TriggerClientEvent("vehtuning",source)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LIMPAREA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("limparea",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Police" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			local x,y,z = vRPclient.getPositions(source)
			TriggerClientEvent("syncarea",-1,x,y,z,100)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("players",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"admin.permissao") then
			local quantidade = 0
			local users = vRP.getUsers()
			for k,v in pairs(users) do
				quantidade = parseInt(quantidade) + 1
			end
			TriggerClientEvent("Notify",source,"importante","<b>Players Conectados:</b> "..quantidade,5000)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CPLAYERS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cplayers",function(source,args,rawCommand)
	if source == 0 then
		local quantidade = 0
		local users = vRP.getUsers()
		for k,v in pairs(users) do
			quantidade = parseInt(quantidade) + 1
		end
		print("Players Conectados: "..quantidade)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pon',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin", "Mod", "Sup" }
	if vRP.hasAnyPermission(user_id,perms) then
		local users = vRP.getUsers()
		local players = ""
		local quantidade = 0
		for k,v in pairs(users) do
			if k ~= #users then
				players = players..", "
			end
			players = players..k
			quantidade = quantidade + 1
		end
		TriggerClientEvent('chatMessage',source,"TOTAL ONLINE",{1, 136, 0},quantidade)
		TriggerClientEvent('chatMessage',source,"ID's ONLINE",{1, 136, 0},players)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("anuncio",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local perms = {	"Owner", "Admin" }
	if user_id then
		if vRP.hasAnyPermission(user_id,perms) then
			local message = vRP.prompt(source,"Message:","")
			if message == "" then
				return
			end

			TriggerClientEvent("Notify",-1,"negado",message.."<br><b>Mensagem enviada por:</b> Prefeitura",15000)
			vRP.createWeebHook(Webhooks.webhookadmin,"```prolog\n[ID]: "..user_id.." \n[ENVIOU MENSAGEM]: "..message.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ITEMALL
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("itemall",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") and args[1] and args[2] then
			if vRP.itemBodyList(args[1]) then
				local users = vRP.getUsers()
				for k,v in pairs(users) do
					vRP.giveInventoryItem(parseInt(k),tostring(args[1]),parseInt(args[2]),nil,true)
				end
			else
				TriggerClientEvent("Notify",source,"negado","Item inexistente",5000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PEGA IP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('pegarip',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local tplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id,"Owner") then
        if args[1] and tplayer then
        	TriggerClientEvent('chatMessage',source,"^1IP do Usuário: "..GetPlayerEndpoint(tplayer))
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPEC 
----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("spec",function(source,args)
    local source = source
    local user_id = vRP.getUserId(source)
    local spectar = tonumber(args[1])
    if vRP.hasPermission(user_id, "Owner") then
        local nplayer = vRP.getUserSource(spectar)
        if nplayer then
            TriggerClientEvent("SpecMode", source,nplayer)
        else
            TriggerClientEvent("Notify", source, "Negado", "Esse player não está online...",4000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MATAR COM CODIGO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('kill',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Owner") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                vRPclient.killGod(nplayer)
                vRPclient.setHealth(nplayer,0)
            end
        else
            vRPclient.killGod(source)
            vRPclient.setHealth(source,0)
            vRPclient.setArmour(source,0)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDP
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRPclient.nearestPlayer(source,5)
    if nplayer then
        local nuser_id = vRP.getUserId(nplayer)
        TriggerClientEvent("Notify",source,"importante","Jogador próximo: "..nuser_id..".",4000)
    else
        TriggerClientEvent("Notify",source,"aviso","Nenhum Jogador Próximo",4000)
    end
end)

RegisterCommand('freeze', function(source, args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Owner") and args[1] then
		local nplayer = vRP.getUserSource(parseInt(args[1]))
		if nplayer then
			TriggerClientEvent('Congelar', nplayer)
			TriggerClientEvent("Notify",source,"sucesso","Jogador Congelado!",4000)
		end  
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DM (MENSAGEM NO PRIVADO)
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('dm',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    local nplayer = vRP.getUserSource(parseInt(args[1]))
    if vRP.hasPermission(user_id,"Admin") then
        if args[1] == nil then
            TriggerClientEvent("Notify",source,"negado","Necessário passar o ID após o comando, exemplo: <b>/dm 1</b>",5000)
            return
        elseif nplayer == nil then
            TriggerClientEvent("Notify",source,"negado","O jogador não está online!",5000)
            return
        end
        local mensagem = vRP.prompt(source,"Digite a mensagem:","")
        if mensagem == "" then
            return
        end
        TriggerClientEvent("Notify",source,"sucesso","Mensagem enviada com sucesso!")
        TriggerClientEvent('chatMessage',nplayer,"PREFEITURA:",{255,20,0},mensagem)
        TriggerClientEvent("Notify",nplayer,"aviso","<b>Mensagem da Administração</b> ",10000)
    end
end)

RegisterCommand("checar",function(source,args,rawCommand)
    local source = source
    local user_id = vRP.getUserId(source)
    local contratados = {}
    if vRP.hasPermission(user_id,"Admin") and args[1] then
        local consult = vRP.query("vRP/get_specific_perm",{ permiss = args[1] }) or {}
        for k,v in pairs(consult) do
            local identity = vRP.getUserIdentity(v.user_id)
            TriggerClientEvent("Notify",source,"aviso","ID: "..v.user_id.." "..identity.name.." "..identity.name2.."",5000)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("rg",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Police") or vRP.hasPermission(user_id,"Admin") then
			if parseInt(args[1]) > 0 then
				local nuser_id = parseInt(args[1])
				local identity = vRP.getUserIdentity(nuser_id)
				if identity then
					local fines = vRP.getFines(user_id)
					TriggerClientEvent("Notify",source,"importante","<b>Passaporte:</b> "..identity.id.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(fines)),20000)
				end
			else
				local nplayer = vRPclient.nearestPlayer(source,2)
				if nplayer then
					local nuser_id = vRP.getUserId(nplayer)
					if nuser_id then
						local identity = vRP.getUserIdentity(nuser_id)
						if identity then
							local fines = vRP.getFines(user_id)
							TriggerClientEvent("Notify",source,"importante","<b>Passaporte:</b> "..identity.id.."<br><b>Nome:</b> "..identity.name.." "..identity.name2.."<br><b>RG:</b> "..identity.registration.."<br><b>Telefone:</b> "..identity.phone.."<br><b>Multas Pendentes:</b> $"..vRP.format(parseInt(fines)),20000)
						end
					end
				end
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- OUT PRISON
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("outprison", function(source, args)
    local user_id = vRP.getUserId(source)
    if user_id and args[1] and vRP.hasPermission(user_id,"Admin") then
        local nuser_id = parseInt(args[1])
        local nplayer =  vRP.getUserSource(nuser_id)
        local ped = GetPlayerPed(nplayer)
        TriggerClientEvent('prisioneiro',nplayer,false)
        SetEntityCoords(ped,1850.5,2604.0,45.5)
        vRP.setUData(parseInt(nuser_id),"vRP:prisao",-1)
    end
end)

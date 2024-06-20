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
svVRP = {}
Tunnel.bindInterface("Survival",svVRP)
svCLIENT = Tunnel.getInterface("Survival")
local resetCoords = { -445.38,-307.61,35.84 }
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("god",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner")or vRP.hasPermission(user_id,"Admin") or vRP.hasPermission(user_id,"Mod") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					svCLIENT.revivePlayer(nplayer,400)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("resetDiagnostic",nplayer)
					vRP.createWeebHook(Webhooks.webhookgod,"```prolog\n[ID]: "..user_id.."\n[DEU GOD PARA:]: "..args[1].." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
				end
			else
				svCLIENT.revivePlayer(source,400)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
				vRP.createWeebHook(Webhooks.webhookgod,"```prolog\n[ID]: "..user_id.."\n[DEU GOD PARA SI MESMO]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("good",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"Owner") then
			if args[1] then
				local nplayer = vRP.getUserSource(parseInt(args[1]))
				if nplayer then
					svCLIENT.revivePlayer(nplayer,400)
					vRP.upgradeThirst(parseInt(args[1]),100)
					vRP.upgradeHunger(parseInt(args[1]),100)
					vRPclient.setArmour(nplayer,100)
					vRP.downgradeStress(user_id,100)
					TriggerClientEvent("resetBleeding",nplayer)
					TriggerClientEvent("resetDiagnostic",nplayer)
				end
			else
				vRP.upgradeThirst(user_id,100)
				vRP.upgradeHunger(user_id,100)
				vRP.downgradeStress(user_id,100)
				vRPclient.setArmour(source,100)
				svCLIENT.revivePlayer(source,400)
				TriggerClientEvent("resetBleeding",source)
				TriggerClientEvent("resetDiagnostic",source)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- UPGRADESTRESS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("upgradeStress")
AddEventHandler("upgradeStress",function(number)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.upgradeStress(user_id,parseInt(number))
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("re",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local nplayer = vRPclient.nearestPlayer(source,2)
		revive(user_id, nplayer)
	end
end)

RegisterNetEvent("paramedic:Revive")
AddEventHandler("paramedic:Revive",function(nplayer)
	local source = source
	local user_id = vRP.getUserId(source)
	revive(user_id,nplayer)
end)

function revive(user_id, nplayer)
	local source = vRP.getUserSource(user_id)
	if vRP.hasPermission(user_id,"Paramedic") or vRP.hasPermission(user_id,"Sup") or vRP.hasPermission(user_id,"Gote") then
		local nuser_id = vRP.getUserId(nplayer)
		if nplayer then
			if svCLIENT.deadPlayer(nplayer) then
				TriggerClientEvent("Progress",source,10000,"Retirando...")
				TriggerClientEvent("cancelando",source,true)
				vRPclient._playAnim(source,false,{"mini@cpr@char_a@cpr_str","cpr_pumpchest"},true)
				local chance = math.random(0,100)
				if chance >= 5 and not svCLIENT.finalizado(nplayer) then
					SetTimeout(10000,function()
						vRPclient._removeObjects(source)
						svCLIENT.revivePlayer(nplayer,110)
						TriggerClientEvent("resetBleeding",nplayer)
						TriggerClientEvent("cancelando",source,false)
						vRP.createWeebHook(Webhooks.webhookreviver,"```prolog\n[ID]: "..user_id.."\n[REVIVEU:]: "..vRP.getUserId(nplayer).." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					end)
				else
					SetTimeout(10000,function()
						TriggerClientEvent("cancelando",source,false)
						vRPclient._removeObjects(source)
						TriggerClientEvent("Notify",source,"negado","Cidadão está sem pulso.",5000)
						TriggerClientEvent("Notify",nplayer,"negado","Você está sem pulso.",5000)
						Wait(120000)
						svCLIENT.finishDeath(nplayer)
						TriggerClientEvent("resetHandcuff",nplayer)
						TriggerClientEvent("resetBleeding",nplayer)
						TriggerClientEvent("resetDiagnostic",nplayer)
						TriggerClientEvent("vrp_survival:FadeOutIn",nplayer)
						Wait(5000)
						local clear = vRP.clearInventory(nuser_id)
						if clear then
							vRPclient._clearWeapons(nplayer)
							Wait(2000)
							vRPclient.teleport(nplayer,359.87,-585.34,43.29)
							Wait(1000)
							svCLIENT.SetPedInBed(nplayer)
						end
						TriggerClientEvent("vrp_hud:toggleHood",nplayer)
						Wait(10000)
						svCLIENT.revivePlayer(nplayer,110)
						TriggerClientEvent("Notify",nplayer,"aviso","Você acabou de acordar de um coma",5000)
						TriggerClientEvent("vrp_hud:toggleHood",nplayer)
					end)
				end
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SOCORRO
-----------------------------------------------------------------------------------------------------------------------------------------
--[[RegisterCommand("socorro",function(source,args,rawCommand)
	valor = 10000
	local user_id = vRP.getUserId(source)
	local paramedic = vRP.numPermission("Paramedic")
	if user_id then
		if #paramedic == 0 then
			--local request = vRP.request(source, "Você deseja dar socorro por R$10.000,00 ?", 60)
			--if request then
				if vRPclient.getHealth(source) <= 101 and not svCLIENT.finalizado(source) then
					if vRP.paymentBank(user_id,valor) then
						svCLIENT.revivePlayer(source,120)
						TriggerClientEvent("resetBleeding",nplayer)
						vRP.upgradeHunger(user_id,50)
						vRP.upgradeThirst(user_id,50)
						vRP.createWeebHook(Webhooks.webhooksocorro,"```prolog\n[ID]: "..user_id.."\n[DEU SOCORRO]"..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
					else
						TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua conta bancária.",3000)
					end
				end
			--end
		else
			TriggerClientEvent("Notify",source,"negado","Existe paramedicos em serviço.",3000)
		end
	end
end)]]
-----------------------------------------------------------------------------------------------------------------------------------------
-- GG
-----------------------------------------------------------------------------------------------------------------------------------------
function svVRP.ResetPedToHospital()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if svCLIENT.deadPlayer(source) then
			svCLIENT.finishDeath(source)
			TriggerClientEvent("resetHandcuff",source)
			TriggerClientEvent("resetBleeding",source)
			TriggerClientEvent("resetDiagnostic",source)
			TriggerClientEvent("vrp_survival:FadeOutIn",source)
			Wait(1000)
			if not vRP.hasPermission(user_id, "vip.permissao") then
				local clear = vRP.clearInventory(user_id)
				if clear then
					vRPclient._clearWeapons(source)
				end
			end
			Wait(2000)
			vRPclient.teleport(source,resetCoords[1], resetCoords[2], resetCoords[3])
			Wait(1000)
			svCLIENT.SetPedInBed(source)
			Wait(1000)
			TriggerClientEvent("Notify",source,"importante","Você acabou de acordar de um coma.",3000)
		end
	end
end

RegisterCommand("finalizar",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.nearestPlayer(source,2)
	if svCLIENT.deadPlayer(nplayer) then
		TriggerClientEvent("vrp_survival:finalizado",nplayer)
		TriggerClientEvent("Notify",source,"sucesso","Cidadão finalizado.",3000)
		TriggerClientEvent("Notify",nplayer,"aviso","Você foi finalizado",3000)
	end
end)

RegisterCommand("bugado",function(source,args,rawCommand)
	local source = source
	local user_id = vRP.getUserId(source)
	if vRPclient.getHealth(source) >= 101 then
		TriggerClientEvent("vrp_survival:desbugar",source)
	end
end)

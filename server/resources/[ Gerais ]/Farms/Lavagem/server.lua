local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Tools = module("vrp","lib/Tools")
local Webhooks = module("Reborn/webhooks")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")
emP = {}
Tunnel.bindInterface("Lavagem",emP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- Checar Itens
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkItens()
	local source = source
	local user_id = vRP.getUserId(source)
	local dinheiro_sujo = vRP.getInventoryItemAmount(user_id,"dollars2")
	if user_id then
		if vRP.hasPermission(user_id,Farms.lavagem.perm) then
			if dinheiro_sujo >= Farms.lavagem['dinheiro_sujo'].min_money and dinheiro_sujo <= Farms.lavagem['dinheiro_sujo'].max_money then
				return true 
			else
				TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente.",4000)  
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- Pagamento
-----------------------------------------------------------------------------------------------------------------------------------------
function emP.checkPayment()
    local source = source
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
	local dinheiro = vRP.getInventoryItemAmount(user_id,"dollars2")
    if user_id then
		if vRP.tryGetInventoryItem(user_id,"dollars2",dinheiro) then
			local payment = dinheiro * (Farms.lavagem['dinheiro_sujo'].porcentagem)/100
			vRP.giveInventoryItem(user_id,"dollars",payment,true)
			vRP.createWeebHook(Webhooks.webhooklavagem,"```prolog\n[PASSAPORTE]: "..user_id.." \n[NOME]: "..identity.name.." "..identity.name2.." \n[LAVOU]: "..dinheiro.." \n[RECEBEU]: "..payment.." "..os.date("\n[Data]: %d/%m/%y \n[Hora]: %H:%M:%S").." \r```")
		end
   end
end
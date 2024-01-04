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
cRP = {}
Tunnel.bindInterface("Races",cRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- FINISHRACES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.finishRaces()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		vRP.giveInventoryItem(user_id,"dollars2",math.random(Config.races['payment']['min'],Config.races['payment']['max']))
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTRACES
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.startRaces()
	local source = source
	local user_id = vRP.getUserId(source)
	local comAmount = vRP.numPermission("Police")
	if user_id then
		TriggerClientEvent("Notify",source,"importante","A policia foi acionada, corra!",5000)
		vRP.createWeebHook(Webhooks.webhookraces,"```prolog\n[ID]: "..user_id.."\n[Iniciou corrida] "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
	end
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- CALLPOLICE
-----------------------------------------------------------------------------------------------------------------------------------------
function cRP.callPolice(x,y,z)
	local copAmount = vRP.numPermission("Police")
	for k,v in pairs(copAmount) do
		local player = vRP.getUserSource(v)
		async(function()
			TriggerClientEvent("NotifyPush",player,{ time = os.date("%H:%M:%S - %d/%m/%Y"), text = "Estou vendo um bando de incompetente planejando uma corrida por aqui!", code = 10, title = "Corrida em andamento", x = x, y = y, z = z, rgba = {95,158,160} })
		end)
	end
end
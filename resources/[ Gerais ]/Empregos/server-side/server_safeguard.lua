safeg = {}
Tunnel.bindInterface("salvavidas",safeg)
local amount = {}

local points = {}
local points_incident = {}

function safeg.spawnveh()
    local source = source
    local user_id = vRP.getUserId(source)
    local spawn = vector3(-1480.03, -1033.39, 5.99)
    local cabeca = 229.9898223877
    if user_id then
        TriggerClientEvent("spawnarveiculopl",source, 'blazer2', spawn, cabeca)
    end
end

function safeg.setPlayerObserve()
	local source = source
    local user_id = vRP.getUserId(source)
	if points[user_id] == nil then
		points[user_id] = 0
	end
end
function safeg.setPlayerIncident()
	local source = source
    local user_id = vRP.getUserId(source)
	if points_incident[user_id] == nil then
		points_incident[user_id] = 0
	end
end

function safeg.pointObserved()
	local source = source
    local user_id = vRP.getUserId(source)
	points[user_id] = points[user_id] + 1
end

function safeg.incidents()
	local source = source
    local user_id = vRP.getUserId(source)
	points_incident[user_id] = points_incident[user_id] + 1
end

function safeg.paymentsv()
    local source = source
    local user_id = vRP.getUserId(source)
    if points_incident[user_id] == 0 or points_incident[user_id] == nil then
        return
    end
    if points[user_id] == 0 or points[user_id] == nil then
        return
    end
    local payment = math.random(configs.payment[1],configs.payment[2])*points[user_id]
    local payment2 = math.random(configs.payment_incident[1],configs.payment_incident[2])*points_incident[user_id]
    local total = payment + payment2
    if user_id then
		if points[user_id] ~= 0 then
            TriggerClientEvent("itensNotify",vRP.getUserSource(parseInt(user_id)),"RECEBEU",vRP.itemIndexList("dollars"),vRP.format(total),"Dinheiro")
            vRP.giveMoney(user_id,total)
            if points_incident[user_id] ~= 0 then
                TriggerClientEvent("Notify",source,"PAGAMENTO","<br> Pontos observados: <b>"..points[user_id].."</b>,<br>Ocorrências realizadas: <b>"..points_incident[user_id].."</b>, <br>Ganhos: <b>R$"..total.."</b>.",5000)
            else
                TriggerClientEvent("Notify",source,"PAGAMENTO","<br> Pontos observados: <b>"..points[user_id].."</b>, Ganhos: <b>R$"..total.."</b>.",5000)
            end
            points[user_id] = nil
            points_incident[user_id] = nil
		end
	end
end
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
hpVRP = {}
Tunnel.bindInterface("Hospital",hpVRP)
hpCLIENT = Tunnel.getInterface("Hospital")
vSURVIVAL = Tunnel.getInterface("Survival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- BONES
-----------------------------------------------------------------------------------------------------------------------------------------
local bones = {
	[11816] = "Pelvis",
	[58271] = "Coxa Esquerda",
	[63931] = "Panturrilha Esquerda",
	[14201] = "Pe Esquerdo",
	[2108] = "Dedo do Pe Esquerdo",
	[65245] = "Pe Esquerdo",
	[57717] = "Pe Esquerdo",
	[46078] = "Joelho Esquerdo",
	[51826] = "Coxa Direita",
	[36864] = "Panturrilha Direita",
	[52301] = "Pe Direito",
	[20781] = "Dedo do Pe Direito",
	[35502] = "Pe Direito",
	[24806] = "Pe Direito",
	[16335] = "Joelho Direito",
	[23639] = "Coxa Direita",
	[6442] = "Coxa Direita",
	[57597] = "Espinha Cervical",
	[23553] = "Espinha Toraxica",
	[24816] = "Espinha Lombar",
	[24817] = "Espinha Sacral",
	[24818] = "Espinha Cocciana",
	[64729] = "Escapula Esquerda",
	[45509] = "Braco Esquerdo",
	[61163] = "Antebraco Esquerdo",
	[18905] = "Mao Esquerda",
	[18905] = "Mao Esquerda",
	[26610] = "Dedo Esquerdo",
	[4089] = "Dedo Esquerdo",
	[4090] = "Dedo Esquerdo",
	[26611] = "Dedo Esquerdo",
	[4169] = "Dedo Esquerdo",
	[4170] = "Dedo Esquerdo",
	[26612] = "Dedo Esquerdo",
	[4185] = "Dedo Esquerdo",
	[4186] = "Dedo Esquerdo",
	[26613] = "Dedo Esquerdo",
	[4137] = "Dedo Esquerdo",
	[4138] = "Dedo Esquerdo",
	[26614] = "Dedo Esquerdo",
	[4153] = "Dedo Esquerdo",
	[4154] = "Dedo Esquerdo",
	[60309] = "Mao Esquerda",
	[36029] = "Mao Esquerda",
	[61007] = "Antebraco Esquerdo",
	[5232] = "Antebraco Esquerdo",
	[22711] = "Cotovelo Esquerdo",
	[10706] = "Escapula Direita",
	[40269] = "Braco Direito",
	[28252] = "Antebraco Direito",
	[57005] = "Mao Direita",
	[58866] = "Dedo Direito",
	[64016] = "Dedo Direito",
	[64017] = "Dedo Direito",
	[58867] = "Dedo Direito",
	[64096] = "Dedo Direito",
	[64097] = "Dedo Direito",
	[58868] = "Dedo Direito",
	[64112] = "Dedo Direito",
	[64113] = "Dedo Direito",
	[58869] = "Dedo Direito",
	[64064] = "Dedo Direito",
	[64065] = "Dedo Direito",
	[58870] = "Dedo Direito",
	[64080] = "Dedo Direito",
	[64081] = "Dedo Direito",
	[28422] = "Mao Direita",
	[6286] = "Mao Direita",
	[43810] = "Antebraço Direito",
	[37119] = "Antebraço Direito",
	[2992] = "Cotovelo Direito",
	[39317] = "Pescoco",
	[31086] = "Cabeca",
	[12844] = "Cabeca",
	[65068] = "Rosto"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLEEDING
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("sangramento",function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.nearestPlayer(source,3)
    bleeding(user_id,nplayer)
end)

RegisterNetEvent("hospital:sangramento")
AddEventHandler("hospital:sangramento",function(nplayer)
	local source = source
	local user_id = vRP.getUserId(source)
	bleeding(user_id,nplayer)
end)

function bleeding(user_id,nplayer)
	if vRP.hasPermission(user_id,"Paramedic") then
        if nplayer then
            TriggerClientEvent("resetBleeding",nplayer)
            TriggerClientEvent("Notify",source,"sucesso","O sangramento parou.",5000)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DIAGNOSTIC
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("diagnostico",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.nearestPlayer(source,3)
	diagnostic(user_id,nplayer)
end)

RegisterNetEvent("hospital:diagnostico")
AddEventHandler("hospital:diagnostico",function(nplayer)
	local source = source
	local user_id = vRP.getUserId(source)
	diagnostic(user_id,nplayer)
end)

function diagnostic(user_id,nplayer)
	if vRP.hasPermission(user_id,"paramedico.permissao") then
		if nplayer then
			local hurt = false
			local diagnostic,bleeding = hpCLIENT.getDiagnostic(nplayer)
			if diagnostic then
				
				local damaged = {}
				for k,v in pairs(diagnostic) do
					damaged[k] = bones[k]
				end

				if next(damaged) then
					hurt = true
					TriggerClientEvent("drawInjuries",source,nplayer,damaged)
				end
			end
			
			local text = ""
			if bleeding > 4 then
				text = "- <b>Bleeding</b><br>"
			end

			if diagnostic.taser then
				text = text .. "- <b>Taser prongs</b><br>"
			end

			if diagnostic.vehicle then
				text = text .. "- <b>Vehicle accident bruises</b><br>"
			end

			if text ~= "" then
				TriggerClientEvent("Notify",source,"aviso","Status do paciente:<br>" .. text,5000)
			elseif not hurt then
				TriggerClientEvent("Notify",source,"sucesso","Status do paciente:<br>- <b>Nada encontrado</b>",5000)
			end
			vRP.createWeebHook(Webhooks.webhookdiagnostico,"```prolog\n[ID]: "..user_id.."\n[DIAGNOSTICOU]: "..nplayer.."\n[RESULTADO]: "..text.. " "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TREAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("tratamento",function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	local nplayer = vRPclient.nearestPlayer(source,3)
	treatment(user_id,nplayer)
end)

RegisterNetEvent("hospital:tratamento")
AddEventHandler("hospital:tratamento",function(nplayer)
	local source = source
	local user_id = vRP.getUserId(source)
	treatment(user_id,nplayer)
end)

function treatment(user_id,nplayer)
	if vRP.hasPermission(user_id,"Paramedic") then
		if nplayer then
			if not vSURVIVAL.deadPlayer(nplayer) then
				vSURVIVAL._startCure(nplayer)
				TriggerClientEvent("resetBleeding",nplayer)
				TriggerClientEvent("resetDiagnostic",nplayer)
				TriggerClientEvent("Notify",source,"sucesso","O tratamento começou.",5000)
				vRP.createWeebHook(Webhooks.webhooktratamento,"```prolog\n[ID]: "..user_id.."\n[DEU TRATAMENTO PARA:]: "..nplayer.." "..os.date("\n[Data]: %d/%m/%Y [Hora]: %H:%M:%S").." \r```")
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKSERVICES
-----------------------------------------------------------------------------------------------------------------------------------------
function hpVRP.checkServices()
	local amountMedics = vRP.numPermission("Paramedic")
	if parseInt(#amountMedics) >= 1 then
		TriggerClientEvent("Notify",source,"aviso","Existem paramédicos em serviço.",5000)
		return false
	end
	return true
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PAYMENTCHECKIN
-----------------------------------------------------------------------------------------------------------------------------------------
function hpVRP.paymentCheckin()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		if vRP.hasPermission(user_id,"policia.permissao") then
			return true
		end

		local value = 500
		if GetEntityHealth(GetPlayerPed(source)) <= 101 then
			value = value + 1600
		end

		if vRP.paymentBank(user_id,parseInt(value)) then
			return true
		else
			TriggerClientEvent("Notify",source,"negado","Dinheiro insuficiente na sua mochila.",5000)
		end
	end
	return false
end

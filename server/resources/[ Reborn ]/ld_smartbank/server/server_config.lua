local Webhooks = module("Reborn/webhooks")
-------------------------------------------------------------------------------------------------------------------------
-- COMANDO DE MULTAR INTEGRADO COM O BANCO
-------------------------------------------------------------------------------------------------------------------------
--[[ RegisterCommand('multar',function(source,args,rawCommand)
	local user_id = vRP.getUserId(source)
	if vRP.hasPermission(user_id,"policia.permissao") then
		local id = vRP.prompt(source,"Passaporte:","")
		local valor = vRP.prompt(source,"Valor:","")
		local motivo = vRP.prompt(source,"Motivo:","")
		if id == "" or valor == "" or motivo == "" then
			return
		end
		local nplayer = vRP.getUserSource(parseInt(id))
		local pix = GetPIXFromSource(nplayer)
        if pix ~= nil then
			local oficialid = vRP.getUserIdentity(user_id)
			if CreateFine(nplayer, oficialid.name.." "..oficialid.firstname, parseInt(valor), motivo) then
				local value = vRP.getUData(parseInt(id),"vRP:multas")
				local multas = json.decode(value) or 0
				vRP.setUData(parseInt(id),"vRP:multas",json.encode(parseInt(multas)+parseInt(valor)))
				local oficialid = vRP.getUserIdentity(user_id)

				randmoney = math.random(90,150)
				vRP.giveMoney(user_id,parseInt(randmoney))
				TriggerClientEvent("Notify",source,"sucesso","Multa aplicada com sucesso.")
				TriggerClientEvent("Notify",source,"importante","Você recebeu <b>$"..vRP.format(parseInt(randmoney)).." dólares</b> de bonificação.")
				TriggerClientEvent("Notify",nplayer,"importante","Você foi multado em <b>$"..vRP.format(parseInt(valor)).." dólares</b>.<br><b>Motivo:</b> "..motivo..".")
			end
		end
	end
end) ]]

-------------------------------------------------------------------------------------------------------------------------
-- CONFIGURAÇÃO PARTE SERVIDOR
-------------------------------------------------------------------------------------------------------------------------
ld_smartbank = {}
ld_smartbank['config'] = {
	
	['debugMode']        = false, -- Ativa as mensagens de debug
	
	gerarPIX = function(s) -- METÓDO QUE A CHAVE PIX É GERADA, ALTERE CASO QUEIRA E SAIBA.
        local res = ""
		local length = 10
		for i = 1, length do
			res = res .. string.char(math.random(97, 122))
		end
        return string.upper(res)
    end,
	
    ['enableATMs']          = true, -- Ativa/desativa as ATMS (caixinhas)
    ['enableCards']        = false, --  Ativa o comando /cartoes. ATENÇÃO! Caso aqui esteja false, os jogadores não conseguirão emprestar seus cartões a outros jogadores
    ['enableStatements']    = true, -- Ativa a aba de "estatísticas"
	['enableFines']    = true, -- Ativa a aba de multas
    ['enableCrypto']        = true, -- Ativa o sistema de criptomoedas
	
	['savingAccount'] = {
        ['enableIncomes']    = false, -- Ativa/desativa se a poupança vai render (ATENÇÃO! A poupança rende apenas com o player ONLINE. Caso ele relogue, o tempo reiniciará.)
		['nuiMessage']    = true, -- Porcentagem que a poupança vai render (padrão = 5% [0.05])
		['time']    = 1000 * 60 * 90, -- Tempo que a poupança vai levar para render a porcentagem (padrão = 60m)
		['percentage']    = 0.01, -- Porcentagem que a poupança vai render (padrão = 5% [0.05])
    },

    ['fees']                = { transfer = 4, withdraw = 2 }, -- Taxas de transferência e saque (respectivamente)
    ['startingMoney']       = 0, -- Dinheiro inicial que o jogador irá ganhar
    ['ATMDaily']            = 3600000, -- Tempo para resetar o limite de saque da ATM [O padrão é uma hora]
    ['ATMDailyLimit']       = 5000, -- Valor máximo para saque na sessão (reseta no tempo acima)
    ['cryptoPercentage']    = 1.0, -- Determina a porcentagem do preço real do BTC que será representado no servidor [Exemplo - Se o BITCOIN está em 60k e o valor aqui em 0.5, dentro do servidor 1 BTC = 30k][Min 0.1]
	['cryptoLimit']    = 5.0, -- Determina o limite máximo de bitcoins que o player pode ter na sua carteira.
	
	['cryptoUpdateTime']    = 1000 * 60 * 15, -- Tempo que o preço do bitcoin vai levar pra ser atualizado (padrão = 15 minutos)
	
    ['webhooksURL']         = Webhooks.webhookbank, -- Link para as LOGS.
	['pixTable']         = "vrp_users", -- Tabela que vai armezenar a coluna chavePix
	['moneyTable']         = "vrp_users", -- Tabela onde será feito as alterações do dinheiro caso necessário.
	['moneyBankColumn']         = "bank", -- Coluna do dinheiro do banco (da tabela acima)

	['pixChangePermission']         = "admin.permissao", -- Permissão para alterar chave pix (DEIXE nil PARA QUE SEJA LIVRE)

    ['nui'] = {
        ['customColor']             = 'purple',  -- Cores da interface disponíveis: lightblue, red, green, yellow, blue, purple
        ['logo']                    = 'https://media.discordapp.net/attachments/950068214296088596/959320569717874738/rbn.png' -- Logo do banco [recomendado 818x482]
    }
}

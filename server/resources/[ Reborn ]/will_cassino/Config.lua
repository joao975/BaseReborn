Tunnel = module("vrp","lib/Tunnel")
--            ///////////////\\\\\\\\\\\\\\
--                   CASSINO JOGOS
--            ///////////////\\\\\\\\\\\\\\
Config = {}
-- Primeiramente queriamos agradecer pela confiança e pela compra de um de nossos produtos da Reborn Shop.
-- Esse arquivo será o unico que deverá ser alterado conforme seu gosto e sua cidade.
-- Jamais mexa em nenhum outro arquivo dentro de cada pasta, isso irá desativar sua key e seu suporte conosco.
-- Cada configuração sua explicação
-- Duvidas pode entrar em contato conosco no discord: discord.gg/8TFHTKmV

-- Item utilizado no cassino para apostar. (Recomendado criar um item fichas)
Config.money = "fichas"

-- Carro de exibição e npc em alguns lugares, caso não queira, deixar 'false'. 
-- Recomendado retirar para otimizar um pouco mais.
Config.details = true

-- Carro de exibição
Config.car = "zentorno"

-- Caso deseja alguns npc para exibição, deixe 'true', caso contrario, 'false'
Config.npc = true

local Webhooks = module("Reborn/webhooks")
local webhookgames = Webhooks.webhookcassino
Config.webhookgames = webhookgames

-- Locais de cada npc, aconselha-se deixar assim, mas caso queira mudar:
-- { x, y, z, heading, HashDoNpc }

Config.npcLocal = {
    { 938.46,47.36,72.28, 180.0, 691061163 }, 
    { 936.32,48.28,72.28, 180.0, -886023758 },
    { 933.51,47.9,72.28, 181.21, 469792763 },

    { 931.17,46.59,72.28,223.97, -245247470 },
    { 929.47,44.06,72.28,251.92, 691061163 },

    { 949.62,32.95,71.84,63.22, 1535236204 },

    { 998.77,45.27,69.84,36.84, -886023758 },
    { 958.85,50.18,71.44,121.98, 469792763 },
    -- 
    { 933.6,41.57,81.09,63.18, -254493138 },

} -- 999748158

--#############################
--         Lucky Wheel
--#############################

-- A roleta pode ser rodada em 2 formas:

-- 1° Um valor definido para cada rodada

Config.roleta = 7000    -- Valor para rodar a roleta //\\ É usado o Config.money como item

-- 2° Um item exclusivo apenas para rodar a roleta
-- Se não for utilizar, deixar vazio -> ""
Config.item = ""

-- Prêmios da roleta:

-- "_priceIndex" --> Define em qual premio irá parar.

function premio(user_id)
    local _money = 0
    local _randomPrice = math.random(1, 100)
    if _randomPrice <= 50 then
        local _subRan = math.random(1,10)
        if _subRan <= 5 then
            _priceIndex = 9
        else
            _priceIndex = 100
        end
    elseif _randomPrice > 50 and _randomPrice <= 75 then
        _priceIndex = 2
    elseif _randomPrice > 75 and _randomPrice <= 85 then
        _priceIndex = 6
    elseif _randomPrice > 85 and _randomPrice <= 90 then
        _priceIndex = 16
    elseif _randomPrice > 90 and _randomPrice <= 100 then
        local _subRan = math.random(1,10)
        if _subRan <= 3 then
            _priceIndex = 30
        else
            _priceIndex = 14
        end
    end
    SetTimeout(6000, function()
        isRoll = false
        if _priceIndex == 2 then	
            _money = 10000
        elseif _priceIndex == 6 then
            _money = 20000
        elseif _priceIndex == 9 then
            _money = 2500
        elseif _priceIndex == 14 then
            local _subRan = 4
            if _subRan <= 5 then
                _money = 20000
            elseif _subRan == 6 then
                _money = 30000
            elseif _subRan == 7 then
                _money = 40000
            elseif _subRan >= 8 then
                _money = 50000
            end
        elseif _priceIndex == 16 then
            _money = 25000
        elseif _priceIndex == 30 then
            --_money = 75000	-- Mystery
			exports['will_garages_v2']:addVehicle(user_id, "zentorno")
        elseif _priceIndex == 100 then
            _money = 5000
        end
		vRP.giveInventoryItem(user_id,Config.money,_money)
        TriggerClientEvent("luckywheel:rollFinished", -1)
    end)
    TriggerClientEvent("luckywheel:doRoll", -1, _priceIndex)
end

--#############################
--           Roleta
--#############################

Config.TranslationSelected = 'br'

-- Segundos para iniciar a roleta após sentar na mesa
Config.RouletteStart = 30 

-- Mexer apenas no minBet(minimo para apostar) e maxBet(maximo para apostar)
Config.RulettTables = { 
    [1] = {
        position = vector3(1003.94,57.09,69.44 - 1.0),
        rot = 11.13,
        minBet = 100,
        maxBet = 500
    },
    [2] = { 
        position = vector3(999.53,56.04,69.44 - 1.0),
        rot = 106.28,
        minBet = 5,
        maxBet = 100
    },
    [3] = {
        position = vector3(984.5,52.28,70.24 - 1.0),
        rot = 100.15,
        minBet = 250,
        maxBet = 1000
    },
}

--#############################
--            Slots
--#############################

Config.OffWinner = false -- Adicionar 30% de chance para perder

Config.slotsWins = {
	doubled = false,  -- Ganhar com 2 simbolos iguais
	multiplicador = 5 -- Multiplicador caso ganhe com 2 simbolos
}

Config.Mult = { -- Multiplicadores: baseado no GTA:ONLINE
	['1'] = 2.5,	
	['2'] = 5,
	['3'] = 10,
	['4'] = 15,
	['5'] = 20,
	['6'] = 25,
	['7'] = 30,
}

-- As maquinas, suas posições e a quantidade que pode apostar:
-- Mude apenas o 'bet' para o que preferir em cada maquina.
-- (Lembrando que é o mesmo item utilizado no Config.money para apostar)

Config.Slots = { 
	[1] = { -- Diamonds
		pos = vector3(943.87,51.37,71.44),		
		bet = 2500,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[2] = {
		pos = vector3(948.92,49.42,71.44),
		bet = 2500,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[3] = {
		pos = vector3(957.11,51.76,71.44),
		bet = 2500,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},
	[4] = {
		pos = vector3(953.59,40.52,71.44),
		bet = 2500,
		prop = 'vw_prop_casino_slot_07a',
		prop1 = 'vw_prop_casino_slot_07a_reels',
		prop2 = 'vw_prop_casino_slot_07b_reels',
	},

	-- Fortune And Glory

	[5] = { 
		pos = vector3(958.73,39.2,71.44),
		bet = 1000,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[6] = { 
		pos = vector3(955.88,40.7,71.44),
		bet = 1000,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[7] = { 
		pos = vector3(953.37,47.93,71.44),
		bet = 1000,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
	[8] = { 
		pos = vector3(951.2,49.55,71.44),
		bet = 1000,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},

    -- Have A Stab
	
	[9] = { 
		pos = vector3(943.28,50.81,71.44),
		bet = 500,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[10] = {
		pos = vector3(949.56,48.95,71.44),
		bet = 500,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[11] = {
		pos = vector3(955.13,50.91,71.44),
		bet = 500,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	[12] = {
		pos = vector3(954.23,40.15,71.44),
		bet = 500,
		prop = 'vw_prop_casino_slot_06a',
		prop1 = 'vw_prop_casino_slot_06a_reels',
		prop2 = 'vw_prop_casino_slot_06b_reels',
	},
	
	-- Shoot First

	[16] = { 
		pos = vector3(944.37,47.13,71.44),
		bet = 200,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[17] = {
		pos = vector3(953.23,51.9,71.44),
		bet = 200,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[18] = {
		pos = vector3(954.2,45.37,71.44),
		bet = 200,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	[19] = {
		pos = vector3(957.53,41.46,71.44),
		bet = 200,
		prop = 'vw_prop_casino_slot_03a',
		prop1 = 'vw_prop_casino_slot_03a_reels',
		prop2 = 'vw_prop_casino_slot_03b_reels',
	},
	
    -- Fame or Shame

	[20] = { 
		pos = vector3(957.64,41.28,71.44),
		bet = 100,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[21] = {
		pos = vector3(955.88,42.49,71.44),
		bet = 100,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[22] = {
		pos = vector3(953.45,46.16,71.44),
		bet = 100,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[23] = {
		pos = vector3(953.24,51.52,71.44),
		bet = 100,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[24] = {
		pos = vector3(951.39,51.58,71.44),
		bet = 100,
		prop = 'vw_prop_casino_slot_04a',
		prop1 = 'vw_prop_casino_slot_04a_reels',
		prop2 = 'vw_prop_casino_slot_04b_reels',
	},
	[25] = {
		pos = vector3(942.79,50.55,71.44),
		bet = 1000,
		prop = 'vw_prop_casino_slot_05a',
		prop1 = 'vw_prop_casino_slot_05a_reels',
		prop2 = 'vw_prop_casino_slot_05b_reels',
	},
}

function winSlots(bet, a, b, c)
	local total = 0
	if a == b and b == c and a == c then
		if Config.Mult[a] then
			total = bet * Config.Mult[a]
		end		
	elseif Config.slotsWins['doubled'] then
		if a == '6' and b == '6' then
			total = bet*Config.slotsWins['multiplicador']
		elseif a == '6' and c == '6' then
			total = bet*Config.slotsWins['multiplicador']
		elseif b == '6' and c == '6' then
			total = bet*Config.slotsWins['multiplicador']
		end
	end
	return total
end


--#############################
--            Poker
--#############################

-- SETUPS

Config.TimeLeftAfter = 15 -- Tempo para o jogador apostar
Config.PlayerDecideTime = 15 -- Tempo para o jogador decidir
Config.ShowCardsAfterReveal = true -- Mudar a camera do jogador quando revelar as cartas

-- Mudar apenas o MinimumBet e MaximumBet, minimo e maximo para apostar.
Config.Pokers = {
    [1] = {
        Position = vector3(985.04, 66.63, 69.23),
        Heading = 8.0,
        MaximumBet = 150000,
        MinimumBet = 50
    },
    [2] = {
        Position = vector3(994.90, 58.21, 68.43),
        Heading = 243.0,
        MaximumBet = 150000,
        MinimumBet = 50
    },
    [3] = {
        Position = vector3(998.43, 61.03, 68.43),
        Heading = 193.0,
        MaximumBet = 50000,
        MinimumBet = 50
    },
    [4] = {
        Position = vector3(996.34, 51.73, 68.43),
        Heading = 323.0,
        MaximumBet = 50000,
        MinimumBet = 50
    },
    [5] = {
        Position = vector3(1000.78, 51.03, 68.43),
        Heading = 13.0,
        MaximumBet = 50000,
        MinimumBet = 50
    },
    [6] = {
        Position = vector3(988.46, 64.28, 69.23),
        Heading = 283.0,
        MaximumBet = 50000,
        MinimumBet = 50
    },
    [7] = {
        Position = vector3(993.23, 43.61, 69.23),
        Heading = 283.0,
        MaximumBet = 50000,
        MinimumBet = 50
    },
    [8] = {
        Position = vector3(991.46, 40.09, 69.23),
        Heading = 203.0,
        MaximumBet = 50000,
        MinimumBet = 50
    },
}

--#############################
--         Blackjack
--#############################
Config.blackJackTables = {
    [0] = {
        dealerPos = vector3(1001.88,59.86,69.44),
        dealerHeading = 321.34,
        tablePos = vector3(1002.38, 60.50, 68.43),
        tableHeading = 143.30,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01"
    },
    [1] = { --    1003.49,53.62,69.44,
        dealerPos = vector3(1003.49,53.62,69.44),
        dealerHeading = 237.76,
        tablePos = vector3(1004.18, 53.19, 68.43),
        tableHeading = 58.30,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01"
    },
    [2] = { -- 986.04,59.76,70.24,3.69
        dealerPos = vector3(986.04,59.76,70.24),
        dealerHeading = 3.69,
        tablePos = vector3(985.90, 60.55, 69.23),
        tableHeading = 188.31,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01"
    },
    [3] = {
        dealerPos = vector3(986.48,42.06,70.24),
        dealerHeading = 278.74,
        tablePos = vector3(987.26, 42.20, 69.23),
        tableHeading = 103.30,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01"
    }, -- 
    [4] = {
        dealerPos = vector3(988.7,46.48,70.24),
        dealerHeading = 203.31,
        tablePos = vector3(989.03, 45.72, 69.23),
        tableHeading = 23.30,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01"
    },
    [5] = {
        dealerPos = vector3(981.61,62.68,70.24),
        dealerHeading = 281.72,
        tablePos = vector3(982.48, 62.90, 69.23),
        tableHeading = 103.30,
        distance = 1000.0,
        prop = "vw_prop_casino_blckjack_01"
    },
} 

Config.blackjack = {
    ['MinimumBet'] = 10,
    ['MaximumBet'] = 10000
}

--#############################
--         InsideTrack
--#############################

Config.InsideTrack = {
	['minBet'] = 100,
	['maxBet'] = 10000,
	['multiplier'] = 2
}
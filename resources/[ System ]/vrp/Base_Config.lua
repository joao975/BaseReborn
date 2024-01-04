local Proxy = module("lib/Proxy")
local Tunnel = module("lib/Tunnel")
Reborn = {}
Proxy.addInterface("Reborn",Reborn)
Tunnel.bindInterface("Reborn",Reborn)

----####----####----####----##
----##        LICENÇA      -##
----####----####----####----##

Reborn.license = function()
    return {
        ['ip'] = "http://localhost/",
        ['porta'] = "30120",
        ['license'] = "Sua licença (Token) aqui!"
    }
end

----####----####----####----##
----##    IMG DIRETORIO    -##
----####----####----####----##

Reborn.images = function()
    return "http://localhost/imagens"
end

----####----####----####----##
----##   MULTI-PERSONAGEM  -##
----####----####----####----##

Reborn.multi_personagem = function()
    return {
        ['Enabled'] = true,
        ['Max_personagens'] = 1         -- Quantidade de personagens que todos conseguerem criar
    }                                   -- Para aumentar de player especifico: Banco de dados > vrp_infos > chars
end

----####----####----####----##
--  ##   PRIMEIRO LOGIN     ##
----####----####----####----##

Reborn.first_login = function()
    return {
        ['Mensagem'] = "Seja bem-vindo a <b>Base Reborn</b>. A cidade foi desenvolvida pensando especialmente em você, faça sua historia.",
        -- Itens inicias
        ['Itens'] = {
            ['celular'] = 1,
            ['identity'] = 1,
            ['water'] = 3,
            ['sandwich'] = 3,
            ['dollars'] = 10000,
        },
        ['Spawn'] = { x = -1036.84, y = -2734.79, z = 13.76 },
        ['Groups'] = {
            --[id] = { 'grupos' }
            [1] = { "Owner", "Admin" },
            [2] = { "Owner", "Admin" },
        },
        -- Roupa inicial
        ['Clothes'] = {
            ['Male'] = {
                ["pants"] = { item = 17, texture = 4 },
                ["arms"] = { item = 0, texture = 0 },
                ["tshirt"] = { item = 15, texture = 0 },
                ["torso"] = { item = 44, texture = 2 },
                ["vest"] = { item = 0, texture = 0 },
                ["shoes"] = { item = 5, texture = 1 },
                ["mask"] = { item = 0, texture = 0 },
                ["backpack"] = { item = 0, texture = 0 },
                ["hat"] = { item = -1, texture = 0 },
                ["glass"] = { item = 0, texture = 0 },
                ["ear"] = { item = -1, texture = 0 },
                ["watch"] = { item = -1, texture = 0 },
                ["bracelet"] = { item = -1, texture = 0 },
                ["accessory"] = { item = 0, texture = 0 },
                ["decals"] = { item = 0, texture = 0 }
            },
            ['Female'] = {
                ["pants"] = { item = 37, texture = 0 },
                ["arms"] = { item = 2, texture = 0 },
                ["tshirt"] = { item = 14, texture = 0 },
                ["torso"] = { item = 30, texture = 0 },
                ["vest"] = { item = 0, texture = 0 },
                ["shoes"] = { item = 13, texture = 0 },
                ["mask"] = { item = 0, texture = 0 },
                ["backpack"] = { item = 0, texture = 0 },
                ["hat"] = { item = -1, texture = 0 },
                ["glass"] = { item = 0, texture = 0 },
                ["ear"] = { item = -1, texture = 0 },
                ["watch"] = { item = -1, texture = 0 },
                ["bracelet"] = { item = -1, texture = 0 },
                ["accessory"] = { item = 0, texture = 0 },
                ["decals"] = { item = 0, texture = 0 }
            }
        }
    }
end

----####----####----####----##
--  ##      FOME E SEDE     ##
----####----####----####----##

Reborn.needs = function()
    return {
        ['Tempo'] = 90,         -- Segundos
        ['Fome'] = 1,           -- Total de 100
        ['Sede'] = 1,           -- Total de 100
    }
end

--####----####----####----
--##   NPC CONTROL   ##--
--####----####----####----

Reborn.npcControl = function()
    return {
        ['PedDensity'] = 0.5,           -- Quantidade de npc na rua (0.0 a 0.99)
        ['VehicleDensity'] = 0.4,       -- Quantidade de veiculos de npc na rua (0.0 a 0.99)
        ['ParkedVehicle'] = 0.4,        -- Quantidade de veiculos estacionados (0.0 a 0.99)
    }
end
-- Caso deseja tirar os npc, deixa tudo 0.0

----####----####----####----##
----## ESTATISTICAS SERVER -##
----####----####----####----##

Reborn.statistics = function()
    return {
        ['Comando'] = "exit",
        ['Webhook'] = ""
    }
end

--####----####--
--##  WIPE  ##--
--####----####--

Reborn.segurity_code = function()
    return {
        code = "Reborn",                    -- Codigo de segurança
        start_id = 1,                       -- Inicio dos Ids
        start_bank = 25000,                 -- Dinheiro inicial no banco
        db_tables = {
            'vrp_infos',
            'vrp_invoice',
            'vrp_permissions',
            'vrp_srv_data',
            'vrp_users',
            'vrp_user_data',
            'vrp_user_ids',
            'smartbank_accounts',
            'smartbank_cards',
            'smartbank_fines',
            'smartbank_statements',
            'vrp_user_data',
            'vrp_user_ids',
            'vrp_vehicles',
            'vrp_weapons',
            'will_battlepass',
            'will_sprays',
            'will_ficha',
            'will_homes',
            'will_rent',
            'will_conce',
            'will_shops',
            'will_shops_jobs',
            'will_shops_stock',
            'user_bans',

            'smartphone_uber_trips',
            'smartphone_ifood_orders',
            'smartphone_contacts',
            'smartphone_settings',
            'smartphone_calls',
            'smartphone_olx',
            'smartphone_blocks',
            'smartphone_instagram',
            'smartphone_instagram_posts',
            'smartphone_instagram_likes',
            'smartphone_instagram_followers',
            'smartphone_instagram_notifications',
            'smartphone_twitter_profiles',
            'smartphone_twitter_tweets',
            'smartphone_twitter_likes',
            'smartphone_twitter_followers',
            'smartphone_paypal_transactions',
            'smartphone_tor_messages',
            'smartphone_tor_payments',
            'smartphone_whatsapp',
            'smartphone_whatsapp_channels',
            'smartphone_whatsapp_messages',
            'smartphone_whatsapp_groups',
            'smartphone_casino',
            'smartphone_calls',
            'smartphone_bank_invoices',
        }
    }
end

----####----####----####----##
----## MENSAGENS DE INICIO -##
----####----####----####----##

Reborn.Language = function()
    return {
        joining = "Entrando...",
        connecting = "Conectando...",
        err = "Não foi possível identificar sua Steam ou Social Club.",
        _err = "Você foi desconectado por demorar demais na fila.",
        pos = "Você é o %d/%d da fila, aguarde sua conexão",
        connectingerr = "Não foi possível adiciona-lo na fila.",
        steam = "Você precisa estar com a Steam aberta para conectar.",
        whitelist = "Você não é está aprovado, entre em nosso Discord para mais informações: https://discord.gg/8unYr9MUdx"
    }
end

--####----####----####----
--##  SIMILAR TABLES  ##--
--####----####----####----

Reborn.dbSimilarTables = function()
    return {
        { ['Old'] = "vrp_user_vehicles", ['New'] = "vrp_vehicles" },
        { ['Old'] = "summerz_propertys", ['New'] = "vrp_homes" },
        { ['Old'] = "summerz_vehicles", ['New'] = "vrp_vehicles",
            ['Columns'] = {
                ['tax'] = 'time',
            }
        },
        { ['Old'] = "summerz_fidentity", ['New'] = "vrp_users" },
        { ['Old'] = "summerz_entitydata", ['New'] = "vrp_srv_data" },
        { ['Old'] = "summerz_playerdata", ['New'] = "vrp_user_data" },
        { ['Old'] = "summerz_accounts", ['New'] = "vrp_infos" },
        { ['Old'] = "summerz_characters", ['New'] = "vrp_users" },
    }
end

--# REBORN SHOP #--
--# REBORN SHOP #--
--# REBORN SHOP #--

fx_version 'adamant'

game 'gta5'

author 'Will IV#8996'

description 'Cassino Jogos'

version '2.1.0'

ui_page 'DiamondRoleta/html/index.html'

client_scripts {
	"@vrp/lib/utils.lua",
    "Config.lua",
    -- DiamondLuckyWheel
	'DiamondLuckyWheel/client/client.lua',
    -- DiamondPeds
    'DiamondPeds/client.lua',
    -- DiamondRoleta
    'DiamondRoleta/client/cl_main.lua',
    -- DiamondSlots
	'DiamondSlots/client.lua',
    -- DiamondBlackjack
	"DiamondBlackjack/cl_blackjack.lua",
	-- 'DiamondInsideTrack
	'DiamondInsideTrack/client/utils.lua',
    'DiamondInsideTrack/client/presets.lua',
    'DiamondInsideTrack/client/client.lua',
    'DiamondInsideTrack/client/bigScreen.lua',
    'DiamondInsideTrack/client/anim.lua',
    'DiamondInsideTrack/client/screens/*.lua',
	-- DiamondPoker
    'DiamondPoker/translations.lua',
    'DiamondPoker/main.lua',
    'DiamondPoker/client/cl_main.lua',
}

server_scripts {
	"@vrp/lib/utils.lua",
    "Config.lua",
	"server_utils.lua",
     -- DiamondLuckyWheel
	'DiamondLuckyWheel/server/server.lua',
     -- DiamondPeds
    'DiamondPeds/server.lua',
    -- DiamondSlots
	'DiamondSlots/server.lua',
    -- DiamondBlackjack
    "DiamondBlackjack/sv_blackjack.lua",
    -- DiamondRoleta
    'DiamondRoleta/server/sv_main.lua',
	-- DiamondPoker
    'DiamondPoker/translations.lua',
    'DiamondPoker/main.lua',
    'DiamondPoker/server/sv_main.lua',
	-- 'DiamondInsideTrack
	'DiamondInsideTrack/server/server.lua',

}

files {
    -- DiamondRoleta
    'DiamondRoleta/html/index.html',
    'DiamondRoleta/html/js/*.js',
    'DiamondRoleta/html/DEP/*.js',
    'DiamondRoleta/html/img/**',
    'DiamondRoleta/html/ProximaNova.woff',
}

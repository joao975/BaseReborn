--[[# REBORN SHOP #]]--
--[[# REBORN SHOP #]]--
--[[# REBORN SHOP #]]--

fx_version 'bodacious'
game 'gta5'

author 'Will IV#8996'
description 'Cassino Jogos'

version '2.7.2'

ui_page 'web-side/index.html'

client_scripts {
	"@vrp/lib/utils.lua",
    "Config/Config.lua",
    "Config/main_poker.lua",
	'client/*',
}

server_scripts {
	"@vrp/lib/utils.lua",
    "Config/Config.lua",
    "Config/main_poker.lua",
	"Config/server_utils.lua",
	'server/*',
}

files {
    -- Blackjack
    "streams/peds.meta",
    -- Roleta
    'web-side/index.html',
    'web-side/ProximaNova.woff',
    'web-side/js/*.js',
    'web-side/js/sounds/*.ogg',
    'web-side/js/sounds/*.mp3',
    'web-side/styles/*.css',
    'web-side/img/*',
}
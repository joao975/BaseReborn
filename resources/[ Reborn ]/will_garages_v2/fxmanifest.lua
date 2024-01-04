--## REBORN SHOP ##--
--## REBORN SHOP ##--
--## REBORN SHOP ##--

fx_version 'bodacious'
game 'gta5'

author 'Will IV#8996'

ui_page {
	'html/index.html',
}

files {
	'html/*.css',
	'html/*.js',
	'html/*.html',
	'html/images/*.png',
	'html/images/*.svg',
}

shared_script{
	'Garages.lua',
	'Vehicles.lua',
}

client_scripts {
	"@vrp/lib/utils.lua",
	'Config.lua',
	'client/main.lua',
	'client/client_config.lua',
}

server_scripts {
	"@vrp/lib/utils.lua",
	'Config.lua',
	'server/*.lua',
}

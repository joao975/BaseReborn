--## REBORN SHOP ##--
--## REBORN SHOP ##--
--## REBORN SHOP ##--

fx_version "bodacious"
game "gta5"

author "Will IV#8996"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"Config.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"Config.lua",
	"server-side/server.lua",
	"server-side/functions.lua"
}

files {
	'web-side/*.*',
	'web-side/**/*.*',
}

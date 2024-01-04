fx_version "bodacious"
game "gta5"

ui_page "web-side/index.html"

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	"lib/utils.lua",
	"Base_Config.lua",
	"Esx-Qbcore.lua",
	"base.lua",
	"lib/server.lua",
	"queue.lua",
	"Reborn/*",
	"server-side/*",
}

client_scripts {
	"lib/utils.lua",
	"Base_Config.lua",
	"Esx-Qbcore.lua",
	"Reborn/*",
	"client-side/*",
}

files {
	"web-side/*",
	"web-side/**/*",
	"lib/Tunnel.lua",
	"lib/Proxy.lua",
	"lib/utils.lua",
	"lib/vehicles.lua",
	"lib/Tools.lua",
	"lib/Hofs.lua",
}

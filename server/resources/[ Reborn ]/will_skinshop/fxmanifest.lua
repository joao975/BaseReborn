fx_version "bodacious"
game "gta5"

author "Reborn Studios"

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"Config.lua",
	"client-side/*"
	
}

server_scripts {
	"@vrp/lib/utils.lua",
	"Config.lua",
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/assets/*"
}
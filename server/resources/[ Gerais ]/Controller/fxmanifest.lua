fx_version "bodacious"
game "gta5"

ui_page "Tencode/web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"**/client.lua",
}

server_scripts {
	"@vrp/lib/utils.lua",
	"Doors/config.lua",
	"**/server.lua",
}

files {
	"Tencode/web-side/*",
	"Tencode/web-side/**/*"
}

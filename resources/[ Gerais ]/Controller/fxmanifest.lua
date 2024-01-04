fx_version "bodacious"
game "gta5"

ui_page "Tencode/web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"Admin/client.lua",
	"Hospital/client.lua",
	"Player/client.lua",
	"Survival/client.lua",
	"Tencode/client.lua",
	"Wall/client.lua",
	"Weather/client.lua",
	"Doors/client.lua",
}

server_scripts {
	"@vrp/lib/utils.lua",
	"Admin/server.lua",
	"Hospital/server.lua",
	"Player/server.lua",
	"Survival/server.lua",
	"Tencode/server.lua",
	"Wall/server.lua",
	"Weather/server.lua",
	"Doors/server.lua",
}

files {
	"Tencode/web-side/*",
	"Tencode/web-side/**/*"
}              
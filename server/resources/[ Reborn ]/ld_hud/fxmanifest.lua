fx_version "bodacious"

game 'gta5'
author 'Lucca.#1294'
description 'https://discord.gg/4YDS7mW6UE'
version '1.0'

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/utils.lua",
	"client-side/*",
	"config.lua",
	"emojis.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"server-side/*",
	"config.lua"
}

files {
	"web-side/*",
	"web-side/**/*",
	"web-side/**/**/*",
	"web-side/**/**/**/*"
}

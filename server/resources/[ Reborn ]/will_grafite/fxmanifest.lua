fx_version 'bodacious'
game 'gta5'

author 'Will IV#8996'

ui_page 'web-side/index.html'

client_scripts {
	"@vrp/lib/utils.lua",
	'Config.lua',
	'client-side/anim.lua',
	'client-side/client.lua',
	'client-side/control.lua',
}

server_scripts {
	"@vrp/lib/utils.lua",
	'Config.lua',
	'server-side/*.lua'
}

files {
	"web-side/**/*.*",
}
fx_version 'cerulean'
lua54 'on'
game 'gta5'
ui_page 'html/index.html'

server_scripts {
	"@vrp/lib/utils.lua",
	'colors.lua',
	'config.lua',
	'server/*'
}

client_scripts {
	"@vrp/lib/utils.lua",
	'colors.lua',
	'config.lua',
	'client/client.lua',
	'client/client_config.lua',
}

files {
	'html/design.css',
	'html/index.html',
	'html/*.js',
	'html/fonts/*',	
	'html/img/*.svg',
	'html/audio/*.ogg',
	"data/carcols_gen9.meta",
    "data/carmodcols_gen9.meta",
    "data/carmodcols.ymt",
}

data_file "CARCOLS_GEN9_FILE" "data/carcols_gen9.meta"
data_file "CARMODCOLS_GEN9_FILE" "data/carmodcols_gen9.meta"
data_file "FIVEM_LOVES_YOU_447B37BE29496FA0" "data/carmodcols.ymt"
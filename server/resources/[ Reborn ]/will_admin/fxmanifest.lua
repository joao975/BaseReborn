--## REBORN SHOP ##--
--## REBORN SHOP ##--
--## REBORN SHOP ##--

fx_version 'bodacious'
game 'gta5'

ui_page "nui/index.html"

client_scripts {
    "@vrp/lib/utils.lua",
    'Config.lua',
    'client/*.lua',
}

server_scripts {
    "@vrp/lib/utils.lua",
    'Config.lua',
    'server/*.lua',
}

files {
    "nui/index.html",
    "nui/js/*.js",
    "nui/css/*.css",
    "nui/webfonts/*.css",
    "nui/webfonts/*.otf",
    "nui/webfonts/*.ttf",
    "nui/webfonts/*.woff2",
}

lua54 'yes'
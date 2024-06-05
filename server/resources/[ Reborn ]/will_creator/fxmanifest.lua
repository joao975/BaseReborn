fx_version 'bodacious'
game 'gta5'

version '1.0.0'
ui_page 'html/index.html'

server_scripts {
    "@vrp/lib/utils.lua",
    'config.lua',
    'server/*.lua'
}

client_scripts {
    "@vrp/lib/utils.lua",
    'config.lua',
    'client/*.lua'
}

files {
    'html/index.html',
    'html/style.css',
    'html/js/*.js',
    -- 'html/img/dads/*.png',
    -- 'html/img/moms/*.png',
    'html/assets/*',
    'html/assets/**/*',
}

lua54 'yes'

dependency '/assetpacks'

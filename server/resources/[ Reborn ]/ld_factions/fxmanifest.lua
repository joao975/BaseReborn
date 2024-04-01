fx_version 'bodacious'
game 'gta5'
lua54 ''

author 'Lucca. (luccathereal)'
description 'https://discord.gg/4YDS7mW6UE'
version '1.0.1'

ui_page 'web/index.html'

shared_scripts {
    '@vrp/lib/utils.lua',
    'web/orgs/lib/*.lua',
    'config/config.lua'
}

client_scripts {'@vrp/lib/utils.lua', 'config/client_main.lua', 'client.lua'}
server_scripts {'@vrp/lib/utils.lua', 'config/server_main.lua', 'server.lua'}

files {
    'web/*',
    'web/**/nui/*',
    'web/**/nui/**/*',
    'web/**/nui/**/**/*',
    'web/**/nui/**/**/**/*',
}

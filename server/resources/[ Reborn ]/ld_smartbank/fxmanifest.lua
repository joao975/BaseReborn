fx_version 'adamant'
game 'gta5'

author 'Lucca'
description 'https://discord.gg/4YDS7mW6UE'
version '1.0'

client_scripts {
	'@vrp/lib/utils.lua',
    'locales/*.lua',
    'client/client_config.lua',
    'client/client.lua'
}

server_scripts {
	'@vrp/lib/utils.lua',
    'locales/*.lua',
    '@mysql-async/lib/MySQL.lua',
    'server/server_config.lua',
    'server/server.lua',
}

server_exports {
    'CreateFine',
    'RegisterNewEntry',
	'ChangePix',
}

ui_page 'nui/index.html'
files{
    'nui/img/kredit.ttf',
    'nui/index.html',
    'nui/css/style.css',
    'nui/img/banking.png',
    'nui/js/script.js',
    'nui/js/demo/chart-area-demo.js',
    'nui/vendor/bootstrap/js/bootstrap.bundle.min.js',
    'nui/vendor/chart.js/Chart.js',
    'nui/vendor/datatables/dataTables.bootstrap4.js',
    'nui/vendor/datatables/jquery.dataTables.js',
    'nui/vendor/jquery/jquery.min.js',
    'nui/vendor/jquery-easing/jquery.easing.min.js',
    'nui/vendor/js/src/tools/sanitizer.js',
    'nui/vendor/js/src/*.js',
	'nui/vendor/node_modules/popper.js/dist/esm/popper.js',
}
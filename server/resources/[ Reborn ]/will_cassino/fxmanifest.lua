--# REBORN SHOP #--
--# REBORN SHOP #--
--# REBORN SHOP #--

fx_version 'adamant'

game 'gta5'

author 'Will IV#8996'

description 'Cassino Jogos'

version '2.1.0'

ui_page 'DiamondRoleta/html/index.html'

client_scripts {
	"@vrp/lib/utils.lua",
    "Config.lua",
    -- DiamondLuckyWheel
	'DiamondLuckyWheel/client/client.lua',
    -- DiamondPeds
    'DiamondPeds/client.lua',
    -- DiamondRoleta
    'DiamondRoleta/client/cl_main.lua',
    -- DiamondSlots
	'DiamondSlots/client.lua',
    -- DiamondBlackjack
    "DiamondBlackjack/src/RMenu.lua",
	"DiamondBlackjack/src/menu/RageUI.lua",
	"DiamondBlackjack/src/menu/Menu.lua",
	"DiamondBlackjack/src/menu/MenuController.lua",
	"DiamondBlackjack/src/components/*.lua",
	"DiamondBlackjack/src/menu/elements/*.lua",
	"DiamondBlackjack/src/menu/items/*.lua",
	"DiamondBlackjack/src/menu/panels/*.lua",
	"DiamondBlackjack/src/menu/panels/*.lua",
	"DiamondBlackjack/src/menu/windows/*.lua",
	"DiamondBlackjack/cl_blackjack.lua",
	-- 'DiamondInsideTrack
	'DiamondInsideTrack/client/utils.lua',
    'DiamondInsideTrack/client/presets.lua',
    'DiamondInsideTrack/client/client.lua',
    'DiamondInsideTrack/client/bigScreen.lua',
    'DiamondInsideTrack/client/anim.lua',
    'DiamondInsideTrack/client/screens/*.lua',
	-- DiamondPoker
    'DiamondPoker/src/RMenu.lua',
    'DiamondPoker/src/menu/RageUI.lua',
    'DiamondPoker/src/menu/Menu.lua',
    'DiamondPoker/src/menu/MenuController.lua',
    'DiamondPoker/src/components/*.lua',
    'DiamondPoker/src/menu/elements/*.lua',
    'DiamondPoker/src/menu/items/*.lua',
    'DiamondPoker/src/menu/panels/*.lua',
    'DiamondPoker/src/menu/panels/*.lua',
    'DiamondPoker/src/menu/windows/*.lua',
    'DiamondPoker/shared/shared_utils.lua',
    'DiamondPoker/translations.lua',
    'DiamondPoker/main.lua',
    'DiamondPoker/client/cl_main.lua',
}

server_scripts {
	"@vrp/lib/utils.lua",
    "Config.lua",
	"server_utils.lua",
     -- DiamondLuckyWheel
	'DiamondLuckyWheel/server/server.lua',
     -- DiamondPeds
    'DiamondPeds/server.lua',
    -- DiamondSlots
	'DiamondSlots/server.lua',
    -- DiamondBlackjack
    "DiamondBlackjack/sv_blackjack.lua",
    -- DiamondRoleta
    'DiamondRoleta/server/sv_main.lua',
	-- DiamondPoker
    'DiamondPoker/shared/shared_utils.lua',
    'DiamondPoker/translations.lua',
    'DiamondPoker/main.lua',
    'DiamondPoker/server/sv_main.lua',
	-- 'DiamondInsideTrack
	'DiamondInsideTrack/server/server.lua',

}

files {
    -- DiamondBlackjack
    "DiamondBlackjack/peds.meta",
	'DiamondBlackjack/audio/dlcvinewood_amp.dat10',
	'DiamondBlackjack/audio/dlcvinewood_amp.dat10.nametable',
	'DiamondBlackjack/audio/dlcvinewood_amp.dat10.rel',
	'DiamondBlackjack/audio/dlcvinewood_game.dat151',
	'DiamondBlackjack/audio/dlcvinewood_game.dat151.nametable',
	'DiamondBlackjack/audio/dlcvinewood_game.dat151.rel',
	'DiamondBlackjack/audio/dlcvinewood_mix.dat15',
	'DiamondBlackjack/audio/dlcvinewood_mix.dat15.nametable',
	'DiamondBlackjack/audio/dlcvinewood_mix.dat15.rel',
	'DiamondBlackjack/audio/dlcvinewood_sounds.dat54',
	'DiamondBlackjack/audio/dlcvinewood_sounds.dat54.nametable',
	'DiamondBlackjack/audio/dlcvinewood_sounds.dat54.rel',
	'DiamondBlackjack/audio/dlcvinewood_speech.dat4',
	'DiamondBlackjack/audio/dlcvinewood_speech.dat4.nametable',
	'DiamondBlackjack/audio/dlcvinewood_speech.dat4.rel',
    -- DiamondRoleta
    'DiamondRoleta/html/index.html',
    'DiamondRoleta/html/js/*.js',
    'DiamondRoleta/html/DEP/*.js',
    'DiamondRoleta/html/img/**',
    'DiamondRoleta/html/ProximaNova.woff',
    -- DiamondLuckyWheel
	'DiamondLuckyWheel/audio/dlcvinewood_amp.dat10',
	'DiamondLuckyWheel/audio/dlcvinewood_amp.dat10.nametable',
	'DiamondLuckyWheel/audio/dlcvinewood_amp.dat10.rel',
	'DiamondLuckyWheel/audio/dlcvinewood_game.dat151',
	'DiamondLuckyWheel/audio/dlcvinewood_game.dat151.nametable',
	'DiamondLuckyWheel/audio/dlcvinewood_game.dat151.rel',
	'DiamondLuckyWheel/audio/dlcvinewood_mix.dat15',
	'DiamondLuckyWheel/audio/dlcvinewood_mix.dat15.nametable',
	'DiamondLuckyWheel/audio/dlcvinewood_mix.dat15.rel',
	'DiamondLuckyWheel/audio/dlcvinewood_sounds.dat54',
	'DiamondLuckyWheel/audio/dlcvinewood_sounds.dat54.nametable',
	'DiamondLuckyWheel/audio/dlcvinewood_sounds.dat54.rel',
	'DiamondLuckyWheel/audio/dlcvinewood_speech.dat4',
	'DiamondLuckyWheel/audio/dlcvinewood_speech.dat4.nametable',
	'DiamondLuckyWheel/audio/dlcvinewood_speech.dat4.rel',
}
-- DiamondBlackjack
data_file "PED_METADATA_FILE" "DiamondBlackjack/peds.meta"
data_file 'AUDIO_GAMEDATA' 'DiamondBlackjack/audio/dlcvinewood_game.dat'
data_file 'AUDIO_SOUNDDATA' 'DiamondBlackjack/audio/dlcvinewood_sounds.dat'
data_file 'AUDIO_DYNAMIXDATA' 'DiamondBlackjack/audio/dlcvinewood_mix.dat'
data_file 'AUDIO_SYNTHDATA' 'DiamondBlackjack/audio/dlcVinewood_amp.dat'
data_file 'AUDIO_SPEECHDATA' 'DiamondBlackjack/audio/dlcvinewood_speech.dat'
-- DiamondLuckyWheel
data_file 'AUDIO_GAMEDATA' 'DiamondLuckyWheel/audio/dlcvinewood_game.dat'
data_file 'AUDIO_SOUNDDATA' 'DiamondLuckyWheel/audio/dlcvinewood_sounds.dat'
data_file 'AUDIO_DYNAMIXDATA' 'DiamondLuckyWheel/audio/dlcvinewood_mix.dat'
data_file 'AUDIO_SYNTHDATA' 'DiamondLuckyWheel/audio/dlcVinewood_amp.dat'
data_file 'AUDIO_SPEECHDATA' 'DiamondLuckyWheel/audio/dlcvinewood_speech.dat'
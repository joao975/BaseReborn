Config = {}

Config.logo = "./src/img/logo.png"
Config.userms = 1000
Config.usermscar = 400
Config.maxLife = 400
Config.showBullets = true

Config.events = {
	voiceTalking = "hud:talking",
	talkingMode = "pma-voice:setTalkingMode",
	radioChange = "hud:Radio",
	hunger = "statusHunger",
	thirst = "statusThirst",
}

Config.notifyIcons = {
	sucesso = "https://cdn-icons-png.flaticon.com/512/148/148767.png",
	negado = "https://cdn-icons-png.flaticon.com/512/527/527456.png",
	importante = "https://cdn-icons-png.flaticon.com/512/9068/9068121.png",
	aviso = "https://cdn-icons-png.flaticon.com/512/1409/1409819.png",
}

Config.chats = {
    ["Staff"] = {
        commandName = "cs",
        logsWebhook = "",
        prefixName = "[STAFF]",
        prefixColor = "#89f266",
        showAuthor = true,
        permEnviar = "suporte.permissao",
        permReceber = "suporte.permissao",
    },
	
	["Ilegal"] = {
        commandName = "ilegal",
        logsWebhook = "",
        prefixName = "<i class='fa-solid fa-masks-theater'></i> ILEGAL",
        prefixColor = "#696969",
        showAuthor = false,
		permIgnore = "policia.permissao"
    },
	
	["Admin"] = {
        commandName = "admin",
        logsWebhook = "",
        prefixName = "<img style='width: 17px' src='https://www.svgrepo.com/show/258457/speaker-audio.svg'> #PREFEITURA",
        prefixColor = "#e80e20",
		backgroundColor = "232, 63, 77",
        showAuthor = false,
		permEnviar = "admin.permissao",
    }
}

Config.clearCommandPermission = "Admin"
Proxy = module("vrp","lib/Proxy")
Tunnel = module("vrp","lib/Tunnel")
vRP = Proxy.getInterface("vRP")

Config = {}

Config.base = "creative"       -- vrpex / creative

Config.data = {
    [1] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "Recruta",
        paisanaGroup = "PaisanaRecruta",
        blip = true,
        webhook = "",
        Anim = "Tablet"  -- Tablet ou Anim
    },
    [2] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "Soldado",
        paisanaGroup = "PaisanaSoldado",
        webhook = "",
        blip = false,
        Anim = "Tablet"
    },
    [3] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "Cabo",
        paisanaGroup = "PaisanaCabo",
        webhook = "",
        blip = false,
        Anim = "Tablet"
    },
    [4] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "3Sargento",
        paisanaGroup = "Paisana3Sargento",
        webhook = "",
        blip = false,
        Anim = "Tablet"
    },
    [5] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "2Sargento",
        paisanaGroup = "Paisana2Sargento",
        webhook = "",
        blip = false,
        Anim = "Tablet"
    },
    [6] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "Sargento",
        paisanaGroup = "PaisanaSargento",
        webhook = "",
        blip = false,
        Anim = "Tablet"
    },
    [7] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "Sub.Tenente",
        paisanaGroup = "PaisanaSub.Tenente",
        webhook = "",
        blip = false,
        Anim = ""
    },
    [8] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "Tenente",
        paisanaGroup = "PaisanaTenente",
        webhook = "",
        blip = false,
        Anim = ""
    },
    [9] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "Major",
        paisanaGroup = "PaisanaMajor",
        webhook = "",
        blip = false,
        Anim = ""
    },
    [10] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "Capitao",
        paisanaGroup = "PaisanaCapitao",
        webhook = "",
        blip = false,
        Anim = ""
    },
    [11] = {
        loc = { -1071.08,-823.24,5.48 },
        group = "Coronel",
        paisanaGroup = "PaisanaCoronel",
        webhook = "",
        blip = false,
        Anim = ""
    },
    [12] = {
        loc = { 308.13,-602.28,43.29 },
        group = "Enfermeiro",
        paisanaGroup = "PaisanaEnfermeiro",
        webhook = "",
        blip = false,
        Anim = ""
    },
    [13] = {
        loc = { 308.13,-602.28,43.29 },
        group = "Medico",
        paisanaGroup = "PaisanaMedico",
        webhook = "",
        blip = false,
        Anim = ""
    },
    [14] = {
        loc = { 308.13,-602.28,43.29 },
        group = "Diretor",
        paisanaGroup = "PaisanaDiretor",
        webhook = "",
        blip = false,
        Anim = ""
    },
    [15] = {
        loc = { 835.9,-934.37,32.4 },
        group = "Mecanico",
        paisanaGroup = "PaisanaMecanico",
        webhook = "",
        blip = false,
        Anim = ""
    },
    [16] = {
        loc = { 835.9,-934.37,32.4 },
        group = "Mecanicolider",
        paisanaGroup = "PaisanaMecanicolider",
        webhook = "",
        blip = false,
        Anim = ""
    },
}

Config.func = {
    getUserId = function(source)
        return vRP.getUserId(source)
    end,

    hasGroup = function(user_id, group)
        return vRP.hasGroup(user_id, group)
    end,

    updateGroup = function(user_id, group, newGroup)
        vRP.removeUserGroup(user_id,group)
        vRP.addUserGroup(user_id, newGroup)
    end,

    enterService = function(source)
        if vRP.hasPermission(vRP.getUserId(source),"policia.permissao") then
            TriggerEvent("vrp_blipsystem:serviceEnter",source,"Policial",77)
            TriggerClientEvent("tencode:StatusService",source,true)
            TriggerClientEvent("vrp_tencode:StatusService",source,true)
        end
    end,

    exitService = function(source)
        TriggerEvent("vrp_blipsystem:serviceExit",source)
        TriggerClientEvent("tencode:StatusService",source,false)
        TriggerClientEvent("vrp_tencode:StatusService",source,false)
    end,

    removeObjects = function()
        if Config.base == "creative" or Config.base == "summerz" then	
            vRP.removeObjects()
        else
            vRP._DeletarObjeto()
        end
    end,
    
    createTablet = function()
        if Config.base == "creative" or Config.base == "summerz" then		
            vRP.createObjects("amb@code_human_in_bus_passenger_idles@female@tablet@base","base","prop_cs_tablet",50,28422)
        else
            vRP._CarregarObjeto("amb@code_human_in_bus_passenger_idles@female@tablet@idle_a","idle_b","prop_cs_tablet",49,28422)
        end
    end,

    sendDiscord = function(webhook,  color, name, title, text, text2)
        local logo = 'https://cdn.discordapp.com/attachments/796797155100327976/875550178264903730/unknown.png' -- Foto que ira aparecer ao lado da menssagem  
        local avatar = 'https://cdn.discordapp.com/attachments/796797155100327976/875550178264903730/unknown.png' -- Avatar do WebHook
        if title == nil or title == '' then
            return nil
        end
        local date = os.date("%H:%M:%S - %d/%m/%Y") -- Get system time
        local embeds = {
            { 
                ["title"] = title,
                ["type"] = name,
    
                ["thumbnail"] = {
                ["url"] = logo
                }, 
    
                ["fields"] = {
                    { 
                        ["name"] = text,
                        ["value"] = text2
                    }
                },
    
                ["footer"] = { 
                    ["text"] = "Will - "..date,
                    ["icon_url"] = logo
                },
    
                ["color"] =  color
    
            }
        }
        PerformHttpRequest(webhook, function(Error, Content, Hand) end, 'POST', json.encode({username = name, embeds = embeds, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
    end,
}

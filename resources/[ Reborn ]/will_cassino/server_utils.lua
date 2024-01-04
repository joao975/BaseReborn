-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP")

-----------------------------------
--########## Funções vRP ##########
-----------------------------------

function getUserId(source)
    return vRP.getUserId(source)
end

function tryGetInventoryItem(user_id, item, amount)
    return vRP.tryGetInventoryItem(user_id, item, amount)
end

function giveInventoryItem(user_id, item, amount)
    vRP.giveInventoryItem(user_id, item, amount)
end

function getInventoryItemAmount(user_id, item)
    return vRP.getInventoryItemAmount(user_id, item)
end

RegisterNetEvent("will_cassino:givePayment")
AddEventHandler("will_cassino:givePayment",function(user_id,amount)
    vRP.giveInventoryItem(user_id,Config.money,amount)
end)

function SendDiscord(color, name, title, text)
    if title == nil or title == '' then
        return nil
    end
    local date = os.date("%H:%M:%S - %d/%m/%Y")
    local logo = 'https://cdn.discordapp.com/attachments/796797155100327976/875550178264903730/unknown.png' -- Foto que ira aparecer ao lado da menssagem  
    local avatar = 'https://cdn.discordapp.com/attachments/796797155100327976/875550178264903730/unknown.png' -- Avatar do WebHook    
    local text2 = "Duvidas entre em contato pelo discord:\n@Will IV#8996"
    local webhooks = Config.webhookgames
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
    PerformHttpRequest(webhooks, function(Error, Content, Hand) end, 'POST', json.encode({username = name, embeds = embeds, avatar_url = avatar}), { ['Content-Type'] = 'application/json' })
end

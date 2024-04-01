-- /REVISTAR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('revistar',function(source,args,rawCommand)
    local source = source
    local nplayer = vRPclient.getNearestPlayer(source,2)
    requestRevist(source,nplayer)
end)

RegisterNetEvent("ld-inventory:revistar")
AddEventHandler("ld-inventory:revistar",function(nplayer)
    requestRevist(source,nplayer)
end)

function requestRevist(source,nplayer)
    local user_id = vRP.getUserId(source)
    local nuser_id = vRP.getUserId(nplayer)
    if nuser_id then
        if vRP.hasPermission(user_id, "policia.permissao") or vRP.request(nplayer,"Aceita ser revistado?", 15) then
            TriggerClientEvent(config.blockCommands,source,true)
            TriggerClientEvent(config.blockCommands,nplayer,true)
            
            if config.revistar.enableCarry then
                TriggerClientEvent('carregar',nplayer,source)
            end

            vRPclient._playAnim(nplayer,false,{{"random@mugging3","handsup_standing_base"}},true)
            TriggerClientEvent("progress",source,config.revistar.time*1000,"revistando")
            SetTimeout(config.revistar.time*1000,function()
                TriggerEvent('ld-inv:Server:OpenPlayerInventory',nuser_id,user_id)
            end)
            TriggerClientEvent("Notify",nplayer,"aviso","Você está sendo <b>Revistado</b>.")
        else
            TriggerClientEvent("Notify",source,"negado", "Negado", 5000)
        end
    end
end


local notifyEnabled = true
local Proxy = module("vrp","lib/Proxy")
Reborn = Proxy.getInterface("Reborn")
-----------------------------------------------------------------------------------------------------------------------------------------
-- NOTIFY
-----------------------------------------------------------------------------------------------------------------------------------------
local showHood = false

RegisterNetEvent("Notify")
AddEventHandler("Notify",function(css,mensagem,timer,position)
	if not notifyEnabled then return end
	if not timer or timer == "" then
		timer = 10000
	end
	if not showHud then
		updateDisplayHud()
		SendNUIMessage({ hud = true })
		SetTimeout(timer,function()
			SendNUIMessage({ hud = false })
		end)
	end

	if css == "aviso" or css == "amarelo" then
		SendNUIMessage({ action = true, css = "aviso", mensagem = mensagem, timer = timer, position = position, image = Config.notifyIcons["aviso"] })
    end

	if css == "negado" or css == "vermelho" then
		SendNUIMessage({ action = true, css = "negado", mensagem = mensagem, timer = timer, position = position, image = Config.notifyIcons["negado"] })
    end

	if css == "sucesso" or css == "verde" then
		SendNUIMessage({ action = true, css = "sucesso", mensagem = mensagem, timer = timer, position = position, image = Config.notifyIcons["sucesso"] })
    end

	if css == "importante" or css == "azul" then
		SendNUIMessage({ action = true, css = "importante", mensagem = mensagem, timer = timer, position = position, image = Config.notifyIcons["importante"] })
    end
end)

RegisterNetEvent("itensNotify")
AddEventHandler("itensNotify",function(status,index,amount,item)
	if index and amount and item then
		SendNUIMessage({ mode = status, mensagem = item, item = index, numero = amount, diretory = Reborn.images() })
	else
		SendNUIMessage({ mode = status[1], mensagem = status[4], item = status[2], numero = status[3], diretory = Reborn.images() })
	end
end)

RegisterNetEvent("progress")
AddEventHandler("progress",function(time)
	SendNUIMessage({ teste = true, time = tonumber(time-500) })
end)

RegisterNetEvent("Progress")
AddEventHandler("Progress",function(time)
	SendNUIMessage({ teste = true, time = tonumber(time-500) })
end)

RegisterNetEvent("vrp_hud:toggleHood")
AddEventHandler("vrp_hud:toggleHood",function()
	showHood = not showHood
	SendNUIMessage({ hood = showHood })

	if showHood then
		SetPedComponentVariation(PlayerPedId(),1,69,0,2)
	else
		SetPedComponentVariation(PlayerPedId(),1,0,0,2)
	end
end)


RegisterCommand('togglenotify',function(source,args,rawCommand)
	if notifyEnabled then	
		TriggerEvent("Notify","importante","Você desativou as notifys! Não receberá mais nenhuma.",5000)
		notifyEnabled = false
	else
		notifyEnabled = true
		TriggerEvent("Notify","sucesso","Você ativou as notifys! Agora você as verá novamente.",5000)
	end
end)

RegisterCommand('notifyteste',function(source,args,rawCommand)
	TriggerEvent("Notify","sucesso","Você ativou as notifys! Agora você as verá novamente.",5000)
	TriggerEvent("Notify","importante","Você desativou as notifys! Não receberá mais nenhuma.",5000)
	TriggerEvent("Notify","negado","Você ativou as notifys! Agora você as verá novamente.",5000)
	TriggerEvent("Notify","aviso","Você desativou as notifys! Não receberá mais nenhuma.",5000)
end)

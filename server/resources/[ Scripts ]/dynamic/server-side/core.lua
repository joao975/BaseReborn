-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRPC = Tunnel.getInterface("vRP")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("dynamic",Creative)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:EMERGENCYANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:EmergencyAnnounceMedic")
AddEventHandler("dynamic:EmergencyAnnounceMedic",function()
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		if vRP.hasPermission(Passport,"Paramedic") then
			TriggerClientEvent("dynamic:closeSystem",source)
			local message = vRP.prompt(source,"Mensagem:","")
			if message then
				TriggerClientEvent("Notify",-1,"aviso",'<b>'..message.."</b><br>ENVIADO POR : <b>Hospital</b>",15000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:EMERGENCYANNOUNCE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:EmergencyAnnounce")
AddEventHandler("dynamic:EmergencyAnnounce",function()
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		if vRP.hasPermission(Passport,"Police") then
			TriggerClientEvent("dynamic:closeSystem",source)
			local message = vRP.prompt(source,"Mensagem:","")
			if message then
				TriggerClientEvent("Notify",-1,"importante",'<b>'..message.."</b><br>ENVIADO POR : <b>Policia</b>",30000)
			end
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TENCODES
-----------------------------------------------------------------------------------------------------------------------------------------
local Tencodes = {
	[1] = {
		tag = "QTI",
		text = "Abordagem de trânsito",
		blip = 77
	},
	[2] = {
		tag = "QTH",
		text = "Localização",
		blip = 1
	},
	[3] = {
		tag = "QRR",
		text = "Apoio com prioridade",
		blip = 38
	},
	[4] = {
		tag = "QRT",
		text = "Oficial desmaiado/ferido",
		blip = 6
	}
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- DYNAMIC:TENCODE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent("dynamic:Tencode")
AddEventHandler("dynamic:Tencode",function(Code)
	local source = source
	local Passport = vRP.getUserId(source)
	if Passport then
		local Ped = GetPlayerPed(source)
		local Coords = GetEntityCoords(Ped)
		local Identity = vRP.getUserIdentity(Passport)
		local Service = vRP.numPermission("Police")
		for Passports,Sources in pairs(Service) do
			async(function()
				if Code ~= 4 then
					vRPC.playSound(Sources,"Event_Start_Text","GTAO_FM_Events_Soundset")
				end
				TriggerClientEvent("NotifyPush",Sources,{ code = Tencodes[parseInt(Code)]["tag"], title = Tencodes[parseInt(Code)]["text"], x = Coords["x"], y = Coords["y"], z = Coords["z"], name = Identity["name"].." "..Identity["name2"], time = "Recebido às "..os.date("%H:%M"), blipColor = Tencodes[parseInt(Code)]["blip"] })
			end)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
vSERVER = Tunnel.getInterface("initial")
-----------------------------------------------------------------------------------------------------------------------------------------
-- COMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("resgatar",function()
	if vSERVER.CheckInit() then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		TriggerEvent("hudActived",false)
		SendNUIMessage({ name = "Open", vehicles = Vehicles })
	end	
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITIAL:OPEN
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("initial:Open")
AddEventHandler("initial:Open",function()
	if vSERVER.CheckInit() then
		SetNuiFocus(true,true)
		SetCursorLocation(0.5,0.5)
		TriggerEvent("hudActived",false)
		SendNUIMessage({ name = "Open", vehicles = Vehicles })
	end	
end)

RegisterNetEvent("initial:Notify")
AddEventHandler("initial:Notify",function()
	SendNUIMessage({ name = "Notify" })
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNUICallback("Save",function(Data,Callback)
	SetNuiFocus(false,false)
	vSERVER.Save(Data["name"])
	TriggerEvent("hudActived",true)
	Callback("Save")
end)

RegisterNUICallback("close",function()
	SetNuiFocus(false,false)
end)
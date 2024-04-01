local Ran = false

Citizen.CreateThread(function()
    Citizen.Wait(500)
    ShutdownLoadingScreenNui()
end)

AddEventHandler("playerSpawned", function ()
	if not Ran then
		ShutdownLoadingScreenNui()
		Ran = true
	end
end)
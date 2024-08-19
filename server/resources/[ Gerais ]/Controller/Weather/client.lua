CreateThread(function()
	while true do
		SetWeatherTypeNow(GlobalState.weatherSync)
		SetWeatherTypePersist(GlobalState.weatherSync)
		SetWeatherTypeNowPersist(GlobalState.weatherSync)
		NetworkOverrideClockTime(GlobalState.clockHours,GlobalState.clockMinutes,00)
		Wait(1000)
	end
end)
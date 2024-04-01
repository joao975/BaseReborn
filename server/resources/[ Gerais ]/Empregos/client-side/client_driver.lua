-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
will = {}
Tunnel.bindInterface("driver", will)
vSERVER = Tunnel.getInterface("driver")
-----------------------------------------------------------------------------------------------------------------------------------------
-- FUNCTIONS
-----------------------------------------------------------------------------------------------------------------------------------------
local blip = nil
local passengers = {}
local createdPeds = {}
local timeSeconds = 0
local inService = false
local driverPosition = 1
local coords = configs.driver.coords
local startJob = configs.driver.startJob
local pedHashs = {
	"ig_abigail",
	"u_m_y_abner",
	"a_m_o_acult_02",
	"a_m_m_afriamer_01",
	"csb_mp_agent14",
	"csb_agent",
	"u_m_m_aldinapoli",
	"ig_amandatownley",
	"ig_andreas",
	"u_m_y_antonb",
	"csb_anita",
	"cs_andreas",
	"ig_ashley",
	"s_m_m_autoshop_01",
	"ig_money",
	"g_m_y_ballaeast_01",
	"g_m_y_ballaorig_01",
	"g_f_y_ballas_01",
	"u_m_y_babyd",
	"ig_barry",
	"s_m_y_barman_01",
	"u_m_y_baygor",
	"a_f_y_beach_01",
	"a_f_y_bevhills_02",
	"a_f_y_bevhills_01",
	"u_m_y_burgerdrug_01",
	"a_m_m_business_01",
	"a_f_m_business_02",
	"a_m_y_business_02",
	"ig_car3guy1",
	"ig_chef2",
	"g_m_m_chigoon_02",
	"g_m_m_chigoon_01",
	"ig_claypain",
	"ig_clay",
	"a_f_m_eastsa_01"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- STARTSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 1000
		local ped = PlayerPedId()

		if not IsPedInAnyVehicle(ped) then
			local coords = GetEntityCoords(ped)
            local x,y,z = table.unpack(startJob)
			local distance = #(coords - vector3(x,y,z))
			if distance <= 2.5 then
				timeDistance = 4
				DrawText3DDriver(x,y,z,"~g~E~w~ MOTORISTA",450)
				if distance <= 1.0 and IsControlJustPressed(1,38) then
					toggleServiceDriver()
					Citizen.Wait(5000)
				end
			end
		end

		Citizen.Wait(timeDistance)
	end
end)

function toggleServiceDriver()
	local ped = PlayerPedId()

	if not inService then
		inService = true
		startthreaddriver()
		startthreadtimesecondsdr()
		makeBlipsPositiondriver()
		TriggerEvent("Notify","sucesso","Você iniciou o emprego de <b>Motorista</b>.",5000)
	else
		inService = false
		TriggerEvent("Notify","negado","Você terminou o emprego de <b>Motorista</b>.",5000)
		if DoesBlipExist(blip) then
			RemoveBlip(blip)
			blip = nil
		end
	end
end

Citizen.CreateThread(function()
	while true do
		local will = 500
		if inService then
			will = 4
			drawTxt("PRESSIONE ~r~F7~w~ SE DESEJA FINALIZAR O EXPEDIENTE",4,0.24,0.922,0.4,255,255,255,237)
			if IsControlJustPressed(1,168) then
				inService = false
				TriggerEvent("Notify","negado","Você terminou o emprego de <b>Motorista</b>.",5000)
				if DoesBlipExist(blip) then
					RemoveBlip(blip)
					blip = nil
				end
				FreezeEntityPosition(GetVehiclePedIsUsing(PlayerPedId()), false)
			end
		end
		Citizen.Wait(will)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADSERVICE
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreaddriver()
	Citizen.CreateThread(function()
		while inService do
			local timeDistance = 500
			if inService then
				local ped = PlayerPedId()
				if IsPedInAnyVehicle(ped) then
					local veh = GetVehiclePedIsUsing(ped)
					local coordsPed = GetEntityCoords(ped)
					local distance = #(coordsPed - vector3(coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3]))
					if distance <= 300 and IsVehicleModel(veh,GetHashKey("bus")) then
						timeDistance = 4
						DrawMarker(21,coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3]+0.60,0,0,0,0,180.0,130.0,2.0,2.0,1.0,121,206,121,100,1,0,0,1)
						if distance <= 15 then
							if IsControlJustPressed(1,38) and timeSeconds <= 0 then
                                FreezeEntityPosition(veh, true)
                                pedsLeaveBus()
								timeSeconds = 2
								if driverPosition == #coords then
									driverPosition = 1
								else
									driverPosition = driverPosition + 1
								end
                                pedsEnterBus()
                                vSERVER.paymentMethodDriver()
								makeBlipsPositiondriver()
                                FreezeEntityPosition(veh, false)
							end
						end
					end
				end
			end
			Citizen.Wait(timeDistance)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATEPED
-----------------------------------------------------------------------------------------------------------------------------------------
function creatingPed(coords)
    local pedRand = math.random(#pedHashs)
	local hash = GetHashKey(pedHashs[pedRand])
	RequestModel(hash) while not HasModelLoaded(hash) do Wait(1) end
	local ped = CreatePed(2, hash, coords[1], coords[2], coords[3], 0.0, false, true)
	SetEntityInvincible(ped, true)
	-- SetBlockingOfNonTemporaryEvents(ped, true)
    table.insert(createdPeds, ped)
end

function pedsEnterBus()
    local seat = 0
    local cooldown = 50
    for k,ped in pairs(createdPeds) do
        if not IsPedInAnyVehicle(ped) then
            local veh = GetVehiclePedIsUsing(PlayerPedId())
            while not IsVehicleSeatFree(veh,seat) and cooldown > 0 do
                seat = seat + 1
                cooldown = cooldown - 1
                Citizen.Wait(100)
            end
			cooldown = 50
            if IsVehicleSeatFree(veh,seat) then
                TaskEnterVehicle(ped,veh,-1,seat,1.0,1,0)
                while not IsPedInAnyVehicle(ped) and cooldown > 0  do
                    Citizen.Wait(100)
					cooldown = cooldown - 1
                end
                table.insert(passengers, ped)
                table.remove(createdPeds, k)
            end
        end
    end
end

function pedsLeaveBus()
    local rand = math.random(0,#passengers)
    for k,ped in pairs(passengers) do
        if k <= rand then
            TaskLeaveAnyVehicle(ped,0,0)
            while IsPedInAnyVehicle(ped) do
				TaskLeaveAnyVehicle(ped,0,0)
                Citizen.Wait(10)
            end
            table.remove(passengers, k)
            SetPedKeepTask(ped, false)
            SetTimeout(5000, function()
                DeletePed(ped)
            end)
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TIMESECONDS
-----------------------------------------------------------------------------------------------------------------------------------------
function startthreadtimesecondsdr()
	Citizen.CreateThread(function()
		while inService do
			if timeSeconds > 0 then
				timeSeconds = timeSeconds - 1
			end
			Citizen.Wait(1000)
		end
	end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAKEBLIPSPOSITION
-----------------------------------------------------------------------------------------------------------------------------------------
function makeBlipsPositiondriver()
	if DoesBlipExist(blip) then
		RemoveBlip(blip)
		blip = nil
	end

	if not DoesBlipExist(blip) then
		blip = AddBlipForRadius(coords[driverPosition][1],coords[driverPosition][2],coords[driverPosition][3],50.0)
		SetBlipHighDetail(blip,true)
		SetBlipColour(blip,69)
		SetBlipAlpha(blip,150)
        SetBlipRoute(blip,true)
		SetBlipAsShortRange(blip,true)
	end
    local rand = math.random(0,3)
    repeat
        rand = rand - 1
        creatingPed(coords[driverPosition])
    until rand <= 0
end

function DrawText3DDriver(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
	SetTextFont(4)
	SetTextScale(0.35,0.35)
	SetTextColour(255,255,255,100)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 450
	DrawRect(_x,_y+0.0125,0.01+factor,0.03,0,0,0,100)
end

function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end

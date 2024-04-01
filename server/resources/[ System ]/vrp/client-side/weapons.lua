-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPONTYPES
-----------------------------------------------------------------------------------------------------------------------------------------
local weapon_list = {}

local weapon_types = {
	"GADGET_PARACHUTE",
	"WEAPON_KNIFE",
	"WEAPON_KNUCKLE",
	"WEAPON_NIGHTSTICK",
	"WEAPON_HAMMER",
	"WEAPON_BAT",
	"WEAPON_GOLFCLUB",
	"WEAPON_CROWBAR",
	"WEAPON_BOTTLE",
	"WEAPON_DAGGER",
	"WEAPON_HATCHET",
	"WEAPON_MACHETE",
	"WEAPON_FLASHLIGHT",
	"WEAPON_SWITCHBLADE",
	"WEAPON_POOLCUE",
	"WEAPON_PIPEWRENCH",
	"WEAPON_STONE_HATCHET",
	"WEAPON_WRENCH",
	"WEAPON_BATTLEAXE",
	"WEAPON_AUTOSHOTGUN",
	

	"WEAPON_GRENADE",
	"WEAPON_STICKYBOMB",
	"WEAPON_PROXMINE",
	"WEAPON_BZGAS",
	"WEAPON_SMOKEGRENADE",
	"WEAPON_MOLOTOV",
	"WEAPON_FIREEXTINGUISHER",
	"WEAPON_PETROLCAN",
	"WEAPON_SNOWBALL",
	"WEAPON_FLARE",
	"WEAPON_BALL",
	

	"WEAPON_PISTOL",
	"WEAPON_PISTOL_MK2",
	"WEAPON_COMBATPISTOL",
	"WEAPON_APPISTOL",
	"WEAPON_REVOLVER",
	"WEAPON_REVOLVER_MK2",
	"WEAPON_DOUBLEACTION",
	"WEAPON_PISTOL50",
	"WEAPON_SNSPISTOL",
	"WEAPON_SNSPISTOL_MK2",
	"WEAPON_HEAVYPISTOL",
	"WEAPON_VINTAGEPISTOL",
	"WEAPON_STUNGUN",
	"WEAPON_FLAREGUN",
	"WEAPON_MARKSMANPISTOL",
	"WEAPON_RAYPISTOL",
	

	"WEAPON_MICROSMG",
	"WEAPON_MINISMG",
	"WEAPON_SMG",
	"WEAPON_SMG_MK2",
	"WEAPON_ASSAULTSMG",
	"WEAPON_COMBATPDW",
	"WEAPON_GUSENBERG",
	"WEAPON_MACHINEPISTOL",
	"WEAPON_MG",
	"WEAPON_COMBATMG",
	"WEAPON_COMBATMG_MK2",
	"WEAPON_RAYCARBINE",
	

	"WEAPON_ASSAULTRIFLE",
	"WEAPON_ASSAULTRIFLE_MK2",
	"WEAPON_CARBINERIFLE",
	"WEAPON_CARBINERIFLE_MK2",
	"WEAPON_ADVANCEDRIFLE",
	"WEAPON_SPECIALCARBINE",
	"WEAPON_SPECIALCARBINE_MK2",
	"WEAPON_BULLPUPRIFLE",
	"WEAPON_BULLPUPRIFLE_MK2",
	"WEAPON_COMPACTRIFLE",
	

	"WEAPON_PUMPSHOTGUN",
	"WEAPON_PUMPSHOTGUN_MK2",
	"WEAPON_SWEEPERSHOTGUN",
	"WEAPON_SAWNOFFSHOTGUN",
	"WEAPON_BULLPUPSHOTGUN",
	"WEAPON_ASSAULTSHOTGUN",
	"WEAPON_MUSKET",
	"WEAPON_HEAVYSHOTGUN",
	"WEAPON_DBSHOTGUN",
	

	"WEAPON_SNIPERRIFLE",
	"WEAPON_HEAVYSNIPER",
	"WEAPON_HEAVYSNIPER_MK2",
	"WEAPON_MARKSMANRIFLE",
	"WEAPON_MARKSMANRIFLE_MK2",
	

	"WEAPON_GRENADELAUNCHER",
	"WEAPON_GRENADELAUNCHER_SMOKE",
	"WEAPON_RPG",
	"WEAPON_MINIGUN",
	"WEAPON_FIREWORK",
	"WEAPON_RAILGUN",
	"WEAPON_HOMINGLAUNCHER",
	"WEAPON_COMPACTLAUNCHER",
	"WEAPON_RAYMINIGUN",
	"WEAPON_PIPEBOMB"
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.getWeapons()
	local ped = PlayerPedId()
	local ammo_types = {}
	local weapons = {}
	for k,v in pairs(weapon_types) do
		local hash = GetHashKey(v)
		if HasPedGotWeapon(ped,hash) then
			local weapon = {}
			weapons[v] = weapon
			local atype = GetPedAmmoTypeFromWeapon(ped,hash)
			if ammo_types[atype] == nil then
				ammo_types[atype] = true
				weapon.ammo = GetAmmoInPedWeapon(ped,hash)
			else
				weapon.ammo = 0
			end
		end
	end
	weapons = tvRP.legalWeaponsChecker(weapons)
	return weapons
end

function tvRP.legalWeaponsChecker(weapon)
	local source = source
	local weapon = weapon
	local weapons_legal = tvRP.getWeaponsLegal()
	local ilegal = false
	for v, b in pairs(weapon) do
	  if not weapon_list[v] then
		ilegal = true 
	  end
	end
	if ilegal then
		tvRP.giveWeapons(weapons_legal, true)
		weapon = weapons_legal						 
	end
	return weapon
end	

function tvRP.getWeaponsLegal()
									
	return weapon_list
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- REPLACEWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.replaceWeapons()
	local old_weapons = tvRP.getWeapons()
	RemoveAllPedWeapons(PlayerPedId(),true)
	weapon_list = {}
	return old_weapons
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CLEARWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.clearWeapons()
	RemoveAllPedWeapons(PlayerPedId(),true)
	weapon_list = {}
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GiveWeaponToPed
-----------------------------------------------------------------------------------------------------------------------------------------
function tvRP.giveWeapons(weapons,clear_before)
	local ped = PlayerPedId()
	if clear_before then
		RemoveAllPedWeapons(ped,true)
		weapon_list = {}
	end

	for k,v in pairs(weapons) do
		GiveWeaponToPed(ped,GetHashKey(k),v.ammo or 0,false,true)
		weapon_list[string.upper(k)] = v
	end
	TriggerServerEvent("will_inventory:giveWeapons", weapon_list)
end

-----------------------------------------------------------------------------------------------------------------------------------------
-- RECOIL
-----------------------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()

		if IsPedArmed(ped,6) then
			DisableControlAction(1,140,true)
			DisableControlAction(1,141,true)
			DisableControlAction(1,142,true)
			Citizen.Wait(4)
		else
			Citizen.Wait(1500)
		end

		if IsPedShooting(ped) then
			local cam = GetFollowPedCamViewMode()
			local veh = IsPedInAnyVehicle(ped)
			
			local speed = math.ceil(GetEntitySpeed(ped))
			if speed > 70 then
				speed = 70
			end

			local _,wep = GetCurrentPedWeapon(ped)
			local class = GetWeapontypeGroup(wep)
			local p = GetGameplayCamRelativePitch()
			local camDist = #(GetGameplayCamCoord() - GetEntityCoords(ped))

			local recoil = math.random(110,120+(math.ceil(speed*0.5)))/100
			local rifle = false

			if class == 970310034 or class == 1159398588 then
				rifle = true
			end

			if camDist < 5.3 then
				camDist = 0.7
			elseif camDist < 10.0 then
				camDist = 1.5
			else
				camDist =  2.0
			end

			if veh then
				recoil = recoil + (recoil * camDist)
			else
				recoil = recoil * 0.1
			end

			if cam == 4 then
				recoil = recoil * 0.6
				if rifle then
					recoil = recoil * 0.1
				end
			end

			if rifle then
				recoil = recoil * 0.6
			end

			local spread = math.random(4)
			local h = GetGameplayCamRelativeHeading()
			local hf = math.random(10,40+speed) / 100

			if veh then
				hf = hf * 2.0
			end

			if spread == 1 then
				SetGameplayCamRelativeHeading(h+hf)
			elseif spread == 2 then
				SetGameplayCamRelativeHeading(h-hf)
			end

			local set = p + recoil
			SetGameplayCamRelativePitch(set,0.8)
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 1000
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	Citizen.Wait(1000)
	SetWeaponDamageModifier(GetHashKey("WEAPON_PISTOL50"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_REVOLVER"),0.4)
	SetWeaponDamageModifier(GetHashKey("WEAPON_PISTOL"),0.8)
	SetWeaponDamageModifier(GetHashKey("WEAPON_PISTOL_MK2"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_UNARMED"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_COMBATPISTOL"),0.8)
	SetWeaponDamageModifier(GetHashKey("WEAPON_FLASHLIGHT"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_NIGHTSTICK"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_HATCHET"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_KNIFE"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_BAT"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_BATTLEAXE"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_BOTTLE"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_CROWBAR"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_DAGGER"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_GOLFCLUB"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_HAMMER"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_MACHETE"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_POOLCUE"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_STONE_HATCHET"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_SWITCHBLADE"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_WRENCH"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_KNUCKLE"),0.1)
	SetWeaponDamageModifier(GetHashKey("WEAPON_COMPACTRIFLE"),0.4)
	SetWeaponDamageModifier(GetHashKey("WEAPON_APPISTOL"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_HEAVYPISTOL"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_MACHINEPISTOL"),0.7)
	SetWeaponDamageModifier(GetHashKey("WEAPON_MICROSMG"),0.7)
	SetWeaponDamageModifier(GetHashKey("WEAPON_MINISMG"),0.7)
	SetWeaponDamageModifier(GetHashKey("WEAPON_SNSPISTOL"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_SNSPISTOL_MK2"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_VINTAGEPISTOL"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_CARBINERIFLE"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_ASSAULTRIFLE"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_ASSAULTRIFLE_MK2"),0.6)
	SetWeaponDamageModifier(GetHashKey("WEAPON_ASSAULTSMG"),0.7)
	SetWeaponDamageModifier(GetHashKey("WEAPON_GUSENBERG"),0.7)
	SetWeaponDamageModifier(GetHashKey("WEAPON_SAWNOFFSHOTGUN"),1.3)
	SetWeaponDamageModifier(GetHashKey("WEAPON_PUMPSHOTGUN"),2.0)
	while true do
		Citizen.Wait(2000)
		InvalidateIdleCam()
		InvalidateVehicleIdleCam()
		DistantCopCarSirens(false)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADGLOBAL - 5
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		HideHudComponentThisFrame(1)
		HideHudComponentThisFrame(3)
		HideHudComponentThisFrame(4)
		HideHudComponentThisFrame(5)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(10)
		HideHudComponentThisFrame(11)
		HideHudComponentThisFrame(12)
		HideHudComponentThisFrame(13)
		HideHudComponentThisFrame(15)
		HideHudComponentThisFrame(17)
		HideHudComponentThisFrame(18)
		HideHudComponentThisFrame(20)
		HideHudComponentThisFrame(21)
		HideHudComponentThisFrame(22)
		--DisableControlAction(1,37,true)
		DisableControlAction(1,192,true)
		DisableControlAction(1,204,true)
		DisableControlAction(1,211,true)
		DisableControlAction(1,349,true)
		DisableControlAction(1,157,false)
		DisableControlAction(1,158,false)
		DisableControlAction(1,160,false)
		DisableControlAction(1,164,false)
		DisableControlAction(1,165,false)
		DisableControlAction(1,159,false)
		DisableControlAction(1,161,false)
		DisableControlAction(1,162,false)
		DisableControlAction(1,163,false)
		
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_KNIFE"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PISTOL"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_MINISMG"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_SMG"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_PUMPSHOTGUN"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_CARBINERIFLE"))
		RemoveAllPickupsOfType(GetHashKey("PICKUP_WEAPON_COMBATPISTOL"))

		DisablePlayerVehicleRewards(PlayerId())

		local ped = PlayerPedId()
		if not IsPedInAnyVehicle(ped) then
			SetPedInfiniteAmmo(ped,true,"WEAPON_FIREEXTINGUISHER")
		end
		Citizen.Wait(5)
	end
end)
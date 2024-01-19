
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
vRP = Proxy.getInterface("vRP")
Reborn = Proxy.getInterface("Reborn")
local multi_personagem = Reborn.multi_personagem()
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
Creative = {}
Tunnel.bindInterface("spawn",Creative)

vRP.prepare("characters/countPersons","SELECT COUNT(steam) as qtd FROM vrp_users WHERE steam = @steam and deleted = 0")
vRP.prepare("characters/countChars","SELECT chars FROM vrp_infos WHERE steam = @steam")
vRP.prepare("characters/lastCharacters","SELECT id FROM vrp_users WHERE steam = @steam ORDER BY id DESC LIMIT 1")
vRP.prepare("characters/update_character","UPDATE vrp_users SET name = @name, name2 = @name2, phone = @phone, registration = @registration WHERE steam = @steam ORDER BY id DESC LIMIT 1")
vRP.prepare("characters/create_characters","INSERT INTO vrp_users(steam,name,name2,phone,registration) VALUES(@steam,@name,@name2,@phone,@registration)")

local Global = {}

function Creative.Characters()
  local source = source
  local steam = vRP.getSteam(source)
  TriggerEvent("vRP:BucketServer", source, "Enter", source)
  local consult = vRP.query("vRP/get_characters",{ steam = steam })
  if consult and consult[1] then
    local values = {}
    for k, v in pairs(consult) do
      local userTablesSkin = json.decode(vRP.getUData(v["id"],"Datatable"))
			if userTablesSkin then
        local identity = vRP.getUserIdentity(v["id"])
        local userTablesBarber = json.decode(vRP.getUData(v["id"],"currentCharacterMode")) or {}
        local userTablesClotings = json.decode(vRP.getUData(v["id"],"Clothings"))
        local userTablesTatto = json.decode(vRP.getUData(v["id"],"vRP:tattoos")) or {}
        local fullName = identity.name.." "..identity.name2
        local sex = userTablesSkin["skin"] == 1885233650 and "Masculino" or "Feminino"
        values[#values + 1] = { Passport = v.id, Skin = userTablesSkin["skin"] or -1667301416, Nome = fullName, Sexo = sex, Blood = "A", Clothes = userTablesClotings, Barber = userTablesBarber, Tattoos = userTablesTatto, Banco = identity.bank }
      end
    end
    return values
  end
  return {}
end

function Creative.CharacterChosen(user_id)
  local source = source
  local data = vRP.getUData(user_id, "vRP:spawnController")
	local sdata = json.decode(data) or nil
  if sdata ~= nil then
    TriggerEvent("vRP:BucketServer", source, "Exit")
    TriggerEvent("baseModule:idLoaded", source, user_id, nil)
    return true
  else
    DropPlayer(source, "Conectando em personagem irregular.")
    return false
  end
end

function Creative.NewCharacter(name, name2, sex)
  local source = source
  if not Global[source] then
    Global[source] = true
    local steam = vRP.getSteam(source)
		local myChars = vRP.query("characters/countPersons",{ steam = steam })
    local dataInfo = vRP.query("characters/countChars",{ steam = steam })
    if multi_personagem['Enabled'] then
			if multi_personagem['Max_personagens'] <= parseInt(myChars[1]["qtd"]) and parseInt(dataInfo[1]['chars']) <= parseInt(myChars[1]["qtd"]) then
				TriggerClientEvent("Notify",source,"aviso","Atingiu o limite de personagens.",5000)
        Global[source] = nil
				return
			end
			vRP.execute("characters/create_characters",{ steam = steam, name = name, name2 = name2, phone = vRP.generatePhoneNumber(), registration = vRP.generateRegistrationNumber() })
    else
			if parseInt(myChars[1]["qtd"]) >= 1 then
        Global[source] = nil
				TriggerClientEvent("Notify",source,"aviso","Você já possui um personagem.",5000)
				return
			end
			vRP.execute("characters/update_character",{ steam = steam, name = name, name2 = name2, phone = vRP.generatePhoneNumber(), registration = vRP.generateRegistrationNumber() })
    end
    local consult = vRP.query("characters/lastCharacters",{ steam = steam })
		if consult[1] then
      TriggerClientEvent("spawn:Finish",source)
      Citizen.Wait(300)
			TriggerEvent("baseModule:idLoaded", source, parseInt(consult[1]["id"]), sex)
      TriggerEvent("vRP:BucketServer", source, "Exit")
			TriggerClientEvent('createModule:characterCreate', source, sex)
		end
    Global[source] = nil
    return true
  end
end

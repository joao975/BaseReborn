local surgery_male = { model = "mp_m_freemode_01" }
local surgery_female = { model = "mp_f_freemode_01" }
local travesti1 = { model = "a_m_m_tranvest_01" }
local travesti2 = { model = "a_m_m_tranvest_02" }
local gogoboy = { model = "u_m_y_staggrm_01" }
local deus = { model = "u_m_m_jesus_01" }
local padre = { model = "cs_priest" }
local pegrande = { model = "cs_orleans" }
local gato = { model = "a_c_cat_01" }
local pug = { model = "a_c_pug" }
local lessie = { model = "a_c_shepherd" }
local poodle = { model = "a_c_westy" }
local onca = { model = "a_c_mtlion" }
local chop = { model = "a_c_chop" }
local macaco = { model = "a_c_chimp" }

for i=0,19 do
	surgery_female[i] = { 1,0 }
	surgery_male[i] = { 1,0 }
end

Reborn.cloakroom_types = function()
	local cloakroom_types = {
		["Personagem"] = {
			_config = {
				permissions={"administrador.permissao"}
			},
			["Travesti 1"] = travesti1,
			["Travesti 2"] = travesti2,
			["Gogoboy"] = gogoboy,
			["Deus"] = deus,
			["Padre"] = padre,
			["Pé Grande"] = pegrande,
			["Gato"] = gato,
			["Pug"] = pug,
			["Lessie"] = lessie,
			["Poodle"] = poodle,
			["Onça"] = onca,
			["Chop"] = chop,
			["Macaco"] = macaco
		},
		["Police"] = {
			_config = {
				permissions={"Police"}
			},
			tshirt_1 = 0, tshirt_2 = 0,
			torso_1 = 0, torso_2 = 0,
			decals_1 = 0, decals_2 = 0,
			arms = 0, arms_2 = 0,
			pants_1 = 0, pants_2 = 0,
			shoes_1 = 0, shoes_2 = 0,
			mask_1 = 0,	mask_2 = 0,
			bproof_1 = 0, bproof_2 = 0,
			neckarm_1 = 0, neckarm_2 = 0,
			helmet_1 = 0, helmet_2 = 0,
			glasses_1 = 0, glasses_2 = 0,
			lefthand_1 = 0,	lefthand_2 = 0,
			righthand_1 = 0, righthand_2 = 0,
			bags_1 = 0,	bags_2 = 0,
			ears_1 = 0,	ears_2 = 0,
		},
	}
	return cloakroom_types
end

Reborn.cloakrooms = function()
	local cloakrooms = {
		{ "Personagem",206.82,-1002.02,29.29 },
		{ "Police", 206.82,-1000.02,29.29 }
	}
	return cloakrooms
end

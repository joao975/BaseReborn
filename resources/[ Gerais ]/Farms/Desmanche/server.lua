local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local Webhooks = module("Reborn/webhooks")
vRP = Proxy.getInterface("vRP")
vRPclient = Proxy.getInterface("vRP")

rbn = {}
Tunnel.bindInterface("Desmanche", rbn)

vCLIENT = Tunnel.getInterface("Desmanche")

local iniciado = false
------------------------------------------------------
-- CONFIG 
------------------------------------------------------
local RestritoParaDesmanche = Farms.desmanche.RestritoParaDesmanche
local PermissaoDesmanche = Farms.desmanche.PermissaoDesmanche

local PrecisaDeItem = Farms.desmanche.PrecisaDeItem
local ItemNecessario = Farms.desmanche.ItemNecessario
local QtdNecessaria = Farms.desmanche.QtdNecessaria

local CarrosDesmanches = {   
    ['150'] = 8500,
    ['amarok'] = 380000,
    ['biz25'] = 5000,
    ['bros60'] = 15000,
    ['civic2016'] = 70000,
    ['dm1200'] = 10000,
    ['ds4'] = 30000,
    ['eletran17'] = 40000,
    ['evoq'] = 145000,
    ['fiat'] = 10000,
    ['fiatstilo'] = 75000, 
    ['fiattoro'] = 180000, 
    ['fiatuno'] = 13000, 
    ['fordka'] = 10000, 
    ['fusion'] = 75000,
    ['golg7'] = 20000, 
    ['hornet'] = 70000, 
    ['jetta2017'] = 50000, 
    ['l200civil'] = 90000, 
    ['monza'] = 15000, 
    ['p207'] = 18000, 
    ['palio'] = 18000, 
    ['punto'] = 48000,
    ['santafe'] = 60000, 
    ['saveiro'] = 35000, 
    ['sonata18'] = 75000, 
    ['upzinho'] = 23000, 
    ['veloster'] = 50000, 
    ['voyage'] = 20000,
    ['vwgolf'] = 45000, 
    ['vwpolo'] = 30000, 
    ['xj'] = 65000, 
    ['xt66'] = 45000, 
    ['z1000'] = 100000, 
    ['dune'] = 450000,
    ['audirs6'] = 600500, 
    ['audirs7'] = 600500, 
    ['bmwm3f80'] = 600000, 
    ['bmwm4gts'] = 400000,
    ['dodgechargersrt'] = 800000,
    ['focusrs'] = 400000,
    ['fordmustang'] = 600000,
    ['hondafk8'] = 750000,
    ['lancerevolution9'] = 600500,
    ['lancerevolutionx'] = 600500, --
    ['f150'] = 70000,
    ['evoque'] = 350000,
    ['mazdarx7'] = 420000,
    ['mercedesa45'] = 420000,
    ['mustangmach1'] = 380000,
    ['nissan370z'] = 380000,
    ['nissangtr'] = 380000,
    ['nissangtrnismo'] = 380000,
    ['nissanskyliner34'] = 380000,
    ['porsche930'] = 420000,
    ['raptor2017'] = 380000,
    ['teslaprior'] = 600500,
    ['toyotasupra'] = 380000,
    ['ruiner'] = 80000,
    ['verlierer2'] = 15000,
    ['sentinel'] = 5000,
    ['intruder'] = 15000,
    ['asea'] = 18000,
    ['sultanrs'] = 210000,
    ['casco'] = 9000,
    ['zentorno'] = 250000,
    ['voltic'] = 250000,
    ['sanchez'] = 6000,
    ['manchez'] = 17820,
    ['santafe'] = 45000,
    ['panto'] = 45000,
    ['r1'] = 90000,
    ['zx10r'] = 90000,
    ['tiger'] = 130000,
    ['i8'] = 780000,
    ['ferrariitalia'] = 800000,
    ['lamborghinihuracan'] = 650000,
    ['t20'] = 650000,
    ['laferrari15'] = 800000,
    ['tyrant'] = 550000,
    ['r1250'] = 350000,
    ['divo'] = 800000,
	['benson'] = 15000,
	['blista'] = 5000,
	['brioso'] = 8000,
	['dilettante'] = 4000,
	['issi2'] = 12000,
	['issi3'] = 15000,
	['panto'] = 1000,
	['prairie'] = 4500,
	['rhapsody'] = 750,
	['cogcabrio'] = 7500,
	['exemplar'] = 30000,
	['f620'] = 15000,
	['felon'] = 15000,
	['felon2'] = 20000,
	['jackal'] = 9000,
	['oracle'] = 500,
	['oracle2'] = 700,
	['sentinel'] = 1200,
	['sentinel2'] = 1200,
	['windsor'] = 900,
	['windsor2'] = 1000,
	['zion'] = 500,
	['zion2'] = 500,
	['guardian'] = 12000,
	['akuma'] = 150000,
	['avarus'] = 30000,
	['bagger'] = 18000,
	['bati'] =  60000,
	['bati2'] = 55000,
	['bf400'] = 75000,
	['carbonrs'] = 40000,
	['chimera'] = 18500,
	['cliffhanger'] = 20000,
	['daemon'] = 20000,
	['daemon2'] = 21000,
	['defiler'] = 30000,
	['deathbike2'] = 60000,
	['deathbike3'] = 60000,
	['diablous'] = 28000,
	['diablous2'] = 28000,
	['double'] = 35000,
	['enduro'] = 9000,
	['esskey'] = 15000,
	['faggio'] = 500,
	['faggio2'] = 500,
	['faggio3'] = 500,
	['fcr'] = 14000,
	['fcr2'] = 14000,
	['gargoyle'] = 14000,
	['hakuchou'] = 55000,
	['hakuchou2'] = 62000,
	['hexer'] = 11000,
	['innovation'] = 12000,
	['lectro'] = 15000, 
	['manchez'] = 14000,
	['nemesis'] = 14000,
	['nightblade'] = 17000,
	['oppressor'] = 60000,
	['oppressor2'] = 60000,
	['pcj'] = 5500,
	['ratbike'] = 60000,
	['ruffian'] = 13000,
	['sanchez'] = 8000,
	['sanchez2'] = 9000,
	['sanctus'] = 14000,
	['shotaro'] = 6000,
	['sovereign'] = 12000,
	['thrust'] =  14000,
	['vader'] = 12000,
	['vindicator'] = 12000,
	['vortex'] =  20000,
	['wolfsbane'] = 11000,
	['zombiea'] = 11000,
	['zombieb'] = 11000,
	['buccaneer'] = 1200,
	['buccaneer2'] = 2400,
	['chino'] = 1200,
	['chino2'] = 2400,
	['clique'] =  3600,
	['coquette3'] = 6000,
	['deviant'] = 3000,
	['dominator'] = 3000,
	['dominator3'] = 5000,
	['dukes'] = 1500,
	['faction'] = 1500,
	['faction2'] = 35000,
	['faction3'] = 4500,
	['ellie'] = 3000,
	['gauntlet'] =1450,
	['hermes'] =  5000,
	['hotknife'] = 2500,
	['hustler'] = 2800,
	['impaler'] = 3000,
	['moonbeam'] =2500,
	['moonbeam2'] = 4500,
	['nightshade'] = 2700,
	['picador'] = 1500,
	['ratloader2'] = 2200,
	['ruiner'] = 3500,
	['sabregt'] = 2400,
	['sabregt2'] = 1500,
	['slamvan'] = 1500,
	['slamvan2'] =  1900,
	['slamvan3'] = 2000,
	['stalion'] =  1500,
	['tampa'] =  3500,
	['tulip'] =  3000,
	['vamos'] =  3200,
	['vigero'] =  1700,
	['virgo'] = 1500,
	['virgo2'] =  2500,
	['virgo3'] =  1800,
	['voodoo'] =  2200,
	['yosemite'] = 3500,
	['bfinjection'] =  1500,
	['bifta'] = 1900,
	['blazer'] = 1600,
	['blazer4'] = 3000,
	['bodhi2'] = 2500,
	['brawler'] = 3000,
	['dubsta3'] = 5500,
	['freecrawler'] = 3500,
	['kalahari'] = 3500,
	['kamacho'] = 6000,
	['mesa3'] =  7000,
	['rancherxl'] = 3000,
	['rebel'] = 3500,
	['rebel2'] = 4000,
	['riata'] = 5000,
	['sandking'] = 6000,
	['trophytruck'] = 4500,
	['baller6'] = 20000,
	['cavalcade'] =  1100,
	['cavalcade2'] = 1300,
	['contender'] =  9000,
	['dubsta2'] = 4000,
	['granger'] = 4000,
	['huntley'] =  2000,
	['mesa'] = 2000,
	['patriot'] =  4500,
	['toros'] =  5500,
	['xls'] =  15000,
	['xls2'] =  10000,
	['asea'] =  500,
	['cog55'] = 2000,
	['cognoscenti'] = 2500,
	['fugitive'] =  2000,
	['primo'] =  1200,
	['regina'] = 1200,
	['romero'] =  3000,
	['stafford'] = 4000,
	['stretch'] = 7500,
	['superd'] = 2500,
	['warrener'] = 900,
	['banshee'] = 6000,
	['bestiagts'] = 8000,
	['buffalo2'] = 3500,
	['carbonizzare'] =  6500,
	['comet2'] =  5000,
	['comet3'] = 5500,
	['comet4'] = 6800,
	['comet5'] = 7500,
	['coquette'] = 4500,
	['elegy'] = 15000,
	['elegy2'] = 8000,
	['feltzer2'] = 3500,
	['flashgt'] = 10000,
	['futo'] = 3000,
	['gb200'] = 3500,
	['hotring'] = 3000,
	['italigto'] = 12000,
	['jester'] = 4000,
	['jester3'] = 4000,
	['kuruma'] = 75000,
	['massacro'] = 4000,
	['neon'] =  8000,
	['ninef2'] = 5000,
	['pariah'] = 5500,
	['raiden'] = 3200,
	['rapidgt'] = 4000,
	['rapidgt2'] = 4500,
	['ruston'] = 4500,
	['schafter3'] = 1800,
	['schafter4'] = 1900,
	['schlagen'] = 6000,
	['sentinel3'] = 1500,
	['seven70'] = 6500,
	['specter2'] = 7000,
	['sultan'] =  60000,
	['verlierer2'] = 3300,
	['btype'] = 50000,
	['btype2'] = 55000,
	['btype3'] = 45000,
	['casco'] = 35000,
	['coquette2'] = 55000,
	['fagaloa'] = 30000,
	['gt500'] = 34000,
	['infernus2'] = 85000,
	['jb700'] = 20000,
	['mamba'] = 30000,
	['manana'] = 12000,
	['michelli'] = 16000,
	['rapidgt3'] = 19000,
	['savestra'] = 20000,
	['tornado'] = 14000,
	['tornado2'] = 16000,
	['tornado5'] = 25000,
	['turismo2'] = 45000,
	['cheburek'] = 15000,
	['adder'] = 50000,
	['banshee2'] = 70000,
	['cyclone'] = 80000,
	['entityxf'] = 70000,
	['italigtb'] = 75000,
	['italigtb2'] = 82000,
	['nero2'] = 60000,
	['osiris'] = 65000,
	['pfister811'] = 80000,
	['sheava'] = 70000,
	['sultanrs'] = 85000,
	['t20'] =  100000,
	['taipan'] = 8000,
	['tempesta'] = 70000,
	['tezeract'] = 80000,
	['vagner'] = 90000,
	['visione'] = 60000,
	['xa21'] = 55000,
	['zentorno'] =  70000,
	['caddy'] = 500,
	['caddy2'] = 500,
	['caddy3'] = 450,
	['burrito'] = 2000,
	['burrito2'] = 2000,
	['burrito3'] = 2000,
	['burrito4'] = 2000,
	['camper'] = 1800,
	['gburrito'] = 3000,
	['gburrito2'] = 5000,
	['minivan'] = 1500,
	['minivan2'] = 3000,
	['paradise'] = 2500,
	['pony'] = 2000,
	['pony2'] = 2500,
	['rumpo'] = 2200,
	['rumpo2'] =  2200,
	['rumpo3'] =  10000,
	['speedo'] =  2200,
	['surfer'] = 1900,
	['surfer2'] =  1850,
	--['audirs6'] =  90000,
	['bmwi8'] = 90000,
	['bmwm3e36'] =  90000,
	--['bmwm4gts'] =  90000,
	['civictyper'] =  90000,
	--['dodgechargersrt'] =  90000,
	['ferrari812'] =  90000,
	['ferrarif12'] =  90000,
	--['ferrariitalia'] = 90000,
	--['fordmustang'] =  90000,
	--['lamborghinihuracan'] = 90000, 
	--['lancerevolutionx'] =  90000,
	--['mazdarx7'] =  90000,
	['mclarenp1'] =  90000,
	['mclarensenna'] =  90000,
	['mercedesgt63'] =  90000,
	['mustangfast'] =  90000,
	--['nissangtr'] =  90000,
	['nissangtr2'] =  90000,
	--['nissangtrnismo'] =  90000,
	['silvias15'] =  90000,
	--['nissanskyliner34'] = 90000, 
	['subaruimpreza'] =  90000,
	--['teslaprior'] =  90000,
	--['toyotasupra'] =  90000,
	['70camarofn'] =  90000,
	['488gtb'] = 90000,
	['eclipse'] = 90000,
	['fc15'] =  90000,
	['g65amg'] = 90000,
	['lp700r'] =  90000,
	['nissantitan17'] = 90000,
	['p1'] = 90000,
	['18macan'] = 90000,
	['911r'] =  90000,
	['palameila'] =  90000,
	['weevil'] = 5000,
	['veneno'] = 90000
	--['lancerevolution9'] = 90000, 
	--['raptor2017'] = 90000
}

-- RETORNA VEICULOS PERMITIDOS
function rbn.GetVehs()
    return CarrosDesmanches
end


-- FUNÇÃO VERIFICAR PERMISSÃO DO DESMANCHE
function rbn.CheckPerm()
    local source = source
    local user_id = vRP.getUserId(source)
    if RestritoParaDesmanche then
        if vRP.hasPermission(user_id, PermissaoDesmanche) and not iniciado then
			iniciado = true
            return true
        end
        return false
    end
end

function rbn.backIniciado()
	iniciado = false
end

-- FUNÇÃO PRA VERIFICAR SE POSSUI O ITEM
function rbn.CheckItem()
    local source = source
    local user_id = vRP.getUserId(source)
    if PrecisaDeItem then
        if vRP.tryGetInventoryItem(user_id,ItemNecessario,QtdNecessaria) then
            return true
        end
        return false
    end
    return true
end

-- FUNÇÃO PARA GERAR O PAGAMENTO E OS ITENS
function rbn.GerarPagamento(placa, nomeFeio, nomeBonito)
    local source = source
    local user_id = vRP.getUserId(source)
    local identity = vRP.getUserIdentity(user_id)
	local puser_id = vRP.getVehiclePlate(placa)
	if puser_id and puser_id ~= user_id then
    	for k, v in pairs(CarrosDesmanches) do
        	if string.upper(k) == string.upper(nomeFeio) then
				local pagamento = v
				vRP.giveInventoryItem(user_id,'dollars2',pagamento)-- DINHEIRO SUJO
				for k,v in pairs(Farms.desmanche['Payment']) do
					vRP.giveInventoryItem(user_id,k,v)
				end
				iniciado = false 

                local value = vRP.getUData(puser_id,'vRP:multas')
                local multas = json.decode(value) or 0
                multas = multas + pagamento
                local nsource = vRP.getUserSource(puser_id)
                if nsource then
					exports['ld_smartbank']:CreateFine(nsource, "Governo", parseInt(multas), "Seguro de veiculo")
					vRP.setUData(puser_id,'vRP:multas',json.encode(parseInt(multas)))
                    TriggerClientEvent('Notify', nsource, 'aviso', 'Você foi multado em <b>R$' .. vRP.format(pagamento) .. '</b> referente ao seguro do veículo <b>' .. nomeBonito .. ' (' .. nomeFeio .. ')</b>.', 5000)
                end
				TriggerClientEvent("vrp_sound:source",source,'coin',0.3)
				TriggerClientEvent('Notify', source, 'sucesso', 'Você recebeu <b>R$'..vRP.format(pagamento)..'</b> pelo desmanche de um <b>'..nomeBonito..' ('.. nomeFeio..' - PLACA [' .. placa .. '])</b>.', 5000)
				vRP.createWeebHook(Webhooks.hookdesmanche,"```prolog\n[PASSAPORTE]: "..user_id.." \n[NOME]: "..identity.name.." "..identity.name2.." \n[DESMANCHOU]: "..nomeBonito.."  \n[PLACA]: ".. placa .." \n[RECEBEU]: ".. vRP.format(pagamento) .." "..os.date("\n[Data]: %d/%m/%y \n[Hora]: %H:%M:%S").." \r```")
				break
            end
        end
    end
end

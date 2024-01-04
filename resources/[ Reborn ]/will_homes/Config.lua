Proxy = module("vrp","lib/Proxy")
Tunnel = module("vrp","lib/Tunnel")

-----##########################################################-----
--###          CONFIG
-----##########################################################-----

Config = {}

Config.base = "creative"

Config.SellTax = 10

Config.showBlips = true

Config.taxTime = 7

Config.delHomeTime = 7

Config.houseTaxes = function(id)
    local house = Config.Houses[id]
    local price = house.price * 1/10
    if price > 100000 then
        price = 100000
    end
    return price
end

Config.targetScript = true

Config.Aparts = {
    ["apartment1"] = {
        out = vector3(265.98,-1007.61,-101.0),
        chest = vector3(265.9,-999.42,-99.0),
    },
    ["apartment2"] = {
        out = vector3(-24.04,-597.62,80.04),
        chest = vector3(-12.64,-597.13,79.44),
    },
    ["apartment3"] = {
        out = vector3(-782.2, 319, 187.9),
        manage = vector3(-796.58,322.04,187.32),
        chest = vector3(-796.5, 328.2, 187.3),
    },
    ["apartment4"] = {
        out = vector3(342.07,437.9,149.39),
        chest = vector3(338.43,436.76,141.78),
    },
    ["apartment5"] = {
        out = vector3(-1289.94,449.92,97.91),
        chest = vector3(-1287.88,455.55,90.3),
    },
}

Config.Houses_Template = { 
    name = "Casa a venda",
    price = 5,
    coords = {      
        house_in = vector3(1,1,1),
        house_out = vector3(1,1,1),
        chest = vector3(1,1,1)
    },
    owner = "",
    friends = {  },
    theme = "apartment1",
    stars = 1,
    extends = {},
}

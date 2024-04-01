--####--####--####--####
--##  AUTENTICAÇÃO  --##
--####--####--####--####

Citizen.CreateThread(function()
    local direct = Reborn.images()
    SendNUIMessage({ act = "setDirect", myDirect = direct })
end)

--####--####--####--#
--##   CONVERSÃO   -#
--####--####--####--#

tvRP.getNearestPlayer = function(radius) 
    return vRP.nearestPlayer(radius)
end

tvRP.getNearestVehicle = function(radius)
    return vRP.getNearVehicle(radius)
end
tvRP.getNearestVehicles = function(radius)
    return vRP.getNearVehicles(radius)
end

tvRP.CarregarObjeto = function(dict,anim,prop,flag,mao,altura,pos1,pos2,pos3,pos4,pos5)
    vRP.createObjects(dict,anim,prop,flag,mao,altura,pos1,pos2,pos3,pos4,pos5)
end

tvRP.DeletarObjeto = function(status)
    vRP.removeObjects(status)
end

tvRP.nearVehicle = function(radius)
    return vRP.getNearVehicle(radius)
end


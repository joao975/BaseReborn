--####--####--####--#
--##   CONVERSÃO   -#
--####--####--####--#

function exportHandler(resource, exportName, func)
    AddEventHandler(('__cfx_export_%s_%s'):format(resource,exportName), function(setCB)
        setCB(func)
    end)
end

tvRP.getNearestPlayer = function(radius) 
    return vRP.nearestPlayer(radius)
end

tvRP.getNearestPlayers = function(distance)
    return vRP.nearestPlayers(distance)
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

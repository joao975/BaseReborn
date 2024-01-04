function mBMarker(vector, sizex, sizey, sizez, src, id)
    if not HasStreamedTextureDictLoaded(src) then
        RequestStreamedTextureDict(src, true)
        while not HasStreamedTextureDictLoaded(src) do
            Wait(1)
        end
    else
        local x,y,z = table.unpack(vector)
        DrawMarker(9, x, y, z, 0.0, 0.0, 0.0, tonumber('90.0'), tonumber('90.0'), 0.0, sizex, sizey, sizez, 255, 255, 255, 255,false, true, 2, false, src, id, false)
    end
end
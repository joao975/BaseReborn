--####--####--####--
--##    HOF's   ##--
--####--####--####--

local HOFs = {}
local HOF = {}

function HOFs.Generator(array)
	local r = setmetatable({}, { __index = HOF })
	r:constructor(array)
	return r
end

function HOF:constructor(array)
	self.array = array
end

function HOF:some(callback)
	if type(callback) == 'function' then
		for k,v in ipairs(self.array) do
			if callback(v) then
				return true	
			end
		end
        return false
	end
    return nil
end

function HOF:every(callback)
    if type(callback) == 'function' then
		for k,v in ipairs(self.array) do
			if not callback(v) then
				return false	
			end
		end
        return true
	end
    return nil
end

function HOF:map(callback)
    if type(callback) == 'function' then
        local newArray = {}
        for k,v in ipairs(self.array) do   
            newArray[k] = callback(v)
        end
        return newArray
    end
    return self.array
end

function HOF:find(callback)
    if type(callback) == 'function' then
        for k,v in ipairs(self.array) do
            if callback(v) then
                return self.array[k]
            end
        end
    end
    return false
end

function HOF:filter(callback)
    if type(callback) == 'function' then
        local newArray = {}
        local i = 1
        for k,v in ipairs(self.array) do
            if callback(v) then
                newArray[i] = v
                i = i + 1
            end
        end
        return newArray
    end
    return self.array
end

return HOFs


--[[ local Hofs = module("vrp","lib/Hofs")
Citizen.CreateThread(function()
	local array = { 'laranja', 'morango', 'mala', 5 }
	local newArray = Hofs.Generator(array)
	local myfunction = function(e) if e == 'mala' then return true end end
	local mapfunc = function(e)	if type(e) == 'string' then	return 'Will' end end

	local hofSome = newArray:some(myfunction)

	local hofEvery = newArray:every(myfunction)

	local hofFind = newArray:find(myfunction)

	local hofmap = newArray:map(mapfunc)

	local hoffilter = newArray:filter(myfunction)

	print(hofSome,teste2,json.encode(hofmap),hofFind,json.encode(hoffilter))
end) ]]

local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'appDoer'
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self._tag = 'map'
end

function _M:cacheTime()

    return 60 * 24 * 7
end

function _M:model()

    return new(Map)
end

function _M:getAll()

    local maps = self:remember('map.all', function()
        
        return new(Map):all()
    end)
    
    return maps
end

function _M:getByTag(tag)

    local maps = self:remember('map.tag.' .. tag, function()
        
        return new(Map):where('tag', tag):get()
    end)
    
    return maps
end

function _M:count(tag)

    local count = self:remember('map.count.' .. tag, function()
        if tag then
            
            return new(Map):where('tag', tag):count()
        end
        
        return new(Map):count()
    end)
    
    return count
end

function _M:saveSettings(inputs)

    local map
    for key, value in pairs(inputs) do
        map = new(Map):firstOrNew({key = key})
        map.tag = 'settings'
        map.value = value
        map:save()
    end
    self:clearCache()
end

function _M:getArrayByTag(tag)

    local maps = self:getByTag(tag)

    local arr = {}
    for _, map in pairs(maps) do
        arr[map.key] = map.value
    end
    
    return arr
end

function _M:get(key)

    local map = self:remember('map.one.' .. key, function()
        
        return new(Map):where('key', key):first()
    end)
    
    return map
end

function _M:getValue(key, default)

    local map = self:get(key)
    if map and lf.notEmpty(map.value) then
        
        return map.value
    end
    
    return default
end

function _M:getBoolValue(key, default)

    default = default or false
    local defaultValue = default and 'true' or 'false'
    
    return self:getValue(key, defaultValue) == 'true'
end

function _M:delete(key)

    self:clearCache()
    
    return new(Map):where('key', key):delete()
end

function _M:create(request)

    self:clearCache()
    local map = new(Map):create({
        key = request.key, value = request.value
    })
    
    return map
end

return _M


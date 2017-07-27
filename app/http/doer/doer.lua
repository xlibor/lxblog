
local lx, _M, mt = oo{
    _cls_ = ''
}

local app, lf, tb, str = lx.kit()

function _M:new()

    local this = {
        xblogCache = nil
    }
    
    return oo(this, mt)
end

function _M:model() end

function _M:tag()

    return self._tag
end

function _M.__:getXblogCache()

    if self.xblogCache == nil then
        self.xblogCache = app('xblogCache')
        self.xblogCache:setTag(self:tag())
        self.xblogCache:setTime(self:cacheTime())
    end
    
    return self.xblogCache
end

function _M:cacheTime()

    return 60
end

function _M:count()

    local count = self:remember(self:tag() .. '.count', function()
        
        return self:model():count()
    end)
    
    return count
end

function _M:all()

    local all = self:remember(self:tag() .. '.all', function()
        
        return self:model():all()
    end)
    
    return all
end

function _M:remember(key, entity, tag)

    return self:getXblogCache():remember(key, entity, tag)
end

function _M:forget(key, tag)

    self:getXblogCache():forget(key, tag)
end

function _M:clearCache(tag)

    self:getXblogCache():clearCache(tag)
end

function _M:clearAllCache()

    self:getXblogCache():clearAllCache()
end

return _M


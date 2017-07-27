
local lx, _M, mt = oo{
    _cls_ = '',
    -- _bond_ = 'xblogCache'
}

local app, lf, tb, str = lx.kit()

local cache = lx.h.cache

function _M:new()

    local this = {
        tag = nil,
        cacheTime = nil
    }
    
    return oo(this, mt)
end

function _M:setTag(tag)

    self.tag = tag
end

function _M:remember(key, entity, tag)

    tag = tag or self.tag
 
    return cache():tags(tag)
        :remember(key, self.cacheTime, entity)
end

function _M:forget(key, tag)

    tag = tag or self.tag
    cache():tags(tag):forget(key)
end

function _M:clearCache(tag)

    tag = tag or self.tag
    cache():tags(tag):flush()
end

function _M:clearAllCache()

    cache():flush()
end

function _M:setTime(time_in_minute)

    self.cacheTime = time_in_minute
end

return _M


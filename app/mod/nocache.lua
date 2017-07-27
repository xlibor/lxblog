
local lx, _M, mt = oo{
    _cls_ = '',
    -- _bond_ = 'xblogCache'
}

local app, lf, tb, str = lx.kit()

function _M:setTag(tag)
end

function _M:setTime(time_in_minute)
end

function _M:remember(key, entity, tag)

    return entity()
end

function _M:forget(key, tag)
end

function _M:clearCache(tag)
end

function _M:clearAllCache()
end

return _M


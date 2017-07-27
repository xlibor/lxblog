
local lx, _M = oo{
    _cls_	= '',
    _bond_ 	= 'scope'
}

local app, lf, tb, str = lx.kit()

function _M:apply(query, model)

    return query:where('status', 1)
end

return _M


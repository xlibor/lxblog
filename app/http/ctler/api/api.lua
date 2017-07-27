
local lx, _M, mt = oo{
    _cls_ = ' ApiController'
}

local app, lf, tb, str = lx.kit()

function _M:result(result, code)

    code = code or 200
    
    return {code = code, data = result}
end

function _M:paging(pagination)

    return pagination
end

return _M


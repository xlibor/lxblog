
local lx, _M, mt = oo{
    _cls_ = ''
}

local app, lf, tb, str = lx.kit()

function _M:gather(context, view)

    local settings = XblogConfig.getArrayByTag('settings')
    tb.mergeTo(context, settings)
end

return _M


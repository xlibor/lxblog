
local lx, _M, mt = oo{
    _cls_ = ''
}

local app, lf, tb, str = lx.kit()
local abort = lx.h.abort

function _M:handle(ctx, next)

    local user = ctx.req.user
    if not user or not Ah.isAdmin(user) then
        -- abort(404)
    end
    
    return next(ctx)
end

return _M


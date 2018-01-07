
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller',
    _mix_ = 'lxlib.auth.authenticateUser'
}

local app, lf, tb, str = lx.kit()
local redirect = lx.h.redirect

function _M:ctor()

    self.redirectTo = '/blog'
    self:setBar('guest', {except = 'logout'})
end

function _M:logout(ctx)

    local request = ctx.req
    self:guard():logout()
    local session = request.session
    session:flush()
    session:regenerate()
    
    return redirect(self.redirectTo)
end

return _M


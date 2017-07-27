
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller',
    _mix_ = 'resetsPasswords'
}

local app, lf, tb, str = lx.kit()

function _M:ctor()

    self:setBar('guest')
end

return _M


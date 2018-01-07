
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'lxlib.auth.user',
    -- _mix_ = 'notifiable'
}

local app, lf, tb, str = lx.kit()
local jsde = lx.h.jsde

function _M:ctor()

	self.table = 'users'
    self.fillable = {'name', 'email', 'password', 'avatar'}
    self.hidden = {'password', 'remember_token'}
end

function _M:getMetaAttr(meta)

    local a = jsde(meta, true)
    
    return a or {}
end

function _M:setMetaAttr(meta)

    self.attrs['meta'] = jsen(meta)
end

function _M:posts()

    return self:hasMany('.app.model.post')
end

return _M


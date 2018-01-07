
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'model'
}

local app, lf, tb, str = lx.kit()

function _M:ctor()

	self.table = 'ips'
    self.timestamps = false
    self.fillable = {'id', 'user_id'}
    self.incrementing = false
    
end

function _M:comments()

    return self:hasMany('.app.model.comment')
end

function _M:user()

    return self:belongsTo('.app.model.user')
end

return _M


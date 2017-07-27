
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

    return self:hasMany(Comment)
end

function _M:user()

    return self:belongsTo(User)
end

return _M


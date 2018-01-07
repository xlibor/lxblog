
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'model'
}

local app, lf, tb, str = lx.kit()

function _M:ctor()

	self.table = 'categories'
	self.fillable = {'name'}
    
end

function _M:posts()

    return self:hasMany('.app.model.post')
end

return _M


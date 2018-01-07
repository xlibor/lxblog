
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'model'
}

local app, lf, tb, str = lx.kit()

function _M:ctor()

	self.table = 'tags'
	self.fillable = {'name'}
    
end

function _M:posts()

    return self:belongsToMany('.app.model.post')
end

return _M


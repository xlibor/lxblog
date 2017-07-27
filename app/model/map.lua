
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'model'
}

local app, lf, tb, str = lx.kit()

function _M:ctor()

	self.table = 'maps'
    self.timestamps = false
    self.fillable = {'key', 'value'}
end

return _M


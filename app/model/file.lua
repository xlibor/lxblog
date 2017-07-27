
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'model'
}

local app, lf, tb, str = lx.kit()

function _M:ctor()

	self.table = 'files'
	self.fillable = {'name', 'key', 'size', 'type'}

end

return _M


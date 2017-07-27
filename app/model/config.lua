
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'model'
}

local app, lf, tb, str = lx.kit()

local jsde = lx.h.jsde

function _M:ctor()

	self.table = 'configs'
    self.fillable = {'config'}
    self.timestamps = false
end

function _M:configable()

    return self:morphTo()
end

function _M:getConfigAttr(meta)

	if not meta then return {} end

    local a = jsde(meta)
    
    return a or {}
end

function _M:setConfigAttr(meta)

    self.attrs['config'] = jsen(meta)
end

return _M


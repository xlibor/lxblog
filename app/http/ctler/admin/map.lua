
local lx, _M, mt = oo{
    _cls_ = ' MapController',
    _ext_ = 'controller'
}

local app, lf, tb, str = lx.kit()

function _M:new()

    local this = {
        mapDoer = nil
    }
    
    return oo(this, mt)
end

function _M:ctor(mapDoer)

    self.mapDoer = mapDoer
end

function _M:store(request)

    self:validate(request, {
        key = 'required|unique:maps',
        value = 'required'
    })
    
    if self.mapDoer:create(request) then
        
        return back():with('success', '保存成功')
     else 
        
        return back():withErrors('保存失败')
    end
end

function _M:get(key)

    local map = self.mapDoer:get(key)
    if not map then
        abort(404)
    end
    
    return map
end

return _M



local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = {path = 'lxlib.routing.controller'},
    _mix_ = {'authorizeRequest', 'validateRequest'}
}

local app, lf, tb, str = lx.kit()

function _M:checkPolicy(ability, model, code)

    code = code or 403
    if Gate.denies(ability, model) then
        abort(code)
    end
end

function _M:jsonMsg(msg, code)

    code = code or 200
    msg = msg or ''
    
    local ctx = app:ctx()
    
    return ctx:json{code = code, msg = msg}
end

function _M:succeedJsonMsg(msg)

    msg = msg or ''
    
    return self:jsonMsg(msg, 200)
end

function _M:failedJsonMsg(msg)

    msg = msg or ''
    
    return self:jsonMsg(msg, 500)
end

return _M


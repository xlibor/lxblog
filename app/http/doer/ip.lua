
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'appDoer'
}

local app, lf, tb, str = lx.kit()

function _M:ctor()

    self._tag = 'ip'
end

function _M:createIfNotExisted(request)

    local ip = Ip.find(request:ip())
    local user_id = auth():id()
    if ip == nil then
        ip = new('ip' ,{id = request:ip(), user_id = user_id})
        ip:save()
     else 
        if user_id and user_id ~= ip.user_id then
            ip.user_id = user_id
            ip:save()
        end
    end
end

function _M:toggleBlock(ip_address)

    local ip = Ip.findOrFail(ip_address)
    ip.blocked = not ip.blocked
    
    return ip:save()
end

function _M:isBlocked(ip_address)

    local ip = Ip.find(ip_address)
    
    return ip ~= nil and ip.blocked
end

function _M:getOne(ip_address)

    return Ip.findOrFail(ip_address)
end

function _M:model()

    return app(IpDoer.class)
end

return _M


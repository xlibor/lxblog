
local lx, _M, mt = oo{
    _cls_ = ' IPController',
    _ext_ = 'controller'
}

local app, lf, tb, str = lx.kit()

function _M:new()

    local this = {
        ipDoer = nil
    }
    
    return oo(this, mt)
end

function _M:ctor(ipDoer)

    self.ipDoer = ipDoer
end

function _M:toggleBlock(ip)

    local action
    local ipInstance = self.ipDoer:getOne(ip)
    ipInstance.blocked = not ipInstance.blocked
    if ipInstance:save() then
        action = "Un Block"
        if ipInstance.blocked then
            action = "Block"
        end
        
        return back():with('success', "{action} {ip} successfully.")
    end
    
    return back():withErrors("Blocked {ip} failed.")
end

function _M:destroy(ip)

    ip = Ip.findOrFail(ip)
    if ip.blocked then
        
        return back():withErrors("UnBlocked {ip.id} firstly.")
    end
    local count = ip:comments():withTrashed():count()
    if (count) > 0 then
        
        return back():withErrors("{ip.id} has {count} comments.Please remove theme first.")
    end
    if ip:delete() then
        
        return back():with('success', "Delete {ip.id} successfully.")
    end
    
    return back():withErrors("Blocked {ip.id} failed.")
end

return _M


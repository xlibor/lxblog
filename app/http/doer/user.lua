
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'appDoer'
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self._tag = 'user'
end

function _M:model()

    return app(User)
end

function _M:get(name)

    local user = self:remember('user.one.' .. name, function()
        
        return new(User):where('name', name):firstOrFail()
    end)
    
    return user
end

function _M:update(request, user)

    user.description = request:get('description')
    user.website = request:get('website')
    user.real_name = request:get('real_name')
    local github_url = array_safe_get(user.meta, 'github')
    local exception = {'_token', 'description', 'website', 'real_name', 'name'}
    local meta = request:except(exception)
    if user.github_id then
        meta['github'] = github_url
    end
    user.meta = meta
    local result = user:save()
    if result then
        self:clearCache()
    end
    
    return result
end

return _M


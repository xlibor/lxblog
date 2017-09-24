
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor(userDoer, imageDoer)

    self.userDoer = new 'userDoer'
    self.imageDoer = new 'imageDoer'
    self:setBar('auth', {except = 'show'})
end

function _M:show(c, name)

    local user = self.userDoer:get(name)
    
    c:view('user.show', {user = user})
end

function _M:notifications()

    local notifications = auth():user().notifications
    
    return view('user.notifications', compact('notifications'))
end

function _M:update(request)

    local user = auth():user()
    self:checkPolicy('manager', user)
    self:validate(request, {description = 'max:66'})
    if self.userDoer:update(request, user) then
        
        return back():with('success', '修改成功')
    end
    
    return back():with('success', '修改失败')
end

function _M:uploadProfile(request)

    local user = auth():user()
    local milliseconds = getMilliseconds()
    local key = 'user/' .. user.name .. "/profile/{milliseconds}." .. request:file('image'):guessClientExtension()
    local url = self:uploadImage(user, request, key, 2048)
    if url then
        user.profile_image = url
    end
    if user:save() then
        self.userDoer:clearCache()
        
        return back():with('success', '修改成功')
    end
    
    return back():with('success', '修改失败')
end

function _M:uploadAvatar(request)

    local user = auth():user()
    local milliseconds = getMilliseconds()
    local key = 'user/' .. user.name .. "/avatar/{milliseconds}." .. request:file('image'):guessClientExtension()
    local url = self:uploadImage(user, request, key)
    if url then
        user.avatar = url
    end
    if user:save() then
        self.userDoer:clearCache()
        
        return back():with('success', '修改成功')
    end
    
    return back():with('success', '修改失败')
end

function _M.__:uploadImage(user, request, key, max, fileName)

    fileName = fileName or 'image'
    max = max or 1024
    self:checkPolicy('manager', user)
    self:validate(request, {fileName = 'required|image|mimes:jpeg,jpg,png|max:' .. max})
    local image = request:file(fileName)
    
    return self.imageDoer:uploadImage(image, key)
end

return _M


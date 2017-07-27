
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()
local redirect, back = lx.h.redirect, lx.h.back

function _M:ctor()

    self.pageDoer = new 'pageDoer'
end

function _M:create(c)

    return c:view('admin.page.create')
end

function _M:store(request)

    self:validate(request, {name = 'required|unique:pages', display_name = 'required', content = 'required'})
    if self.pageDoer:create(request) then
        
        return redirect():route('admin.index')
            :with('success', '页面' .. request.name .. '创建成功')
    end
    
    return back():withInput()
        :with('error', '页面' .. request.name .. '创建失败')
end

function _M:pageShowing(page)

    local comment
    local unreadNotifications
    local user
    if auth():check() then
        user = auth():user()
        unreadNotifications = user.unreadNotifications
        for _, notifications in pairs(unreadNotifications) do
            comment = notifications.data
            if comment['commentable_type'] == 'App\\Page' and comment['commentable_id'] == page.id then
                notifications:markAsRead()
            end
        end
    end
end

function _M:edit(c, page)

    page = new(Page):find(page)

    return c:view('admin.page.edit', {page = page})
end

function _M:update(c, page)

    local request = c.req

    self:validate(request, {
        name = 'required',
        display_name = 'required',
        content = 'required'
    })

    if self.pageDoer:update(request, page) then
        
        return redirect():route('admin.pages')
            :with('success', '页面' .. request.name .. '修改成功')
    end
    
    return back():withInput()
        :withErrors('页面' .. request.name .. '修改失败')
end

function _M:destroy(id)

    self.pageDoer:clearCache()
end

return _M


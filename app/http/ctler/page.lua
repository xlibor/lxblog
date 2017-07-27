
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'controller',
    _mix_ = 'pageHelper'
}

local app, lf, tb, str, new = lx.kit()
local auth, abort = lx.h.auth, lx.h.abort

function _M:ctor()

    self.pageDoer       = new 'pageDoer'
    self.commentDoer    = new 'commentDoer'
end

function _M:show(c, name)

    local page = self.pageDoer:get(name)

    if not self:shouldShow(page) then
        -- abort(404)
    end
    
    self:onPageShowing(page)
    local comments = self.commentDoer:getByCommentable(Page.__cls, page.id
    )
    
    return c:view('page.show', {page = page, comments = comments})
end

function _M.__:onPageShowing(page)

    local comment
    local unreadNotifications
    local user

    if auth():check() then
        user = auth():user()
        -- unreadNotifications = user.unreadNotifications
        -- for _, notifications in pairs(unreadNotifications) do
        --     comment = notifications.data
        --     if comment['commentable_type'] == 'App\\Page' and comment['commentable_id'] == page.id then
        --         notifications:markAsRead()
        --     end
        -- end
    end
end

return _M


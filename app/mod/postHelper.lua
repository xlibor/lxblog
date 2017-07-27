
local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str = lx.kit()

local auth = lx.h.auth

function _M:onPostShowing(post)

    local comment
    local unreadNotifications

    local user = auth():user()

    if not Ah.isAdmin(user) then
        post:increment('view_count')
    end
    
    -- if auth():check() then
    --     unreadNotifications = user.unreadNotifications
    --     for _, notifications in pairs(unreadNotifications) do
    --         comment = notifications.data
    --         if comment['commentable_type'] == '.app.model.post'
    --             and comment['commentable_id'] == post.id then

    --             notifications:markAsRead()
    --         end
    --     end
    -- end
end

return _M


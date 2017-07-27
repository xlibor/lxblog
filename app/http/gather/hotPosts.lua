
local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self.postDoer = new 'postDoer'
end

function _M:gather(context, view)

    local hotPosts = self.postDoer
        :hotPosts(XblogConfig.getValue('hot_posts_count', 5))
        :col():sortBy(function(post, key)
        
        return -(post.view_count + post.comments_count)
    end)

    context.hotPosts = hotPosts
end

return _M


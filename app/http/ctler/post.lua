
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'controller',
    _mix_ = 'postHelper',
}

local app, lf, tb, str, new = lx.kit()
local Post = lx.use('.app.model.post')

function _M:ctor()

    self.postDoer = new('postDoer')
    self.commentDoer = new('commentDoer')
end

function _M:index(c)

    -- echo( Post.findOrFail(11) )

    local page_size = XblogConfig.getValue('page_size', 7)
    local posts = self.postDoer:pagedPosts(page_size)
 
    c:view('post.index', {posts = posts})
end

-- show post by slug
-- @param   object      c
-- @param   string      slug
-- @return  view|null

function _M:show(c, slug)

    local post = self.postDoer:get(slug)

    local recommendedPosts = self.postDoer:recommendedPosts(post)
    local comments = self.commentDoer:getByCommentable(Post.__cls, post.id)

    self:onPostShowing(post)

    c:view('post.show', Compact(
        'post', 'comments', 'recommendedPosts'
    ))

end

return _M


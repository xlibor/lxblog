
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'controller',
    _mix_ = 'postHelper',
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self.postDoer = new('postDoer')
    self.commentDoer = new('commentDoer')
end

function _M:index(c)

    local page_size = XblogConfig.getValue('page_size', 7)
    local posts = self.postDoer:pagedPosts(page_size)
 
    return c:view('post.index', {posts = posts})
end

-- show post by slug
-- @param   object      c
-- @param   string      slug
-- @return  view|null

function _M:show(c, slug)

    -- if t then
    --     Log.debug('user:' .. t.name)
    -- end

    local post = self.postDoer:get(slug)

    local recommendedPosts = self.postDoer:recommendedPosts(post)
    local comments = self.commentDoer:getByCommentable(Post.__cls, post.id)
    self:onPostShowing(post)

    c:view('post.show', Compact(
        'post', 'comments', 'recommendedPosts'
    ))

end


-- @param mixed|null id
-- @param num age
-- @param num sex

function _M:test111(id, age, sex)

end

    -- dd(Dt.now():fmt('Y-m-d H:i:s'))

    -- Log.debug('url:' .. c.fullUri, c.all)

return _M



local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()
local back = lx.h.back

function _M:ctor(postDoer)

    self.postDoer = new 'postDoer'
end

function _M:index(c)

    c:view('index')
end

function _M:search(c)

    local request = c.req

    local key = str.trim(request:get('q'))
    if key == '' then
        
        return back():withErrors("请输入关键字")
    end
    local pageSize = XblogConfig.getValue('page_size', 7)
    key = '%' .. key .. '%'

    local posts = new(Post)
        :where('title', 'like', key)
        :orWhere('description', 'like', key)
        :with({'tags', 'category'})
        :withCount('comments')
        :orderBy('view_count', 'desc')
        :paging(pageSize)

    posts:appends(request:except('page'))

    c:view('search', {posts = posts})
end

function _M:projects(c)

    c:view('projects')
end

function _M:achieve(c)

    local posts = self.postDoer:achieve()
    local posts_count = self.postDoer:postCount()
    
    c:view('achieve', {posts = posts, posts_count = posts_count})
end

return _M


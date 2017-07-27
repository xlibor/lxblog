
local lx, _M, mt = oo{
    _cls_ = ' PostController',
    _ext_ = 'apiController'
}

local app, lf, tb, str = lx.kit()

function _M:new()

    local this = {
        postDoer = nil
    }
    
    return oo(this, mt)
end

function _M:ctor(postDoer)

    self.postDoer = postDoer
end

function _M:index()

    return self:result(Post.select({'slug', 'title', 'description', 'posts.created_at', 'categories.name as categoryName'}):leftJoin('categories', 'posts.category_id', '=', 'categories.id'):orderBy('posts.created_at', 'desc'):get())
end

function _M:html()

    local post = Post.select('html_content'):where('slug', request('slug')):first()
    if post == nil then
        
        return self:result('not found', 404)
    end
    
    return self:result(post.html_content)
end

return _M


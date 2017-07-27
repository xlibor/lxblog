
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'appDoer',
    selectArrayWithOutContent = {
        'id', 'user_id', 'category_id', 'title',
        'slug', 'description', 'created_at', 'status'
    }
}

local app, lf, tb, str, new = lx.kit()

local request, abort = lx.h.request, lx.h.abort
local auth = lx.h.auth

function _M:ctor(markDownParser)

    self.markDownParser = new 'markDownParser'
    self._tag = 'post'
end

function _M:model()

    return new(Post)
end

function _M:count()

    local count = self:remember(self:tag() .. '.count', function()
        
        return self:model():pure():count()
    end)
    
    return count
end

function _M:pagedPostsPure(page)

    page = page or 20
    local req = request()
    local key = 'post.WithOutContent.' .. page .. '' .. req:get('page', 1)
    local status = req:get('status', -1)
    local deleted = req:get('deleted', -1)

    local posts = self:remember(key, function()
        
        local q = new(Post):pure()
            :orderBy{'created_at', 'desc'}
            :select('id', 'title', 'slug', 'deleted_at',
                'published_at', 'status'
            )
        if status >= 0 then
            q:where{status = status}
        end
        if deleted  == 1 then
            q:notNull('deleted_at')
        end
        
        return q:paging(page)
    end)
    
    return posts
end

function _M:pagedPosts(pageSize)

    pageSize = pageSize or 7
    local page = request('page', 1)

    local key = 'post.page.' .. pageSize .. '.' .. page

    local posts = self:remember(key, function()
        
        return new(Post):pick(self.selectArrayWithOutContent)
            :with({'tags', 'category'}):withCount('comments')
            :orderBy{'created_at', 'desc'}
            :paging(pageSize)
    end)

    return posts
end

function _M:get(slug)

    local post = self:remember('post.one.' .. slug, function()
        
        return new(Post):where('slug', slug)
            :with({'tags', 'category', 'config'})
            :withCount('comments'):firstOrFail()
    end)
    
    return post
end

function _M:hotPosts(count)

    count = count or 5
    local posts = self:remember('post.achieve.' .. count, function()
        
        return new(Post):select('title', 'slug', 'view_count')
            :withCount('comments')
            :orderBy{'view_count', 'desc'}
            :limit(count):get()
    end)

    return posts
end

function _M:achieve()

    local posts = self:remember('post.achieve', function()
        
        return new(Post)
            :select('id', 'title', 'slug', 'created_at')
            :orderBy('created_at', 'desc')
            :get()
    end)
    
    return posts
end

function _M:recommendedPosts(post)

    local ret = self:remember('post.recommend.' .. post.slug, function()
        local category = post('category')
        local tags = {}
        for _, tag in pairs(post('tags')) do
            tb.push(tags, tag.name)
        end
        local recommendedPosts = new(Post)
            :where('category_id', category.id)
            :where('id', '<>', post.id)
            :orderBy('view_count', 'desc')
            :pick(self.selectArrayWithOutContent):limit(5):get()
        
        return recommendedPosts
    end)
    
    return ret
end

function _M:postCount()

    local count = self:remember('post-count', function()
        
        return new(Post):count()
    end)
    
    return count
end

function _M:getWithoutContent(post_id)

    local post = self:remember('post.one.wc.' .. post_id, function()
        
        return new(Post):where('id', post_id)
            :pick(self.selectArrayWithOutContent):first()
    end)

    if not post then
        abort(404)
    end
    
    return post
end

function _M:create(request)

    local tag
    self:clearAllCache()
    local ids = {}
    request:nestArgs()
    local tags = request.tags
    if not lf.isEmpty(tags) then
        for _, tagName in pairs(tags) do
            tag = new(Tag):firstOrCreate({name = tagName})
            tb.push(ids, tag.id)
        end
    end

    local status = request:get('status', 0)
    if status == 1 then
        request.published_at = lf.datetime()
    end
    local post = auth():user():posts():create(
        tb.merge(
            request:except('_token', 'description'),
            {
                html_content = self.markDownParser:parse(
                    request:get('content'), false
                ),
                description = self.markDownParser:parse(
                    request:get('description'), false
                )
            }
        )
    )

    post:tags():sync(ids)
    post:saveConfig(request.all)
    
    return post
end

function _M:update(request, post)

    local tag
    self:clearAllCache()
    request:nestArgs()

    local tags = request.tags
    local ids = {}

    if not lf.isEmpty(tags) then
        for _, tagName in ipairs(tags) do
            tag = new(Tag):firstOrCreate({name = tagName})
            tb.push(ids, tag.id)
        end
    end

    post:tags():sync(ids)
    local status = request:get('status', 0)
    if status == 1 then
        request.published_at = lf.datetime()
    end
    post:saveConfig(request.all)

    local html_content = self.markDownParser:parse(
        request:get('content'), false
    )

    return post:update(tb.merge(
            request:except('_token'
        ),
        {
            html_content = html_content
        })
    )
end

return _M


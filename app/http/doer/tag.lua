
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'appDoer'
}

local app, lf, tb, str, new = lx.kit()

local request = lx.h.request

function _M:ctor()

    self._tag = 'tag'
end

function _M:model()

    return new(Tag)
end

function _M:getAll()

    local tags = self:remember('tag.all', function()
        
        return new(Tag):withCount('posts'):get()
    end)
    
    return tags
end

function _M:get(name)

    local tag = self:remember('tag.one.' .. name, function()
        
        return new(Tag):where{name = name}:firstOrFail()
    end)
    
    return tag
end

function _M:pagedPostsByTag(tag, page)

    page = page or 7

    local key = 'tag.posts.' .. tag.name .. page .. request():get('page', 1)
    local posts = self:remember(key, function()

        return tag:posts()
            :pick(Post.static.selectArrayWithOutContent)
            :with({'tags', 'category'}):withCount('comments')
            :orderBy('created_at', 'desc')
            :paging(page)
    end)
    
    return posts
end

function _M:create(request)

    self:clearCache()
    local tag = new(Tag):create({name = request.name})
    
    return tag
end

return _M


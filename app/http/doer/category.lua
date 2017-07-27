
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'appDoer'
}

local app, lf, tb, str, new = lx.kit()

local request = lx.h.request

local redirect, back, abort = lx.h.kit()

function _M:ctor()

    self._tag = 'category'
end

function _M:model()

    return new(Category)
end

function _M:getAll()

    local categories = self:remember('category.all', function()
        
        return new(Category):withCount('posts'):get()
    end)
    
    return categories
end

function _M:get(name)

    local category = self:remember('category.one.' .. name, function()
        
        return new(Category):where{name = name}:firstOrFail()
    end)
    if not category then
        abort(404)
    end
    
    return category
end

function _M:pagedPostsByCategory(category, pageSize)

    pageSize = pageSize or 7
    local page = request():get('page', 1)
    local key = 'category.posts.' .. category.name .. pageSize .. page
    local posts = self:remember(key, function()

        return category:posts()
            :pick(Post.static.selectArrayWithOutContent)
            :with({'tags', 'category'})
            :withCount('comments')
            :orderBy('created_at', 'desc')
            :paging(pageSize)
    end)
    
    return posts
end

function _M:create(request)

    self:clearCache()
    local category = new(Category):create({name = request.name})
    
    return category
end

function _M:update(request, category)

    self:clearCache()
    
    return category:update(request.all)
end

return _M


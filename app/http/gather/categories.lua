
local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self.categoryDoer = new 'categoryDoer'
end

function _M:gather(context, view)

    local categories = self.categoryDoer
        :getAll():col():reject(function(category)
        
        return category.posts_count == 0
    end)

    context.categories = categories
end

return _M


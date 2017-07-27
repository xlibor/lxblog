
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self.doer = new 'categoryDoer'
end

function _M:index(c)

    return c:view('category.index')
end

function _M:show(c, name)

    local category = self.doer:get(name)

    local page_size = XblogConfig.getValue('page_size', 7)

    local posts = self.doer:pagedPostsByCategory(category, page_size)

    return c:view('category.show', {
        posts = posts, name = name
    })
end

return _M


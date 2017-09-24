
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self.tagDoer = new 'tagDoer'
end

function _M:index(c)

    c:view('tag.index')
end

function _M:show(c, name)

    local tag = self.tagDoer:get(name)
    local page_size = XblogConfig.getValue('page_size', 7)
    local posts = self.tagDoer:pagedPostsByTag(tag, page_size)
    
    c:view('tag.show', {posts = posts, name = name})
end

return _M



local lx, _M, mt = oo{
    _cls_ = ' GeneratedController',
    _ext_ = 'controller'
}

local app, lf, tb, str = lx.kit()

function _M:new()

    local this = {
        xblogCache = nil
    }
    
    return oo(this, mt)
end
const tag = 'generated'
function _M:index()

    local view = self:getXblogCache():remember('generated.sitemap', function()
        posts = Post.select({'slug', 'updated_at'}):orderBy('created_at', 'desc'):get()
        pages = Page.select({'id', 'name', 'display_name', 'updated_at'}):with('config'):get():reject(function(page)
            result = page.config and page.config.config['display'] or 'false'
            
            return result == 'false'
        end)
        
        return view('generated.sitemap', compact('posts', 'pages')):render()
    end)
    
    return response(view):header('Content-Type', 'text/xml')
end

function _M:feed()

    local view = self:getXblogCache():remember('generated.feed', function()
        posts = Post.select(Post.static.selectArrayWithOutContent):orderBy('created_at', 'desc'):with('category', 'user'):get()
        
        return view('generated.feed', compact('posts')):render()
    end)
    
    return response(view):header('Content-Type', 'text/xml')
end

function _M.__:getXblogCache()

    if self.xblogCache == nil then
        self.xblogCache = app('XblogCache')
        self.xblogCache:setTag(GeneratedController.tag)
        self.xblogCache:setTime(60 * 24)
    end
    
    return self.xblogCache
end

return _M


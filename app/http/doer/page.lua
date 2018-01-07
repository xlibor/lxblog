
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'appDoer'
}

local app, lf, tb, str, new = lx.kit()
local abort = lx.h.abort

local Page = lx.use('.app.model.page')

function _M:ctor()

    self._tag = 'page'
    self.parseDown = new('parseDown')
end

function _M:model()

    return app(Page)
end

function _M:get(name)

    local page = self:remember('page.one.' .. name, function()

        return new(Page):where('name', name)
            :with('config'):withCount({'comments'})
            :first()
    end)
    if not page then
        abort(404)
    end
    
    return page
end

function _M:getAll()

    local page = self:remember('page.all', function()

        return new(Page):select('id', 'name', 'display_name'):with('config'):get()
    end)

    if not page then
        abort(404)
    end

    return page
end

function _M:create(c)

    local request = c.req

    self:clearCache()
    local page = new(Page):create(
        tb.merge(request:except('_token'), {
            html_content = self.parseDown:text(request:get('content'))
        })
    )
    page:saveConfig(request.all)
    
    return page
end

function _M:update(request, pageId)

    page = Page.find(pageId)
    self:clearCache()
    page:saveConfig(request.all)
    
    return page:update(
        tb.merge(request:except('_token'), {
            html_content = self.parseDown:text(request:get('content'))
        })
    )
end

return _M



local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self.pageDoer = new 'pageDoer'
end

function _M:gather(context, view)

    local pages = self.pageDoer:getAll()

    if #pages > 0 then
        pages = pages:Col()
        local result, config
        pages:reject(function(page)
            config = page('config')
            result = config and config['display'] or 'false'
            
            return result == 'false'
        end):sortBy(function(page, key)
            config = page('config')
            result = config and config['sort_order'] or 1
            
            return -result
        end)
    end

    context.pages = pages
end

return _M



local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor(tagDoer)

    self.tagDoer = new 'tagDoer'
end

function _M:gather(context, view)

    local tags = self.tagDoer:getAll():col():reject(function(tag)

        return tonumber(tag.posts_count) == -1
    end)

    context.tags = tags
end

return _M



local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:create('post_tag', function(table)
        table:bigInteger('post_id'):unsigned()
        table:bigInteger('tag_id'):unsigned()
        table:primary({'post_id', 'tag_id'})
    end)
end

function _M:down(schema)

    schema:drop('post_tag')
end

return _M


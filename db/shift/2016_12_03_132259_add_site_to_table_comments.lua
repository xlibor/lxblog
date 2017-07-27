
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:table('comments', function(table)
        table:string('site'):nullable()
    end)
end

function _M:down(schema)

    schema:table('comments', function(table)
        table:dropColumn('site')
    end)
end

return _M


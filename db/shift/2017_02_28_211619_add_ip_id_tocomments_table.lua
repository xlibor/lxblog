
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()

function _M:up(schema)

    schema:table('comments', function(table)
        table:string('ip_id', 128):nullable():index()
    end)
end

function _M:down(schema)

    schema:table('comments', function(table)
        table:dropColumn('ip_id')
    end)
end

return _M


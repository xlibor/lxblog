
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:create('maps', function(table)
        table:increments('id')
        table:string('key'):unique()
        table:string('tag'):index()
        table:text('value'):nullable(true)
        table:text('meta'):nullable(true)
    end)
end

function _M:down(schema)

    schema:dropIfExists('maps')
end

return _M



local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:create('configs', function(table)
        table:increments('id')
        table:integer('configable_id'):unsigned():index()
        table:string('configable_type'):index()
        table:string('config'):nullable(true)
    end)
end

function _M:down(schema)

    schema:dropIfExists('configs')
end

return _M


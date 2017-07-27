
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()

function _M:up(schema)

    schema:create('cache', function(table)

        table:string('key'):unique()
        table:mediumBlob('value')
        table:integer('expiration')
    end)
end

function _M:down(schema)

    schema:drop('cache')
end

return _M


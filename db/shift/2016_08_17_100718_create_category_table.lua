
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()

function _M:up(schema)

	schema:create('categories', function(table)
        table:bigIncrements('id')
        table:timestamps()
        table:string('name'):unique()
    end)
end

function _M:down(schema)

    schema:drop('categories')
end

return _M


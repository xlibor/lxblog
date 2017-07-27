
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:create('files', function(table)
        table:bigIncrements('id')
        table:string('name')
        table:string('key'):unique()
        table:string('type'):index()
        table:integer('size')
        table:timestamps()
    end)
end

function _M:down(schema)

    schema:dropIfExists('files')
end

return _M


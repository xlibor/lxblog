
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:create('pages', function(table)
        table:bigIncrements('id')
        table:timestamps()
        table:string('name'):unique()
        table:string('display_name')
        table:longText('content')
        table:longText('html_content'):nullable(false)
    end)
end

function _M:down(schema)

    schema:drop('pages')
end

return _M


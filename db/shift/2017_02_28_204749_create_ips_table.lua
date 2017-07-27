
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:create('ips', function(table)
        table:string('id', 128):primary()
        table:boolean('blocked'):default(false)
    end)
end

function _M:down(schema)

    schema:dropIfExists('ips')
end

return _M


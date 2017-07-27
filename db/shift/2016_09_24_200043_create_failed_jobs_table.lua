
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:create('failed_jobs', function(table)
        table:increments('id')
        table:text('connection')
        table:text('queue')
        table:longText('payload')
        table:longText('exception')
        table:timestamp('failed_at'):useCurrent()
    end)
end

function _M:down(schema)

    schema:dropIfExists('failed_jobs')
end

return _M


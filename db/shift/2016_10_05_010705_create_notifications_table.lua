
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:create('notifications', function(table)
        table:string('id'):primary()
        table:string('type')
        table:morphs('notifiable')
        table:text('data')
        table:timestamp('read_at'):nullable()
        table:timestamps()
    end)
end

function _M:down(schema)

    schema:dropIfExists('notifications')
end

return _M



local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()
function _M:up(schema)

    schema:create('comments', function(table)
        table:increments('id')
        table:integer('user_id'):index():nullable(true)
        table:integer('commentable_id'):index()
        table:text('content'):nullable(false)
        table:text('html_content'):nullable(false)
        table:string('commentable_type'):index()
        table:string('username')
        table:string('email')
        table:softDeletes()
        table:timestamps()
    end)
end

function _M:down(schema)

    schema:dropIfExists('comments')
end

return _M


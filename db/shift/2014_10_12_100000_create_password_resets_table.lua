
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()

function _M:up(schema)

	schema:create('password_resets', function(table)
        table:string('email'):index()
        table:string('token'):index()
        table:timestamp('created_at'):nullable()
    end)
end

function _M:down(schema)

	schema:drop('password_resets')
end

return _M


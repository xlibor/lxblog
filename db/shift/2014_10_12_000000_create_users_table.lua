
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()

function _M:up(schema)

    schema:create('users', function(table)
        table:increments('id')
        table:string('name'):unique()
        table:string('email'):unique()
        table:string('password')
        table:string('register_from'):default('web_form'):index()
        table:integer('github_id'):index():nullable(true)
        table:string('github_name'):index():nullable(true)
        table:string('website'):nullable(true)
        table:string('real_name'):nullable(true)
        table:string('description'):nullable(true)
        table:text('meta'):nullable(true)
        table:string('avatar'):nullable(true)
        table:string('profile_image'):nullable(true)
        table:rememberToken()
        table:timestamps()
    end)
end

function _M:down(schema)

    schema:drop('users')
end

return _M


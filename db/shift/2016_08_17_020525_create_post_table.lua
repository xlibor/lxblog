
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'shift'
}

local app, lf, tb, str = lx.kit()

function _M:up(schema)

    schema:create('posts', function(table)
        table:bigIncrements('id')
        table:bigInteger('user_id'):unsigned():index()
        table:bigInteger('category_id'):unsigned():index()
        table:string('title'):nullable(false)
        table:string('description'):nullable(false)
        table:string('slug'):unique()
        table:longText('content'):nullable(false)
        table:longText('html_content'):nullable(false)
        table:tinyInteger('status'):default(0)
        table:integer('view_count'):unsigned():default(0)
        table:timestamps()
        table:timestamp('published_at'):nullable():index()
        table:softDeletes()
    end)
end

function _M:down(schema)

    schema:drop('posts')
end

return _M


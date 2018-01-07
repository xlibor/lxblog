
local lx, _M = oo{
	_cls_ = '',
	_ext_ = 'seeder'
}

local app, lf, tb, str, new = lx.kit()

local Model = lx.use('model')

local fair = lx.h.fair
local rand = lf.random

function _M:run()

	new(Post):truncate()
	new(Category):truncate()
	new(Tag):truncate()

    Model.unguard()

    local cats = {'Android', 'Java', 'Php', 'Spring', 'Laravel'}
    for _, v in ipairs(cats) do
        fair(Category):create({name = v})
    end

    fair(Tag, 10):create()
    local tag_ids = new(Tag):all()
    fair(User, 10):create():each(function(u)
        fair(Post, rand(2, 10))
        	:make({category_id = rand(1, 5)})
        	:each(function(post)
                
	            local p = u:posts():save(post)
	            local count = rand(1, 4)
	            local ids = {}
	            for i = 1, count do
	                tb.push(ids, tag_ids[rand(1, 9)].id)
	            end
	            p:tags():sync(ids)
            end)
    end)
end

return _M


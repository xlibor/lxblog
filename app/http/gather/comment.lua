
local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str, new = lx.kit()

local route, request = lx.h.route, lx.h.request

function _M:ctor()

end

function _M:touch(context, view)

    local post, page = context.post, context.page
    local data
    if post then
		data = {
			comment_key = post.slug,
			comment_title = post.title,
			comment_url = route('post.show', post.slug),
			commentable = post,
			comments = comments or {},
			redirect = request().fullUrl,
			commentable_type = Post.__cls
		}
	elseif page then
		data = {
        	comment_key = 'page.' .. page.name,
        	comment_title = page.display_name,
        	comment_url = route('page.show', page.name),
        	commentable = page,
        	comments = comments or {},
        	redirect = request().fullUrl,
        	commentable_type = Page.__cls
    	}
	end

	tb.mergeTo(context, data)
end

return _M


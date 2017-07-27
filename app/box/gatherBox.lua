
local lx, _M = oo{
	_cls_	= '',
	_ext_ 	= 'box'
}

local app, lf, tb, str = lx.kit()

function _M:reg()

	app:bindNs('.app.http.gather', lx.dir('app', 'http/gather'))

end

function _M:boot()

	local view = app.view

    view:gather('widget.categories', 	'.app.http.gather.categories')
    view:gather('widget.hot_posts', 	'.app.http.gather.hotPosts')
    view:gather('widget.tags', 			'.app.http.gather.tags')
    view:touch('widget.comment', 		'.app.http.gather.comment')
    view:gather({'index', 'layouts.header'}, '.app.http.gather.pages')
    view:gather('*', 					'.app.http.gather.settings')
end

return _M


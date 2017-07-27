
local lx, _M = oo{
	_cls_	= '',
	_ext_ 	= 'box'
}

local app, lf, tb, str, new = lx.kit()

function _M:reg()

	app:bind('context', '.app.http.context')
	app:bind('controller', '.app.http.ctler.controller')
	app:bind('exception.handler', '.app.excp.handler')

	app:single('.app.http.bar.verifyCsrfToken')
	app:single('.app.http.bar.redirectIfAuthenticated')
	app:single('.app.http.bar.admin')

	app:bind('appDoer', '.app.http.doer.doer')
	app:bind('fileDoer', '.app.http.doer.file')
	
	app:bindNs('.app.http.doer', lx.dir('app', 'http/doer'), {
		except = {'doer', 'file'}, suffix = 'Doer'
	})

	app:bindNs('.app.mod', lx.dir('app', 'mod'), {
		except = {'nocache', 'file'}, name = true
	})

	app:bind('xblogCache', '.app.mod.cacheable')

	app:single('appHelper', '.app.mod.appHelper')
	
	app:single('xblogConfig', function()
		
		return new('mapDoer')
	end)
end

function _M:boot()

	local custom = app:get('view.blade.custom')
end

return _M


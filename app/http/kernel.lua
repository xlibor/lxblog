
local _M = {
	_cls_ = '',
	_ext_ = {
		path = 'lxlib.http.kernel'
	},
	bars = {
	},
	routeBars = {
		{'auth', 		'lxlib.auth.bar.authenticate'},
		{'auth.basic', 	'lxlib.auth.bar.authenticateWithBasicAuth'},
		{'can', 		'lxlib.auth.bar.authorize'},
		{'guest', 		'.app.http.bar.redirectIfAuthenticated'},
		{'admin',		'.app.http.bar.admin'}
	},
	barGroup = {
		web = {
			'lxlib.cookie.bar.addToResponse',
			'lxlib.session.bar.startSession',
			'lxlib.view.bar.shareErrorsFromSession',
			'.app.http.bar.verifyCsrfToken'
		}
	}
}

function _M:ctor()

	self:initBars()
end

return _M


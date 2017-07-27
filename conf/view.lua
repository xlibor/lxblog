
local lx = require('lxlib')
local env, app = lx.env, lx.app()

local conf = {
	engine	= 'blade',
	paths	= {
		lx.dir('res', 'view'),
	},
	cache	= lx.dir('tmp', 'view'),
	extension = 'html',
	tags = {
		twig = {
			-- signBegin = '{', signEnd = '}'
		}
	}
}

return conf
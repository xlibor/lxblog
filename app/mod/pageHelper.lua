
local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str = lx.kit()
local auth = lx.h.auth

function _M:shouldShow(page)

	if not page then

		return false
	end

    if Ah.isAdminById(auth():id()) then
        
        return true
    end
    local config = page('config')

    if config and config.display == 'true' then

        return true
    end
    
    return false
end

return _M


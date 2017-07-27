
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'model',
    _mix_ = {'commentHelper', 'configHelper'}
}

local app, lf, tb, str = lx.kit()

function _M:ctor()

    self.table = 'pages'
    self.fillable = {'name', 'display_name',
    	'content', 'html_content'
    }
    
end

function _M:comments()

    return self:morphMany(Comment, 'commentable')
end

function _M:config()

    return self:morphOne(Config, 'configable')
end

function _M:getConfigKeys()

    return {'allow_resource_comment', 'comment_type',
    	'comment_info', 'display', 'sort_order'
    }
end

return _M



local lx, _M = oo{
    _cls_ = ''
}

local app, lf, tb, str = lx.kit()

function _M:getCommentInfo()

    local cfg = self('config')

    local config = cfg and cfg.config

    if not config then
        config = {
            comment_info = 'default',
            comment_type = 'default'
        }
    end
    
    return config
end

function _M:isShownComment()

    local config = self:getCommentInfo()

    return config['comment_info'] ~= 'force_disable'
        and config['comment_info'] == 'force_enable'
        or XblogConfig.getValue('comment_type') ~= 'none'

end

function _M:allowComment()

    local allow_resource_comment = self:getConfig('allow_resource_comment', 'default')
    
    return allow_resource_comment == 'default' and XblogConfig.getBoolValue('allow_comment', true) or self:getBoolConfig('allow_resource_comment', true)
end

function _M:getCommentType()

    local comment_type = XblogConfig.getValue('comment_type', 'raw')
    local commentable_config = self:getCommentInfo()['comment_type']
    
    return commentable_config == 'default' and comment_type or commentable_config
end

return _M


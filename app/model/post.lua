
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'model',
    _mix_ = {'softDelete', 'commentHelper', 'configHelper'},

    _static_ = {
        selectArrayWithOutContent = {
            'id', 'user_id', 'category_id', 'title',
            'slug', 'view_count', 'description', 'updated_at',
            'created_at', 'status'
        }
    }
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self.table = 'posts'
    self.dates = {'deleted_at', 'published_at'}

    self.fillable = {
        'title', 'description', 'slug',
        'category_id', 'user_id', 'content', 'published_at',
        'status', 'html_content'
    }

end

function _M.__:boot()

    self:__super('boot')
    self:addGlobalScope(new('publishedScope'))
end

function _M:category()

    return self:belongsTo('.app.model.category')
end

function _M:tags()

    return self:belongsToMany('.app.model.tag')
end

function _M:user()

    return self:belongsTo('.app.model.user')
end

function _M:comments()

    return self:morphMany('.app.model.comment', 'commentable')
end

function _M:config()

    return self:morphOne('.app.model.config', 'configable')
end

function _M:isPublished()

    return self.status == 1
end

function _M:getConfigKeys()

    return {'allow_resource_comment', 'comment_type', 'comment_info'}
end

return _M


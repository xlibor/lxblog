
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'appDoer'
}

local app, lf, tb, str, new = lx.kit()
local abort, request = lx.h.abort, lx.h.request

function _M:ctor()

    self._tag = 'comment'
    self.mention = new 'mention'
    self.markdownParser = new 'markDownParser'
end

function _M:model()

    return new(Comment)
end

function _M:count()

    local count = self:remember(self:tag() .. '.count', function()
        
        return self:model():withTrashed():count()
    end)
    
    return count
end

function _M.__:getCacheKey(commentable_type, commentable_id)

    return commentable_type .. '.' .. commentable_id .. 'comments'
end

function _M:getByCommentable(commentable_type, commentable_id)

    local key = self:getCacheKey(commentable_type, commentable_id)
    local comments = self:remember(key, function()
        local commentable = app(commentable_type):where('id', commentable_id):select({'id'}):firstOrFail()
        
        return commentable:comments():with('user'):orderBy{'id', 'asc'}:get()
    end)
    
    return comments
end

function _M:getAll(page)

    page = page or 20
    local comments = self:remember('comment.page.' .. page .. '' .. request():get('page', 1), function()
        
        return new(Comment):pure():orderBy{'created_at', 'desc'}:paging(page)
    end)
    
    return comments
end

function _M:create(request)

    local user
    self:clearCache()
    local comment = new(Comment)
    local commentable_id = request:get('commentable_id')
    local commentable = app(request:get('commentable_type')):where('id', commentable_id):firstOrFail()
    if not commentable:isShownComment() or not commentable:allowComment() then
        abort(403)
    end
    if Auth.check() then
        user = Auth.user()
        comment.user_id = user.id
        comment.username = user.name
        comment.email = user.email
     else 
        comment.username = request:get('username')
        comment.email = request:get('email')
        comment.site = request:get('site')
    end
    local content = request:get('content')
    comment.ip_id = request.ip

    comment.content = self.mention:parse(content)
    comment.html_content = self.markdownParser:parse(comment.content)
    local result = commentable:comments():save(comment)
    
    self.mention:mentionUsers(comment, Ah.getMentionedUsers(content), content)
    
    return result
end

function _M:update(content, comment)

    comment.content = self.mention:parse(content)
    comment.html_content = self.markdownParser:parse(comment.content)
    local result = comment:save()
    if result then
        self:clearCache()
    end
    
    return result
end

function _M:delete(comment, force)

    force = force or false
    self:clearCache()
    if force then
        
        return comment:forceDelete()
    end
    
    return comment:delete()
end

return _M


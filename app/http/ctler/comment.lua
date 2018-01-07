
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()
local redirect, back, abort = lx.h.kit()

local Comment = lx.use('.app.model.comment')

function _M:ctor()

    self.commentDoer = new 'commentDoer'
end

function _M:edit(c, id)

    local comment = Comment.find(id)
    c:view('comment.edit', {comment = comment})
end

function _M:update(c, id)

    local comment = Comment.find(id)
    local request = c.req
    local rdTo
    -- self:checkPolicy('manager', comment)
    if self.commentDoer:update(request:get('content'), comment) then
        rdTo = request.redirect
        if rdTo then
            
            return redirect(rdTo):with('success', '修改成功')
        end
        
        return back():with('success', '修改成功')
    end
    
    return back():withErrors('修改失败')
end

function _M:store(c)

    local request = c.req

    local pattern
    if not request:get('content') then
        
        return c:json({status = 500, msg = 'Comment content must not be empty !'})
    end
    if not Auth.check() then
        if not (request:get('username') and request:get('email')) then
            
            return c:json({status = 500, msg = 'Username and email must not be empty !'})
        end
        pattern = [[^([0-9A-Za-z\-_\.]+)@([0-9a-z]+\.[a-z]{2,3}(\.[a-z]{2})?)]]
        if not str.rematch(request.email, pattern) then
            
            return c:json({status = 500, msg = 'An Invalidate Email !'})
        end
    end
    local comment = self.commentDoer:create(request)
    if comment then
        
        return c:json({status = 200, msg = 'success'})
    end
    
    return response():json({status = 500, msg = 'failed'})
end

function _M:show(c, commentable_id)

    local request = c.req
    local commentable_type = request:get('commentable_type')
    local comments = self.commentDoer:getByCommentable(commentable_type, commentable_id)
    local redirect = request:get('redirect')
    
    c:view('comment.show', {
        comments = comments, commentable = commentable,
        redirect = redirect
    })
end

function _M:destroy(c, comment_id)

    local request = c.req
    local comment
    local force = (request.force == 'true')
    if force then
        comment = new(Comment):withTrashed():findOrFail(comment_id)
     else 
        comment = new(Comment):findOrFail(comment_id)
    end
    -- self:checkPolicy('manager', comment)
    if self.commentDoer:delete(comment, force) then
        
        return back():with('success', '删除成功')
    end
    
    return back():withErrors('删除失败')
end

return _M


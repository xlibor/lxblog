
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()
local redirect, back, abort = lx.h.kit()

function _M:ctor()

    self.commentDoer = new 'commentDoer'
    self.postDoer = new 'postDoer'
end

function _M:restore(c, comment_id)

    local comment = new(Comment):withTrashed():findOrFail(comment_id)
    -- self:checkPolicy('restore', comment)
    if comment:trashed() then
        comment:restore()
        self.commentDoer:clearAllCache()
        
        return redirect():route('admin.comments'):with('success', '恢复成功')
    end
    
    return redirect():route('admin.comments'):withErrors('恢复失败')
end

return _M


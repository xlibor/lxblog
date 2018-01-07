
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()
local redirect, back = lx.h.kit()

local Tag = lx.use('.app.model.tag')

function _M:ctor()

    self.tagDoer = new 'tagDoer'
end

function _M:store(c)

    local request = c.req
    self:validate(request, {
        name = 'required|unique:tags'
    })
    if self.tagDoer:create(request) then
        self.tagDoer:clearCache()
        
        return back():with('success', 'Tag [' .. request.name .. '] 创建成功')
     else 
        
        return back():with('error', 'Tag [' .. request.name .. '] 创建失败')
    end
end

function _M:destroy(c, id)

    local tag = Tag.find(id)

    if tag:posts():pure():count() > 0 then
        
        return redirect():route('admin.tags')
            :withErrors(tag.name .. '下面有文章，不能刪除')
    end
    if tag:delete() then
        self.tagDoer:clearCache()
        
        return back():with('success', tag.name .. '刪除成功')
    end
    
    return back():withErrors(tag.name .. '刪除失败')
end

return _M


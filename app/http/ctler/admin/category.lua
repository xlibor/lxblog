
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()
local redirect, back = lx.h.kit()

function _M:ctor()

    self.categoryDoer = new 'categoryDoer'
end

function _M:create(c)

    c:view('admin.category.create')
end

function _M:store(c)

    local request = c.req
    self:validate(request, {
        name = 'required|unique:categories'
    })
    if self.categoryDoer:create(request) then
        
        return back():with('success', '分类' .. request.name .. '创建成功')
     else 
        
        return back():with('error', '分类' .. request.name .. '创建失败')
    end
end

function _M:edit(c, id)

    local category = new(Category):find(id)
    c:view('admin.category.edit', {category = category})
end

function _M:update(c, id)

    local category = new(Category):find(id)
    local request = c.req
    self:validate(request, {
        name = 'required|unique:categories'
    })
    if self.categoryDoer:update(request, category) then
        
        return redirect():route('admin.categories')
            :with('success', '分类' .. request.name .. '修改成功')
    end
    
    return back():withInput()
        :withErrors('分类' .. request.name .. '修改失败')
end

function _M:destroy(c, id)

    local category = new(Category):find(id)
    if category:posts():pure():count() > 0 then
        
        return redirect():route('admin.categories')
            :withErrors(category.name .. '下面有文章，不能刪除')
    end
    self.categoryDoer:clearCache()
    if category:delete() then
        
        return back():with('success', category.name .. '刪除成功')
    end
    
    return back():withErrors(category.name .. '刪除失败')
end

return _M


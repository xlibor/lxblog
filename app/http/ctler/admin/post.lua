
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()

local redirect, back, abort, route = lx.h.kit()

function _M:ctor()

    self.postDoer       = new 'postDoer'
    self.categoryDoer   =  new 'categoryDoer'
    self.tagDoer        =  new 'tagDoer'
    self.commentDoer    =  new 'commentDoer'
end

function _M:create(c)

    c:view('admin.post.create', {
        categories = self.categoryDoer:getAll(),
        tags = self.tagDoer:getAll()})
end

function _M:store(c)

    local request = c.req

    self:validatePostForm(request)
    local name = request.title

    if self.postDoer:create(request) then
        redirect('admin/posts')
            :with('success', '文章' .. name .. '创建成功')
    else
        redirect('admin/posts')
            :withErrors('文章' .. name .. '创建失败')
    end
end

function _M:preview(c, slug)

    local post = new(Post):pure()
        :where('slug', slug):with('tags'):first()
    if not post then
        abort(404)
    end
    local preview = true
    
    c:view('post.show', {post = post, preview = preview})
end

function _M:publish(c, id)

    local post = new(Post):pure():find(id)
    if post:trashed() then
        
        return back():withErrors(post.title .. '发布失败，请先恢复删除')
    end
    self:clearAllCache()
    if post.status == 0 then
        post.status = 1
        post.published_at = lf.datetime()
        if post:save() then
            
            return back():with('success', post.title .. '发布成功')
        end
     else 
        if post.status == 1 then
            post.status = 0
            if post:save() then
                
                return back():with('success', post.title .. '撤销发布成功')
            end
        end
    end
    
    return back():withErrors(post.title .. '操作失败')
end

function _M:edit(c, id)

    local post = new(Post):pure():find(id)

    -- self:checkPolicy('update', post)
    -- post.description = (new('htmlConverter' ,{header_style = 'atx'})):convert(post.description)
    
    c:view('admin.post.edit', {
        post = post,
        categories = self.categoryDoer:getAll(),
        tags = self.tagDoer:getAll()
    })
end

function _M:update(c, id)

    local request = c.req

    local post = new(Post):pure():find(id)
    -- self:checkPolicy('update', post)
    self:validatePostForm(request, true)
    local name = request.title

    if self.postDoer:update(request, post) then
        redirect():route('admin.posts')
            :with('success', '文章' .. name .. '修改成功')
    else 
        redirect('admin/posts')
            :withErrors('文章' .. name .. '修改失败')
    end
end

function _M:download(id)

    local post = new(Post):pure():where('id', id):with({'tags', 'category'}):first()
    local info = "title: " .. post.title
    info = info .. "\ndate: " .. post.created_at:format('Y-m-d H:i')
    info = info .. "\npermalink: " .. post.slug
    info = info .. "\ncategory: " .. post.category.name
    info = info .. "\ntags:\n"
    for _, tag in pairs(post.tags) do
        info = info .. "- {tag.name}\n"
    end
    info = info .. "---\n\n" .. post.content
    
    return response(info, 200, {['"Content-Type"'] = 'application/force-download', ['Content-Disposition'] = "attachment; filename=\"" .. post.title .. ".md\""})
end

function _M:restore(c, id)

    local post = new(Post):pure():findOrFail(id)
    if post:trashed() then
        post:restore()
        self:clearAllCache()
        
        return redirect():route('admin.posts'):with('success', '恢复成功')
    end
    
    return redirect():route('admin.posts'):withErrors('恢复失败')
end

function _M:destroy(c, id)

    local request = c.req
    local result
    local post = new(Post):pure():findOrFail(id)
    local rdTo = route('admin.posts')
    if request:has('redirect') then
        rdTo = request:input('redirect')
    end
    if post:trashed() then
        result = post:forceDelete()
     else 
        result = post:delete()
    end
    if result then
        self:clearAllCache()
        
        return redirect(rdTo):with('success', '删除成功')
     else 
        
        return redirect(rdTo):withErrors('删除失败')
    end
end

function _M.__:validatePostForm(request, update)

    update = update or false
    local v = {
        title = 'required',
        description = 'required',
        category_id = 'required',
        content = 'required'
    }
    if not update then
        v = tb.merge(v, {slug = 'required|unique:posts'})
    end
    self:validate(request, v)
end

function _M:clearAllCache()

    self.postDoer:clearAllCache()
end

function _M:updateConfig(c, id)

    local request = c.req
    local post = new(Post):pure():findOrFail(id)
    if post:saveConfig(request.all) then
        
        return self:succeedJsonMsg('Update config successfully')
    end
    
    return self:failedJsonMsg('Update Config failed')
end

return _M


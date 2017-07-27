
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()
local route, back = lx.h.route, lx.h.back

function _M:ctor(postDoer, commentDoer, userDoer, categoryDoer, tagDoer, pageDoer, imageDoer, mapDoer)

    self.postDoer = new 'postDoer'
    self.commentDoer = new 'commentDoer'
    self.userDoer = new 'userDoer'
    self.categoryDoer = new 'categoryDoer'
    self.tagDoer = new 'tagDoer'
    self.pageDoer = new 'pageDoer'
    self.imageDoer = new 'imageDoer'
    self.mapDoer = new 'mapDoer'
end

function _M:index(c)

    local response = c.resp

    local failed_jobs_link
    local info = {
        post_count = self.postDoer:count(),
        comment_count = self.commentDoer:count(),
        user_count = self.userDoer:count(),
        category_count = self.categoryDoer:count(),
        tag_count = self.tagDoer:count(),
        page_count = self.pageDoer:count(),
        image_count = self.imageDoer:count(),
        ip_count = new(Ip):count()
    }

    c:view('admin.index', {info = info})

    local failed_jobs_count = Db('failed_jobs'):count()
    if failed_jobs_count > 0 then
        failed_jobs_link = route('admin.failed-jobs')
        response:withErrors({
            failed_jobs = "You have {failed_jobs_count} failed jobs.<a href='{failed_jobs_link}'>View</a>"
        })
    end
end

function _M:settings(c)

    c:view('admin.settings')
end

function _M:saveSettings(c)

    local request = c.req
    local inputs = request:except({
        '_token', 'site_css', 'site_js'
    })

    if lf.isEmpty(inputs.background_image) then
        inputs.background_image = nil
    end

    if lf.isEmpty(inputs.profile_image) then
        inputs.profile_image = nil
    end
    
    self.mapDoer:saveSettings(inputs)
    
    return back():with('success', '保存成功')
end

function _M:posts(c)

    local posts = self.postDoer:pagedPostsPure()
    
    return c:view('admin.posts', {posts = posts})
end

function _M:comments(c)

    local request = c.req

    local comments = new(Comment)
        :pure()
        :where(request:except('page'))
        :orderBy('created_at', 'desc')
        :paging(20)
    
    return c:view('admin.comments', {comments = comments})
end

function _M:tags(c)

    local tags = self.tagDoer:getAll()
    
    return c:view('admin.tags', {tags = tags})
end

function _M:categories(c)

    local categories = self.categoryDoer:getAll()
    
    return c:view('admin.categories', {categories = categories})
end

function _M:users(c)

    local request = c.req
    local users = new(User):where(request:except('page')):paging(20)
    
    return c:view('admin.users', {users = users})
end

function _M:pages(c)

    local pages = new(Page):paging(20)
    
    return c:view('admin.pages', {pages = pages})
end

function _M:ips(c)

    local request = c.req

    local ips = new(Ip):pure()
        :where(request:except('page'))
        :withCount({comments = function(query)
            query:withTrashed()
        end})
        :with('user')
        :orderBy('user_id', 'id')
        :paging(20)
    
    return c:view('admin.ips', {ips = ips})
end

function _M:failedJobs()

    local failed_jobs = DB.table('failed_jobs'):get()
    
    return view('admin.failed_jobs', compact('failed_jobs'))
end

function _M:flushFailedJobs()

    local result = DB.table('failed_jobs'):delete()
    if result then
        
        return back():with('success', "Flush {result} failed jobs")
    end
    
    return back():withErrors("Flush failed jobs failed")
end

return _M


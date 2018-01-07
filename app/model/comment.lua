
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'model',
    _mix_ = 'softDelete'
}

local app, lf, tb, str, new = lx.kit()
local route = lx.h.route

local Post = lx.use('.app.model.post')
local Page = lx.use('.app.model.page')

function _M:ctor()

    self.table = 'comments'
    self.fillable = {'content'}
    self.dates = {'deleted_at'}
    self.commentableData = {}

end

function _M:user()

    return self:belongsTo('.app.model.user')
end

function _M:ip()

    return self:belongsTo('.app.model.ip')
end

function _M:commentable()

    return self:morphTo()
end

function _M:getCommentableData()

    if lf.isEmpty(self.commentableData) then
        self.commentableData['deleted'] = false
        local st = self.commentable_type
        if st == Post.__cls then
            post = Post.where('id', self.commentable_id)
                :select('title', 'slug'):first()
            self.commentableData['type'] = '文章'
            if not post then
                self.commentableData['deleted'] = true
                
                return self.commentableData
            end
            self.commentableData['title'] = post.title
            self.commentableData['url'] = route('post.show', post.slug)
         elseif st == Page.__cls then
            page = Page.where('id', self.commentable_id):select('name', 'display_name'):first()
            self.commentableData['type'] = '页面'
            if not page then
                self.commentableData['deleted'] = true
                
                return self.commentableData
            end
            self.commentableData['title'] = page.display_name
            self.commentableData['url'] = route('page.show', page.name)
        end
    end
    
    return self.commentableData
end

return _M


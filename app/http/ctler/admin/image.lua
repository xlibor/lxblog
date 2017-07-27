
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'controller'
}

local app, lf, tb, str, new = lx.kit()

function _M:ctor()

    self.imageDoer = new 'imageDoer'
end

function _M:images(c)

    local images = self.imageDoer:getAll()
    local image_count = self.imageDoer:count()
    
    return c:view('admin.images', {
        images = images,
        image_count = image_count
    })
end

function _M:uploadImage(request)

    self:validate(request, {image = 'required|image|max:5000'})
    local type = request:input('type', nil)
    if type ~= nil and type == 'xrt' then
        
        return self.imageDoer:uploadImageToQiNiu(request, false)
     else 
        if self.imageDoer:uploadImageToQiNiu(request, true) then
            
            return back():with('success', '上传成功')
        end
        
        return back():withErrors('上传失败')
    end
end

return _M


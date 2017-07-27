
local lx, _M, mt = oo{
    _cls_ = ' FileController',
    _ext_ = 'controller'
}

local app, lf, tb, str = lx.kit()

function _M:new()

    local this = {
        imageDoer = nil,
        unknownFileDoer = nil
    }
    
    return oo(this, mt)
end

function _M:ctor(imageDoer, unknownFileDoer)

    self.imageDoer = imageDoer
    self.unknownFileDoer = unknownFileDoer
end

function _M:files()

    local files = self.unknownFileDoer:getAllFiles()
    
    return view('admin.files', compact('files'))
end

function _M:uploadFile(request)

    self:validate(request, {file = 'required'})
    local type = request:get('type')
    if type then
        
        return self:uploadTypeFile(request)
    end
    if self:upload(request, self:getTag(request)) then
        
        return back():with('success', '上传成功')
    end
    
    return back():withErrors('上传失败')
end

function _M:uploadTypeFile(request)

    self:validate(request, {file = 'required', type = 'required'})
    if self:upload(request, request:get('type')) then
        
        return back():with('success', '上传成功')
    end
    
    return back():withErrors('上传失败')
end

function _M:deleteFile(request)

    local key = request:get('key')
    local type = File.where('key', key):firstOrFail().type
    self.unknownFileDoer:setTag(type)
    local result = self.unknownFileDoer:delete(key)
    if result then
        
        return back():with('success', '删除成功')
    end
    
    return back():with('success', '删除失败')
end

function _M.__:upload(request, type)

    self.unknownFileDoer:setTag(type)
    
    return self.unknownFileDoer:upload(request)
end

function _M.__:getTag(request)

    local tag = request:file('file'):getClientOriginalExtension()
    if not tag then
        tag = 'unknown'
    end
    
    return tag
end

return _M


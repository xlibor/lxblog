
local lx, _M = oo{
    _cls_ = '',
    _ext_ = 'fileDoer'
}

local app, lf, tb, str, new = lx.kit()
local request = lx.h.request

function _M:ctor()

    self._tag = 'image'
end

function _M:getAll(page)

    page = page or 12
    local key = 'image.page.' .. page .. request():get('page', 1)
    local maps = self:remember(key, function()
        
        return new(File):where('type', 'image')
        :orderBy('created_at', 'desc')
        :paging(page)
    end)
    
    return maps
end

function _M:uploadImage(file, key)

    return self:uploadFile(file, key)
end

function _M:uploadImageToQiNiu(request, html)

    local file = request:file('image')
    local data = {}
    local url = self:uploadFile(file)
    if url then
        if html then
            
            return true
         else 
            data['filename'] = url
        end
     else 
        if html then
            
            return false
        end
        data['error'] = 'upload failed'
    end
    
    return data
end

function _M:uploadImageToLocal(request)

    local result
    local image
    local file = request:file('image')
    local path = file:store('public/images')
    local url = Storage.url(path)
    if path then
        image = File.firstOrNew({
            name = file:getClientOriginalName(),
            key = url,
            size = file:getSize(),
            type = 'image'
        })
        result = image:save()
     else 
        result = false
    end
    self:clearCache()
    
    return result
end

function _M:count()

    local count = self:remember(self:tag() .. '.count', function()
        
        return new(File):where('type', self:type()):count()
    end)
    
    return count
end

function _M:type()

    return self._tag
end

return _M


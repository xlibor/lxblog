
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'appDoer'
}

local app, lf, tb, str = lx.kit()

function _M:ctor(fileUploadManager)

    self.fileUploadManager = fileUploadManager
end

function _M:delete(key)

    local result = self.fileUploadManager:deleteFile(key)
    if result then
        self:clearCache()
        self:clearCache('files')
        File.where('key', key):delete()
    end
    
    return result
end

function _M:getAllFiles()

    local files = self:remember('file.all', function()
        
        return File.where('type', '<>', ImageDoer.tag):orderBy('type', 'desc'):get()
    end, 'files')
    
    return files
end

function _M:getAllFilesByType()

    local js = self:remember(self:type() .. '.all.type', function()
        
        return File.where('type', self:type()):get()
    end)
    
    return js
end

function _M:get(key)

    local map = self:remember(self:type() .. '.one.' .. key, function()
        
        return File.where('key', key):firstOrFail()
    end)
    
    return map
end

function _M:deleteAllByType()

    local files = File.where('type', self:type()):get()
    for _, file in pairs(files) do
        self:delete(file.key)
    end
end

function _M:uploadFile(file, key)

    local result
    local fileModel
    if key == nil then
        key = self:type() .. '/' .. file:hashName()
     else 
        key = self:type() .. '/' .. key
    end
    if self.fileUploadManager:uploadFile(key, file:getRealPath()) then
        fileModel = File.firstOrNew({
            name = file:getClientOriginalName(),
            key = key,
            size = file:getSize(),
            type = self:type()
        })
        if fileModel:save() then
            result = getUrlByFileName(key)
         else 
            result = false
        end
     else 
        result = false
    end
    self:clearCache()
    self:clearCache('files')
    
    return result
end

function _M:type() end

function _M:model()

    app(File.class)
end

return _M


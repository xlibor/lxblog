
local lx, _M, mt = oo{
    _cls_ = '',
    _ext_ = 'fileDoer'
}

local app, lf, tb, str = lx.kit()

function _M:setTag(tag)

    self._tag = tag
end

function _M:upload(request, delete, fileName)

    fileName = fileName or 'file'
    delete = delete or false
    if delete then
        self:deleteAllByType()
    end
    local file = request:file(fileName)
    
    return self:uploadFile(file, file:getClientOriginalName())
end

function _M:type()

    return self._tag
end

return _M

